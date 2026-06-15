@V := "discovery" :: flatband-at-ef-candidates [active]
  id      = "flatband-at-ef-candidates-20260615"
  date    = "2026-06-15"
  domain  = "RTSC"
  seed    = "no-cooling/ambient-pressure flat-band SC: find a host whose flat band sits AT E_F (|dE|<0.1eV) AND is non-magnetic AND ambient-stable — beating the campaign's two confirmed failure modes (dE-offset: CoSn -0.44, CsV3Sb5 +0.92; competing magnetism: RbOs2O6 robust ~3-5uB PBE)"
  method  = "d18 round-1 fan-out: arxiv+web deep research (WebSearch/WebFetch) + first-principles line-graph NOVEL reasoning + 2-axis screen (dE from E_F, magnetism, ambient stability)"
  verdict-tier-target = "🟢 GATE_CLOSED_MEASURED via QE/QFORGE scf+bands (dE) + nspin=2 SCF (magnetism) per candidate; falsifier pre-registered per top pick"

# ──────────────────────────────────────────────────────────────────────────
# RANKED CANDIDATE TABLE — flat band AT/near E_F · non-magnetic · ambient
# (dE = E_flatband − E_F; |dE| small = good. The bar to beat: CoSn -0.44 mag,
#  CsV3Sb5 +0.92 nonmag, RbOs2O6 ~0 but robustly PBE-magnetic.)
# ──────────────────────────────────────────────────────────────────────────
# rank | candidate    | lattice / SG          | est dE from E_F        | magnetic? | ambient? | source                       | first DFT check
# ①   | MoSn/HfSn/NbSn| 1:1 kagome (CoSn-type, | "near E_F", d-orbital  | NON-MAG   | YES dyn+ | arXiv 2605.24822 (Jiao/Qiao/ | QE scf+bands nspin=2: confirm
#      | (MMSn family) |  P6/mmm class)        | FB, exact dE NOT given  | (predicted)| thermo  | Zhou/Lu/Zhang 2026)          | dE & nm; FB-at-E_F? then DFPT λ/Tc
#      |              |                        | in abstract → DFT needed|           | stable  | predicts λ-driven Tc 1.7-2.3K|
# ②   | LaRu3Si2     | Ru kagome, P6/mmm      | flat band "near E_F",   | NON-MAG   | YES,     | arXiv 2503.22477 (2025) +    | QE scf+bands: locate Ru-dz2 FB
#      |              |  (LaRu3Si2-type)       | Ru-dz2; exact dE→DFT    | (real SC) | real     | Princeton μSR nodeless paper | dE; reproduce mode-selective λ
#      |              |                        |                         |           | crystal  | (osti 1822402)               | (Tc 7K — highest real of set)
# ③   | Sc2Ir4-xSix  | kagome / C15 Laves     | FB AT E_F (SOC-driven)  | NON-MAG   | YES real | arXiv 2310.03609 / Commun.   | QE scf+bands WITH SOC: confirm
#      | (x≈0.5 opt)  |                        | only when SOC included  | (real SC) | crystal  | Mater. s43246-024-00521-4    | SOC FB at E_F; nm check
# ④   | CsTi3Bi5 /   | Ti kagome, P6/mmm      | −0.25 eV (ARPES meas.)  | NON-MAG   | YES real | Nat.Commun s41467-023-40515-3| QE scf+bands: reproduce −0.25;
#      | RbTi3Bi5     |                        | shallower than CoSn      | (real SC, | crystal, | + Research 0238 (Tc~1.8-1.9K)| test strain/hole-dope to lift FB
#      |              |                        |                         |  no CDW)  | Tc~4.8K  |                              | to E_F (small shift vs CoSn 0.44)
# ⑤   | CaNi2        | 3D Ni pyrochlore / C15 | −0.4 eV (FB1 shoulder), | NON-MAG   | YES real | Nature s41586-023-06640-1    | QE scf+bands: confirm 3D FB at
#      |              |  Laves Fd-3m           | −0.58 (FB2 peak) ARPES  | (Pauli)   | crystal  | (Nat 2023, ARPES+DFT)        | −0.4/−0.58; doping path to E_F
#      |              |                        |                         |           |          |                              | (paper: doping→FB@E_F→SC)
# ⑥   | CeRu2        | Ru pyrochlore / C15    | −0.5 to −0.6 eV (ARPES) | ~NON-MAG  | YES real | arXiv 2304.09066 / npj QM    | QE scf+bands: dE; CAUTION Ce-4f
#      |              |  Laves Fd-3m           | (−0.2 segment at Γ)     | (f-elec   | crystal, | s41535-024-00683-x           | (field-induced weak mag risk) →
#      |              |                        |                         |  weak-mag | Tc 5.1K  |                              | nspin=2 + 4f handling needed
#      |              |                        |                         |  risk)    |          |                              |
# ⑦   | LaCoSi       | ternary electride,     | +33 / +100 meV ABOVE    | NON-MAG   | likely   | front.phys 10.15302/         | NOVEL-for-SC: scf+bands confirm
#      | (NOVEL probe)|  electride flat band   | E_F (very shallow!)     | (para)    | ambient  | frontphys.2025.034202        | +33meV FB; nspin=2 nm; THEN DFPT
#      |              |                        |                         |           | (verify) | (FB predicted, SC NOT yet)   | — SC never tried here
# ──────────────────────────────────────────────────────────────────────────

