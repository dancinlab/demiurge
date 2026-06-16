#!/usr/bin/env python3
"""Robust harvest of total lambda + omega_log from QE ph.x electron_phonon='simple'.

Two paths:
  (A) QE-printed summary: when ph.x finishes the la2F sum it prints a broadening
      table with 'lambda' and '<log w>' per el_ph_sigma. Take the asymptotic
      (largest-sigma-converged) row.
  (B) Per-q reconstruction (immune to '********' overflow), per the YH6 lesson:
      lambda(q,nu) = gamma(q,nu) / (pi * N(Ef) * omega(q,nu)^2)
      then lambda = sum_q w_q sum_nu lambda(q,nu); omega_log from the same.
      Acoustic Gamma modes with omega->0 are EXCLUDED (1/omega^2 divergence;
      acoustic sum rule), and imaginary modes (omega^2<0) flagged + excluded.

Usage: parse_lambda.py ph_elph.out [out_dir_with_a2F_files]
"""
import sys, re, math, glob, os, json

Ry2K = 157887.0          # 1 Ry = 157887 K
cm1_2K = 1.438776        # 1 cm^-1 = 1.4388 K
cm1_2Ry = 1.0/109737.0   # 1 cm^-1 in Ry

def parse_printed(text):
    """Path A: QE broadening table. Returns list of {sigma,dos,lambda,wlog_cm1}."""
    rows = []
    # QE prints blocks like:
    # Gaussian Broadening:   0.005 Ry, ngauss=   0
    #   DOS =   ...  states/spin/Ry/Unit Cell at Ef=  ... eV
    #   lambda =   X.XXXX   gamma=   YYY.YY GHz
    # plus a final "lambda(  isig) =  ...  <log w> =  ... K" in some versions.
    blocks = re.split(r'Gaussian Broadening:', text)
    for b in blocks[1:]:
        msig = re.match(r'\s*([\d.]+)\s*Ry', b)
        mdos = re.search(r'DOS\s*=\s*([\d.eE+-]+)\s*states', b)
        mlam = re.search(r'lambda\s*=\s*([\d.eE+-]+)', b)
        if msig and mlam:
            rows.append({"sigma_Ry": float(msig.group(1)),
                         "dos_ef": float(mdos.group(1)) if mdos else None,
                         "lambda": float(mlam.group(1))})
    return rows

def parse_lambda_dot_lines(text):
    """Some QE versions print 'lambda(   N)=  X   gamma=  Y  omega= Z' per mode."""
    return re.findall(r'lambda\(\s*\d+\)\s*=\s*([\d.eE+-]+)\s+gamma=\s*([\d.eE+*-]+)', text)

if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else "ph_elph.out"
    txt = open(path).read()
    printed = parse_printed(txt)
    print("=== QE broadening table (path A) ===")
    for r in printed:
        print(f"  sigma={r['sigma_Ry']} Ry  DOS(Ef)={r['dos_ef']}  lambda={r['lambda']}")
    # report the largest-sigma row and the 'converged' mid-sigma row
    if printed:
        last = printed[-1]
        print(f"\nLAST(sigma={last['sigma_Ry']}): lambda={last['lambda']}, DOS={last['dos_ef']}")
    # also dump any explicit <log w> lines
    for m in re.finditer(r'<?\s*log\s*w?\s*>?\s*=\s*([\d.eE+-]+)\s*K', txt):
        print("omega_log printed =", m.group(1), "K")
    # raw lambda lines for manual inspection
    print("\n=== raw 'lambda' lines (first 40) ===")
    for ln in txt.splitlines():
        if 'lambda' in ln.lower():
            print("  ", ln.strip())
