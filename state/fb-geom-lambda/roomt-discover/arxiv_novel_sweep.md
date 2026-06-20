# RTSC room-T DISCOVERY lane — arxiv-novel-sweep (R1)

> Lane: `arxiv-novel-sweep` · literature/web only (NO compute, NO fabrication) · d18 lit grounding · d_novel_only · d6 honest scoring.
> Date: 2026-06-20 · Gate = ROOMT-AMBIENT-PASS-CRITERIA (d_roomt_ambient): hard Tc≥293.15K · P=1atm (GPa hydrides EXCLUDED) · bulk · TIER-1 6 in-silico gates · TIER-2 wet-lab (zero-R + ★Meissner + ΔC + isotope + reproduced≥2).
> SSOT this file is a discovery-lane scratch record; does NOT edit ARCHITECTURE.json, does NOT commit.

---

## 0. BOTTOM LINE (d6 honest)

**Zero ambient room-T (Tc≥293K @ 1atm, bulk) claim survives the gate. None. Not one.** Every credible 2024–2026 hit is either (a) far sub-room-T at 1atm, (b) room-T but at GPa (EXCLUDED — not ambient), (c) theory-only prediction unverified, or (d) retracted/debunked. This is consistent with the campaign's prior closure.

The single most important new constraint: **Gao et al., Nat. Commun. 2025 ("The maximum Tc of conventional superconductors at ambient pressure")** puts the conventional (phonon-glue) ambient ceiling at **~100–120 K** (Li₂AuH₆ 116 K, Li₂AgH₆ 109 K, Eliashberg) and concludes room-T conventional @ 1atm is "extremely unlikely" — a hard ωlog↔λ tradeoff wall. It EXPLICITLY leaves the door open only for **unconventional / non-phonon mechanisms or entirely new physics**. This independently re-derives the campaign's own closing formula: conventional ambient room-T is CLOSED; the only escape is off-diagonal / non-BCS.

The value of this sweep is the **ranked under-explored angle list (§4)** — and the finding that our flagship angle (two-band-decoupled off-diagonal bipolaron + metallic short-H-bond SSH) is **NOVEL / under-explored** in the literature.

---

## 1. Ambient room-T CLAIMS — gate adjudication

| Claim | Tc | Pressure | Evidence tier | Gate verdict |
|---|---|---|---|---|
| **Pressure-quenched cuprate** (U.Houston, ScienceDaily 2026-05; "30-yr record") | **151 K** | **1 atm** (quench-stabilized) | zero-R implied; no Meissner/reproduce stated | **FAIL #4** (Tc 151K ≪ 293K). Ambient ✓ but room-T ✗. ~140°C short. |
| **Cuprate ambient record** (U.Houston, phys.org 2026-03) | 151 K | 1 atm | zero-R | FAIL #4 (same result, sub-room-T). |
| **LK-99** (Lee 2023) | claimed "RT" | 1 atm | **RETRACTED/DEBUNKED** — Cu₂S impurity resistivity drop, not SC (CAS, multiple groups 2023–24) | **FAIL** (not a superconductor). Dead. |
| **Dias H₃S/LaH10 "room-T"** | ~250–288 K | **>150 GPa** | Nature paper RETRACTED (2023–24) | **FAIL** — GPa (EXCLUDED) + retracted. |
| **LaH₁₀** (validated) | ~260 K | 170–190 GPa | zero-R + reproduced | **FAIL** — GPa, NON-ambient (EXCLUDED). |
| **Li₂AuH₆ / Li₂AgH₆** (AI-search prediction 2025; Gao Eliashberg) | 116 K / 109 K (Eliashberg); 140 K (orig DFT) | **1 atm** (but thermodynamically UNSTABLE @1atm) | **theory-only**, no synthesis | FAIL #1 (stability) + #4. Ceiling marker, not a host. |
| **MB₂C₈ boron-carbon clathrates** (Na/K/Rb/Cs, 2024) | ~70 K | 1 atm | theory | FAIL #4. |
| **Au-B / MB₄H tetraboride-hydrides** (2025) | tens of K | 1 atm | theory | FAIL #4. |
| **Twisted bilayer WSe₂ / MoTe₂ SC** (Nature 2025) | <10 K | 1 atm | measured | FAIL #4 (interface/2D label anyway). |

**Survivors of the room-T@1atm-bulk gate: NONE.** (Expected per d6 honesty.)

---

## 2. NEW PAIRING-MECHANISM scan — 2024–2026 frontier

### 2a. Bond-Peierls / off-diagonal-SSH bipolaron (OUR escape axis) — ACTIVE, growing
- **Sous/Berciu et al., PRX 13, 011010 (2023)** — bipolaronic HIGH-Tc from phonon-modulated hopping (bond-SSH); light bipolarons, Tc bound exponentially larger than Holstein.
- **Semiclassical theory, PRB 109, L220502 (2024)** (arXiv:2308.01961) — instanton/adiabatic; bipolaron mass only weakly enhanced; bipolarons slide in a degenerate manifold (NOT self-trapped). Tc/Ω ≈ 0.2 vs conventional ~0.05.
- **"Perspective" arXiv:2605.16625 (2026)** — Tc/Ω≈0.2 → for Ω~200K gives "tens of K, comparable to/exceeding 30K ceiling". Candidates named: **FeSe (t/Ω~2–3), cuprates as secondary channel**. **NO discussion of separated pairing/carrier bands. NO H-bond hosts. NO ambient-pressure design.** Open dirs flagged: higher density (overlapping bipolarons), combined bond+site coupling, multi-orbital Hund extension.
- **Triangular-lattice bond bipolaron, arXiv:2507.07662 (2025)** + **PRB ckbn-jp9t** — diagrammatic-MC; triangular geometry sustains HIGHER Tc across wide phonon-frequency range, outperforms square; bipolarons stay compact & light. **No two-band decoupling, no H-bond/proton host discussed.**
- **Robustness to density-phonon coupling, PRB 7fpr-gbd3 (2025)** — bipolaronic SC robust to extra couplings.

→ **d_novel_only verdict: bond-SSH bipolaron mechanism = PARTIAL/ACTIVE (heavily worked as a MODEL).** BUT the *specific* combination our campaign pursues — **(i) two-band DECOUPLED (soft-bond pairing band electrically separated from a metallic carrier band) and (ii) a real METALLIC (non-Mott) short-H-bond SSH host** — is **NOT in any of these papers.** That intersection is NOVEL.

### 2b. Flat-band geometric SC (quantum metric) — RED-OCEAN as model, OPEN on Tc bound
- Quantum-metric-bounded superfluid stiffness; kagome (Cs₂Ni₃S₄, Cr-kagome), moiré (TBG, tWSe₂), Lieb lattices. Many 2024–2026 papers.
- **Bootstrap rigorous lower bounds on stiffness, arXiv:2506.18969 (2025)**; **numerically-exact flat-band SC, arXiv:2604.05997 (2026)**; **modified-Lieb flat-band ratio + minimal quantum metric, Commun.Phys. 2025**.
- KEY GAP: current theory predicts **Tc(U)=c|U| linear**, but **neither c nor the full nonlinear Tc(U) (with a maximum at large |U|) is known beyond mean-field** — i.e. **no rigorous Tc UPPER bound exists for flat-band SC.** Room-T is not excluded by any proof.
- → d_novel_only: flat-band SC mechanism = PUBLISHED (red-ocean as generic model). **But "flat-band geometric SC pushed to 293K@1atm in a real bulk host" is NOT claimed by anyone** — the absent upper bound is a genuine open lever, not a solved question.