@F f1 := "MMSn 1:1 kagome family — NEW non-mag ambient flat-band-near-E_F SC predictions" :: grounded [active]
  arxiv   = "2605.24822 (Jiao, Qiao, Zhou, Lu, Zhang — 'Prediction of 1:1 kagome metals with superconductivity and band topology', 2026)"
  claim   = "MoSn(Tc 2.17K), HfSn(2.31K), NbSn(1.67K), TaSn(0.71K), WSn(1.09K): 1:1 CoSn-type kagome, NON-MAGNETIC, dynamically+thermodynamically stable at ambient, d-orbital flat-band-like states 'conspicuously near E_F' driving phonon-mediated SC. MoSn/HfSn/NbSn = topological."
  why_beats = "beats CoSn on BOTH axes at once: non-magnetic (CoSn is 0.43uB) AND flat band near E_F (CoSn -0.44, CsV3Sb5 +0.92). Same CoSn-type kagome family but with d-count that places FB at E_F + quenches moment. Phonon-mediated → directly addressable by QFORGE/QE DFPT (campaign canonical engine)."
  caveat  = "abstract does NOT give exact dE(eV) or λ — 'near E_F' must be confirmed by real scf+bands (c9: no fabricated number). Predicted Tc is low (~2K) but proves the 2-axis-clean platform exists; campaign goal is the platform, then engineer Tc up (doping/strain)."
  target  = "QE/QFORGE scf+bands nspin=2 on MoSn first → measure dE & confirm nm; if |dE|<0.1 & m<0.5 → DFPT λ/Tc"

@F f2 := "LaRu3Si2 — real kagome SC, flat band near E_F, Tc 7K (highest real of set)" :: grounded [active]
  arxiv   = "2503.22477 (2025, 'Chemical enhancement of SC in LaRu3Si2 with mode-selective coupling between kagome phonons and flat bands') + Princeton/OSTI 1822402 (nodeless kagome SC, μSR s-wave)"
  claim   = "Ru-kagome, NON-MAGNETIC, ambient real crystal, Tc≈7K. Ru-dz2 kagome flat band + Dirac + vHs near E_F. el-ph mode-selective (Ru-B3u phonon ↔ Ru-Ag electron); el-ph alone underestimates Tc → flat-band/vHs DOS enhancement implicated. Doping moves chemical potential toward DOS max."
  why_beats = "highest real Tc (7K) of any clean non-mag ambient flat-band kagome; the el-ph+FB-DOS mechanism is exactly the campaign's no-cooling thesis, and it's ALREADY a 7K SC (vs predict-only MMSn). Doping-to-DOS-max is a concrete Tc-lift knob."
  target  = "QE scf+bands: locate Ru-dz2 FB dE; reproduce mode-selective λ; test chemical-potential shift (doping) → DOS(E_F) gain"

@F f3 := "Sc2Ir4-xSix — SOC-DRIVEN flat band AT E_F, real non-mag SC, two-dome Tc" :: grounded [active]
  arxiv   = "2310.03609 / Commun. Mater. s43246-024-00521-4 (2024)"
  claim   = "kagome/C15 Laves, NON-MAGNETIC, ambient real crystal. Flat band sits AT E_F ONLY WHEN SOC is included (5d-Ir large SOC). Two-dome Tc(x); optimal x≈0.5 (Sc2Ir3.5Si0.5) shows non-Fermi-liquid + divergent specific heat = strong-correlation flat-band signatures."
  why_beats = "FB genuinely at E_F (not offset) and non-magnetic — but the lever is SOC, NOT chemistry; means our DFT MUST include SOC to see it (a methods note: campaign's RbOs2O6 SOC run already proves we run full-rel). Unconventional pairing = risk for phonon-only QFORGE path."
  caveat  = "SOC-mandatory; pairing may be unconventional (NFL behavior) → Allen-Dynes/DFPT may not capture full Tc (c9 honesty: phonon-mediated assumption may fail here)."
  target  = "QE scf+bands WITH SOC (full-rel, like RbOs2O6 battery): confirm FB at E_F under SOC; nspin/nm check"

