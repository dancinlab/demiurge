# LIMIT_BREAKTHROUGH.md — hexa-aura

> Real-limits audit (Wave M) per `LATTICE_POLICY.md §1.2`.
> Domain: **post-aural cortical interface chip + form-factor substrate**
> — mastoid-clip pair carrying RT-SC nano-coils that read/write A1, V1,
> S1, M1 cortex non-invasively. Real ceilings are RT-superconductor
> physics, cortical safety (SAR, thermal, FAR), magnetic-induction
> spatial resolution, MRI compatibility, and FDA medical-device pathway.

---

## §1 Domain identification

`hexa-aura` v1.0.0 is a 4-pillar chip + form-factor substrate spec:

- **clip** (HEXA-MASTOID-CLIP) — temporal-bone / mastoid attachment.
- **coil** (HEXA-RT-SC-NANOCOIL) — σ²=144 ch/tile, J₂=24 ch/macro,
  n^τ=6⁴=1296-ch hex.
- **cortex** (HEXA-CORTICAL-IF) — σ=12 zones × φ=2 dir × τ=4 modes,
  "18→0" wearable-collapse claim.
- **safety** (HEXA-CORTICAL-SAFETY) — Shannon k ≤ 1.5, SAR ≤ 2 W/kg,
  ΔT ≤ 0.5 K, watchdog FAR ≤ 1 %, MRI-conditional, no-craniotomy.

The repo's central claim is that an RT-SC nano-coil clip pair can
*non-invasively* read and write cortical signal at sufficient
fidelity to subsume 18 wearables (AirPods, Vision Pro, Watch,
exoskeleton, e-skin, etc.). Real-limit ceilings below test whether
that claim is engineering-improvable, biophysics-forbidden, or
regulatory-bottlenecked.

---

## §2 Real limits applicable

### L1 — Magnetic-field penetration through skull / scalp (HARD_WALL — physics)
- **Bound**: TMS coils require ~ 1.5–2 T at coil face to reach
  motor cortex (depth ~ 2 cm); falls off with cube of distance.
  Spatial resolution of figure-8 coil ~ 1.5–2 cm at cortex
  (Deng et al., *Brain Stimul.* 2013).
- **Anchor**: Biot-Savart law + tissue magnetic permeability.
  No engineering trick beats the spatial spread at fixed depth;
  multi-coil arrays only reshape distribution.
- **Repo touch**: `coil` pillar — RT-SC nano-coil claim must
  respect this.

### L2 — RT-superconductor maturity (BREAKABLE_WITH_TECH but speculative)
- **Bound**: As of 2026, room-temperature superconductors at
  ambient pressure remain *not reproducibly demonstrated*. The
  2023 LK-99 (Lee, Kim, Kwon) claim did not replicate; high-
  pressure hydrides (H₃S, LaH₁₀, CSH at ~ 250 K) require
  hundreds of GPa (Snider et al., *Nature* 2020, retracted 2022).
- **Anchor**: BCS / unconventional superconductivity physics. No
  RT-SC at ambient pressure verified.
- **Repo touch**: `coil` pillar — RT-SC core assumption is
  speculative. Must be preregistered as such.

### L3 — SAR limit (specific absorption rate) (HARD safety wall)
- **Bound**: IEEE C95.1-2019 / FDA: 2 W/kg averaged over any 10 g
  tissue for general public; 1.6 W/kg US head/torso (FCC 96-326).
- **Anchor**: tissue heating threshold. Repo's spec already cites
  ≤ 2 W/kg correctly.
- **Repo touch**: `safety` pillar.

### L4 — Tissue thermal ΔT — Pennes bioheat (HARD safety wall)
- **Bound**: brain temperature increase ΔT ≤ 0.5–1.0 K
  considered safe for chronic implant; > 2 K causes
  thermo-mechanical damage (Wells et al., *Lasers Surg. Med.*
  2007).
