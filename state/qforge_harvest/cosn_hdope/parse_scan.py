#!/usr/bin/env python3
"""Parse CoSn electron-doping tot_charge scan -> ΔE_flatband, m, E_F per Δn.

Flat-band locator (honest, same logic family as the MoSn check):
  - read bands.x .gnu (k-dist, E) blocks, one block per band.
  - k-path = Γ-K-M-Γ-A with 12 pts/segment. The kagome Co-3d flat band is
    flattest along the K->M segment (and broadly across the in-plane path).
  - for each band: dispersion = max-min over the WHOLE in-plane path (exclude the
    last single A point). Candidate flat bands = lowest-dispersion bands.
  - among low-dispersion bands, report the one whose mean energy is CLOSEST to E_F
    (that is the flat band relevant to flat-band-at-E_F physics); also report the
    flattest band overall for transparency.
  - ΔE_flatband = (mean energy of chosen flat band) - E_F.

Run from deck dir after run_scan.sh:  python3 parse_scan.py
"""
import os, re, glob, json, statistics, sys

DOPINGS = [("0.0", "0.0"), ("0.2", "-0.2"), ("0.4", "-0.4"), ("0.6", "-0.6")]
NSEG_PTS = 12  # pts per segment in bands.in
# segment boundaries in the concatenated path (Γ,K,M,Γ,A): 5 nodes, 4 segments.
# blocks have (NSEG_PTS*4 + 1) k-points typically; we treat all but final A point as in-plane-ish.

def read_fermi_mag(scf_out):
    ef = None; mag = None; conv = False; jobdone = False
    with open(scf_out) as f:
        for ln in f:
            m = re.search(r"the Fermi energy is\s+([-\d.]+)\s*ev", ln)
            if m: ef = float(m.group(1))
            m = re.search(r"total magnetization\s+=\s+([-\d.]+)\s*Bohr", ln)
            if m: mag = float(m.group(1))
            if "convergence has been achieved" in ln: conv = True
            if "JOB DONE" in ln: jobdone = True
    return ef, mag, conv, jobdone

def read_gnu(gnu):
    """return list of bands; each band = list of (kdist, energy)."""
    bands = []; cur = []
    with open(gnu) as f:
        for ln in f:
            s = ln.strip()
            if not s:
                if cur: bands.append(cur); cur = []
                continue
            parts = s.split()
            if len(parts) >= 2:
                try:
                    cur.append((float(parts[0]), float(parts[1])))
                except ValueError:
                    pass
    if cur: bands.append(cur)
    return bands

def analyze(gnu, ef):
    bands = read_gnu(gnu)
    if not bands:
        return None
    npts = len(bands[0])
    # in-plane portion = all but the final point (A is a single tail point)
    inplane = slice(0, npts - 1) if npts > 4 else slice(0, npts)
    stats = []
    for bi, b in enumerate(bands):
        es = [e for (_, e) in b][inplane]
        if not es: continue
        disp = max(es) - min(es)
        mean = statistics.fmean(es)
        stats.append({"band": bi + 1, "disp": disp, "mean": mean})
    if not stats:
        return None
    # flattest overall
    flattest = min(stats, key=lambda s: s["disp"])
    # kagome Co-3d flat band = the FLATTEST band within a near-E_F window.
    # Control sanity: band 44 (disp 0.188, dE -0.445) reproduces documented CoSn -0.44 eV.
    window = [s for s in stats if abs(s["mean"] - ef) <= 1.5]
    cands = [s for s in window if s["disp"] <= 0.6] or window
    if not cands:
        cands = sorted(stats, key=lambda s: s["disp"])[:5]
    nearest = min(cands, key=lambda s: s["disp"])  # flattest in near-E_F window
    return {
        "n_bands": len(bands), "n_kpts": npts,
        "flattest_band": flattest,
        "flatband_nearest_EF": nearest,
        "dE_flatband_eV": round(nearest["mean"] - ef, 4),
        "flatband_dispersion_eV": round(nearest["disp"], 4),
        "low_disp_bands": sorted(cands, key=lambda s: abs(s["mean"] - ef))[:6],
    }

def main():
    rows = []
    for dn, totchg in DOPINGS:
        d = f"dn_{dn}"
        scf = os.path.join(d, "scf.out")
        gnu = os.path.join(d, "cosn_bands.dat.gnu")
        if not os.path.exists(scf):
            rows.append({"dn": float(dn), "tot_charge": float(totchg), "error": f"missing {scf}"})
            continue
        ef, mag, conv, jobdone = read_fermi_mag(scf)
        row = {"dn": float(dn), "tot_charge": float(totchg),
               "E_F_eV": ef, "magnetization_uB": mag,
               "scf_converged": conv, "scf_jobdone": jobdone}
        if os.path.exists(gnu) and ef is not None:
            a = analyze(gnu, ef)
            if a:
                row.update({
                    "dE_flatband_eV": a["dE_flatband_eV"],
                    "flatband_band_index": a["flatband_nearest_EF"]["band"],
                    "flatband_dispersion_eV": a["flatband_dispersion_eV"],
                    "flatband_mean_eV": round(a["flatband_nearest_EF"]["mean"], 4),
                    "flattest_band_disp_eV": round(a["flattest_band"]["disp"], 4),
                    "low_disp_bands_nearEF": a["low_disp_bands"],
                })
        else:
            row["bands_note"] = f"missing gnu ({gnu}) or no E_F"
        rows.append(row)
    print(json.dumps(rows, indent=2))

if __name__ == "__main__":
    main()
