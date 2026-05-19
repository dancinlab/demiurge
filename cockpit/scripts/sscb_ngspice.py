# sscb_ngspice.py — phase κ-34 (P-⑧ cohort producer prototype, D55)
# ngspice transient producer for `sscb + analyze` — the first **cohort**
# domain wired to a real measuring engine tool (not just chip/component/
# matter).
#
# Invoked by Swift's SSCBProducer via:
#   /opt/homebrew/bin/python3 cockpit/scripts/sscb_ngspice.py <output_dir>
#
# What it does (honest scope):
#   1. Writes a *plausible-but-not-from-datasheet* SSCB hard-switching
#      netlist to <output_dir>/sscb_v1.cir:
#         - 600 V DC bus / 100 A nominal load
#         - SiC abstract switch (voltage-controlled, Ron=20 mΩ Roff=1 GΩ)
#         - PWL gate drive opening at 1 µs (target ≤ 1 µs interruption
#           per HEXA-SSCB mk1, domains/sscb.md §1)
#         - RC snubber stub (100 nF / 5 Ω) across switch
#         - 1 µH series inductor (stray bus) to make di/dt visible
#   2. Spawns `ngspice -b -o <log> -r <raw>` to run the transient.
#   3. Parses the stdout (`Index time v(...) i(...)` table) and computes:
#         - peak load voltage observed (`v_load_peak_V`)
#         - load voltage at t=1.5 µs (the post-trip steady value
#           `v_load_post_trip_V`)
#         - peak supply current observed (`i_dc_peak_A`)
#         - 90→10% fall time on the load voltage (`fall_time_s`)
#         - peak overshoot ratio (`overshoot_ratio` = v_peak/v_pre)
#   4. Emits sscb_v1.meta.json with the *measurements* + the netlist
#      hash so downstream sweeps can spot drift.
#
# HONESTY (g3 — non-negotiable):
#   • The numbers above are real numerical measurements of the simulated
#     circuit — ngspice's IEEE-754 transient solver IS the "instrument"
#     here. But the *circuit* is plausible, not absorbed from a real
#     SiC device datasheet (no PSpice .lib, no Wolfspeed C3M0021120K
#     model). So measurement_gate stays GATE_OPEN until a real device
#     model + bench-validated load are wired in (BANNED-absorbed stance,
#     mirrors chip-synth gate-OPEN discipline).
#   • Fall time / overshoot ARE the numbers — single-point measurements,
#     not a curve sweep. P-⑧ asks "can we MAKE a record at all?" and the
#     answer here is yes; full-sweep parity belongs in a later phase.
#   • absorbed=true is NEVER set by this producer. The Swift side
#     (SSCBProducer) reads only the ok flag + the measurements dict;
#     the gate is decided downstream from those, mirroring MatterAnalyzer.

import hashlib
import json
import os
import subprocess
import sys
from typing import Tuple


# --- Netlist template (mirror domains/sscb.md §1 plausible HEXA-SSCB mk1)
GEOMETRY_ID = "sscb_v1"

# Physical targets (NOT a datasheet pull):
V_DC = 600.0           # V — DC bus
R_LOAD = 6.0           # Ω — 100 A nominal at 600 V
L_BUS = 1.0e-6         # H — 1 µH stray bus inductance
R_SW_ON = 20.0e-3      # Ω — SiC on-state (plausible C3M0021120K-class)
R_SW_OFF = 1.0e9       # Ω — off-state isolation
V_THR = 7.0            # V — gate threshold
V_HYST = 1.0           # V — hysteresis
C_SNUB = 100.0e-9      # F — 100 nF snubber capacitor
R_SNUB = 5.0           # Ω — 5 Ω snubber resistor
T_TRIP = 1.0e-6        # s — 1 µs gate fall start (HEXA-SSCB mk1 target)
T_SIM = 6.0e-6         # s — 6 µs window
T_STEP = 5.0e-9        # s — 5 ns max step

