#!/usr/bin/env python3
"""Parse LaRu3Si2 bands.out -> locate Ru-kagome flat band, report dE = E_flat - E_F.
A kagome flat band is FLAT across the Gamma-K-M plane (small bandwidth) near E_F.
Strategy: extract per-kpoint eigenvalues, find bands with smallest variance across
the in-plane segment (Gamma-K-M-Gamma = first 3 segments, ~120 kpts), pick the one
nearest E_F. Report dE for the flattest near-E_F manifold. HONEST: also print the
3 flattest bands + their mean energy + bandwidth so a human can adjudicate hybridization.
"""
import re, sys, math

bands_out = sys.argv[1] if len(sys.argv) > 1 else 'bands.out'
scf_out   = sys.argv[2] if len(sys.argv) > 2 else 'scf.out'

# Fermi level from scf.out (eV)
ef = None
for line in open(scf_out):
    m = re.search(r'the Fermi energy is\s+([-\d.]+)\s*ev', line)
    if m: ef = float(m.group(1))
if ef is None:
    print("WARN: E_F not found in scf.out; trying bands.out")
    for line in open(bands_out):
        m = re.search(r'the Fermi energy is\s+([-\d.]+)\s*ev', line)
        if m: ef = float(m.group(1))

txt = open(bands_out).read()
# QE band blocks: "          k =  x y z (   npw ...)\n\n   e1 e2 e3 ...\n"
kblocks = re.findall(r'k =\s*[-\d. ]+\([^)]*\)\s*\n\n((?:\s+[-\d.]+){2,}\s*\n(?:(?:\s+[-\d.]+){1,}\s*\n)*)', txt)
if not kblocks:
    # spin-polarized: bands printed per spin; grab all eigenvalue blocks
    kblocks = re.findall(r'bands \(ev\):\s*\n\n((?:\s+[-\d.]+)+\s*\n(?:(?:\s+[-\d.]+)+\s*\n)*)', txt)

kpts = []
for b in kblocks:
    vals = [float(x) for x in b.split()]
    if vals: kpts.append(vals)

if not kpts:
    print("ERROR: could not parse eigenvalue blocks from", bands_out); sys.exit(2)

nb = min(len(k) for k in kpts)
nk = len(kpts)
print(f"E_F = {ef} eV ; parsed nk={nk} kpoints, nb={nb} bands")

# in-plane segment = first 3 path segments (Gamma-K-M-Gamma). path has 40+40+40+... pts.
# Use first ~120 kpts (or first half if fewer) as the flat-band test window.
inplane = min(120, nk)
def band_stats(j):
    e = [kpts[k][j] for k in range(inplane)]
    mean = sum(e)/len(e)
    bw = max(e) - min(e)
    return mean, bw

stats = [(j,)+band_stats(j) for j in range(nb)]
# candidate flat bands: bandwidth < 0.6 eV AND mean within 1.5 eV of E_F
cands = [s for s in stats if s[2] < 0.6 and abs(s[1]-ef) < 1.5]
cands.sort(key=lambda s: s[2])  # flattest first
print("\n--- flat-band candidates (bandwidth<0.6 eV, within 1.5 eV of E_F) ---")
print(f"{'band':>5} {'mean_eV':>9} {'bw_eV':>7} {'dE=mean-EF':>11}")
for j,mean,bw in cands[:8]:
    print(f"{j+1:5d} {mean:9.4f} {bw:7.4f} {mean-ef:11.4f}")

if cands:
    # pick flattest band nearest E_F among the top-flat ones
    topflat = sorted(cands[:5], key=lambda s: abs(s[1]-ef))
    j,mean,bw = topflat[0]
    dE = mean - ef
    print(f"\n>>> SELECTED Ru-kagome flat band: band#{j+1}, mean={mean:.4f} eV, "
          f"bandwidth={bw:.4f} eV, dE = {dE:+.4f} eV")
    av = abs(dE)
    if av < 0.10: verdict = "PASS (GREEN)"
    elif dE > 0.2: verdict = "FALSIFY (RED, dE>0.2)"
    elif av > 0.2: verdict = "FALSIFY (RED, |dE|>0.2)"
    else: verdict = "INCONCLUSIVE (ORANGE, 0.1<=|dE|<=0.2)"
    print(f">>> |dE| = {av:.4f} eV -> gate (dE axis): {verdict}")
else:
    print("\nNo clear flat band within 1.5 eV of E_F (bandwidth<0.6). "
          "Report band manifold honestly + reasoning (Ru-4d may hybridize/disperse).")
