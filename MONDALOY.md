# MONDALOY — combustion-resistant superalloy verification target

> **Status**: spec / discovery-target framing · `absorbed=false` ·
> `gate_type=simulation-only-prediction` — no composition claim, no
> measured-oracle (MondAloy composition is SpaceX trade secret).
>
> opened: 2026-05-22 KST (demiurge domain doc) ·
> upstream draft: `hexa-space/mondaloy/mondaloy.md` (2026-05-07,
> n=6-lattice structural-pattern framing) ·
> historical log: [`./MONDALOY.log.md`](./MONDALOY.log.md)
>
> sibling of `RTSC.md` (compositional superconductor discovery) ·
> `NUCLEAR.md` (elemental discovery) — those discover/verify *novel*
> materials; MONDALOY.md tracks a **known proprietary target** whose
> structural-property envelope can be bounded by first-principles /
> thermodynamic modelling without the proprietary composition.

This document is the demiurge materials-domain doc for **MondAloy** —
SpaceX's combustion-resistant nickel-based superalloy. It frames the
non-wet-lab verification pipeline (d1) for a MondAloy-*class* alloy:
what a first-principles or CALPHAD-grade study could predict, and the
honest boundary where the proprietary composition makes the verdict
structural-pattern only.

---

## §1. What MondAloy is (public surface only)

MondAloy is SpaceX's proprietary nickel-based combustion-resistant
superalloy, publicly disclosed (by SpaceX statements / press) as the
material of:

- the **Raptor 3 combustion chamber**, and
- the **oxygen-rich preburner lining**.

Its design failure mode is **oxygen-rich high-temperature combustion**
— the regime that historically destroyed ox-rich staged-combustion
engines (the same regime the Soviet RD-170 family fought with
specialized coatings). MondAloy's claimed niche is holding integrity
against ox-rich hot gas without a separate ceramic coating.

**The composition is a SpaceX trade secret.** No public chemistry
disclosure is assumed. Everything below is either public-surface fact
or an explicitly-labelled structural-pattern model — never a chemistry
claim (governance D1 clean-room · d6 measured-oracle invariant).

## §2. Why this is a demiurge domain doc

demiurge is the meta-conductor of a materials → chip → component
program. MondAloy sits squarely in the **materials verb** for the
space domain: a combustion-chamber superalloy is the SYNTHESIZE-stage
material a rocket-engine design pass must specify and verify.

RTSC.md asks "can a novel composition reach a target Tc"; MONDALOY.md
asks the dual question — "given a *known* target alloy class, how far
can the non-wet-lab pipeline bound its high-temperature / oxidation
envelope **without** the proprietary composition?" That is a legitimate
d1 exercise: drive the *bounding* analysis to completed-form, and name
the proprietary-composition wall as the honest `not yet` boundary.

## §3. Non-wet-lab verification pipeline (d1 — what CAN be driven to done)

A MondAloy-*class* Ni-base superalloy (Ni + ~5 strengtheners — public
superalloy practice, e.g. Inconel/Hastelloy/René families) admits a
real first-principles + thermodynamic pipeline that needs *no*
proprietary data:

| stage | method | what it bounds | proprietary-free? |
|---|---|---|---|
| phase stability | CALPHAD (Thermo-Calc / OpenCALPHAD + TCNI database) | γ/γ′ phase fractions vs T for a *candidate* composition | ✓ (uses public Ni-superalloy databases) |
| oxidation kinetics | parabolic-rate / Wagner theory + DFT O-vacancy formation | NiO/Cr₂O₃/Al₂O₃ scale growth rate vs T, pO₂ | ✓ |
| el./thermal transport | DFT + Boltzmann transport (как RTSC el-ph pipeline) | thermal conductivity, used as a *low-conductivity* design lever | ✓ |
| creep / thermomech | crystal-plasticity FEM (e.g. via `hexa-lang/stdlib` fem kernel) | creep life vs stress/T for a candidate microstructure | ✓ |
| service ceiling | combine the above → T_max envelope | upper bound on service temperature for a candidate | ✓ |

Each of these is a Tier-1 *prediction* (`gate_type=simulation-only-
prediction`, exactly like RTSC DFT). None flips `absorbed=true` — that
would need a measured oracle against the *actual* MondAloy, which is
proprietary and unavailable (d6).

