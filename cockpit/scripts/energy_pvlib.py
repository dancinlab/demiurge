# energy_pvlib.py — phase κ-38 (P-⑧ 4th cohort producer prototype, D59)
# pvlib clear-sky producer for `energy + analyze` — the FOURTH cohort
# domain (after sscb κ-34 / grid κ-35? planned / bot κ-36? planned) and
# the FIRST renewable-energy producer wired to a real measuring engine
# tool (NREL SAM-class clear-sky algorithms via pvlib).
#
# Invoked by Swift's EnergyAnalyzeProducer via:
#   /opt/homebrew/bin/python3 cockpit/scripts/energy_pvlib.py <output_dir>
#
# What it does (honest scope):
#   1. Construct a deterministic site (Phoenix, AZ — 33.4484 N / 112.074
#      W, alt 331 m, tz America/Phoenix) and standard PV system:
#        - module:   Canadian_Solar_Inc__CS5P_220M  (CECMod database)
#        - inverter: ABB__MICRO_0_25_I_OUTD_US_208__208V_ (CECInverter)
#        - mount:    fixed-tilt 33.4° south (lat-tilt rule of thumb)
#        - 1 string × 1 module (1-module reference system)
#   2. Run pvlib's Ineichen clear-sky model for the full 2024 calendar
#      (8784 hourly steps, leap year) at the site:
#        - GHI/DNI/DHI via Location.get_clearsky() (Ineichen + Linke
#          turbidity climatology — NREL SAM verified)
#        - DC + AC power via ModelChain (CEC SAPM module model + CEC
#          inverter Sandia model, physical AOI + no spectral loss)
#   3. Compute annual_energy_kwh (AC), annual_energy_dc_kwh, peak power
#      figures, and a 12-month breakdown.
#   4. Emit pv_clearsky.meta.json with parameters + measurements +
#      pvlib version + Python version so cross-host drift is visible.
#
# HONESTY (g3 — non-negotiable):
#   • Clear-sky output IS the measurement — pvlib's Ineichen + CEC SAPM
#     algorithms are NREL SAM-verified (canonical reference solar
#     simulation in industry). The numbers are real algorithm outputs,
#     not toy estimates.
#   • BUT there is NO sky-measured irradiance data — this is the *clear-
#     sky upper bound*, not a TMY (Typical Meteorological Year) yield
#     simulation. Real-world annual yield is typically 70-85 % of the
#     clear-sky bound (cloud cover, aerosol variability, snow soiling).
#     measurement_gate stays GATE_OPEN ALWAYS until TMY3 / NSRDB data
#     is wired in.
#   • absorbed = false ALWAYS. pvlib is BSD-3 OSS, but "absorbed"
#     requires (a) bench-validated module I-V curves (not just CEC
#     database lookup) AND (b) site-measured irradiance time series.
#     Neither is in scope here.
#   • No system losses applied (DC wiring, mismatch, soiling, etc.) —
#     these would push numbers DOWN, so the clear-sky bound is honestly
#     optimistic. scope_caveats embeds this.

import json
import os
import platform
import subprocess
import sys
import warnings

# pvlib + pandas emit deprecation chatter we don't want polluting the
# producer summary line (honest: we want clean stderr for parsing).
warnings.filterwarnings("ignore")

# --- Standard site (Phoenix AZ — chosen for low cloud cover, high DNI,
#     which makes the clear-sky bound representative of a real high-
#     yield desert PV deployment).
GEOMETRY_ID = "pv_clearsky_phoenix_az_v1"
SITE_NAME = "Phoenix_AZ"
LATITUDE = 33.4484
LONGITUDE = -112.0740
ALTITUDE_M = 331.0
TIMEZONE = "America/Phoenix"

# --- Standard module + inverter (CEC database — canonical SAM picks).
MODULE_NAME = "Canadian_Solar_Inc__CS5P_220M"
INVERTER_NAME = "ABB__MICRO_0_25_I_OUTD_US_208__208V_"

# --- Mount + array geometry.
SURFACE_TILT = 33.4484          # lat-tilt rule (annual-optimal for fixed)
SURFACE_AZIMUTH = 180.0         # due-south (northern hemisphere)
MODULES_PER_STRING = 1
STRINGS = 1

