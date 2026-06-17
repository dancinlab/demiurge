#!/usr/bin/env python3
"""
Parse QE bands.x output (cosn_bands.dat, gnuplot &plot format) + scf.out Fermi
level → flat-band offset ΔE = E_flat_mean − E_F for the kagome flat band.

Flat band = the band whose k-dispersion (max−min over the band path) is smallest
within an energy window around E_F. Reports ΔE (eV), the band index, its
dispersion, and the scf magnetization. SAME detector for control + every doped
point so the SHIFT is internally consistent (c9 — no per-point tuning).

Usage: parse_flatband_dE.py <scf.out> <cosn_bands.dat> [window_eV]
"""
import sys, re

def read_fermi(scf_out):
    ef = None
    mag = None
    for line in open(scf_out, errors="ignore"):
        if "Fermi energy" in line:
            m = re.search(r"([-0-9.]+)\s*ev", line)
            if m:
                ef = float(m.group(1))
        if "total magnetization" in line:
            m = re.search(r"([-0-9.]+)", line.split("=")[-1])
            if m:
                mag = float(m.group(1))
    return ef, mag

def read_bands(dat):
    txt = open(dat, errors="ignore").read()
    m = re.search(r"nbnd=\s*(\d+),\s*nks=\s*(\d+)", txt)
    nbnd, nks = int(m.group(1)), int(m.group(2))
    nums = re.findall(r"[-+]?\d+\.\d+", txt.split("/", 1)[1])
    nums = [float(x) for x in nums]
    # each k-block = 3 coords + nbnd energies
    stride = 3 + nbnd
    bands = [[] for _ in range(nbnd)]
    for k in range(nks):
        base = k * stride + 3
        for b in range(nbnd):
            bands[b].append(nums[base + b])
    return nbnd, nks, bands

def main():
    scf_out, dat = sys.argv[1], sys.argv[2]
    window = float(sys.argv[3]) if len(sys.argv) > 3 else 2.0
    ef, mag = read_fermi(scf_out)
    nbnd, nks, bands = read_bands(dat)
    cands = []
    for b in range(nbnd):
        bmin, bmax = min(bands[b]), max(bands[b])
        bmean = sum(bands[b]) / nks
        disp = bmax - bmin
        if (ef - window) <= bmean <= (ef + window):
            cands.append((disp, b, bmean, bmin, bmax))
    cands.sort()
    flat_disp, flat_b, flat_mean, flat_min, flat_max = cands[0]
    dE = flat_mean - ef
    print(f"E_F            = {ef:.4f} eV")
    print(f"magnetization  = {mag} uB/cell")
    print(f"flat band idx  = {flat_b} (1-based {flat_b+1})")
    print(f"flat band disp = {flat_disp:.3f} eV (max-min over path)")
    print(f"flat band mean = {flat_mean:.4f} eV   [min {flat_min:.3f}, max {flat_max:.3f}]")
    print(f"deltaE         = {dE:+.4f} eV   (E_flat_mean - E_F)")
    # also report the 3 flattest near E_F for sanity
    print("  -- 3 flattest near E_F --")
    for disp, b, bmean, bmin, bmax in cands[:3]:
        print(f"     band {b+1}: disp={disp:.3f} mean={bmean:.4f} dE={bmean-ef:+.4f}")

if __name__ == "__main__":
    main()