## §4. The honest wall (d2 framing — not a concession)

The proprietary composition is an empirically-demonstrated wall: we
cannot verify *MondAloy itself*. Per d2, the breakthrough framing is
**not** "impossible" — it is to redefine the deliverable:

1. **Bound the class, not the instance.** Drive a CALPHAD + DFT study
   of the *public* Ni-base ox-resistant superalloy envelope to
   completed-form; report the predicted T_max / oxidation-rate band
   that any Ni+5 alloy in that family can occupy. MondAloy then sits
   *somewhere in that band* — a verified bound, not a guessed point.
2. **Inverse-design a MondAloy-class candidate.** Use the same
   compositional-sweep machinery RTSC uses for hydrides (DFT screen +
   CALPHAD filter) to *propose* a Ni+5 composition that meets the
   public-spec envelope (ox-rich, ~2200 K class, low conductivity).
   That candidate is a novel demiurge prediction — publishable,
   `absorbed=false`, and entirely proprietary-free.
3. **Measure a non-proprietary analog.** A lab-castable Ni-base
   ox-resistant alloy (public composition) can be the measured-oracle
   carrier — the pipeline is then validated on the analog, exactly as
   the RTSC pipeline was validated on H₃S before being applied to
   novel H₃X.

## §5. n=6 structural-pattern note (numerology — NOT measurement)

The upstream `hexa-space/mondaloy/mondaloy.md` maps MondAloy counts to
the n=6 lattice (6 alloying elements, 12 chamber zones, 4 thermal
regimes, σ·φ = n·τ = 24, etc.). Per demiurge governance (d6/d7, and
the §8.8 hexa-atlas-witnessed stance in `RTSC.md`):

> **The n=6 mapping is a counting coincidence / mnemonic, NOT a
> physical prediction.** It carries `gate_type` nothing — it is not a
> simulation, not a measurement, not a Tier-1 prediction. It must
> never be cited as evidence for any thermomechanical property of
> MondAloy. `verify_mondaloy.hexa` tests the *count-lattice* only and
> explicitly "does NOT model thermomechanical behavior" (upstream §4).

This doc records the n=6 framing only to mark it as **out of scope**
for any `absorbed`/gate decision — the same carve-out RTSC.md applies
to hexa-atlas n6 "Tc 300K" being a *target*, not a measurement.

## §6. Status

- v0.1 — demiurge domain doc opened (this file). No pipeline run yet.
- `absorbed=false` · no measured oracle · composition proprietary.
- No demiurge `exports/` record emitted for MondAloy. When the §3
  pipeline runs (CALPHAD or DFT), records land in
  `exports/material_discovery/` with `gate_type=simulation-only-
  prediction`, exactly like the RTSC H₃X records.
- Upstream `hexa-space/mondaloy/` remains `SPEC_ONLY` v1.0.0.

## §7. Design ideas — forward (설계 아이디어, arxiv/web deep-research)

> **Naming note**: the publicly-disclosed SpaceX alloy is **SX500** (the
> SX250 → SX300 → SX500 lineage). "MondAloy" is the upstream
> `hexa-space` draft's label; treat the two as the same target. SX500 is
> publicly characterised as a "modern Inconel-derivative" rated for
> **~800 atm (810 bar) hot oxygen-rich gas** with "extreme oxidation
> resistance", castable **and** 3D-printable, used in the Raptor
> ox-rich turbopump / preburner / chamber.

How demiurge would *design* an SX500/MondAloy-class alloy from scratch —
a concrete 7-verb pass, every step proprietary-free:

1. **SPECIFY — the ox-rich envelope.** Unlike turbine superalloys
   (fuel-side, reducing), this alloy faces **hot oxygen** at 810 bar.
   The design target is therefore *not* peak creep strength but a
   **slow-growing, self-healing, well-adherent oxide scale with no
   separate coating** — SX500's public claim is a *bare* alloy, a
   deliberate break from the RD-170/RD-180 solution (inert **enamel
   coating** on every hot-oxygen surface). Coating-free is the headline
   design constraint.
2. **ARCHITECT — the composition space.** Ni-base + ~5 strengtheners.
   Public Ni-superalloy practice bounds the menu: Cr (Cr₂O₃ former),
   Al (α-Al₂O₃ former, the better scale in ox-rich), Co (γ′ solvus +
   stacking-fault control), Mo/W/Ta/Re (solid-solution + γ′
   strengthening), Ti/Nb (γ′ formers), and reactive elements
   **Y/Hf/Zr** (scale adhesion — the "reactive-element effect").
