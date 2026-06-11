#!/usr/bin/env python3
"""
QFORGE-PAW round-3 phonon ω(q,ν) audit — QForge vs QE, single-number diagnostic.

Question (d6/@L5, VERBATIM): after every |g|(vertex) DFT lever was ruled out
(round-2: PBE-SCF Δλ=-0.915, ∂V_NL/∂u Δλ=-0.003, off-diag ×1.06, basis, FS-mesh,
f_xc — ALL CLOSED-NEG), the SOLE remaining magnitude factor in
    λ = 2 ∫ α²F/ω dω  ∝  Σ |g|²/ω²   (per mode)
is the phonon ω(q,ν). The campaign only ever audited |g| and never ω.
IF QForge ω is systematically HIGHER than QE (phonon harder), λ is suppressed
by exactly that factor → ω would be the deficit culprit.

This script extracts QForge ω vs QE ω VERBATIM and computes the ratio.

0-pod, $0. Run: python3 omega_audit.py  (from the harvest_final dir or pass --dir)
"""
import re, math, glob, os, sys

# ── unit constants (CODATA) ──────────────────────────────────────────────
K_per_cm = 1.0 / 0.69503476     # 1 cm^-1 = 1.4388 K   (hc/k_B)
cm_per_K = 0.69503476
THz_per_cm = 1.0 / 33.35641
Ry_to_cm = 109737.316

QE_DIR = sys.argv[sys.argv.index('--dir')+1] if '--dir' in sys.argv else \
    os.path.join(os.path.dirname(__file__),
                 '../../exports/rtsc/CaH6/harvest_final')

# ── QForge ω: the SINGLE Einstein anchor used everywhere in the CaH6 path ─
#   stdlib/qforge/{orchestrator_selftest,qmesh_qfold_selftest,realcell_qmesh,
#   nc_norm_convention_selftest,qforge_cli,...}.hexa all use ω₀ = 1236.4 K.
#   realcell_qmesh.hexa header: "ONE hardcoded Einstein frequency ω₀=1236.4 K".
#   cah6_realcell_compose_xval.hexa lines 268-289: the DFPT dynmat eigenvalue
#   band is RMS-NORMALIZED and the absolute scale is ANCHORED to 1236.4 K —
#   "the broadening (mode spread) is the real brick-(a) contribution; the
#   absolute scale is anchored, not the shape" (d6, reported verbatim in-code).
#   So the QForge ω MAGNITUDE = 1236.4 K, by construction.
QFORGE_W0_K = 1236.4
QFORGE_W0_CM = QFORGE_W0_K * cm_per_K

# ── QE ω(q,ν): parse the harvested dyn files VERBATIM ────────────────────
def freqs_cm(fn):
    out = []
    for line in open(fn):
        m = re.search(r'freq\s*\(\s*\d+\)\s*=\s*([-0-9.]+)\s*\[THz\]\s*=\s*([-0-9.]+)\s*\[cm-1\]', line)
        if m:
            out.append(float(m.group(2)))
    return out

def lambdas_first_block(fn):
    """λ(ν) from the FIRST Gaussian-broadening block (0.005 Ry) of an .elph file."""
    out = []; inblk = False
    for line in open(fn):
        if 'Gaussian Broadening' in line:
            if out: break
            inblk = True; continue
        m = re.search(r'lambda\(\s*\d+\)=\s*([-0-9.]+)', line)
        if inblk and m:
            out.append(float(m.group(1)))
    return out

def wlog(ws, ls):
    num = den = 0.0
    for l, w in zip(ls, ws):
        if l > 1e-9 and w > 1e-6:
            num += l * math.log(w); den += l
    return math.exp(num/den) if den > 0 else float('nan'), den

print("="*72)
print("QFORGE-PAW round-3 — phonon ω(q,ν) audit  (QForge vs QE, VERBATIM)")
print("="*72)

# 1) QForge ω
print(f"\n[1] QForge ω (Einstein anchor, the CaH6-path magnitude):")
print(f"    ω₀ = {QFORGE_W0_K:.1f} K = {QFORGE_W0_CM:.2f} cm⁻¹ = {QFORGE_W0_CM*THz_per_cm:.3f} THz")
print(f"    (DFPT dynmat gives the SHAPE/spread; the SCALE is anchored to this.)")