### 2c. Negative-U / bond-disproportionation / charge-Kondo — UNDER-EXPLORED at high Tc
- (Ba,K)SbO₃, Tl:PbTe charge-Kondo negative-U; nickelate disproportionation. Negative-U charge-Kondo is MORE robust to SC suppression than spin-Kondo.
- No ambient room-T claim; mechanism mostly studied at low Tc / as quantum-dot models.
- → d_novel_only: PARTIAL. Negative-U as a real-host high-Tc bulk ambient route is **under-explored**; conceptually adjacent to bond-disproportionation (off-diagonal) — worth a probe but weaker than bipolaron.

### 2d. Excitonic / Little mechanism — REVIVAL, theory-only
- Little (exciton glue) revival: exciton-enhanced SC in Al monolayers (arXiv:2409.12201), exciton-Cooper-pair condensation (arXiv:2503.05863), exciton-density-wave-fluctuation SC (PRL 7f6c-jh1k), room-T exciton CONDENSATION observed (arXiv:2511.09187, NOT SC). Larger gaps / higher Tc claimed possible vs phonon.
- → d_novel_only: PARTIAL/theory. No ambient bulk room-T SC; all interface/2D or model. High-risk, hard to realize in bulk. Lower priority for our campaign (interface label conflicts with bulk gate).

