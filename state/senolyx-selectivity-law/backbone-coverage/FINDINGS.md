# backbone-coverage lane r2 — VERDICT 🔵 (no pan-dependency) / 🟠 (magnitudes inferred)

## SUBSTRATE
SenePy 72mouse+64human=136 signatures; NO gene in every signature; most-universal p16 only ~28% (12/43); marker ceiling ~0.28.

## RANKED backbones by p_dep (kill-dependency coverage)
BCL-xL+MCL-1 priming **0.65** (resid 35%) DEP 10.18632/aging.204207 · GPX4/ferroptosis 0.58 (42%) DEP 10.1038/s41556-026-01921-z · HSP90 0.52 DEP · BCL-xL alone 0.45 · p53/FOXO4 0.42 · PI3K/AKT 0.38 · NAD/NAMPT 0.25 · **GLS1 0.18 FLAGGED** (EMBO Rep 2026 in-vivo repro FAIL 10.1038/s44319-026-00740-5) · SA-β-gal/lysosomal **0.92 but MARKER not kill**.

## WINNER + residual
Best DEPENDENCY backbone = BCL-xL+MCL-1 (p_dep≈0.65); dual-stack BCL∪GPX4 → 0.73-0.85 (ρ-dep); **irreducible residual refractory 15-35%**. NO truly pan-senescent dependency exists (best 0.65<0.90) — consistent w/ round-1 theorem f_clear≤p_dep<1.

## MARKER vs DEPENDENCY (AND-gate design)
SA-β-gal (0.92) = near-universal RECOGNITION tag (not kill) · BCL-combo (0.65) = primary KILL backbone · GPX4 (0.58) = orthogonal 2nd kill axis · GLS1 = AVOID as backbone.
DESIGN: backbone = pan-senescent DEPENDENCY (BCL-combo ± GPX4); AND-gate selectivity = non-lethal recognition tags (SA-β-gal + context) layered for margin.

## CAVEATS (d6)
p_dep = inferred coverage projections (per-paper 3-5 line panels onto 136-sig substrate; no single cross-panel) → ±0.10-0.15. GLS1 demoted on cross-lab repro failure. Direction firm (no pan-dependency); magnitudes 🟠.