- **Anchor**: Pennes bioheat equation; perfusion-limited.
- **Repo touch**: `safety` pillar (spec correctly ≤ 0.5 K).

### L5 — Magnetic induction spatial selectivity (HARD physics)
- **Bound**: any non-invasive electromagnetic actuator at cortical
  depth has spatial resolution ≥ 5–10 mm (TMS, TES, TFUS); only
  invasive electrodes hit < 100 µm.
- **Anchor**: dipole spread in conductive medium. σ²=144 ch/tile
  cannot beat this without phased-array beamforming, which has
  its own constructive-interference floor (~ 2–3 mm with focused
  ultrasound; Tufail et al., *Nat. Protoc.* 2011).
- **Repo touch**: `coil` σ²=144 channel claim.

### L6 — Cortical write fidelity — non-invasive (UNCLEAR → BREAKABLE_WITH_TECH)
- **Bound**: TMS writes "pulse" not "percept"; phosphenes from V1
  TMS are crude. TFUS demonstrated focal stimulation but
  behavioural specificity remains low (Legon et al., *Nat.
  Neurosci.* 2014). Sensory-cortex *writing* of structured
  percepts requires intracortical micro-stimulation or optogenetic
  channelrhodopsin (Flesher et al., *Sci. Transl. Med.* 2016 for
  somatosensory ICMS).
- **Anchor**: targeting precision + dosing repeatability. Non-
  invasive structured-percept write is largely unsolved.
- **Repo touch**: `cortex` pillar — "write percept at cortex,
  skip the eye / ear / skin" is the core claim and is biophysics-
  uncertain.

### L7 — Auditory-cortex (A1) read SNR vs. cochlear processor (HARD per-substrate)
- **Bound**: scalp-MEG A1 N100 amplitude ~ 10–30 fT, ~ 100 ms
  latency (Hari & Lounasmaa, *Trends Neurosci.* 1989).
  Cochlear-implant electrode → A1 decode latency ~ 30 ms,
  word-recognition score 60–80 % in quiet (Wilson & Dorman,
  *Hear. Res.* 2008).
- **Anchor**: scalp SQUID sensitivity floor + cortical signal
  source depth.
- **Repo touch**: `cortex` A1 zone read claim; AirPods replacement
  claim requires beating cochlear-implant baseline non-invasively.

### L8 — MRI-conditional device safety (HARD regulatory)
- **Bound**: ASTM F2503 / FDA guidance; conductive implants
  generate RF heating during MR scan; ferromagnetic implants
  experience translational force > 100 N at 3 T.
- **Anchor**: Maxwell's equations + material magnetic susceptibility.
- **Repo touch**: `safety` pillar (correctly declares MRI-
  conditional).

### L9 — FDA medical-device pathway (SOFT_WALL but slow)
- **Bound**: De Novo / PMA pathway typically 3–7 yr post-IDE; BCI
  examples — BrainGate IDE since 2004, no PMA yet; Synchron
  Stentrode IDE 2021, PMA pending; Neuralink IDE 2023.
- **Anchor**: regulatory engineering. Improvable via predicate-
  device 510(k) for non-invasive variant.
- **Repo touch**: any clinical-claim variant of `cortex`.

### L10 — Battery / power budget — 7.2 g BTE form factor (HARD engineering)
- **Bound**: AirPods Pro 2 weighs 5.4 g, 0.5 Wh capacity, ~ 6 hr
  active. RT-SC coil drive current requires cryogenic cooling
  (~ 4–80 K for known superconductors), incompatible with 7.2 g
  passive clip thermal budget.
- **Anchor**: Stefan-Boltzmann radiative + convective dissipation
  from 7.2 g object at room temperature. Even at 1 mW dissipation,
  ΔT ≥ a few K vs. body.
- **Repo touch**: `clip` 7.2 g claim is physically borderline
  even *with* an RT-SC; without it, requires cryocooler (impossible).

---