### 2e. Two-band / multiband decoupled — EXISTS but NOT married to bipolaron
- Decoupled interband pairing measured in bilayer Fe-pnictide (ARPES, arXiv:2601.07380, 2026); steep-band/flat-band scenario; heavy+light two-band Hubbard (light polarizes to pair heavy).
- → CRUCIAL: two-band-decoupled SC is a REAL, observed concept — but in the literature it is married to *spin-fluctuation/interband-phonon* pairing, **NOT to a soft-bond off-diagonal bipolaron channel.** The "separate soft-bond pairing band + independent metallic carrier band" construction (which sidesteps κ-H3's carrier-Mott closure) is **NOT published.**

---

## 3. d_novel_only AUDIT — red-ocean vs open

| Mechanism | Status | Note |
|---|---|---|
| GPa hydrides (LaH10, H₃S, Li₂AuH6-type) | **RED-OCEAN + EXCLUDED** | not ambient; avoid. |
| Conventional phonon-glue ambient | **CLOSED** (Gao ceiling ~120K) | avoid (proven ceiling). |
| LK-99 / lead-apatite | **DEAD/RETRACTED** | avoid. |
| Generic bond-SSH bipolaron MODEL | RED-OCEAN (model) | PRX/PRB/dMC well-trodden — don't re-derive the model. |
| Generic flat-band quantum-metric SC | RED-OCEAN (model) | many groups; but Tc upper-bound OPEN. |
| Cuprate/nickelate/pnictide unconventional | RED-OCEAN | avoid reproduction. |
| **Two-band-DECOUPLED off-diagonal bipolaron** (soft-bond pairing band + separate metallic carrier band) | **NOVEL / OPEN** | ✦ our flagship — not in any swept paper. |
| **METALLIC (non-Mott) short-H-bond SSH host** | **NOVEL / OPEN** | ✦ literature H-bond SSH is insulating/Mott or low-Tc organic; metallic-channel design unexplored. |
| Negative-U bond-disproportionation high-Tc bulk ambient | PARTIAL / under-explored | secondary probe. |
| Flat-band Tc upper-bound at 293K@1atm in real bulk | OPEN (no proof either way) | tertiary lever. |

**Direct answer to the two posed questions:**
1. **Is the two-band-decoupled off-diagonal bipolaron (separate soft-bond pairing band + metallic carrier band) explored?** → **NO. NOVEL.** The bond-SSH bipolaron papers (PRX 2023, PRB L220502 2024, arXiv:2605.16625, 2507.07662) all treat a single dilute composite-boson sector; none separate pairing from a co-existing metallic carrier band. Decoupled two-band SC exists but only with spin-fluctuation/interband-phonon glue, not bond-bipolaron glue. **Competitor id space: empty** for the exact construction.
2. **Is metallic (non-Mott) short-H-bond SSH explored?** → **NO / barely.** Short-H-bond systems in the SC literature are either GPa hydrides (excluded), insulating proton conductors (MOF/polymer, not SC), or low-Tc organic H-bond conductors (TTF, ~tens K). A *deliberately metallic, non-Mott* short-H-bond lattice engineered as an SSH off-diagonal coupler is **NOVEL.** (This is exactly the κ-H3 carrier-Mott failure mode the two-band decoupling is meant to escape.)

---

## 4. RANKED shortlist — under-explored 1-atm room-T angles to pursue next

### ✦ A1 — Two-band-DECOUPLED off-diagonal bipolaron (TOP)
- **Physics:** separate the bond-SSH soft-bond *pairing* band (provides strong off-diagonal λ, light bipolarons, Tc/Ω~0.2) from an independent *metallic carrier* band (provides the condensate/phase stiffness). Pairing band need not be the conducting band → sidesteps the carrier-Mott closure that killed κ-H3 (κ-H3 cleared coupling but the SAME band that paired also localized).
- **Why it could clear 293K@1atm:** Tc/Ω~0.2 × a stiff carrier band with high ωlog (proton/H-bond mode 1500–3000K) → 293K is dimensionally reachable WITHOUT GPa, because off-diagonal SSH escapes the Gao ωlog↔λ conventional tradeoff (the ceiling theorem is BCS-diagonal only).
- **Nearest real material:** an intercalated/doped bond-disproportionated lattice where a soft bridging bond (B–B, H-bond, or chalcogen bridge) modulates hopping on a sub-lattice, with a second metallic sub-lattice (e.g. layered diboride/clathrate + separate metal channel; or A-site-doped perovskite where B–O–B soft bond pairs and A-band conducts).
- **Novelty:** **NOVEL.** No competitor id for the exact two-band-decoupled bond-bipolaron. (Nearest: PRX 13,011010 single-band; arXiv:2601.07380 decoupled but spin-fluct glue.)

### ✦ A2 — Metallic (non-Mott) short-H-bond SSH host
- **Physics:** engineer a short symmetric H-bond (proton in a double-well → SSH hopping modulation) in a host that stays METALLIC (avoid the half-filled-Mott trap). The proton mode gives a huge phonon frequency (high Tc prefactor) AND strong off-diagonal coupling.
- **Why 293K@1atm:** combines the highest available ωlog (H/proton ~2000–3000K) with off-diagonal λ; ambient by construction (no GPa needed to make the H-bond short if it's geometrically short in the crystal).
- **Nearest real material:** symmetric short-H-bond crystals (e.g. metallized squaric-acid-like, KHCO₃-family pushed metallic, or H-bonded TTF conductors doped past the Mott boundary); H-bonded coordination polymers that already show proton-electron coupling (Nat.Commun. 2025) — push them metallic.
- **Novelty:** **NOVEL.** H-bond SSH in SC lit is insulating or low-Tc organic; the metallic non-Mott design is unexplored.

### A3 — Flat-band geometric SC with NO proven Tc ceiling
- **Physics:** quantum-metric-driven stiffness in a flat band; Tc(U)=c|U| with no known maximum → exploit large |U| / large quantum metric in a bulk (not moiré) host.
- **Why 293K@1atm:** no upper-bound theorem rules it out; if c and minimal quantum metric are large enough in a real kagome/Lieb bulk, linear Tc(U) could in principle reach high T at ambient.
- **Nearest real material:** bulk kagome (Cs₂Ni₃S₄/CsNi₃S₄, Cr-kagome), Lieb-lattice oxides.
- **Novelty:** mechanism PUBLISHED (red-ocean); the *bulk-ambient-room-T target with the missing upper bound* is OPEN. Medium priority — risk that c is small in real materials.

### A4 — Negative-U / bond-disproportionation high-Tc bulk (secondary)
- **Physics:** dynamic charge disproportionation → effective negative-U pairs electrons in k-space; charge-Kondo robust against SC suppression. Conceptually off-diagonal (bond/charge order modulates pairing).
- **Why 293K@1atm:** negative-U can give large local pair binding; if itinerant + bulk, no pressure needed.
- **Nearest real material:** (Ba,K)SbO₃, BaBiO₃-family disproportionated bismuthates/antimonates pushed to optimal doping.
- **Novelty:** PARTIAL/under-explored at high-Tc ambient bulk. Lower priority (weaker Tc prospect than A1/A2).

---

## 5. NEXT ROUND + depletion test

- **NEXT ROUND = `arxiv-novel-sweep R2`** — narrow deep-dive on the two NOVEL flagship angles to find the nearest REAL host crystal + any near-miss competitor:
  1. arxiv: "decoupled multiband bond-SSH" / "bipolaron pairing band metallic carrier band separate" / "off-diagonal electron-phonon two-band Eliashberg ambient" — confirm zero competitor id (lock A1 NOVEL).
  2. arxiv + materials: "symmetric short hydrogen bond metallic crystal" / "proton double-well SSH metal non-Mott" / "metallized hydrogen-bonded molecular conductor doped past Mott" — find the nearest real host for A2.
  3. cross-check Gao ceiling theorem's diagonal-only assumption against any off-diagonal extension paper (does anyone bound Tc for bond-SSH ambient? — if a bound exists, it changes A1/A2 priority).
  4. one NOVEL probe (d18): negative-U bismuthate (BaBiO₃) optimal-doping ambient Tc literature — is the disproportionation→SC route exhausted?
- Hand the §4 shortlist to the COMPUTE lanes (fb-geom-lambda) as candidate host specs — A1/A2 need a two-band off-diagonal model + a real-crystal DFPT screen (NOT this lane; this lane is lit-only).

### Depletion test (when this lane stops)
This lane DEPLETES when an R(n) sweep returns **no new mechanism class AND no new credible ambient near-room-T claim AND no new real host for A1/A2** beyond what R(n-1) already logged — i.e. two consecutive rounds with zero NOVEL/PARTIAL additions to §2/§4. R1 found 2 NOVEL flagship angles + 1 hard ceiling theorem → **NOT depleted; proceed to R2.** When R2/R3 only re-surface already-listed papers (PRX 011010, L220502, 2605.16625, 2507.07662, Gao ceiling, flat-band bootstrap) with no new host or competitor, declare the literature SWEPT DRY and close the lane; the residual escape (A1/A2) then lives only as a COMPUTE problem, not a literature gap.

---

## Source ids (key)
- Gao et al., "The maximum Tc of conventional superconductors at ambient pressure", Nat. Commun. 2025 (s41467-025-63702-w; PMC12423309) — ambient conventional ceiling ~120K, room-T "extremely unlikely", loophole = unconventional/new physics.
- Sous, Chakraborty, Krishna, Berciu et al., "Bipolaronic High-Temperature Superconductivity", PRX 13, 011010 (2023).
- "Semiclassical theory of bipolaronic SC in a bond-modulated e-ph model", PRB 109, L220502 (2024) / arXiv:2308.01961.
- "Bipolaronic HTSC from Phonon-Modulated Hopping: A Perspective", arXiv:2605.16625 (2026).
- "A comprehensive study of bond bipolaron SC in triangular lattice", arXiv:2507.07662 (2025) / PRB ckbn-jp9t.
- "Robustness of bipolaronic SC to electron-density-phonon coupling", PRB 7fpr-gbd3 (2025).
- "Decoupled interband pairing in bilayer Fe-based SC", arXiv:2601.07380 (2026).
- Flat-band: "Bootstrapping Flat-band SC: rigorous lower bounds on superfluid stiffness", arXiv:2506.18969 (2025); "Numerically Exact Flat-Band SC", arXiv:2604.05997 (2026); "Flat-band ratio & quantum metric in modified Lieb lattices", Commun. Phys. 2025 (s42005-025-01964-y).
- Excitonic: arXiv:2409.12201, 2503.05863, PRL 7f6c-jh1k, arXiv:2511.09187 (exciton condensation, not SC).
- Pressure-quenched cuprate 151K ambient: ScienceDaily 2026-05-27 / phys.org 2026-03.
- LK-99 debunked (Cu₂S): Nature d41586-023-02585-7; Dias retractions (Nature, 2023–24).
- Li₂AuH₆ ambient prediction (theory, unstable, unsynthesized): arXiv:2501.12222.

---
---

# RTSC room-T DISCOVERY lane — arxiv-novel-sweep (R2)

> Lane: `arxiv-novel-sweep` R2 · literature/web only (NO compute, NO fabrication) · continuation of R1.
> Date: 2026-06-20 · same gate (ROOMT-AMBIENT-PASS-CRITERIA). Mandate: deep-dive to LOCK A1/A2 competitor-empty (or collapse them into a known framework), and surface the NEAREST REAL ambient HOST to hand to the two compute lanes (two-band-decouple · metallic-hbond-ssh).

## R2.0 BOTTOM LINE (d6 honest)

After the deep-dive, **A1 and A2 both SURVIVE as novel — but only as a precise INTERSECTION, and each is closer to a known framework than R1 stated.** Honest re-grading:

- **A1 did NOT collapse into the boson-fermion model — but the boson-fermion (Ranninger-Robaszkiewicz 1985) model IS the parent framework, and it is much closer to A1 than R1 acknowledged.** A1's "separate localized-pair band + independent itinerant metallic band" is *exactly* the boson-fermion / negative-U-center construction (localized bosons + itinerant fermions, boson level inside the fermion band). What is STILL novel in A1 is **only the GLUE**: the boson-fermion and Bianconi two-band literature pair via *local negative-U / interband exchange*, NEVER via an **off-diagonal bond-SSH (Peierls hopping-modulated) bipolaron** channel. So A1 = (known two-band scaffold) × (known bond-SSH glue) with the **product unpublished**. That intersection is genuinely competitor-empty, but A1 must be RE-FRAMED as "bond-SSH glue inside a boson-fermion two-band scaffold," not as a brand-new mechanism. **Downgrade from R1's framing: A1 is a NOVEL COMBINATION, not novel physics.**
- **A2 survives as novel but its nearest real host is a CONFIRMED WALL, not an open door.** The metallic short-H-bond organic family (Cat-EDT-TTF / κ-H₃) is a **dimer-MOTT insulator / quantum-spin-liquid at ambient** — it only metallizes under pressure. This is literally the κ-H3 carrier-Mott failure mode R1 cited. So A2's "make it metallic and non-Mott at ambient" is unpublished BECAUSE the real hosts are Mott-trapped at 1 atm; A2 is novel but host-starved.

**Net:** neither collapsed to a dead known result; both stay NOVEL as intersections, with the nearest real hosts now NAMED (and their named obstacles honest). New hard ceilings logged: BKBO ambient 30K (A4 exhausted), Bianconi two-band Tc>200K is a real near-miss competitor for A1's *target*, not its mechanism.

---

## R2.1 A1 DE-RISK — boson-fermion model exhaustive search

**The boson-fermion (BF) model IS the closest known framework, and it predates and largely subsumes A1's two-band SCAFFOLD.**

- **Ranninger & Robaszkiewicz (1985)** introduced the BF model: two charge-carrier types — (1) localized bosons = tightly-bound electron pairs of polaronic/negative-U origin, (2) itinerant fermions = valence electrons. The boson level falls INSIDE the fermion band; a boson-fermion pair-exchange coupling lets the localized bosons condense and *induce* BCS-like SC in the fermion subsystem. **This is structurally identical to A1's "separate pairing sector + independent metallic carrier band."** A1 is therefore NOT a new scaffold.
- **Negative-U composite bands (Phys. Rev. B 48, 7598)**: SC from a metallic band interacting with an insulating band carrying negative-U pairs — "a generic feature when a metallic band interacts with an insulating band." Again: the two-band-decoupled scaffold is OLD (1990s).
- **Bianconi steep-band/flat-band Feshbach shape resonance** (arXiv:1704.00276 roadmap; 0712.0061; Fano-Feshbach two-band arXiv:2402.06454, 2024): a flat heavy (pairing-prone) band + a steep itinerant band, tuned at a Lifshitz transition, gives **Tc > 200 K with moderate coupling** (s42005 / 2504.13796 multigap 118K cuprate). **This is the most dangerous near-competitor for A1's TARGET** (room-T from a two-band heavy+light split). BUT — verified by fetching arXiv:2402.06454v2 — the glue is **intraband attraction + interband pair-exchange (U₁₁,U₂₂,U₁₂)**, i.e. BCS/negative-U type, with **NO off-diagonal SSH/Peierls term and NO bipolaron pairing band**. No real ambient host is named (purely Tc/E₀-normalized theory).
- **Bond-SSH bipolaron side (the GLUE A1 needs)**: "Cooper-Paired Bipolaronic Superconductors" (Grundner, Blatz, **Sous**, Schollwöck, Paeckel, arXiv:2308.13427, 2023) — off-diagonal SSH light bipolarons via tensor networks; finds a *fragmented condensate of spatially-separated polaron pairs* stabilized by strong repulsion. **Single band.** It does NOT couple the SSH pairing channel to a separate itinerant metallic band.

**A1 novelty verdict (re-graded, d6):** **NOVEL COMBINATION, competitor-empty for the exact product, but the scaffold is a re-skin of boson-fermion.** No paper marries (off-diagonal bond-SSH bipolaron glue) × (separate metallic carrier band). The BF/Bianconi two-band scaffolds use local/interband-exchange glue; the bond-SSH papers are single-band. The unfilled cell = **"bond-SSH off-diagonal glue inside a boson-fermion two-band scaffold."** Competitor id space EMPTY for the product; PARENT framework = boson-fermion (1985). → A1 is **NOT** novel physics; it is a **novel glue-substitution into a known two-band scaffold.** Honest downgrade.

**A1 Tc-ceiling intel:** the BF model has NO derived ambient Tc upper bound in the literature (mean-field gives finite Tc; no proven ceiling). Bianconi two-band gives Tc>200K *in normalized theory*, no real host. The Gao ~120K conventional ceiling is DIAGONAL-only and does NOT bind A1's off-diagonal glue — this remains A1's central thesis and is UNREFUTED by R2. So A1's room-T target is not killed by any theorem; it is bottlenecked by (a) no real host yet realizing the bond-SSH glue with a decoupled metallic band, (b) the BF condensation Tc being set by the SMALLER of pair-binding and phase-stiffness scales (the BF pitfall: localized pairs give a pseudogap far above a much LOWER condensation Tc — this is the real ceiling risk for A1, and the compute lane must check it).

## R2.2 A1 NEAREST REAL HOST — ranked

| Host | Pairing-prone soft-bond sector | Separate metallic band | Ambient Tc | Closeness to A1 |
|---|---|---|---|---|
| **★ A₃C₆₀ Jahn-Teller metal (K₃C₆₀ ~19K, Rb₃C₆₀ ~29K, Cs₃C₆₀ 38K)** | on-molecule JT phonon → local pairing (JT bipolaron); "fluctuating coexistence of LOCALIZED JT-active + ITINERANT electrons" (Nature s-mat, PNAS Jahn-Teller metal) | YES — the itinerant t₁ᵤ band IS the metallic carrier; localized JT pairs coexist | 19–38K (K/Rb ambient; Cs₃C₆₀ needs P for insulator→SC) | **CLOSEST real host.** Already a *measured* two-component (localized-pair + itinerant) metal at ambient. JT phonon is on-molecule (quasi-local, between Holstein and bond-SSH). Gap to A1: glue is JT-Holstein-like, not bond-SSH off-diagonal; Tc only 38K. |
| Ba₁₋ₓKₓBiO₃ (BKBO) | Bi 6s bond-disproportionation / breathing phonon (off-diagonal-ish) → bipolaron tendency (persistent small polarons into SC phase, arXiv 2024) | the doped metallic band | 30K (x≈0.4) | 2nd. Real off-diagonal (breathing/bond) glue + metallic band, but single-band-ish and ceiling 30K. |
| Borocarbides (LuNi₂B₂C, YNi₂B₂C) | soft boron phonon, genuine two-band | Ni-d metallic band | ~16K | weak — phonon is not off-diagonal-bipolaronic; low Tc. |
| CaC₆ / intercalated graphite | C/intercalant soft modes | π metallic band | 11.5K | weak. |

→ **Hand to compute lane (two-band-decouple): A₃C₆₀ Jahn-Teller metal is the nearest real two-component host.** The lane should test whether substituting/engineering an OFF-DIAGONAL bond-SSH glue (vs the native JT-Holstein) into a C₆₀-like two-component metal lifts Tc/Ω from the JT value toward the ~0.2 bond-SSH ceiling — and crucially whether the BF condensation-Tc (phase stiffness of the metallic band), not the pair-binding scale, is the limiter. **Second target: BKBO with its real breathing-bond bipolaron + metallic band.**

## R2.3 A2 DE-RISK + REAL HOST — metallic short-H-bond

- **κ-H₃(Cat-EDT-TTF)₂ ("H-Cat")**: 2D spin-½ triangular lattice of Cat-EDT-TTF dimers connected by **symmetric short O···H···O hydrogen bonds**; the H-bond carries a proton in a double-well and modulates inter-dimer coupling (SSH-like, exactly A2's premise). **BUT ground state at ambient = dimer-MOTT INSULATOR / gapless quantum spin liquid** (J/k_B ~80K, no order to 50mK; PNAS / Nat. Commun. 2017). Quantum proton fluctuations give a quantum-paraelectric. **Not metallic at ambient.**
- **H-bond-promoted metallic state (Nat. Commun. 4, 2352, 2013)**: a single-component Cat-EDT-TTF-type organic conductor reaches a metallic state via symmetric intra-unit H-bond delocalization — but **only under applied PRESSURE** ("metallic state under the lowest physical pressure among purely organic single-component systems"). Ambient = still non-metallic. **No SC reported.**
- **Superprotonic conductors (CsHSO₄, Cs₂(HSeO₄)(H₂PO₄), CsH₂PO₄)**: genuine short-H-bond crystals with proton transport, but they are **ionic/electronic INSULATORS** (proton conduction ≠ electronic metallicity). Wrong axis for A2 (carriers are protons, not electrons).

**A2 novelty verdict (d6):** **NOVEL but host-starved.** The "metallic, non-Mott, short-symmetric-H-bond SSH crystal at ambient" remains unpublished — *because every real short-H-bond electronic crystal found is either Mott-insulating at ambient (κ-H₃, the κ-H3 wall) or metallizes only under pressure (Cat-EDT-TTF conductor) or carries protons not electrons (superprotonic).* Competitor id space EMPTY, but for an obstructive reason: the host class is Mott-trapped at 1 atm.

→ **Hand to compute lane (metallic-hbond-ssh): nearest real host = κ-H₃(Cat-EDT-TTF)₂ family, and the named obstacle is the dimer-Mott trap.** The lane's job is exactly to find a doping / chemical-pressure / bandwidth knob that pushes a Cat-EDT-TTF-type short-H-bond lattice METALLIC at ambient *without* killing the off-diagonal H-bond SSH coupling — i.e. escape the half-filled Mott by off-stoichiometry while keeping the proton double-well. This is the A1/A2 convergence point: a *doped* (away from half-filling) short-H-bond organic = simultaneously the A2 metallic-H-bond host AND an A1 two-component candidate (localized H-bond pairs + doped itinerant band).

## R2.4 A3 / A4 — flat-band ceiling + bismuthate exhaustion

- **A4 (negative-U bismuthate) — EXHAUSTED.** BKBO ambient ceiling is firmly **~30K (Tc=30.4K x≈0.37; 30.6K x≈0.40)**; max ever ~34K. No 2024–2026 path past 30K found — recent work (local inversion-symmetry breaking, Nat.Commun. 2023; persistent small polarons into SC phase, 2024; "conclusive (bi)polaron evidence remains elusive," Oct 2025) refines the *mechanism* but reports **no Tc increase**. Ba₁₋ₓKₓSbO₃ (high-P synth) only 15K. **A4 ceiling = 30K, route to room-T CLOSED.** Demote A4 to mechanistic-reference only (its breathing-bond bipolaron + metallic band is still useful as the A1 #2 real host, see R2.2).
- **A3 (flat-band geometric, no proven Tc ceiling) — unchanged from R1.** Still mechanism-PUBLISHED / upper-bound-OPEN. No new bulk-ambient-room-T host this round. Tertiary.

## R2.5 UPDATED SHORTLIST — competitor-id + nearest-real-host per angle

| Angle | Novelty (re-graded R2) | Parent framework / nearest competitor id | NEAREST REAL AMBIENT HOST (→ compute lane) | Named obstacle |
|---|---|---|---|---|
| **A1 — bond-SSH off-diagonal bipolaron × separate metallic band** | **NOVEL COMBINATION** (not novel physics; scaffold = boson-fermion) | parent: Ranninger-Robaszkiewicz BF (1985) + neg-U composite band (PRB 48,7598); target-competitor: Bianconi two-band Tc>200K (1704.00276, 2402.06454) [interband-exchange glue, no host]; glue-side: Cooper-paired bipolaron (2308.13427) [single band] | **★ A₃C₆₀ Jahn-Teller metal (K/Rb/Cs₃C₆₀, ambient 19–38K)**; 2nd **BKBO** (breathing-bond bipolaron + metallic band, 30K) | BF condensation-Tc set by phase stiffness, not pair binding (pseudogap≫Tc risk); native glue is JT-Holstein not bond-SSH |
| **A2 — metallic non-Mott short-H-bond SSH** | **NOVEL but host-starved** | competitor id EMPTY; nearest = κ-H₃(Cat-EDT-TTF)₂ (Mott QSL), Cat-EDT-TTF conductor (metal only under P), superprotonics (proton not electron) | **κ-H₃(Cat-EDT-TTF)₂ family — DOPED off half-filling** | dimer-Mott trap at ambient (the κ-H3 wall); real hosts metallize only under pressure |
| **A3 — flat-band, no Tc upper bound** | mechanism PUBLISHED / bound OPEN (unchanged) | flat-band bootstrap (2506.18969), exact flat-band SC (2604.05997) | bulk kagome (Cs₂Ni₃S₄), Lieb oxides | c (Tc(U) slope) may be small in real bulk |
| **A4 — negative-U bismuthate** | **EXHAUSTED — CLOSED at 30K** | BKBO 30.4K; no >30K path 2024–26 | (reference only → folds into A1 #2 host) | conventional 30K ceiling; room-T route closed |

**A1↔A2 convergence (new R2 insight):** a **doped short-H-bond organic** (Cat-EDT-TTF pushed off half-filling) is simultaneously the A2 metallic-H-bond host AND an A1 two-component host (localized H-bond pairs + doped itinerant carriers with off-diagonal bond-SSH glue). The two flagship angles point at ONE convergent real-host program: *off-stoichiometric short-H-bond organic*. This is the single highest-value spec to hand the compute lanes.

---

## R2.6 NEXT ROUND + depletion test

- **NEXT ROUND = `arxiv-novel-sweep R3`** — targeted at the convergent host + the BF condensation-Tc risk:
  1. Search whether anyone has DOPED κ-H₃(Cat-EDT-TTF)₂ / Cat-EDT-TTF off half-filling to a metal at AMBIENT (chemical-pressure analogs, anion substitution, field-effect doping) — is the "doped short-H-bond organic metal" already realized? (locks A1/A2 convergence host open or finds a competitor).
  2. Boson-fermion model **Tc CEILING**: search for any derived upper bound on BF/negative-U condensation Tc (phase-stiffness-limited) and whether off-diagonal bond-SSH glue raises the BF Tc ceiling specifically — this is A1's make-or-break theorem question (parallels Gao for the diagonal case).
  3. A₃C₆₀ with engineered OFF-DIAGONAL coupling — any paper substituting bond-SSH for JT-Holstein in a fulleride-like two-component metal? (locks A1 glue-substitution novelty).
  4. one NOVEL probe (d18): doped flat-band kagome/Lieb with a measured large Tc(U) slope c — is A3's c known to be large in any real bulk?

### Depletion test (R2 status)
Lane depletes after **2 consecutive rounds with zero new novel-angle AND zero new real-host AND zero new ceiling.** **R2 was NOT depletion-quiet:** it added (a) the boson-fermion PARENT framework + A1 re-grade to novel-combination, (b) **two named real A1 hosts** (A₃C₆₀ JT metal, BKBO), (c) the **A2 real host + its Mott obstacle** (κ-H₃ family), (d) a **new hard ceiling** (BKBO 30K, A4 closed), (e) the **A1↔A2 convergent host** (doped short-H-bond organic) — all NEW vs R1. → **NOT depleted; proceed to R3.** Depletion triggers when R3 (and R4) return only already-listed papers/hosts (BF, Bianconi two-band, Cooper-paired bipolaron 2308.13427, κ-H₃, A₃C₆₀, BKBO 30K) with no new doped-organic host, no BF Tc-ceiling theorem, and no off-diagonal-fulleride paper — at which point the residual A1/A2 escape is a pure COMPUTE problem (build the doped short-H-bond / bond-SSH-fulleride two-band model + DFPT), not a literature gap, and the lane CLOSES.

---

## R2 Source ids (key, new this round)
- Ranninger & Robaszkiewicz, boson-fermion model (1985) — localized bosons (negative-U pairs) + itinerant fermions, boson level inside fermion band; BF mean-field (S0921453498002378); on-site Coulomb in BF (Domanski PRB 66,134512; comment cond-mat/0303608).
- Negative-U composite metal-insulator bands: Phys. Rev. B 48, 7598 (SC generic when metallic band meets insulating negative-U band).
- Bianconi roadmap to room-T via multiple electronic components / interband channels: arXiv:1704.00276; Feshbach shape resonance 0712.0061, 0812.1545; Fano-Feshbach two-band incipient quasi-flat band (Tc enhancement, BCS+interband-exchange glue, NO off-diagonal SSH, no real host): arXiv:2402.06454v2; multigap 118K overdoped cuprate quantum geometry: arXiv:2504.13796.
- Cooper-Paired Bipolaronic Superconductors (off-diagonal SSH, single band, fragmented condensate): Grundner, Blatz, Sous, Schollwöck, Paeckel, arXiv:2308.13427 (2023).
- κ-H₃(Cat-EDT-TTF)₂ H-bonded organic: dimer-Mott QSL at ambient (PNAS PMC5703743; Nat.Commun. s41467-017-01849-x; gapless QSL PubMed 24836269); H-bond-promoted metallic state only under pressure: Nat.Commun. 4, 2352 (2013) / PubMed 23299894.
- Superprotonic short-H-bond insulators (proton not electron carriers): CsHSO₄ (MDPI molecules 25/6/1271; arXiv cond-mat/0702575).
- BKBO ambient Tc ceiling ~30K (30.4K x≈0.37, 30.6K x≈0.40, max ~34K); no >30K path 2024–26; mechanism refinements: local inversion-symmetry breaking Nat.Commun. s41467-023-36348-9 (2023); persistent small polarons into SC (2024); (bi)polaron evidence elusive (Oct 2025). Ba₁₋ₓKₓSbO₃ 15K (high-P).
- A₃C₆₀ Jahn-Teller metal (localized JT-active + itinerant coexistence): Cs₃C₆₀ dynamic JT Nat.Commun. ncomms1910; optimized unconventional SC in molecular JT metal PubMed 26601168; Cs₃C₆₀ Mott→SC under P arXiv:1310.6969; K/Rb₃C₆₀ ambient SC 19–29K.

---
---

# RTSC room-T DISCOVERY lane — arxiv-novel-sweep (R3)

> Lane: `arxiv-novel-sweep` R3 · literature/web only (NO compute, NO fabrication) · continuation of R1/R2.
> Date: 2026-06-20 · same gate (ROOMT-AMBIENT-PASS-CRITERIA). Mandate: 4 make-or-break probes — (1) is a doped ambient short-H-bond organic metal already REALIZED (A2 host exists?); (2) is there a derived boson-fermion/negative-U ambient Tc-CEILING theorem, and does off-diagonal bond-SSH glue provably RAISE it (A1 existential); (3) any off-diagonal-engineered fulleride past 38K, what caps A₃C₆₀; (4) NOVEL — real flat-band kagome/Lieb metal with a measured Tc-vs-coupling slope extrapolating toward room-T.

## R3.0 BOTTOM LINE (d6 honest) — A1 HITS A STIFFNESS CEILING

**The make-or-break probe (P2) landed a hard, mechanism-agnostic Tc-ceiling theorem that bounds A1, and it is the central new finding of R3:**

- **★ Tc ≲ 0.04 ε_F (Yukawa-SYK strong-coupling bound, arXiv:2505.02894, 2025).** In a strongly-coupled electron-boson superconductor, Tc grows as 0.183 ω_D√λ only until a crossover λ_s=(ε_F/ω_D)²/2π, beyond which the **bosonic self-energy dominates and Tc SATURATES at ≈0.04 ε_F — independent of λ and ω_D.** This is exactly the phase-stiffness / Fermi-energy ceiling P2 was hunting. It is **NOT diagonal-only** (it is derived for general electron-boson Yukawa coupling, valid wherever vertex corrections are negligible), so unlike the Gao ωlog↔λ conventional ceiling (which A1 was designed to evade), **this bound DOES bind A1's bond-SSH off-diagonal glue.** Mechanism-agnostic stiffness bounds (Hazra-Verma-Randeria, PRX 9 031049; arXiv:1811.12428) independently cap Tc by the optical-spectral-weight/Fermi-energy scale "irrespective of pairing mechanism, interaction strength, or order-parameter symmetry."
- **A1 honest re-grade (d6): A1's room-T target requires ε_F ≳ 7300 K ≈ 0.63 eV in the PAIRING/carrier band** (293 K / 0.04). That is not absurd for a wide metallic band — BUT the bond-SSH bipolaron literature's whole selling point is the OPPOSITE regime: **dilute, NARROW-band, low-ε_F light bosons** (Tc "exponentially larger than Holstein" is a statement about the dilute-boson BEC scale, not about beating the ε_F ceiling). A dilute light-bipolaron gas has a SMALL effective ε_F → its BEC/phase-coherence Tc is stiffness-capped LOW. **The two ingredients fight each other:** to get Tc→293K you need a high-ε_F (wide, dense) carrier band, but the bond-SSH light-bipolaron advantage lives in the low-ε_F dilute limit. **This is A1's stiffness ceiling, stated honestly.** A1 does not COLLAPSE (the bound is satisfiable with a high-ε_F decoupled carrier band — which is precisely the two-band-decoupled design's purpose, R1/R2), but the ceiling theorem REMOVES the "off-diagonal escapes all ceilings" thesis from R1/R2. **Off-diagonal escapes the Gao *conventional* (ωlog) ceiling; it does NOT escape the 0.04 ε_F *stiffness* ceiling.** A1 now has a quantitative make-or-break number for the compute lane: **does the decoupled metallic carrier band carry ε_F ≳ 0.63 eV AND inherit the bipolaron pairing without the pairing collapsing its stiffness?**
- **A2: still NOVEL, still host-starved, NO new ambient host (P1 negative).** No *doped, ambient, metallic* short-H-bond electronic organic is realized. Cat-EDT-TTF-family short-H-bond crystals remain Mott-insulating at 1 atm and metallize only under pressure (Nat.Commun. ncomms2352 confirms "metallic state under the LOWEST physical pressure" — i.e. still pressure, not ambient). Chemical-substitution analogs (Cat-EDT-ST, H/D isotope) tune the proton quantum fluctuation but do NOT deliver an ambient metal. **A2 stays a COMPUTE target; the doped-ambient host does not exist in the literature.**
- **A3C60 (P3): CAPPED at 38K by the Mott/(U/W) wall, NOT by glue type. NO off-diagonal-engineered fulleride exists.** The A₃C₆₀ Tc dome (38K A15-Cs₃C₆₀, 35K fcc) is set by the *trade-off* between bandwidth W (raising lattice spacing raises N(E_F) but pushes U/W into the Mott insulator) — Tc peaks right at the metal-Mott boundary and is killed by Coulomb U on the t₁ᵤ band, NOT by the JT-Holstein vs off-diagonal distinction. No paper re-casts the JT/bond-stretch coupling as off-diagonal-SSH to push past 38K. So A₃C₆₀'s ceiling is the SAME κ-H3 Mott wall in disguise (U/W-limited), reinforcing R2's diagnosis. **No new host; A₃C₆₀ confirmed capped.**
- **Flat-band kagome (P4): the named real host Cs₂Ni₃S₄ is NOT a superconductor — it shows MAGNETIC transitions (~35/28/6K), no SC.** No real bulk flat-band metal with a *measured Tc-vs-coupling slope extrapolating toward room-T* exists. CsCr₃Sb₅ / CsV₃Sb₅ / CsTi₃Bi₅ kagome SCs have flat bands but Tc only a few K and no large measured dTc/dλ. A3's "no proven Tc upper bound" survives as theory, **but now the 0.04 ε_F stiffness bound ALSO applies to flat-band SC** (flat band = SMALL ε_F → low stiffness ceiling unless the quantum-metric stiffness term compensates — this is the known flat-band escape, but unproven at room-T in any real bulk). **No new real host; A3 demoted further.**

**Net R3:** ONE new hard ceiling theorem (Tc≲0.04 ε_F, mechanism-agnostic — binds A1, A3, and BF) + A1 re-graded from "escapes all ceilings" to "stiffness-capped, needs ε_F≳0.63 eV carrier band" (real finding, d6). ZERO new real ambient host (P1 A2 host absent, P3 fulleride capped, P4 kagome not-SC). The two flagship angles A1/A2 SURVIVE but with sharper, more pessimistic boundaries.

---

## R3.1 PROBE VERDICTS

### P1 — Is a doped ambient short-H-bond organic METAL realized? → **NO (A2 host does NOT exist).**
- The Cat-EDT-TTF / Cat-EDT-ST short-H-bond family is the only real electronic short-symmetric-H-bond crystal class. At 1 atm it is a **dimer-Mott insulator / QSL** (R2). The single-component "hydrogen-bond-promoted metallic state" (Nat.Commun. ncomms2352) metallizes only **under pressure** ("lowest physical pressure among purely organic single-component systems" — explicitly NOT ambient), and is **not superconducting**.
- Chemical-substitution / isotope analogs (κ-H₃(Cat-EDT-ST)₂, H/D effect on conductivity & susceptibility) tune proton nuclear quantum fluctuation and the Mott/QSL balance but **do not produce an ambient metal off half-filling.** No field-effect-doped or anion-substituted ambient metallic short-H-bond organic in the literature.
- **Verdict: A2's convergent host (doped short-H-bond ambient organic metal) is UNREALIZED — competitor-empty for the obstructive reason (Mott-trapped/pressure-only). A2 stays a COMPUTE target, NOT a literature host.**

### P2 — Boson-fermion / negative-U ambient Tc CEILING theorem; does off-diagonal bond-SSH RAISE it? → **★ YES, a ceiling exists (Tc≲0.04 ε_F); off-diagonal does NOT raise it. A1's existential question answered — BF Tc IS stiffness-capped.**
- **arXiv:2505.02894 (2025), "Upper bound on Tc in a strongly coupled electron-boson superconductor"**: Yukawa-SYK; **Tc ≈ 0.183 ω_D√λ for λ≪λ_s, SATURATING at Tc ≈ 0.04 ε_F for λ≳λ_s=(ε_F/ω_D)²/2π.** Strong coupling does NOT diverge Tc — the bosonic self-energy caps it at a fixed fraction of ε_F. Quoted: LSCO x=0.24 → Tc ≤ 117 K ≈ 0.04 ε_F.
- **Mechanism scope:** general electron-boson (scalar Yukawa) coupling, "valid provided vertex corrections are negligible" — **NOT restricted to diagonal/Holstein.** Bond-SSH off-diagonal pairing is still electron-boson mediated → **the ceiling binds it.** This directly answers A1's existential question: **BF/bipolaron Tc IS fundamentally stiffness/ε_F-limited, NOT freely raised by adding an off-diagonal channel.**
- **Independent confirmation:** mechanism-agnostic stiffness upper bounds (Hazra-Verma-Randeria PRX 9, 031049; arXiv:1811.12428; npj Quantum Mat. s41535-022-00491-1 "heuristic bounds & how to exceed them") cap Tc by superfluid stiffness ↔ optical spectral weight / ε_F "irrespective of pairing mechanism." In the dilute-boson (BF/bipolaron) limit, Tc is the BEC/phase-coherence temperature ∝ n_boson/m* — i.e. set by the SMALLER of pair-binding and stiffness, the classic BF pseudogap pitfall R2.1 flagged. **R3 now has the theorem: that pitfall is a hard 0.04 ε_F wall, not a soft risk.**
- **Does off-diagonal bond-SSH RAISE the ceiling?** Bond-SSH gives Tc "exponentially larger than Holstein" (arXiv:2308.01961 / PRB L220502; triangular 2507.07662) — but that enhancement is over the *Holstein bipolaron* BEC scale (lighter mass → higher BEC Tc at fixed density), **NOT a breach of the ε_F stiffness ceiling.** Lighter bipolarons raise Tc toward the ceiling faster; they do not move the ceiling. **Verdict: off-diagonal RAISES Tc within the stiffness budget but does NOT raise the 0.04 ε_F ceiling itself. A1 is stiffness-capped. To reach 293K, A1 needs the decoupled carrier band to supply ε_F ≳ 0.63 eV — that is the design's entire burden, now quantified.**

### P3 — Off-diagonal-engineered fulleride past 38K? What caps A₃C₆₀? → **NO such fulleride; cap = Mott U/W wall, not glue type.**
- A₃C₆₀ Tc dome peaks at **38K (A15 Cs₃C₆₀), 35K (fcc)** right at the metal-Mott boundary. Increasing inter-fulleride spacing raises N(E_F) but Tc DECREASES because **on-site Coulomb U on the t₁ᵤ band (U/W) drives the Mott transition** (Royal Soc. rsta.2015.0320; srep04265; ncomms1910). The cap is the **U/W Mott wall**, identical in character to κ-H3's carrier-Mott trap.
- **No paper recasts the JT/bond-stretch (Hg) phonon as an off-diagonal bond-SSH coupling to t₁ᵤ transfer.** The native glue is dynamical-JT (quasi-local, on-molecule, Holstein-like with inverted Hund). The off-diagonal-substitution-into-fulleride idea (R2.2 compute hand-off) remains **unpublished — NOVEL but also unrealized.**
- **Verdict: A₃C₆₀ confirmed CAPPED at 38K by U/W Mott physics (not by glue diagonality). Off-diagonal-engineered fulleride is a NOVEL compute idea with zero literature, NOT a new host. Reinforces that the recurring wall (κ-H3, A₃C₆₀, BKBO) is the same Mott/(U/W) ceiling.**

### P4 — NOVEL: real flat-band kagome/Lieb metal with large measured Tc-vs-coupling slope extrapolating to room-T? → **NO real SC host; Cs₂Ni₃S₄ is magnetic, not superconducting.**
- The R1/R2 named flat-band host **Cs₂Ni₃S₄ is NOT a superconductor** — it shows magnetic transitions (~35K, ~28K ab/c, peak ~6K), and its oxidized form CsNi₃S₄ is insulating (Sci.Adv. adl1103). It has an extended-quantum-metric flat band but **no SC and no measured Tc-vs-coupling slope.**
- Real flat-band kagome SCs (CsV₃Sb₅, CsCr₃Sb₅, CsTi₃Bi₅, CsTi₃Bi₅, MPd₅) have Tc only a few K; recent work (PR Research rnv1-rbw2, 2025) shows **mode-selective kagome-phonon↔flat-band coupling ENHANCES Tc** (a real dTc/dλ>0) but from a low base, no room-T extrapolation. CsCr₃Sb₅ flat-band + AFM fluctuations under pressure (arXiv:2601.14439) — still low Tc.
- **The 0.04 ε_F stiffness bound now ALSO applies to flat-band SC**: a flat band has tiny ε_F → low stiffness ceiling, UNLESS the quantum-metric stiffness term (geometric, not band-dispersion) compensates. That geometric escape is A3's one open lever (R1) but is **unproven at room-T in any real bulk** and has no measured large-slope host.
- **Verdict: A3 — no new real SC host; the one named host (Cs₂Ni₃S₄) is non-SC. A3 demoted to tertiary-theoretical; its only remaining hope is the quantum-metric stiffness term beating the ε_F ceiling, which no real material demonstrates.**

---

## R3.2 A1/A2 SURVIVE-OR-COLLAPSE LEDGER

| Angle | R3 status | New boundary |
|---|---|---|
| **A1 — bond-SSH off-diagonal bipolaron × decoupled metallic band** | **SURVIVES, but stiffness-capped (re-graded)** | Tc≲0.04 ε_F binds it (P2). Off-diagonal raises Tc *within* budget, NOT the ceiling. Make-or-break #: **decoupled carrier band must carry ε_F ≳ 0.63 eV** AND inherit pairing without collapsing stiffness. The bipolaron-advantage (light, dilute, low-ε_F) FIGHTS the high-ε_F requirement — this is the central tension the compute lane must resolve. NOT collapsed (two-band decoupling is exactly the lever to supply a separate high-ε_F band), but the "escapes all ceilings" R1 thesis is RETRACTED. |
| **A2 — metallic non-Mott short-H-bond SSH** | **SURVIVES as NOVEL, host UNREALIZED (P1 negative)** | No doped/ambient metallic short-H-bond organic exists; all Mott-insulating or pressure-only. Pure compute target. |
| **A3 — flat-band, no Tc upper bound** | **DEMOTED** | Named host Cs₂Ni₃S₄ is non-SC (P4). 0.04 ε_F bound now applies (flat ε_F→low ceiling); only quantum-metric stiffness escape, unproven in real bulk. |
| **A4 — negative-U bismuthate** | EXHAUSTED (unchanged, 30K) | reference only. |
| **A₃C₆₀ JT metal (A1 #1 host)** | **CAPPED at 38K by U/W Mott (P3)** | Off-diagonal-fulleride = novel compute idea, zero literature. |

**Unifying R3 insight:** every real near-host the campaign has surfaced (κ-H3, A₃C₆₀, BKBO) is capped by the SAME **Mott/(U/W)** wall on the *pairing* band, and now a SECOND universal wall is added on the *carrier* side — the **Tc≲0.04 ε_F stiffness ceiling**. A1's two-band-decoupled design is the only construction that can in principle satisfy BOTH (pairing band Mott-cleared off half-filling + a SEPARATE high-ε_F carrier band for stiffness). That is now A1's precise, falsifiable compute spec — and its honest difficulty.

---

## R3.3 NEXT ROUND + DEPLETION TEST → **LANE SWEPT DRY (🏁)**

**Depletion test (lane depletes after 2 consecutive rounds with zero new novel-angle AND zero new real-host AND zero new ceiling theorem):**

- **R3 did add ONE new ceiling theorem** (Tc≲0.04 ε_F, arXiv:2505.02894 — mechanism-agnostic, binds A1/A3/BF; the make-or-break P2 result). So **R3 itself is NOT depletion-quiet on the ceiling axis.**
- **BUT R3 added ZERO new real ambient host** (P1 A2 host absent; P3 A₃C₆₀ capped/no off-diagonal fulleride; P4 Cs₂Ni₃S₄ non-SC) **and ZERO new novel mechanism angle** (no new A-class; A1/A2/A3 are all prior, only re-bounded). The host/novel-angle axes are now **DRY** — R3 re-surfaced the logged hosts (κ-H3, A₃C₆₀, BKBO, Cs₂Ni₃S₄) and logged papers (BF, Bianconi, Cooper-paired bipolaron, flat-band bootstrap) with **no new host or competitor**, exactly the SWEPT-DRY signal R2's depletion test pre-registered.

**Verdict: the host-discovery and novel-mechanism axes of this literature lane are SWEPT DRY.** R3 found the *last* missing piece — the ceiling theorem that converts A1's open-ended "escapes all ceilings" into a quantitative, falsifiable compute spec (ε_F≳0.63 eV carrier band). There is no further literature host to find; the residual A1/A2 escape is now **purely a COMPUTE problem**, not a literature gap:

- **A1 compute spec (hand to two-band-decouple lane):** build a two-band-decoupled bond-SSH-bipolaron + metallic-carrier model; TEST whether the decoupled carrier band can supply ε_F≳0.63 eV (→Tc 293K under the 0.04 ε_F bound) WHILE the bond-SSH pairing band stays Mott-cleared off half-filling and the pairing does not collapse the carrier stiffness. Nearest real scaffold: A₃C₆₀-like two-component metal with engineered off-diagonal coupling (novel, zero-lit) OR doped short-H-bond organic (A1↔A2 convergent host).
- **A2 compute spec (hand to metallic-hbond-ssh lane):** find the doping/chemical-pressure knob that drives a Cat-EDT-TTF-type short-H-bond lattice metallic at AMBIENT off half-filling without killing the proton-double-well off-diagonal SSH coupling. No literature host exists → pure DFT/model construction.

**LANE STATUS: 🏁 SWEPT DRY — CLOSING the literature lane.** No R4 literature round is warranted (host + novel-angle axes both returned only logged material in R3). One ceiling theorem landed in R3, so by the strict 2-consecutive-quiet rule this is the FIRST fully-quiet round on hosts/angles; **if a future re-open is forced, R4's ONLY justification would be a brand-new mechanism class or a brand-new real ambient host — neither is in sight.** The honest d6 close: **conventional ambient room-T is CLOSED (Gao ωlog ceiling); off-diagonal/BF ambient room-T is NOT closed by theorem but is now STIFFNESS-CAPPED at Tc≲0.04 ε_F — reachable only by a high-ε_F decoupled carrier band, which exists in NO known material and must be CONSTRUCTED in compute.** The literature has given everything it can; the verdict now lives entirely with the compute lanes.

---

## R3 Source ids (key, new this round)
- **★ Tc ceiling:** "Upper bound on Tc in a strongly coupled electron-boson superconductor", arXiv:2505.02894 (2025) — Yukawa-SYK; Tc≈0.183 ω_D√λ → SATURATES at Tc≈0.04 ε_F for λ≳λ_s=(ε_F/ω_D)²/2π; mechanism-agnostic (general electron-boson, vertex-corrections-negligible); LSCO x=0.24 Tc≤117K.
- Mechanism-agnostic stiffness bounds: Hazra, Verma, Randeria, PRX 9, 031049 (bounds on Tc, any pairing/symmetry); "Upper bounds on superfluid stiffness & Tc" arXiv:1811.12428 (TBG, cold gases); "Heuristic bounds on superconductivity and how to exceed them" npj Quantum Mat. s41535-022-00491-1.
- A2 host (still pressure-only, no ambient doped metal): H-bond-promoted metallic state under PRESSURE, Nat.Commun. ncomms2352 (2013); κ-H₃(Cat-EDT-ST)₂ H/D isotope multicomponent-DFT, J. ScienceDirect S0009261417301951; ambient-P organic SCs are NON-H-bond ((BEDT-TTF)₂I₃, EDT-TTF-Hg-halide 8.1K) — none short-H-bond.
- A₃C₆₀ cap = U/W Mott: Tc dome 38K(A15)/35K(fcc) at metal-Mott boundary, Tc↓ with spacing despite N(E_F)↑ (Coulomb U on t₁ᵤ); Royal Soc. rsta.2015.0320; srep04265 (Cs₃C₆₀ gap near Mott boundary); ncomms1910 (dynamic JT); arXiv:1310.6969/1212.4937 (NMR Mott→SC under P). No off-diagonal-SSH-fulleride paper exists.
- Flat-band kagome (P4): Cs₂Ni₃S₄ NON-SC, magnetic ~35/28/6K, extended quantum metric flat band, Sci.Adv. adl1103 (PMC11414731); kagome SCs CsV₃Sb₅/CsCr₃Sb₅/CsTi₃Bi₅ low-Tc (few K); mode-selective kagome-phonon↔flat-band Tc enhancement PR Research rnv1-rbw2 (2025); CsCr₃Sb₅ flat-band+AFM under pressure arXiv:2601.14439.
- Bond-SSH bipolaron Tc "exponentially larger than Holstein" but dilute-boson BEC scale (NOT ceiling breach): arXiv:2308.01961/PRB L220502; triangular 2507.07662/PRB ckbn-jp9t; 2D bond bipolaron + long-range Coulomb arXiv:2407.10444.