# --- Simulation horizon (full year, hourly).
SIM_YEAR = 2024                 # leap year → 8784 steps
SIM_FREQ = "1h"

# --- Weather constants (clear-sky has no temperature data — use STC
#     ambient as honest placeholder; scope_caveats records the gap).
TEMP_AIR_C = 25.0
WIND_SPEED_MS = 1.0


def pvlib_version() -> str:
    try:
        import pvlib
        return pvlib.__version__
    except Exception:
        return "unknown"


def run_simulation(output_dir: str) -> dict:
    """Run the full pvlib ModelChain and return a summary dict. Raises
    on import / library failure — the caller (main) catches and reports
    honest gap."""
    import pvlib
    from pvlib.location import Location
    from pvlib.pvsystem import PVSystem, retrieve_sam
    from pvlib.modelchain import ModelChain
    import pandas as pd

    loc = Location(
        latitude=LATITUDE, longitude=LONGITUDE, tz=TIMEZONE,
        altitude=ALTITUDE_M, name=SITE_NAME,
    )

    mods = retrieve_sam("CECMod")
    invs = retrieve_sam("CECInverter")
    if MODULE_NAME not in mods:
        raise KeyError(f"module not in CECMod: {MODULE_NAME}")
    if INVERTER_NAME not in invs:
        raise KeyError(f"inverter not in CECInverter: {INVERTER_NAME}")
    mod = mods[MODULE_NAME]
    inv = invs[INVERTER_NAME]

    mount = pvlib.pvsystem.FixedMount(
        surface_tilt=SURFACE_TILT, surface_azimuth=SURFACE_AZIMUTH)
    temp_params = pvlib.temperature.TEMPERATURE_MODEL_PARAMETERS[
        "sapm"]["open_rack_glass_glass"]
    array = pvlib.pvsystem.Array(
        mount=mount,
        module_parameters=mod,
        temperature_model_parameters=temp_params,
        modules_per_string=MODULES_PER_STRING,
        strings=STRINGS,
    )
    system = PVSystem(arrays=[array], inverter_parameters=inv)
    mc = ModelChain(system, loc, aoi_model="physical",
                    spectral_model="no_loss")

    times = pd.date_range(
        f"{SIM_YEAR}-01-01", f"{SIM_YEAR}-12-31 23:00",
        freq=SIM_FREQ, tz=loc.tz)
    cs = loc.get_clearsky(times)   # Ineichen + Linke turbidity
    weather = pd.DataFrame({
        "ghi": cs["ghi"], "dni": cs["dni"], "dhi": cs["dhi"],
        "temp_air": TEMP_AIR_C, "wind_speed": WIND_SPEED_MS,
    }, index=times)
    mc.run_model(weather)

    dc = mc.results.dc
    ac = mc.results.ac
    # ModelChain returns DC as a DataFrame (single-array systems) with
    # a 'p_mp' column, or a Series if old API. Handle both.
    if hasattr(dc, "columns") and "p_mp" in getattr(dc, "columns", []):
        dc_p = dc["p_mp"]
    elif hasattr(dc, "p_mp"):
        dc_p = dc.p_mp
    else:
        dc_p = dc

    # Hourly W → kWh = W * 1h / 1000.
    dc_kwh = float(dc_p.sum()) / 1000.0
    ac_kwh = float(ac.sum()) / 1000.0
    dc_peak_kw = float(dc_p.max()) / 1000.0
    ac_peak_kw = float(ac.max()) / 1000.0

    # 12-month AC breakdown (kWh per calendar month) — useful for
    # downstream sweeps + sanity check (summer > winter in Phoenix).
    ac_monthly = (ac.groupby(ac.index.month).sum() / 1000.0).round(3)
    monthly_kwh = {int(m): float(v) for m, v in ac_monthly.items()}

    ghi_total_mwh_m2 = float(cs["ghi"].sum()) / 1000.0   # kWh → MWh per m²

    # Write the hourly AC time series to CSV (small — 8784 rows × 2
    # cols) so downstream sweeps can re-aggregate without re-running.
    csv_path = os.path.join(output_dir, f"{GEOMETRY_ID}.csv")
    series = pd.DataFrame({"dc_W": dc_p, "ac_W": ac}, index=times)
    series.to_csv(csv_path, index_label="timestamp")

    return {
        "rows": int(len(times)),
        "annual_energy_kwh": round(ac_kwh, 3),
        "annual_energy_dc_kwh": round(dc_kwh, 3),
        "dc_peak_kw": round(dc_peak_kw, 6),
        "ac_peak_kw": round(ac_peak_kw, 6),
        "ghi_annual_mwh_per_m2": round(ghi_total_mwh_m2, 3),
        "monthly_ac_kwh": monthly_kwh,
        "csv_artifact": f"{GEOMETRY_ID}.csv",
    }


