# compute-plan lane r1 — VERDICT 🟢 GATE-DESIGNABLE (ABFE-free pipeline)
## PRIMARY READOUT replaces ABFE: S_total = S_enzyme(β-gal fold)×S_target(f_s/f_q)×S_delivery(local PK)×(1−leak)/coupling(ρ) — ratio-of-ratios → FF systematic error cancels (selectivity by construction). ABFE→binary S0 only (warhead-still-binds-after-caging Y/N).
## STAGED PIPELINE (cheapest-decisive first, all mini-free except S0)
S1 AND-gate S_total + ∂/∂ρ,∂/∂leak sensitivity (numpy) — PASS S_total≥10× across ρ∈[0,.5]×leak∈[0,.2] box; FAIL <2× anywhere → revise. ★NEW prototype.
S2 prodrug β-gal kinetics MM+2-compartment leak (scipy) — PASS sen:norm≥5× & leak≤20%. REUSE round5 r5a_bgal_kinetics.py.
S3 f_s/f_q BCL-2-family priming ODE (BH3-calibrated) — PASS≥3×. build small (round4_models §2 scaffold).
S4 local PK 2-3 compartment — PASS tissue/systemic AUC≥10×.
S5 η_neo PD Pearl do-operator (SASP-Hill) — PASS clearance≥60%→ceiling≥0.90 & causal slope>0. REUSE round7 causal_model.py.
S0 ABFE/MD binary caged-vs-free (GPU·reuse openmmtools round13 harness).
## REUSE (d3/d19): round4 selectivity-pd · round5 kinetics · round7 causal · round13 ABFE harness · hexa autograd/flame. 4/5 stages reuse-or-trivial; only S1 new.
## IN-SILICO DECIDABLE: directionality·robustness·order-of-mag of every selectivity factor + AND-gate logic + causal cure structure. WET-LAB-ONLY (d5 downstream): absolute GLB1 kcat/Km in-situ·real f_s/f_q·in-vivo PK·efficacy.
CITATIONS: BCL-2 ODE 10.1038/msb4100208 · dynamic BH3 10.1038/cdd.2017.183 · Nav-Gal 10.1111/acel.13142.
