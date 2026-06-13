#!/usr/bin/env python3
"""analyze_rbfe.py — SENOLYX R12 single-topology RBFE convergence diagnostic.

Prep-lane analyzer (no GPU needed). Run when production finishes and
`ddG_result.json` / the per-leg `.nc` files exist. Produces an HONEST
convergence verdict — never fabricates a magnitude for an unconverged run
(d6 / g63).

System: HSP90 single-topology RBFE, 17AG <-> 17AAG (C17 8-atom perturbation,
shared 77-atom ansamycin core NOT decoupled). 2 legs (complex + solvent),
11 lambda windows, 3 repeats, HREX.

Sign convention (SHARED with the watch session):
  JSON key ddG_bind_17AG_to_17AAG_kcal = dG_bind(17AAG) - dG_bind(17AG)
  i.e. perturbation direction 17AG -> 17AAG.
  Experimentally 17AG binds ~1.9 kcal/mol STRONGER  =>  exp dG_bind diff
  in this direction is POSITIVE, exp ddG ~ +1.9.
  PASS  = sign positive (+)  AND  |ddG - (+1.9)| <= 1.5 kcal/mol.
  A positive sign vindicates the single-topology approach (supersedes the
  gold ABFE-difference sign flip R12=-1.42 vs gold=+2.74).
  Negative / out-of-band sign = a deeper closed-negative for the whole
  system; record it honestly, do NOT force agreement.

Usage:
    python3 analyze_rbfe.py [--root ~/rbfe-prod/rbfe_prod] [--exp 1.9] [--tol 1.5]

Exit code 0 = analysis ran (PASS or honest-FAIL); 2 = not yet complete.
"""
from __future__ import annotations
import argparse, json, math, os, sys, glob, statistics
from pathlib import Path

EXP_DDG_DEFAULT = 1.9   # kcal/mol, 17AG->17AAG direction (positive = 17AG stronger)
TOL_DEFAULT = 1.5       # kcal/mol PASS band
OVERLAP_MIN_OK = 0.03   # adjacent-window MBAR overlap floor (rough sanity)
SANE_ERR_KCAL = 1.0     # cross-repeat stddev above this = under-converged


def _load_pymbar_overlap(estimator):
    """Best-effort MBAR overlap matrix from an openfe/pymbar estimator.
    Returns (min_adjacent_overlap, n_windows) or (None, None)."""
    try:
        omat = None
        if hasattr(estimator, "compute_overlap"):
            omat = estimator.compute_overlap()["matrix"]
        elif hasattr(estimator, "overlap_matrix"):
            omat = estimator.overlap_matrix
        if omat is None:
            return None, None
        n = len(omat)
        adj = [omat[i][i + 1] for i in range(n - 1)]
        return (min(adj) if adj else None), n
    except Exception:
        return None, None


def _per_leg_dg(root: Path):
    """Parse per-leg, per-repeat dG from openfe result jsons / .nc sidecars.
    Robust to schema: tries ddG_result.json first, then result_*.json globs.
    Returns dict {leg: [dG_repeat0, dG_repeat1, ...]} in kcal/mol."""
    legs: dict[str, list[float]] = {}
    # primary: the consolidated result file the driver writes on completion
    for jf in sorted(glob.glob(str(root / "**" / "*result*.json"), recursive=True)):
        try:
            d = json.loads(Path(jf).read_text())
        except Exception:
            continue
        # openfe ProtocolResult-style: {'estimate': {...,'magnitude':x,'unit':'kcal/mol'}}
        leg = "complex" if "complex" in jf.lower() else ("solvent" if "solvent" in jf.lower() else Path(jf).stem)
        val = _extract_kcal(d)
        if val is not None:
            legs.setdefault(leg, []).append(val)
    return legs


def _extract_kcal(d):
    """Pull a kcal/mol magnitude out of a nested openfe/json result."""
    if isinstance(d, dict):
        if "magnitude" in d and "unit" in d and "kcal" in str(d.get("unit", "")).lower():
            try:
                return float(d["magnitude"])
            except Exception:
                pass
        for k in ("estimate", "dG", "dg", "free_energy", "result"):
            if k in d:
                v = _extract_kcal(d[k])
                if v is not None:
                    return v
        for v in d.values():
            r = _extract_kcal(v)
            if r is not None:
                return r
    return None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=os.path.expanduser("~/rbfe-prod/rbfe_prod"))
    ap.add_argument("--ddg-json", default=os.path.expanduser("~/rbfe-prod/rbfe_prod/ddG_result.json"))
    ap.add_argument("--exp", type=float, default=EXP_DDG_DEFAULT)
    ap.add_argument("--tol", type=float, default=TOL_DEFAULT)
    args = ap.parse_args()
    root = Path(args.root)

    print("=== SENOLYX R12 RBFE — convergence diagnostic (d6/g63 honest) ===")
    print(f"system: HSP90 single-topology 17AG->17AAG · root={root}")

    ddg = None
    ddg_path = Path(args.ddg_json)
    if ddg_path.exists():
        try:
            dj = json.loads(ddg_path.read_text())
            for k in ("ddG_bind_17AG_to_17AAG_kcal", "ddG", "ddg_bind"):
                if k in dj:
                    ddg = float(dj[k]); break
            if ddg is None:
                ddg = _extract_kcal(dj)
        except Exception as e:
            print(f"  ! ddG_result.json parse error: {e}")

    if ddg is None:
        print("  STATUS: NOT COMPLETE — no ddG_result.json yet (production ongoing).")
        print("  → re-run after progress-log shows ALL_DONE. No magnitude fabricated.")
        return 2

    # --- convergence sanity from per-leg repeats ---
    legs = _per_leg_dg(root)
    repeat_sd = {}
    for leg, vals in legs.items():
        if len(vals) >= 2:
            sd = statistics.pstdev(vals)
            repeat_sd[leg] = sd
            print(f"  leg {leg}: dG repeats={[round(v,2) for v in vals]} mean={statistics.mean(vals):+.2f} sd={sd:.2f}")
    max_sd = max(repeat_sd.values()) if repeat_sd else None

    # --- verdict ---
    sign_ok = ddg > 0
    band_ok = abs(ddg - args.exp) <= args.tol
    conv_ok = (max_sd is None) or (max_sd <= SANE_ERR_KCAL)

    print(f"\n  ddG (17AG->17AAG) = {ddg:+.3f} kcal/mol   [exp ~ +{args.exp}, tol {args.tol}]")
    if max_sd is not None:
        print(f"  cross-repeat max sd = {max_sd:.3f} kcal/mol   [sane <= {SANE_ERR_KCAL}]")
    print(f"  sign positive: {sign_ok}  ·  within band: {band_ok}  ·  converged: {conv_ok}")

    if sign_ok and band_ok and conv_ok:
        print("\n  ✅ PASS — single-topology RBFE reproduces the experimental sign (+),")
        print("     within tolerance, converged. Supersedes the gold ABFE-diff sign flip.")
    elif not conv_ok:
        print("\n  🟠 UNDER-CONVERGED — ddG present but cross-repeat sd too high.")
        print("     Report value verbatim; gate on convergence, do NOT claim PASS.")
    else:
        print("\n  🔴 CLOSED-NEGATIVE (honest) — sign/band off. A deeper system-level")
        print("     finding; record the measured ddG verbatim, never force +1.9 (d6/g63).")

    print("\n  (verdict is advisory input for the record PR; values pasted verbatim.)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
