#!/usr/bin/env python3
# Deterministic assembly of total lambda, omega_log, Allen-Dynes Tc for LaH10
# from QE electron_phonon='simple' per-q elph files. Replicates lambda.x math.
import re, math, glob, os

RY_TO_CM1 = 109737.31568   # 1 Ry = 109737.316 cm-1
WQ = 0.125                 # 2x2x2 nosym grid, 8 q-points equal weight
MUSTAR = 0.10

qfiles = [f"lah10.dyn{q}.elph.{q}" for q in range(1,9)]
# broadening index -> Ry value
broad_vals = [0.005*i for i in range(1,11)]

# per file: parse header freqs (Ry) and per-broadening lambda(nu)
def parse(fn):
    lines = open(fn).read().splitlines()
    hdr = lines[0].split()
    nsig = int(hdr[-2]); nmodes = int(hdr[-1])
    # frequencies: read nmodes floats from lines[1:] until we hit 'Gaussian'
    freqs = []
    i = 1
    while len(freqs) < nmodes:
        toks = lines[i].split()
        freqs += [float(x) for x in toks]
        i += 1
    # QE elph file stores omega^2 in Ry^2; convert to omega in Ry (sqrt, guard neg)
    freqs = [ (math.sqrt(x) if x > 0 else -math.sqrt(-x)) for x in freqs[:nmodes] ]
    # per broadening: capture DOS and lambda list
    blocks = {}
    cur_b = None
    lam = []
    dos = None
    for ln in lines[i:]:
        mb = re.search(r'Gaussian Broadening:\s+([\d.]+) Ry', ln)
        if mb:
            if cur_b is not None:
                blocks[cur_b] = (dos, lam)
            cur_b = float(mb.group(1)); lam = []; dos = None; continue
        md = re.search(r'DOS =\s+([\d.]+)', ln)
        if md: dos = float(md.group(1)); continue
        ml = re.search(r'lambda\(\s*\d+\)=\s*([\d.\-Ee+]+)\s+gamma=\s*([\d.\-Ee+]+)', ln)
        if ml: lam.append(float(ml.group(1)))
    if cur_b is not None:
        blocks[cur_b] = (dos, lam)
    return freqs, nmodes, blocks

data = {q: parse(qfiles[q-1]) for q in range(1,9)}

print("=== per-q parse summary ===")
for q in range(1,9):
    fr,nm,bl = data[q]
    print(f"q{q}: nmodes={nm} broadenings={len(bl)} sum_lam(0.005)={sum(bl[0.005][1]):.4f} DOS(0.005)={bl[0.005][0]}")

print("\n=== lambda / omega_log / Tc sweep over broadening ===")
print(f"{'broad(Ry)':>9} {'lambda':>9} {'wlog(K)':>9} {'Tc_AD(K)':>9} {'Tc_McM(K)':>9}")
for b in broad_vals:
    b = round(b,3)
    lam_tot = 0.0
    lam_lnw = 0.0
    lam_w2  = 0.0
    ok = True
    for q in range(1,9):
        fr,nm,bl = data[q]
        if b not in bl:
            # match by closest key
            key = min(bl.keys(), key=lambda k: abs(k-b))
        else:
            key = b
        dos, lam = bl[key]
        for nu in range(nm):
            l = lam[nu]
            w_ry = fr[nu]
            if w_ry <= 1e-9:   # skip acoustic ~0 / imaginary
                continue
            w_cm = w_ry * RY_TO_CM1
            lam_tot += WQ * l
            lam_lnw += WQ * l * math.log(w_cm)
            lam_w2  += WQ * l * w_cm*w_cm
    if lam_tot <= 0:
        print(f"{b:>9} {lam_tot:>9.4f}  (no coupling)"); continue
    wlog_cm = math.exp(lam_lnw/lam_tot)
    wlog_K  = wlog_cm * 1.43877   # cm-1 -> K
    # Allen-Dynes
    mu = MUSTAR
    f_exp = math.exp(-1.04*(1+lam_tot)/(lam_tot - mu*(1+0.62*lam_tot)))
    Tc_AD = (wlog_K/1.2) * f_exp
    # McMillan (same prefactor form, theta_D->wlog)
    Tc_McM = Tc_AD
    print(f"{b:>9} {lam_tot:>9.4f} {wlog_K:>9.2f} {Tc_AD:>9.2f} {Tc_McM:>9.2f}")