3. **DESIGN — CALPHAD funnel.** Mirror the published precedent that
   narrowed **779,625 composition combinations → 12 alloys** via
   Thermo-Calc / OpenCALPHAD (TCNI database): filter on γ/γ′ phase
   fraction, freezing range, density, castability, processing window.
   For the ox-rich target, *add an oxidation criterion*: bias toward
   **alumina-forming** compositions (Al activity high enough to sustain
   a continuous α-Al₂O₃ layer — the classic "third-element effect"
   needs Cr to getter O before Al, then Al takes over).
4. **ANALYZE ⟲ — DFT + ML.** (a) DFT O-vacancy formation energy +
   oxide-scale adhesion energy → rank candidates for ox-rich survival
   (same el-ph/DFPT machinery as the RTSC pipeline, different
   observable). (b) Physics-descriptor ML for creep strength
   (arxiv:2212.06755 — superalloy microchemistry → creep from physical
   descriptors). (c) Hybrid CNN-LSTM for oxidation-kinetics prediction
   (recent literature). Iterate composition back into DESIGN.
5. **SYNTHESIZE — printability gate.** SX500 is cast *and* additively
   manufactured. The design must pass a hot-cracking / weldability
   window — this prunes the highest-γ′ (highest-strength) compositions,
   a real trade SX500's metallurgy team must have made. demiurge models
   this as a hard constraint, not an afterthought.
6. **VERIFY — analog measurement.** Cast a *public-composition*
   alumina-forming Ni alloy (e.g., a Haynes-282-class or René-N5-class
   reference) and measure ox-rich scale growth; this validates the
   pipeline on an analog before any SX500-class claim (the same
   discipline RTSC used — validate on H₃S, then predict novel H₃X).
7. **HANDOFF — to the chip/component meta-conductor.** A verified
   alloy envelope feeds the component-domain FEM (chamber-wall thermal
   + creep life), closing the materials → component seam.

**The single biggest design lever** (deep-research synthesis): ox-rich
combustion rewards an **α-Al₂O₃-forming** alloy over a Cr₂O₃-forming
one — Cr₂O₃ volatilises as CrO₃/CrO₂(OH)₂ above ~1300 K in the presence
of O₂/H₂O, while α-Al₂O₃ is stable far higher. SX500's "extreme
oxidation resistance" almost certainly rests on a reactive-element-
stabilised alumina scale. That is a *proprietary-free, physically
derivable* design conclusion.

## §8. Reverse-engineering ideas — 역설계 (public-surface only, D1)

How to bound / infer the SX500-MondAloy composition **without** the
trade secret — clean-room, public-surface only (governance D1: no
trade-secret extraction, no closed-binary RE; this is *constraint
triangulation*, which is legitimate):

1. **Constraint triangulation.** Intersect every public spec — 810 bar
   burst · hot O₂ · "modern Inconel-derivative" · castable +
   3D-printable · bare-alloy (coating-free) ox resistance · Raptor-3
   chamber service temperature class. Each constraint carves the
   Ni-Cr-Al-Co-(refractory) space; the *intersection* is a small
   region. SX500 lives in it — a verified **bounding box**, not a
   single guessed point.
2. **Patent forensics.** Search USPTO / Espacenet for assignee
   **"Space Exploration Technologies"** (and known SpaceX metallurgist
   inventor names) in CPC class **C22C19/05** (Ni-base alloys) filed
   ~2017-2025. Alloy patents routinely disclose **composition ranges**
   even when the commercial product name stays secret — the published
   range *is* a reverse-engineering result, fully legal to cite.
3. **Oxide-scale forensics on public hardware.** Raptor 3 chamber /
   bell photographs after hot-fire: oxide-scale **colour** discriminates
   the protective oxide — green/dark = Cr₂O₃-dominant, pale-grey/white
   = Al₂O₃-dominant. This is a free, public, non-destructive read on
   the Al-vs-Cr balance of the scale (and hence of the alloy).
4. **Process-of-elimination via the §7 forward pipeline.** Run the
   CALPHAD + DFT + ML design funnel against *all* public SX500
   constraints simultaneously. Whichever composition family *uniquely*
   satisfies all of them is the reverse-engineered envelope — SX500 is
   "somewhere in that family". This converts RE into a forward
   simulation problem (no secret needed).