@F f4 := "CsTi3Bi5 / RbTi3Bi5 — Ti-kagome real SC, FB −0.25eV (shallower than CoSn), NO CDW" :: grounded [active]
  arxiv   = "Nat.Commun s41467-023-40515-3 (RbTi3Bi5 flat bands) + Research 0238 + s41467-023-39620-0 (CsTi3Bi5 flat band/Dirac/topo)"
  claim   = "Ti-kagome P6/mmm, NON-MAGNETIC (no transition down to Tc, NO CDW unlike CsV3Sb5), ambient real crystals, Tc≈4.8K(Cs)/calc 1.85-1.92K. Flat band measured ~−0.25 eV; ~64% of N(E_F) is Ti-kagome orbital."
  why_beats = "non-magnetic AND CDW-free (cleaner than CsV3Sb5 which has CDW), FB only −0.25 eV (vs CoSn −0.44, CsV3Sb5 +0.92) = shallowest real kagome offset to date. A small hole-dope/strain to lift −0.25→0 is far more physical than CoSn's unphysical 1.57 hole/Co."
  target  = "QE scf+bands: reproduce −0.25 eV; rigid-band/strain estimate of dope needed to reach E_F (compare to CoSn's unphysical 4.72 e/cell)"

@F f5 := "CaNi2 — 3D Ni-pyrochlore flat bands, non-mag, doping→FB-at-E_F→SC demonstrated" :: grounded [active]
  arxiv   = "Nature s41586-023-06640-1 (2023, ARPES+DFT) / PubMed 37938707 / osti 2571313"
  claim   = "C15 Laves with Ni-pyrochlore sublattice, NON-MAGNETIC (Pauli), ambient real crystal. 3D topological flat band FB1 −0.4eV (shoulder), FB2 −0.58eV (peak), FB3 −1.6eV; DFT-ARPES agree to 24meV. KEY: chemical tuning of FB manifold TO E_F coincides with enhanced correlations + SC onset."
  why_beats = "3D (not just 2D kagome) flat band = robust DOS; non-magnetic; and the paper EXPLICITLY shows the doping path FB→E_F→SC. Different lattice family (pyrochlore-in-Laves) from the failed osmate β-pyrochlore — avoids the Os-5d Stoner magnetism that sank RbOs2O6."
  caveat  = "native FB at −0.4/−0.58 eV = offset; requires doping to bring to E_F (but path is demonstrated, unlike CoSn)."
  target  = "QE scf+bands: confirm 3D FB at −0.4/−0.58; rigid-band dope estimate to E_F; nspin=2 nm confirm"

@X n1 := "LaCoSi — NOVEL: shallowest predicted flat band (+33 meV), non-mag, never tried for SC" :: novel [active]
  rationale = "first-principles line-graph + electride reasoning: LaCoSi is a ternary intermetallic ELECTRIDE whose interstitial-anionic-electron flat band sits only +33 meV (and +100 meV on another plane) ABOVE E_F — the SHALLOWEST |dE| of any candidate surveyed, and it's paramagnetic (non-mag). SC has NEVER been computed for it. The +33 meV offset is within trivial electron-doping reach (vs CoSn's −0.44 needing 1.57 hole/Co)."
  source  = "front.phys DOI 10.15302/frontphys.2025.034202 (FB position + paramagnetic CONFIRMED in lit); SC = NOVEL, unverified — needs DFT"
  why_beats = "smallest |dE| (0.033 eV, already within the |dE|<0.1 bar) + non-magnetic + electride flat band (distinct mechanism from kagome/pyrochlore, so a fresh lattice-family shot). Genuinely un-probed for SC = high discovery value (d18 NOVEL lane)."
  caveat  = "SC NOT predicted in any source — purely campaign-novel; ambient stability stated as tunable, must verify; electron-electron correlation in electride FB may need beyond-DFPT. tier=speculation-fenced until DFT."
  target  = "QE scf+bands nspin=2: confirm +33meV FB at/near E_F + nm; if clean → DFPT λ/Tc (campaign-first SC calc for an electride flat-band host)"