NETLIST = f"""* sscb_v1 — demiurge cohort producer, D55 / κ-34
* HONEST: plausible HEXA-SSCB mk1 topology, NOT a measured device model.
.title {GEOMETRY_ID}
Vdc 1 0 {V_DC}
Lbus 1 2 {L_BUS}
Rload 2 3 {R_LOAD}
SW 3 0 gate 0 SWMOD
* RC snubber across the switch (3 → 0)
Csnub 3 4 {C_SNUB}
Rsnub 4 0 {R_SNUB}
* Gate drive — high until 1 µs trip, falls in 50 ns
Vgate gate 0 PWL(0 15 {T_TRIP:e} 15 {T_TRIP + 5.0e-8:e} 0 {T_SIM:e} 0)
.model SWMOD SW (Ron={R_SW_ON} Roff={R_SW_OFF} Vt={V_THR} Vh={V_HYST})
.tran {T_STEP:e} {T_SIM:e}
.print tran v(3) v(2) i(Vdc) i(Lbus)
.control
run
print v(3) v(2) i(Vdc) i(Lbus)
.endc
.end
"""


def write_netlist(path: str) -> str:
    """Write the netlist and return its SHA-256 hex digest (truncated)."""
    with open(path, "w", encoding="utf-8") as f:
        f.write(NETLIST)
    h = hashlib.sha256(NETLIST.encode("utf-8")).hexdigest()[:16]
    return h


def parse_tran_table(captured: str) -> list:
    """Pick numeric ``Index time v(3) v(2) i(vdc)`` table rows out of
    ngspice batch output. Returns list of (t, v_sw, v_load, i_dc) tuples
    — v(3) is the voltage **across the switch** (≈ 2 V pre-trip with
    R_on, ≈ 600 V post-trip), v(2) is the supply-side node (≈ 600 V
    steady), i(vdc) is supply current (negative by ngspice convention).
    Tolerant of multiple printed tables — accumulates all numeric rows.
    """
    rows = []
    for raw in captured.splitlines():
        line = raw.strip()
        parts = line.split()
        if len(parts) < 5:
            continue
        # First field must parse as int (Index), then 4 floats.
        try:
            int(parts[0])
            t = float(parts[1])
            v_sw = float(parts[2])
            v_load = float(parts[3])
            i_dc = float(parts[4])
        except (ValueError, IndexError):
            continue
        rows.append((t, v_sw, v_load, i_dc))
    # Deduplicate by time (the same table may be printed twice — keep
    # the first occurrence; both should agree to FP precision).
    seen = set()
    out = []
    for r in rows:
        if r[0] in seen:
            continue
        seen.add(r[0])
        out.append(r)
    return out