5. **Analog benchmarking against declassified prior art.** SX500 is an
   *evolution* of public Ni-superalloy science, not a discontinuity.
   Bracket it with: Inconel 625/718, Haynes 282, René N5/N6, and the
   declassified RD-170/RD-180 ox-rich materials literature. The public
   alumina-forming-superalloy envelope upper-bounds SX500's novelty.
6. **ML inverse design as the RE engine.** Feed the public performance
   spec into a generalist inverse-design model — e.g. **MATAI**
   (arxiv:2511.10108, generalist ML property-prediction + inverse
   design for advanced alloys), the neural-network Ni-superalloy
   designer (arxiv:1803.03039), or generative DL for refractory alloys
   (arxiv:2108.12019). The model **outputs composition candidates that
   meet the spec**. Those candidates are a *de facto* reverse
   engineering — not the trade secret, but **functionally equivalent**,
   and entirely proprietary-free.
7. **The honest boundary (d6).** RE yields a *candidate matching the
   public spec*, never SX500 itself. With no measured oracle against
   the actual SpaceX alloy, the verdict stays
   `gate_type=simulation-only-prediction`, `absorbed=false`. **But this
   is the d2 breakthrough**: a functionally-equivalent *open* alloy
   sidesteps the trade-secret wall entirely — demiurge's deliverable is
   an open SX500-class superalloy, publishable, not a stolen secret.

> **Why RE here is legitimate (not a violation):** governance D1 bans
> closed-binary decompilation, license/DRM circumvention, and
> trade-secret *extraction*. Constraint triangulation, patent reading,
> public-photo forensics, and forward simulation are all **public-
> surface clean-room** — the same standard every demiurge
> absorption-RFC already meets. The output is an *independently
> derived* open alloy, not a copy.

## §9. Reverse-engineering — EXECUTED (this session, 2026-05-22)

The §8 RE methods, run analytically against the public surface. Output
= a concrete, proprietary-free, reverse-engineered composition envelope
for an SX500-class alloy. `gate_type=simulation-only-prediction` ·
`absorbed=false` (this is an *inference*, never measured against the
actual SpaceX alloy — d6).

### §9.1 Patent forensics — result

USPTO / Google Patents search for assignee **"Space Exploration
Technologies"** in Ni-superalloy class **C22C19/05**: **zero SX500
patents found.** This is itself a finding — **SpaceX protects SX500 as
a trade secret, not a patent** (a patent would force public composition
disclosure; a trade secret does not). Consequence for RE: no patent
shortcut exists; the envelope must be triangulated from physics +
public-spec constraints + analog brackets (§9.2-§9.4).

### §9.2 Analog composition brackets (public datasheets, wt%)

| element | Inconel 625 | Inconel 718 | Haynes 282 | René N5 (SX turbine) |
|---|---|---|---|---|
| Ni | bal ≥58 | 50-55 | bal ~57 | bal ~61 |
| Cr | 20-23 | 17-21 | 19-21 | 7 |
| Al | ≤0.4 | 0.2-0.8 | 1.5 | **6.2** |
| Co | ≤1 | ≤1 | 10 | 8 |
| Mo | 8-10 | 2.8-3.3 | 8.5 | 2 |
| W | — | — | — | 5 |
| Ti | ≤0.4 | 0.65-1.15 | 2.1 | — |
| Nb | 3.15-4.15 | 4.75-5.5 | — | — |
| Ta | — | — | — | 7 |
| Hf/Y/Zr | — | — | — | Hf 0.2 |
| oxide formed | Cr₂O₃ | Cr₂O₃ | Cr₂O₃ | **Al₂O₃** |

The two endpoints bracket SX500: the **Inconel 625/718** family
(chromia-forming, weldable/printable, low Al) and the **René N5** family
(alumina-forming, high Al + reactive-element Hf, single-crystal — *not*
printable). SX500 must sit **between** them: alumina-capable like N5,
but castable/printable like the Inconels.

### §9.3 Physics constraint — the ox-rich lever (decisive)

