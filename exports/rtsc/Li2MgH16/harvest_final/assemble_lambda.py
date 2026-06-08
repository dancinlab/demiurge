#!/usr/bin/env python3
# Deterministic assembly of total lambda, omega_log, Allen-Dynes Tc for Li2MgH16
# from QE electron_phonon='simple' per-q elph files. Replicates lambda.x math.
# Adapted (d19 reuse) from LaH10 lambda_terminal/assemble_lambda.py.
# Data provenance: recovered from destroyed vast anchor pod 39610026 (8/8 q complete).
# Cell: nat=38 (Li2MgH16 x2 fu), 114 modes/q, 2x2x2 nosym grid (8 q, equal weight).
# scf degauss = 0.020 Ry (MP) -> primary el-ph broadening.
import re, math, glob, os

RY_TO_CM1 = 109737.31568   # 1 Ry = 109737.316 cm-1
WQ = 0.125                 # 2x2x2 nosym grid, 8 q-points equal weight (1/8)
PRIMARY = 0.020            # scf MP degauss (Ry) = self-consistent broadening

qfiles = [f"li2mgh16.dyn{q}.elph.{q}" for q in range(1,9)]
broad_vals = [round(0.005*i,3) for i in range(1,11)]  # el_ph_sigma sweep

def parse(fn):
    lines = open(fn).read().splitlines()
    hdr = lines[0].split()
    nsig = int(hdr[-2]); nmodes = int(hdr[-1])
    freqs = []
    i = 1
    while len(freqs) < nmodes:
        toks = lines[i].split()
        freqs += [float(x) for x in toks]
        i += 1
    # QE elph file stores omega^2 in Ry^2; convert to omega in Ry (sqrt, guard neg)
    freqs = [ (math.sqrt(x) if x > 0 else -math.sqrt(-x)) for x in freqs[:nmodes] ]
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
    keys = sorted(bl.keys())
    print(f"q{q}: nmodes={nm} broadenings={len(bl)} sum_lam(0.020)={sum(bl[min(bl,key=lambda k:abs(k-PRIMARY))][1]):.4f} DOS(0.020)={bl[min(bl,key=lambda k:abs(k-PRIMARY))][0]}")

def assemble(b, mustar):
    lam_tot = 0.0; lam_lnw = 0.0
    for q in range(1,9):
        fr,nm,bl = data[q]
        key = b if b in bl else min(bl.keys(), key=lambda k: abs(k-b))
        dos, lam = bl[key]
        for nu in range(nm):
            l = lam[nu]; w_ry = fr[nu]
            if w_ry <= 1e-9:   # skip acoustic ~0 / imaginary
                continue
            w_cm = w_ry * RY_TO_CM1
            lam_tot += WQ * l
            lam_lnw += WQ * l * math.log(w_cm)
    if lam_tot <= 0:
        return lam_tot, None, None
    wlog_cm = math.exp(lam_lnw/lam_tot)
    wlog_K  = wlog_cm * 1.43877   # cm-1 -> K
    f_exp = math.exp(-1.04*(1+lam_tot)/(lam_tot - mustar*(1+0.62*lam_tot)))
    Tc_AD = (wlog_K/1.2) * f_exp
    return lam_tot, wlog_K, Tc_AD

print("\n=== lambda / omega_log / Tc sweep over broadening (mu*=0.10) ===")
print(f"{'broad(Ry)':>9} {'lambda':>9} {'wlog(K)':>9} {'Tc_AD(K)':>9}")
for b in broad_vals:
    lam, wl, tc = assemble(b, 0.10)
    if lam <= 0: print(f"{b:>9} {lam:>9.4f}  (no coupling)"); continue
    print(f"{b:>9} {lam:>9.4f} {wl:>9.2f} {tc:>9.2f}")

print("\n=== PRIMARY broadening (scf degauss = 0.020 Ry) — gate anchor number ===")
for mu in (0.10, 0.13):
    lam, wl, tc = assemble(PRIMARY, mu)
    print(f"mu*={mu:.2f}:  lambda={lam:.4f}  omega_log={wl:.2f} K  Tc_AD={tc:.2f} K")