## §3 Per-limit breakthrough assessment

| ID | Limit | Wall type | Pillar | Breakthrough vector | Verdict |
|----|-------|-----------|--------|---------------------|---------|
| L1 | TMS depth/spread tradeoff | HARD physics | coil | Multi-coil reshape only | unbreakable for non-invasive |
| L2 | RT-SC ambient pressure | UNCLEAR/BREAKABLE | coil | LK-99-class? Not replicated as of 2026 | **speculative core** |
| L3 | SAR ≤ 2 W/kg | HARD safety | safety | Spec already correctly bounded | hard floor |
| L4 | ΔT ≤ 0.5 K cortex | HARD safety | safety | Spec correct | hard floor |
| L5 | Non-invasive 5–10 mm res | HARD physics | coil, cortex | TFUS to ~ 2–3 mm; cannot match µm invasive | physical ceiling |
| L6 | Non-invasive structured-percept write | UNCLEAR | cortex | Unsolved as of 2026 | **research-grade** |
| L7 | A1 read non-invasive vs. CI | HARD substrate | cortex | MEG-class sensitivity, but Wave M dependent | substrate ceiling |
| L8 | MRI-conditional | HARD regulatory | safety | ASTM F2503 compliance | engineering-met |
| L9 | FDA De Novo / PMA 3–7 yr | SOFT | clinical layer | Non-invasive 510(k) path possible | improvable timeline |
| L10 | 7.2 g BTE thermal budget | HARD engineering | clip | Needs RT-SC ambient or fail | gated by L2 |

---

## §4 Top-3 breakthrough opportunities

### #1 — Honest preregistration of RT-SC dependency (rides L2, L10)
The single most important deliverable is to **explicitly preregister**
that the entire form-factor claim depends on RT-SC at ambient
pressure becoming reproducible. As of 2026 this is unverified.
Falsifier F-AURA-2 (coil pillar) must state: "If, by date X, no
RT-SC ambient-pressure material is independently replicated, the
hexa-aura form-factor claim is falsified — fall back to active-
cooled or normal-conductor variants (with corresponding mass +
power budget recalculation)." This is the breakthrough — not
"we have RT-SC," but "we have an honest spec that names the
contingency."

### #2 — TFUS-class non-invasive write at 2–3 mm precision (rides L5, L6)
Transcranial focused ultrasound (Tufail 2011, Legon 2014, Verhagen
et al., *eLife* 2019) is the *currently feasible* non-invasive
neuromodulation modality. It hits 2–3 mm focal volume at cortical
depth with safe SAR + ΔT margins. Realistic spec-level
breakthrough: redefine `cortex` pillar's σ²=144 channels as
*addressable TFUS focal points* (not magnetic-induction zones)
with the achievable resolution declared. This is biophysics-
respecting.

### #3 — 510(k) non-invasive predicate-device path (rides L9)
For a non-invasive variant of hexa-aura (no implant, only
external clip), the FDA path is 510(k) via predicate device (e.g.,
cleared TMS, tDCS, TFUS systems). This is months, not years.
Hexa-aura spec should declare which predicate it claims
equivalence to before any clinical claim. Cortical-write claims
require De Novo or PMA — declare separately and slip date by
3–7 yr accordingly.

---

## §5 Honest caveats

1. **RT-SC at ambient pressure is not verified as of 2026.** LK-99
   did not replicate. Without RT-SC the 7.2 g clip thermal budget
   fails. This is the central honesty disclosure.
2. **Non-invasive cortical *write* of structured percepts is
   unsolved.** TMS and TFUS demonstrate stimulation, not
   structured-percept synthesis. Replacing AirPods (sound at A1),
   Vision Pro (image at V1–V6), or e-skin (touch at S1) requires
   write-fidelity not yet demonstrated.
