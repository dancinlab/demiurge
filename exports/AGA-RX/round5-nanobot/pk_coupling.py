#!/usr/bin/env python3
"""AGA-RX round5-nanobot — couple the GATED actuation (gated_actuation.hexa, ACTUAL sim
output in sim_out.txt) to the INHERITED follicular PK (round3-admet-pk/PK.md).

INHERITED (verified, NOT re-derived):
  C(z) = C_surf * exp(-z / lambda_foll)            [round3-admet-pk 3b; TTR-LAC/A3]
  z_DP (dermal-papilla / hair-bulb depth)  = 1.0-1.5 mm    [round3-admet-pk 2]
  lambda_foll (follicular-shunt attenuation length) bracket 0.2-2.0 mm [round3 2]
  t_lag = z_DP^2 / (6 D_foll); onset = 2 t_lag      -> days-to-weeks, once-daily steady-state
  carrier base = O/W nanoemulsion <=200 nm, >=50% 6 h retention   [round4-synthesize FORMULATION.md]

ACTUAL gate actuation fractions (from gated_actuation.hexa run, sim_out.txt):
  pH gate (pKa 6.0, Hill 1.5):   duct pH5 act_frac=0.0337 ; DPC pH7 act_frac=0.8903
  esterase gate (Km, Hill 2.0):  transit 0.1x act_frac=0.0197 ; DPC 10x act_frac=0.8958
  reference:                     CLOSED 0.0265 ; OPEN(=inherited ungated) 0.8914
  work_per_cycle = 50 kT held across all theta (inherited >=10 kT Brownian floor preserved)

This script does NOT introduce a fabricated constant: every release propensity is the
ACTUAL act_frac from the hexa sim; every PK carry-fraction is the inherited C(z)/C_surf.
"""
import math

# --- actual sim act_frac (release propensity per pass) ---
rel = {
    "pH":      {"duct": 0.0337, "dpc": 0.8903},
    "esterase":{"duct": 0.0197, "dpc": 0.8958},
}
rel_ungated = 0.8914   # OPEN reference: no spatial selectivity, leaks everywhere

# --- inherited PK carry-fraction C(z_DP)/C_surf to the DPC depth ---
carry = {"z1.0_lam1.0": 0.368, "z1.5_lam1.0": 0.223, "z1.0_lam2.0": 0.607}

print("=== DPC-targeted release: GATED vs UNGATED (2-compartment duct->DPC pass) ===")
print("payload descends the follicular duct (transit, low stimulus) -> arrives at DPC (high stimulus).")
print()
for g, rr in rel.items():
    print(f"--- {g} gate ---")
    for ck, cf in carry.items():
        survive = 1 - rr["duct"]            # not prematurely released en-route
        arrived = survive * cf              # PK attenuation to DPC depth
        dpc_rel = arrived * rr["dpc"]       # released at the DPC
        survive_u = 1 - rel_ungated
        dpc_rel_u = survive_u * cf * rel_ungated
        ratio = dpc_rel / dpc_rel_u if dpc_rel_u else float("inf")
        print(f"  {ck}: gated DPC-release={dpc_rel*100:5.1f}%  ungated={dpc_rel_u*100:5.1f}%  "
              f"gated/ungated={ratio:4.1f}x  (en-route leak gated={rr['duct']*100:.1f}% vs ungated={rel_ungated*100:.1f}%)")
    print()

print("=== DPC-targeting FIDELITY = released-at-DPC / total-released ===")
cf = 0.368  # central bracket (z_DP=1.0mm, lambda_foll=1.0mm)
for g, rr in rel.items():
    enroute = rr["duct"]
    dpc = (1 - rr["duct"]) * cf * rr["dpc"]
    fid = dpc / (enroute + dpc)
    enroute_u = rel_ungated
    dpc_u = (1 - rel_ungated) * cf * rel_ungated
    fid_u = dpc_u / (enroute_u + dpc_u)
    print(f"  {g}: gated fidelity={fid*100:.1f}%  vs ungated={fid_u*100:.1f}%  (lift x{fid/fid_u:.1f})")