# ──────────────────────────────────────────────────────────────────────────
# TOP-3 PICK + RATIONALE (vs CoSn -0.44 mag / CsV3Sb5 +0.92 / RbOs2O6 robust-mag)
# ──────────────────────────────────────────────────────────────────────────
@D top3 := "ranked top-3 with 2-axis rationale" :: pick [active]
  pick1 = "MoSn (MMSn family, arXiv 2605.24822) — the FIRST candidate that clears BOTH failure modes simultaneously by prediction: non-magnetic (kills the RbOs2O6/CoSn magnetism axis) AND d-orbital flat band 'near E_F' (kills the CsV3Sb5/CoSn offset axis), in the SAME CoSn-type kagome family demiurge already has decks/engine for. Phonon-mediated → QFORGE/QE DFPT applies directly. Only weakness: 'near E_F' un-quantified in abstract → our DFT supplies the number (the whole point of the check)."
  pick2 = "LaRu3Si2 (arXiv 2503.22477) — strongest REAL (not predict-only) candidate: non-magnetic, ambient, Tc=7K (highest real of the set), Ru-kagome flat band + vHs near E_F, mode-selective el-ph already mapped. It is ALREADY a working flat-band kagome SC at 7K — the campaign's no-cooling thesis realized; doping-to-DOS-max is the Tc-lift knob."
  pick3 = "LaCoSi (NOVEL, DOI 10.15302/frontphys.2025.034202) — shallowest |dE| of all (+33 meV, already inside the |dE|<0.1 bar) + paramagnetic + a DISTINCT mechanism (electride flat band, not kagome/pyrochlore). SC never computed → highest discovery upside. Hedge: a different lattice family de-risks the 'all kagome/pyrochlore share a depth/magnetism wall' outcome."
  why_over_incumbents = "CoSn fails BOTH axes (mag 0.43uB + FB −0.44eV needing unphysical 1.57 hole/Co). CsV3Sb5 clears magnetism but FB +0.92eV deep + has CDW. RbOs2O6 clears dE (FB~E_F) but PBE-magnetism is robust (SOC/rattle do NOT quench → realized competing-order bottleneck). The top-3 each break the specific incumbent wall: MoSn breaks BOTH by prediction; LaRu3Si2 is a real 7K nonmag flat-band SC; LaCoSi has the shallowest dE + a fresh non-osmate non-Stoner lattice."

# ──────────────────────────────────────────────────────────────────────────
# TOP PICK — concrete falsifiable next-step DFT (MoSn)
# ──────────────────────────────────────────────────────────────────────────
@D falsifier := "MoSn pre-registered DFT falsifier" :: falsifier [active]
  step    = "QE (or QFORGE) scf + bands + projwfc on MoSn (CoSn-type 1:1 kagome, P6/mmm-class; build deck analogous to exports/rtsc/decks/anima_csv3sb5 hex cell), nspin=2 seeded m to test magnetism, ecut ~65/650 Ry, dense k for DOS(E_F)."
  measure = "(a) flat-band dE = E_flatband − E_F from band+projwfc (Mo-4d weight); (b) total magnetization from nspin=2 SCF; (c) N(E_F)."
  PASS    = "🟢 |dE| < 0.10 eV AND m < 0.5 uB  → MoSn is a clean 2-axis-clear flat-band-at-E_F non-mag ambient host → PROMOTE to DFPT λ/Tc (no-cooling RTSC lead candidate)."
  FALSIFY = "🔴 dE > 0.2 eV (flat band still offset like CoSn/CsV3Sb5)  OR  m > 0.5 uB (magnetic like CoSn/RbOs2O6)  → MoSn joins the failure set; fall through to HfSn/NbSn, then LaRu3Si2, then LaCoSi."
  axis_closure = "if MoSn AND HfSn AND NbSn AND LaRu3Si2 ALL fail the 2-axis bar → strong honest closed-negative: 'flat-band-at-E_F + non-magnetic + ambient is a structural wall across kagome/pyrochlore/Laves d-metals' (same tier as the hydride-pressure wall). LaCoSi (electride, fresh family) is the de-risking escape hatch before declaring the wall."
  cost    = "all scf+bands are small cells (≤9 atoms, ambient) → d7 pool-free (ubu/summer) or vast CPU batch; NO GPU needed for scf+bands. DFPT (only on a PASS) → vast per d_qforge_parallel q×irr grid."

@D provenance := "lane honesty record (c9)" :: meta [active]
  lane_arxiv_web = "PRODUCTIVE — 6 grounded candidates with real arXiv/DOI/Nature ids (2605.24822, 2503.22477, 2310.03609, s41467-023-40515-3, s41586-023-06640-1, 2304.09066). Exact dE values cited where lit reports them; where abstract-only ('near E_F'), flagged as DFT-needed, NO number fabricated."
  lane_novel     = "PRODUCTIVE — LaCoSi surfaced via electride/line-graph reasoning; FB +33meV & paramagnetism are LIT-CONFIRMED, SC is campaign-novel & explicitly speculation-fenced."
  empty_lanes    = "Lieb-lattice line-graph lane returned NO real ambient intermetallic SC candidate (only cold-atom/optical-lattice realizations) — reported as empty per honesty rules. Twisted/moiré flat-band SC (magic-angle graphene etc.) NOT pursued: not an ambient bulk crystal (needs fabrication/twist) → out of the campaign's bulk-material no-cooling scope."
  not_re_proposed = "CoSn, CsV3Sb5, RbOs2O6, CsOs2O6 NOT re-proposed as new (already in RTSC_LEDGER). MMSn is a NEW member of CoSn's family with a genuinely new angle (different transition metal → 2-axis-clean by prediction)."