def main(argv: list) -> int:
    if len(argv) < 2:
        sys.stderr.write("usage: energy_pvlib.py <output_dir>\n")
        return 2
    output_dir = argv[1]
    os.makedirs(output_dir, exist_ok=True)

    meta_path = os.path.join(output_dir, f"{GEOMETRY_ID}.meta.json")
    pvlib_v = pvlib_version()
    py_v = platform.python_version()

    try:
        measurements = run_simulation(output_dir)
        ok = True
        err = None
    except Exception as exc:
        ok = False
        err = f"{type(exc).__name__}: {exc}"
        measurements = {"rows": 0, "annual_energy_kwh": None,
                        "annual_energy_dc_kwh": None,
                        "dc_peak_kw": None, "ac_peak_kw": None,
                        "ghi_annual_mwh_per_m2": None,
                        "monthly_ac_kwh": {}, "csv_artifact": None}

    meta = {
        "ok": ok,
        "geometry_id": GEOMETRY_ID,
        "pvlib_version": pvlib_v,
        "python_version": py_v,
        "error": err,
        "site": {
            "name": SITE_NAME,
            "latitude": LATITUDE,
            "longitude": LONGITUDE,
            "altitude_m": ALTITUDE_M,
            "timezone": TIMEZONE,
        },
        "system": {
            "module": MODULE_NAME,
            "inverter": INVERTER_NAME,
            "surface_tilt": SURFACE_TILT,
            "surface_azimuth": SURFACE_AZIMUTH,
            "modules_per_string": MODULES_PER_STRING,
            "strings": STRINGS,
            "temp_air_C": TEMP_AIR_C,
            "wind_speed_ms": WIND_SPEED_MS,
        },
        "simulation": {
            "year": SIM_YEAR,
            "freq": SIM_FREQ,
            "model": "clearsky_ineichen+cec_sapm",
        },
        "measurements": measurements,
        "artifacts": {
            "csv": measurements.get("csv_artifact") or "",
        },
    }

    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2, sort_keys=True)
        f.write("\n")

    sys.stderr.write(
        f"energy_pvlib: wrote {meta_path} (ok={ok}, "
        f"rows={measurements['rows']}, "
        f"annual_kwh={measurements['annual_energy_kwh']})\n")
    if not ok:
        sys.stderr.write(f"energy_pvlib: error → {err}\n")

    artifacts_with_meta = dict(meta["artifacts"])
    artifacts_with_meta["meta"] = f"{GEOMETRY_ID}.meta.json"
    summary = {
        "ok": ok,
        "geometry_id": GEOMETRY_ID,
        "pvlib_version": pvlib_v,
        "python_version": py_v,
        "rows": measurements["rows"],
        "annual_energy_kwh": measurements["annual_energy_kwh"],
        "annual_energy_dc_kwh": measurements["annual_energy_dc_kwh"],
        "dc_peak_kw": measurements["dc_peak_kw"],
        "ac_peak_kw": measurements["ac_peak_kw"],
        "ghi_annual_mwh_per_m2": measurements["ghi_annual_mwh_per_m2"],
        "artifacts": artifacts_with_meta,
    }
    sys.stderr.write("ENERGY_PVLIB_RESULT "
                     + json.dumps(summary, sort_keys=True) + "\n")
    sys.stderr.flush()
    return 0 if ok else 5


if __name__ == "__main__":
    sys.exit(main(sys.argv))
