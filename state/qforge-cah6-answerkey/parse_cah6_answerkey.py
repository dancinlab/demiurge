#!/usr/bin/env python3
# White-box answer-key derivation for CaH6 el-ph lambda(sigma).
# Parses all 8 QE .elph files (per-mode lambda at 10 Gaussian broadenings),
# builds the BZ-summed lambda(sigma) = sum_q (w_q/W) sum_nu lambda(q,nu).
# 2x2x2 UNREDUCED grid -> every q has weight 1, W = 8.
import glob, os, re

D = os.path.expanduser("~/.hx/src/stdlib/qforge/fixtures/cah6_elph")
files = sorted(glob.glob(os.path.join(D, "cah6.dyn*.elph.*")),
               key=lambda f: int(f.split(".elph.")[1]))

# sigma -> list of per-q (sum_nu lambda)
per_q_sumlam = {}   # sigma -> {qidx: sum_lambda}
per_q_dos = {}      # sigma -> {qidx: DOS}
W = 0.0
qweights = {}

for f in files:
    qidx = int(f.split(".elph.")[1])
    qweights[qidx] = 1.0   # unreduced 2x2x2
    W += 1.0
    with open(f) as fh:
        lines = fh.readlines()
    # header: line0 = q coords + nbroad + nmodes ; then nmodes/6 lines of freqs
    cur_sigma = None
    cur_dos = None
    for ln in lines:
        m = re.search(r"Gaussian Broadening:\s+([\d.]+)\s+Ry", ln)
        if m:
            cur_sigma = float(m.group(1))
            cur_dos = None
            per_q_sumlam.setdefault(cur_sigma, {}).setdefault(qidx, 0.0)
            continue
        md = re.search(r"DOS =\s+([\d.]+)\s+states", ln)
        if md and cur_sigma is not None:
            cur_dos = float(md.group(1))
            per_q_dos.setdefault(cur_sigma, {})[qidx] = cur_dos
            continue
        ml = re.search(r"lambda\(\s*\d+\)=\s+([-\d.]+)\s+gamma", ln)
        if ml and cur_sigma is not None:
            per_q_sumlam[cur_sigma][qidx] += float(ml.group(1))

sigmas = sorted(per_q_sumlam.keys())
print("=== CaH6 el-ph ANSWER-KEY: lambda_BZ(sigma) from 8 QE .elph files ===")
print(f"W (sum of q-weights) = {W:.0f}  (2x2x2 unreduced, w_q=1 each)")
print(f"nq = {len(files)} q-points, 21 modes each, 10 broadenings")
print()
print(f"{'sigma(Ry)':>10} {'lambda_BZ':>12} {'DOS(Ef)avg':>12}")
print("-"*38)
results = {}
for s in sigmas:
    lam_bz = sum(qweights[q]*per_q_sumlam[s][q] for q in per_q_sumlam[s]) / W
    dosvals = list(per_q_dos.get(s, {}).values())
    dos_avg = sum(dosvals)/len(dosvals) if dosvals else float('nan')
    results[s] = lam_bz
    print(f"{s:>10.3f} {lam_bz:>12.5f} {dos_avg:>12.4f}")

print()
print("=== per-q sum_nu lambda at sigma=0.010 (scf-degauss primary) ===")
s = 0.010
for q in sorted(per_q_sumlam[s]):
    print(f"  q{q}: sum_nu lambda = {per_q_sumlam[s][q]:>10.5f}  DOS={per_q_dos[s].get(q,0):.4f}")
print(f"  -> lambda_BZ(0.010) = {results[0.010]:.6f}")

print()
print("=== KEY COMPARISON ===")
print(f"  lambda_BZ(sigma=0.010) = {results[0.010]:.5f}   <- xval test 'QE 8.516825' anchor")
print(f"  lambda_BZ(sigma=0.020) = {results[0.020]:.5f}   <- ph.out scf-degauss alt")
# find which sigma gives ~4.376
print()
print("=== which sigma reproduces the '4.376' headline? ===")
for s in sigmas:
    print(f"  sigma={s:.3f}: lambda_BZ={results[s]:.4f}  (4.376 ratio={results[s]/4.376:.3f})")