def measurements(rows: list) -> dict:
    """Extract the headline numbers. Honest g3: these are *measurements*
    of the simulated circuit (ngspice IS the instrument), so the values
    are real numbers — but the underlying circuit is plausible-not-
    absorbed, so measurement_gate stays OPEN downstream.

    Signal conventions (mirror parse_tran_table):
      v_sw   = v(3) — voltage **across the switch**. Low pre-trip
               (≈ I·Ron), rises toward V_DC post-trip (the interruption).
      i_dc   = i(vdc) — supply current. ngspice prints it negative
               (convention: current INTO the source terminal is +).
               We measure |i_dc| as the load-side current magnitude.
    """
    empty = {
        "rows": 0,
        "v_sw_pre_trip_V": None,
        "v_sw_peak_V": None,
        "v_sw_post_trip_V": None,
        "i_load_pre_trip_A": None,
        "i_load_peak_A": None,
        "i_load_post_trip_A": None,
        "rise_time_s": None,
        "interrupt_ratio": None,
    }
    if not rows:
        return empty

    # Pre-trip (steady DC, switch closed) baseline — last row strictly
    # before T_TRIP. With Ron=20 mΩ + 600 V / 6 Ω load → I ≈ 99.7 A,
    # v_sw ≈ I·Ron ≈ 2 V (sanity check).
    pre_rows = [r for r in rows if r[0] < T_TRIP]
    if not pre_rows:
        return empty
    v_sw_pre = pre_rows[-1][1]
    i_pre = abs(pre_rows[-1][3])

    v_sw_peak = max(r[1] for r in rows)
    i_peak = max(abs(r[3]) for r in rows)

    # Post-trip steady — sample at t ≈ 1.5 µs (well after gate-fall +
    # snubber ring-down begins). Switch should be open → v_sw → V_DC.
    post_target = T_TRIP + 5.0e-7
    post_rows = sorted(rows, key=lambda r: abs(r[0] - post_target))
    if not post_rows:
        return empty
    v_sw_post = post_rows[0][1]
    i_post = abs(post_rows[0][3])

    # 10→90% rise time on v_sw — first crossing of 0.1·V_DC to 0.9·V_DC
    # AFTER trip. This IS the "speed of interruption" figure-of-merit
    # for an SSCB (HEXA-SSCB mk1 target ≤ 1 µs in domains/sscb.md §1).
    v_lo = 0.1 * V_DC
    v_hi = 0.9 * V_DC
    t_lo = None
    t_hi = None
    for (t, v, *_rest) in rows:
        if t < T_TRIP:
            continue
        if t_lo is None and v >= v_lo:
            t_lo = t
        if t_lo is not None and t_hi is None and v >= v_hi:
            t_hi = t
            break
    rise_time = (t_hi - t_lo) if (t_lo is not None and t_hi is not None) else None

    # interrupt_ratio: i_post / i_pre — how much current is left
    # flowing after the interrupt. 0.0 = perfect, ~1.0 = no interrupt.
    interrupt_ratio = (i_post / i_pre) if i_pre else None

    return {
        "rows": len(rows),
        "v_sw_pre_trip_V": v_sw_pre,
        "v_sw_peak_V": v_sw_peak,
        "v_sw_post_trip_V": v_sw_post,
        "i_load_pre_trip_A": i_pre,
        "i_load_peak_A": i_peak,
        "i_load_post_trip_A": i_post,
        "rise_time_s": rise_time,
        "interrupt_ratio": interrupt_ratio,
    }


def locate_ngspice() -> str:
    for c in ("/opt/homebrew/bin/ngspice",
              "/usr/local/bin/ngspice",
              "/usr/bin/ngspice"):
        if os.path.isfile(c) and os.access(c, os.X_OK):
            return c
    # PATH fallback.
    from shutil import which
    p = which("ngspice")
    if p:
        return p
    return ""


def ngspice_version(binpath: str) -> str:
    try:
        out = subprocess.run([binpath, "-v"], capture_output=True,
                             text=True, timeout=10).stdout
    except Exception:
        return "unknown"
    for line in out.splitlines():
        line = line.strip()
        if line.startswith("** ngspice-"):
            # "** ngspice-46 : Circuit level simulation program"
            tok = line.split(":", 1)[0].strip().lstrip("*").strip()
            return tok.replace("ngspice-", "")
    return "unknown"