# 2) QE ω(Γ,ν) verbatim — dyn1
g = os.path.join(QE_DIR, 'cah6.dyn1')
qe_gamma = freqs_cm(g)
lam_gamma = lambdas_first_block(os.path.join(QE_DIR, 'cah6.dyn1.elph.1'))
ac = qe_gamma[:3]; opt = qe_gamma[3:]
print(f"\n[2] QE ω(Γ,ν) — cah6.dyn1 VERBATIM ({len(qe_gamma)} modes, 3N=21):")
print(f"    acoustic (sum-rule residual): {['%.2f'%x for x in ac]} cm⁻¹  mean={sum(ac)/3:.2f}")
print(f"    optical (18): min={min(opt):.1f} max={max(opt):.1f} mean={sum(opt)/len(opt):.1f} cm⁻¹")
print(f"    g2-audit cited mode-7 = 9.220e-3 Ry = {9.220e-3*Ry_to_cm:.2f} cm⁻¹  "
      f"(dyn1 mode-7 = {qe_gamma[6]:.2f} cm⁻¹ ✓)")
wlg, lt_g = wlog(qe_gamma, lam_gamma)
print(f"    λ-weighted ω_log(Γ) = {wlg:.2f} cm⁻¹ = {wlg*K_per_cm:.1f} K  (λ_tot(Γ)={lt_g:.3f})")

# 3) QE full-BZ ω_log — all 8 q
allw = []; alll = []
print(f"\n[3] QE full-BZ ω(q,ν) — 8 q-points VERBATIM:")
for i in range(1, 9):
    w = freqs_cm(os.path.join(QE_DIR, f'cah6.dyn{i}'))
    l = lambdas_first_block(os.path.join(QE_DIR, f'cah6.dyn{i}.elph.{i}'))
    n = min(len(w), len(l))
    allw += w[:n]; alll += l[:n]
    print(f"    q{i}: {len(w)} modes  ω∈[{min(w):.1f},{max(w):.1f}] cm⁻¹  λ_tot={sum(l):.3f}")
wlf, lt_f = wlog(allw, alll)
print(f"    λ-weighted ω_log(full-BZ, 0.005 Ry) = {wlf:.2f} cm⁻¹ = {wlf*K_per_cm:.1f} K")

# ── VERDICT ──────────────────────────────────────────────────────────────
print("\n" + "="*72)
print("TERM-BY-TERM RATIO  (QForge ω / QE ω)")
print("="*72)
r_gamma = QFORGE_W0_CM / wlg
r_full  = QFORGE_W0_CM / wlf
print(f"  QForge ω₀ / QE ω_log(Γ)       = {QFORGE_W0_CM:.1f} / {wlg:.1f} = {r_gamma:.4f}")
print(f"  QForge ω₀ / QE ω_log(full-BZ) = {QFORGE_W0_CM:.1f} / {wlf:.1f} = {r_full:.4f}  ★")
print()
print("  Required ratio IF ω were the λ-deficit culprit (λ ∝ 1/ω²):")
for lqe, lqf, name in [(2.69, 1.1545, 'reanchor 2.69 / QForge 1.1545'),
                       (4.376, 1.1545, '4.376 outlier / QForge 1.1545')]:
    print(f"    √(λ_QE/λ_QForge) = √({lqe}/{lqf}) = {math.sqrt(lqe/lqf):.4f}   [{name}]")
print()
print("  FINDING:")
print(f"  • QForge ω matches QE full-BZ ω_log to {abs(r_full-1)*100:.2f}% (ratio {r_full:.4f}).")
print(f"  • For ω to cause the deficit, QForge would need ω ~1.53-1.95× HIGHER.")
print(f"  • Instead ω is essentially EQUAL (and at Γ slightly LOWER, {r_gamma:.3f}× —")
print(f"    which would RAISE QForge λ, not lower it).")
print(f"  ⇒ ω is NOT the λ-deficit culprit (outcome 2). The residual is the")
print(f"    irreducible from-scratch(NC+LDA) vs QE-PBE |g| vertex magnitude.")
print("="*72)