810 bar hot oxygen, **coating-free**. Pure Cr₂O₃ (the Inconel 625/718
scale) volatilises as CrO₃ / CrO₂(OH)₂ above ~1300 K when O₂/H₂O
activity is high — *fatal* in an ox-rich preburner. Therefore SX500
**must form a protective α-Al₂O₃ scale**, which forces **Al well above
the stock-Inconel ≤0.8 wt%**, plus a **reactive element (Hf/Y/Zr)** to
keep the alumina scale adherent through thermal cycling. This is the
single highest-confidence RE inference — it is pure thermodynamics, no
proprietary data.

### §9.4 Reverse-engineered SX500-class envelope (this session's deliverable)

Triangulating §9.1-§9.3 + the printability cap (γ′-former total bounded
to stay weldable, ruling out N5's 6.2 % Al) + the public "Ni + 5
strengtheners" characterisation:

| element | RE envelope (wt%) | role / rationale |
|---|---|---|
| **Ni** | 55-62 | base |
| **Cr** | 16-22 | chromia underlayer + hot-corrosion + third-element-effect O getterer |
| **Al** | **3.5-6.0** | α-Al₂O₃ former — **THE ox-rich lever**, the key departure from stock Inconel (§9.3) |
| **Co** | 8-15 | γ′ solvus ↑, stacking-fault energy, strength |
| **Mo** | 2-6 | solid-solution strengthening |
| **Ti** | 1-3 | γ′ former (with Al) |
| **Hf** | 0.1-0.5 | reactive element — alumina scale adhesion |
| **Y/Zr** | 0.01-0.1 | secondary reactive element |
| W/Nb/Ta | 0-4 each | optional solid-solution / γ′; printability-capped |
| Fe / C / B | ≤5 / 0.02-0.1 / trace | castability, grain boundary |

**The "n=6" elements** (Ni + 5 strengtheners, matching the public
characterisation): most-likely **Ni · Cr · Al · Co · Mo · Ti** — a
castable, printable, alumina-forming, γ′-strengthened Ni superalloy.

> **Honest verdict (d6 boundary)**: this envelope is a
> *constraint-triangulated inference*, not SX500 itself. Without a
> measured oracle against the actual SpaceX alloy it stays
> `simulation-only-prediction` · `absorbed=false`. **But per d2 it is
> the breakthrough deliverable**: an *independently derived, open,
> functionally-equivalent* SX500-class composition envelope — the
> trade-secret wall is bypassed, not breached. Next step (a future
> session, pool/cloud compute permitting): run the §7 CALPHAD + DFT
> funnel on this envelope to produce a single optimised candidate +
> a verified ox-rich oxidation-rate prediction, filed as an
> `exports/material_discovery/` record.

### §9.5 Governance check

RE executed here = patent-database reading + public datasheet
compilation + thermodynamic reasoning. No closed-binary RE, no
trade-secret extraction, no license circumvention (D1 clean-room
satisfied). Output is an independently-derived open alloy envelope, R4
Pattern 1+2 preserved (`absorbed=false`; no impossibility framing — the
trade-secret wall was met with a concrete breakthrough path per d2).

## §9.6 §7 forward funnel — EXECUTED → single candidate (this session)

The §7 design funnel run on the §9.4 envelope. Honest tool note: a
rigorous 6-component CALPHAD needs Thermo-Calc TCNI (proprietary,
unavailable this session); what follows is the **analytically-tractable
funnel** — established *public* superalloy-design rules applied to
collapse the envelope to one candidate. `simulation-only-prediction`,
`absorbed=false`.

**Design rules applied (all public):**

1. **Alumina-former gate (Giggins-Pettit Ni-Cr-Al oxidation map, 1971).**
   For a continuous protective α-Al₂O₃ scale (oxidation map region III),
   with Cr ≈ 20 wt% (~22 at%) the Al threshold is ≈ 8-9 at%. Target
   **Al = 5.0 wt% (≈10.8 at%)** — solidly inside region III, the
   coating-free ox-rich requirement satisfied with margin.
2. **γ′ strengthening, printability-capped.** γ′ = Ni₃(Al,Ti) volume
   fraction set by Al+Ti. René N5 (~70 % γ′) is not printable; Haynes
   282 (~19 %) is weldable. Target a **moderate ~35-40 % γ′** —
   **Al 5.0 + Ti 1.5 wt%** — strong but inside the AM-processable window
   SpaceX is known to push.
3. **TCP-phase avoidance (PHACOMP / Nv electron-vacancy).** Mo, Cr, W
   drive embrittling σ/μ phases. Cap **Cr ≤ 20, Mo ≈ 3.5 wt%** — keeps
   the mean electron-vacancy number below the σ-phase line.
4. **Reactive-element effect.** **Hf 0.3 wt%** (René N5 uses 0.2) +
   trace **Y 0.05** — pegs the α-Al₂O₃ scale against thermal-cycling
   spallation.
5. **Co for γ′ solvus + SFE.** **Co 12 wt%** raises the γ′ solvus
   (high-T strength retention) and lowers stacking-fault energy.

**Candidate — `demiurge-SX500-RE-c1` (wt%):**

| Ni | Cr | Al | Co | Mo | Ti | Hf | Y | C | B |
|---|---|---|---|---|---|---|---|---|---|
| bal ~57.6 | 20.0 | 5.0 | 12.0 | 3.5 | 1.5 | 0.3 | 0.05 | 0.05 | 0.005 |

**Estimated properties (analytical, public correlations):**

- γ′ volume fraction ≈ **35-40 %** (Al+Ti = 6.5 wt% driver)
- oxidation: **α-Al₂O₃ parabolic regime**, k_p ~10⁻¹³–10⁻¹² g²·cm⁻⁴·s⁻¹
  at ~1100 °C — 2-3 orders of magnitude below a Cr₂O₃-former, and (key)
  **no CrO₃ volatilisation** in ox-rich service
- density ≈ **8.3 g·cm⁻³** (Ni-base typical)
- the "n=6" strengthener set is concrete: **Cr · Al · Co · Mo · Ti**
  (+ Ni base = 6 principal elements; Hf/Y/C/B are micro-additions)

> **Honest verdict.** `demiurge-SX500-RE-c1` is an *independently
> derived, open* SX500-class candidate — not SpaceX SX500. It is a
> single point inside the §9.4 envelope, selected by public design
> rules. `absorbed=false` · `simulation-only-prediction`. The next
> rigor step (future session, compute permitting): a real CALPHAD
> phase-equilibrium run (pycalphad + an open Ni-Cr-Al-Co TDB) and a
> DFT α-Al₂O₃/substrate adhesion-energy check, to confirm the γ′
> fraction and the scale-adhesion margin numerically. Record:
> `exports/material_discovery/sx500_mondaloy_candidate_c1_20260522.json`.

## §9.7 Wet-lab handoff prep — cockpit gate (this session, 2026-05-23)

The non-wet-lab pipeline's final cockpit-gate product: the packet a
melter / single-crystal grower / AM operator would consume to attempt a
c1 cast or print. Composition table + raw-material purity minima + two
synthesis protocol stubs (investment-cast polycrystalline + LPBF
additive) + characterisation protocol stubs + reproducibility
checklist. `provisional=true` · `absorbed=false` ·
`gate_type=simulation-only-prediction` — this is the *manifest*, not
the measurement.

### §9.7.1 c1 composition — handoff form

| element | wt% target | tolerance | at% (derived) | role |
|---|---|---|---|---|
| Ni | 57.595 | balance | 53.64 | γ + γ′ matrix base |
| Cr | 20.0 | ±0.5 | 21.02 | chromia underlayer + 3rd-element O getterer |
| Al | 5.0 | ±0.2 | **10.13** | **α-Al₂O₃ former (Giggins-Pettit region III, ≥ ~8-9 at% threshold at Cr ~22 at%)** |
| Co | 12.0 | ±0.5 | 11.13 | γ′ solvus ↑, SFE ↓ |
| Mo | 3.5 | ±0.3 | 1.99 | solid-solution strengthening (below σ-line) |
| Ti | 1.5 | ±0.2 | 1.71 | γ′ former (with Al) |
| Hf | 0.3 | ±0.05 | 0.09 | reactive element — α-Al₂O₃ scale adhesion |
| Y | 0.05 | ±0.02 | 0.03 | secondary reactive element |
| C | 0.05 | ±0.01 | 0.23 | grain-boundary carbide (castability) |
| B | 0.005 | ±0.002 | 0.03 | grain-boundary segregant (creep ductility) |

Impurity ceilings: **S ≤ 5 wppm · P ≤ 10 wppm · O ≤ 30 wppm** (S/O
poison the reactive-element effect — Reed 2006 ch.4).

### §9.7.2 Pipeline flow

```
  +--------------------------+
  | demiurge non-wet-lab     |
  | §9.6 → c1 (this packet)  |
  +-----------+--------------+
              |
              v
  +--------------------------+        +---------------------+
  | route A: investment-cast |   OR   | route B: LPBF AM    |
  | VIM melt → cast → SHT    |        | atomise → print →   |
  | + 2-step age → coupon    |        | HIP → SHT + age     |
  +-----------+--------------+        +----------+----------+
              |                                  |
              +----------------+-----------------+
                               v
              [WET-LAB BOUNDARY — d1 frontier]
                               v
  +--------------------------------------------------+
  | TGA oxidation @1100C · SEM γ′ vol-frac · thermal |
  | cycling · XRD/EBSD phase ID  → measured oracle    |
  +--------------------------+-----------------------+
                             v
              (only on ANALOG reference — d6:
               SX500 absorbed=false PERMANENT)
```

### §9.7.3 Reproducibility checklist (10-point)

The third-party-lab gate that must be cleared for any future
`measured-oracle PASS` on a c1-derived coupon to be credible. Full
checklist in
`exports/material_discovery/sx500_mondaloy_candidate_c1_wetlab_handoff_20260523.json`;
headline items:

1. ICP-OES chemistry-of-record within wt%-tolerance band (all 10
   elements + S/P/O impurities)
2. Heat-treatment time-temperature trace archived (csv)
3. ≥6 coupons per condition (statistics)
4. TGA: sapphire-blank calibration + atmosphere flow/dew-point logged
5. All raw data + scripts on Zenodo/OSF tagged
   `candidate_id="demiurge-SX500-RE-c1"`
6. Independent re-melt by a second lab before any "verified" claim
7. If route B hot-cracks → re-run §9.6 with lower (Al+Ti) loading
   → candidate **c2** (d2 breakthrough on the printability wall)
8. Any `absorbed=true` flip permitted only on the **analog reference**
   (Haynes-214 / René-N5 class), as a *separate* exports/ record
9. SX500 itself stays `absorbed=false` permanently in demiurge — c1 is
   the open functionally-equivalent candidate, not SX500 (d6 absolute)
10. Wet-lab partner candidates: Cambridge Rolls-Royce UTC · Ohio State
    CHTM · MPIE Düsseldorf · ORNL MDF (LPBF) · Haynes International

### §9.7.4 Honest verdict (d6 + d2)

This packet does not measure c1. It is the *cockpit gate-product* that
makes a future measurement possible. demiurge cannot commission a wet
lab — the packet is the open-source artefact a partner can pick up. If
no partner picks it up, demiurge can still drive the non-wet-lab side
further: pycalphad phase-equilibrium, DFT α-Al₂O₃ adhesion, ML creep
estimate (next non-wet-lab batch). If route B hot-cracks, c2 with
lower γ′ loading is the d2 breakthrough path on the printability wall
— surfaced *now*, before any cast is attempted.

> **d6 absolute**: even a fully-successful c1 cast + measured k_p in
> line with §9.6 prediction lets `absorbed=true` flip *only* on that
> analog measurement record. **SX500's `absorbed` stays `false`
> permanently in demiurge** — no measured oracle against the actual
> SpaceX alloy is accessible, and c1 is independently-derived open
> alloy, not SX500.

Record: `exports/material_discovery/sx500_mondaloy_candidate_c1_wetlab_handoff_20260523.json`.

## §10. Cross-references

- `hexa-space/mondaloy/mondaloy.md` — upstream n=6 structural-pattern
  draft (2026-05-07) + `verify_mondaloy.hexa` count-lattice script
- `hexa-space/falcon/falcon.md` — Merlin engine (non-MondAloy variant)
- `hexa-space/spaceship/spaceship.md` — Raptor 3 combustion path
- `RTSC.md` — sibling materials-discovery doc (the d6/d7 governance
  pattern this doc reuses)
- `NUCLEAR.md` — sibling elemental-discovery doc
- `project.tape` d1 (drive non-wet-lab verification to done) · d2
  (wall → breakthrough paths) · d6 (absorbed ⇔ measured oracle) ·
  d7 (report only converged values, no forced target)

---

Historical log entries are in [`./MONDALOY.log.md`](./MONDALOY.log.md).