def main(argv: list) -> int:
    if len(argv) < 2:
        sys.stderr.write("usage: sscb_ngspice.py <output_dir>\n")
        return 2
    output_dir = argv[1]
    os.makedirs(output_dir, exist_ok=True)

    netlist_path = os.path.join(output_dir, f"{GEOMETRY_ID}.cir")
    log_path = os.path.join(output_dir, f"{GEOMETRY_ID}.log")
    raw_path = os.path.join(output_dir, f"{GEOMETRY_ID}.raw")
    meta_path = os.path.join(output_dir, f"{GEOMETRY_ID}.meta.json")

    netlist_hash = write_netlist(netlist_path)
    sys.stderr.write(f"sscb_ngspice: wrote {netlist_path} (sha256:{netlist_hash})\n")

    ngs = locate_ngspice()
    if not ngs:
        sys.stderr.write("sscb_ngspice: ngspice not found on PATH or "
                         "/opt/homebrew/bin — fall back honest gap.\n")
        summary = {"ok": False, "geometry_id": GEOMETRY_ID,
                   "error": "ngspice_not_found",
                   "netlist_sha256_16": netlist_hash}
        sys.stderr.write("SSCB_NGSPICE_RESULT "
                         + json.dumps(summary, sort_keys=True) + "\n")
        return 3

    # Run the simulation, capture stdout/stderr. With `-o <log>`, ngspice
    # routes the .print table into <log> rather than stdout — so we
    # have to read it back.
    try:
        result = subprocess.run(
            [ngs, "-b", "-o", log_path, "-r", raw_path, netlist_path],
            capture_output=True, text=True, timeout=60)
    except Exception as exc:
        sys.stderr.write(f"sscb_ngspice: ngspice spawn failed — {exc}\n")
        summary = {"ok": False, "geometry_id": GEOMETRY_ID,
                   "error": f"ngspice_spawn: {exc}",
                   "netlist_sha256_16": netlist_hash}
        sys.stderr.write("SSCB_NGSPICE_RESULT "
                         + json.dumps(summary, sort_keys=True) + "\n")
        return 4

    captured = result.stdout + "\n" + result.stderr
    try:
        with open(log_path, "r", encoding="utf-8", errors="replace") as f:
            captured = captured + "\n" + f.read()
    except OSError:
        pass
    rows = parse_tran_table(captured)
    meas = measurements(rows)

    version = ngspice_version(ngs)
    ok = (result.returncode == 0
          and meas["rows"] > 0
          and meas["rise_time_s"] is not None)

    meta = {
        "ok": ok,
        "geometry_id": GEOMETRY_ID,
        "netlist_sha256_16": netlist_hash,
        "ngspice_version": version,
        "ngspice_exit": result.returncode,
        "topology": {
            "v_dc_V": V_DC,
            "r_load_ohm": R_LOAD,
            "l_bus_H": L_BUS,
            "switch_ron_ohm": R_SW_ON,
            "switch_roff_ohm": R_SW_OFF,
            "snubber_C_F": C_SNUB,
            "snubber_R_ohm": R_SNUB,
            "trip_time_s": T_TRIP,
            "sim_time_s": T_SIM,
            "step_s": T_STEP,
        },
        "measurements": meas,
        "artifacts": {
            "netlist": f"{GEOMETRY_ID}.cir",
            "log": f"{GEOMETRY_ID}.log",
            "raw": f"{GEOMETRY_ID}.raw",
        },
    }

    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2, sort_keys=True)
        f.write("\n")

    sys.stderr.write(f"sscb_ngspice: wrote {meta_path} (ok={ok}, "
                     f"rows={meas['rows']})\n")

    artifacts_with_meta = dict(meta["artifacts"])
    artifacts_with_meta["meta"] = f"{GEOMETRY_ID}.meta.json"
    summary = {
        "ok": ok,
        "geometry_id": GEOMETRY_ID,
        "netlist_sha256_16": netlist_hash,
        "ngspice_version": version,
        "rows": meas["rows"],
        "rise_time_s": meas["rise_time_s"],
        "v_sw_post_trip_V": meas["v_sw_post_trip_V"],
        "i_load_pre_trip_A": meas["i_load_pre_trip_A"],
        "i_load_post_trip_A": meas["i_load_post_trip_A"],
        "interrupt_ratio": meas["interrupt_ratio"],
        "artifacts": artifacts_with_meta,
    }
    sys.stderr.write("SSCB_NGSPICE_RESULT "
                     + json.dumps(summary, sort_keys=True) + "\n")
    sys.stderr.flush()
    return 0 if ok else 5


if __name__ == "__main__":
    sys.exit(main(sys.argv))