3. **σ²=144 channels/tile is geometry, not spatial resolution.**
   Even if the chip *fabricates* 144 coils per tile, the physical
   spread of magnetic induction at cortical depth bounds
   independent channels to ~ (cortex area / 25 mm²). The repo's
   J₂=24 ch/macro and 1296-ch hex are *coil counts*, not
   independent-percept counts. The README is honest about being
   a "substrate" spec; the audit confirms this matters.
4. **MRI-conditional ≠ MRI-safe.** Conductive coils heat in RF
   field; spec must declare per-coil thermal budget at 1.5 T
   and 3 T.
5. **The σ(6)·φ(6) = n·τ(6) = J₂ = 24 lattice is organising
   vocabulary** — it does not derive the physics. Cortical zone
   count is anatomy (Brodmann areas etc.), not number theory.
6. **No-craniotomy** is a hard safety constraint correctly
   declared; the trade-off is that L5 (non-invasive ~ 5–10 mm
   resolution) cannot match invasive µm electrodes. Pick one.
7. **18→0 wearables collapse is the marketing claim;** the
   physics gates each wearable's replacement separately.
   AirPods replacement (A1 read+write) is closer to feasible
   than e-skin replacement (S1 dense write).
8. **HARD walls L1, L3, L4, L5, L8, L10** are physics / safety
   / regulatory. **L2, L6** are UNCLEAR (research frontier);
   L9 is SOFT (regulatory engineering). Spec must declare which
   walls each falsifier (F-AURA-1..15) rides.

---

## §6 References

- Deng ZD, Lisanby SH, Peterchev AV. Electric field depth-focality
  tradeoff in transcranial magnetic stimulation. *Brain Stimul.*
  6:1–13 (2013).
- Snider E et al. Room-temperature superconductivity in a
  carbonaceous sulfur hydride. *Nature* 586:373–7 (2020).
  **Retracted 2022**.
- IEEE C95.1-2019. IEEE Standard for Safety Levels with Respect to
  Human Exposure to Electric, Magnetic, and Electromagnetic Fields,
  0 Hz to 300 GHz.
- Wells J et al. Optical stimulation of neural tissue in vivo.
  *Opt. Lett.* 30:504–6 (2005); Wells J et al. *Lasers Surg.
  Med.* 39:513–26 (2007).
- Tufail Y et al. Ultrasonic neuromodulation by brain stimulation
  with transcranial ultrasound. *Nat. Protoc.* 6:1453–70 (2011).
- Legon W et al. Transcranial focused ultrasound modulates the
  activity of primary somatosensory cortex in humans. *Nat.
  Neurosci.* 17:322–9 (2014).
- Verhagen L et al. Offline impact of transcranial focused
  ultrasound on cortical activation in primates. *eLife*
  8:e40541 (2019).
- Flesher SN et al. Intracortical microstimulation of human
  somatosensory cortex. *Sci. Transl. Med.* 8:361ra141 (2016).
- Hari R, Lounasmaa OV. Recording and interpretation of cerebral
  magnetic fields. *Science* 244:432–6 (1989).
- Wilson BS, Dorman MF. Cochlear implants: a remarkable past and
  brilliant future. *Hear. Res.* 242:3–21 (2008).
- ASTM F2503-23. Standard Practice for Marking Medical Devices
  and Other Items for Safety in the Magnetic Resonance
  Environment.
- FCC 96-326. Guidelines for Evaluating the Environmental Effects
  of Radiofrequency Radiation (1996).
- Lee S, Kim JH, Kwon YW. The First Room-Temperature Ambient-
  Pressure Superconductor. arXiv:2307.12008 (2023). **Not
  reproduced.**

---

*Wave M — real-limits audit; n=6 lattice is geometric vocabulary
only (coil tile count), not biophysical evidence about cortex.
HARD walls L1, L3, L4, L5, L8, L10 are physics/safety;
L2 (RT-SC ambient) is UNCLEAR and is the central honesty caveat;
L6 (non-invasive structured-percept write) is UNCLEAR; L9 is SOFT.*
