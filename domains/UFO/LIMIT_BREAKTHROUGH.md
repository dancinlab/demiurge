<!-- @created: 2026-05-12 -->
<!-- @wave: M (limit-breakthrough audit) -->
<!-- @scope: observational + epistemic + statistical limits bounding UAP evidence quality -->
<!-- @policy: LATTICE_POLICY.md §1.2 — n=6 격자 anchors NOT used here -->
<!-- @epistemics: NO claim about origin / authenticity is made. This audit -->
<!-- @epistemics: bounds *evidence quality*, not the existence of the phenomenon. -->
---
type: limit-breakthrough-audit
wave: M
session: 2026-05-12
domain: UAP-observational-evidence-quality
verbs: 10 (UFO substrate atlas + 7-stage propulsion concepts — DOC/SPECULATIVE)
policy_ref: LATTICE_POLICY.md §1.2
epistemic_warning: "This audit makes NO claim about UAP origin. It bounds observational, statistical, and epistemic limits on the evidence collected to date and the limits any future evidence stack would face. Speculative propulsion-stack verbs are SPECULATIVE-tagged in the repo and not audited as physical realizations here."
---

# LIMIT_BREAKTHROUGH.md — hexa-ufo real-limits audit (evidence-quality bounds only)

> **Epistemic note (read first):** This document does **not** claim that UAP
> are or are not extraterrestrial / engineered / explainable. It bounds the
> *evidence quality* the field can in principle achieve given current sensor
> physics and Bayesian-update mathematics. Treat it as an observational-
> capability audit, not an ontological one.

---

## §1 Domain

UAP (Unidentified Aerial / Anomalous Phenomena) observational substrate.
Data sources span: military FLIR / IR camera systems, civilian smartphone
imagery, radar (primary + secondary surveillance), pilot eyewitness, FAA
ADS-B + ground radar fusion, sometimes hyperspectral or LIDAR. The repo
also catalogs *speculative* propulsion concepts (Alcubierre, Morris-Thorne,
KK ladder, etc.) tagged DOC / SPECULATIVE / UNPROVEN — these are not
audited here as physical realizations; only observational evidence
ceilings are.

---

## §2 Real limits

### §2.1 Sensor-physics limits (HARD)

| Sensor | Resolution limit | Notes |
|---|---|---|
| FLIR/IR (military, e.g. ATFLIR Navy footage) | angular: ~mrad-class @ 3–5 µm wavelength, classified specifics | Diffraction-limited; thermal contrast saturates at hot/cold targets |
| Civilian smartphone | ~1 arcmin / pixel @ standard lens; rolling shutter artifacts | Rolling-shutter creates apparent shape distortion of fast objects (a known source of UAP false positives) |
| Primary radar (skin-track) | range-resolved to ~tens of meters; cross-section ambiguity (small-RCS object indistinguishable from balloon-vs-drone) | RCS does not give size; only echo strength |
| Secondary radar / ADS-B | transponder-only — silent targets invisible | Selection-biased dataset |
| Pilot Mark-1 eyeball | poor angular size estimate without reference; speed estimate ≥ 30% error typical | Cited in NTSB studies |
| FAA ground radar fusion | ~1 km lateral accuracy commercial; sub-100 m military | Not designed for sub-100-m-class targets |

### §2.2 Parallax / range ambiguity (HARD)

A single sensor cannot determine target range. Reported velocity and size
estimates from single sources have *unbounded* uncertainty before fusion.
Multi-sensor fusion (e.g. radar + IR + visual baseline) collapses
uncertainty, but most published UAP cases are **single-sensor** or
**uncorrelated-multi-sensor** (recorded but not synchronized to ms-class
timing).

### §2.3 Sensor artifacts that mimic anomalies (well-catalogued)

- **Lens flare / internal reflection** — produces seemingly fast-moving "objects" tracking with camera pan.
- **Rolling-shutter distortion** — high-speed objects appear elongated / skewed; mimics "morphing".
- **Parallax with distant background** — a near object against a far background can produce apparent "instant acceleration" if reference frame is misidentified.
- **Radar ducting / atmospheric anomaly** — temperature inversions create false long-range returns.
- **Balloon / weather phenomenon / drone / starlink-train / venus / chinese lantern** — Condon (1968), Sturrock (1999), Nimitz USS Princeton 2004 follow-up analyses all show non-trivial fraction of cases resolve to mundane after sensor analysis.

### §2.4 Bayesian-update limits (Sagan / "extraordinary claims") (HARD-ish — math)

Bayes: P(H|E) = P(E|H)·P(H) / P(E).

If prior on hypothesis H₁ ("non-prosaic engineered object") is very low
(e.g. 10⁻⁹ per case before any evidence), and likelihood ratio
P(E|H₁) / P(E|H₀) for typical UAP evidence stack is modest (~10² to 10⁴
based on argued case-by-case sensor analysis), posterior remains very low
without overwhelming evidence. **The wall is not "evidence doesn't exist"
but "current evidence likelihood-ratio is not large enough vs prior."**

This is the formal version of Sagan's "extraordinary claims require
extraordinary evidence" — it is mathematics, not editorial opinion.

### §2.5 Statistical-power limits (HARD)

To distinguish a real rare-event distribution from a noise distribution
requires sample size N scaling as ~1/effect-size². For a 1% anomaly rate
in radar returns with 99% confidence detection, N > ~10⁴–10⁵ classified
cases minimum. AARO + DoD reports cite ~500–800 cases total reviewed —
**under-powered** for rigorous tail-distribution analysis.

### §2.6 Selection / reporting biases (SOFT but persistent)

- Military / pilot reports over-weighted in evidence stack (highest-quality sensors but selection-biased domain).
- Camera-equipped observer at moment of event: very rare (Poisson-thin per area-time-of-sky).
- Reporting incentive: career penalty for "false positive" report (military), social cost (civilian) — **both directions biased toward under-reporting**.

### §2.7 Speculative-propulsion claims (NOT audited — out of scope)

Alcubierre warp, Morris-Thorne wormhole, Kaluza-Klein dim-jump, antigravity
require exotic matter with negative energy density, super-Planckian
field configurations, or extra-dimensional structures not observed at
LHC or in cosmological data. The repo correctly tags these as
**SPECULATIVE** / **UNPROVEN**. This audit does not evaluate whether
they could explain UAP — it only notes that *no observational evidence
currently distinguishes such propulsion from prosaic explanations at
sufficient likelihood-ratio*.

---

## §3 Assessment

| Wall | Movable? | How |
|---|---|---|
| Single-sensor range ambiguity | YES (engineering) — multi-sensor fusion with timing sync | Cost: dedicated multi-modal arrays at suspect-hotspot sites |
| Rolling-shutter / lens-flare artifact | YES (engineering) — global-shutter sensors + lens-design audit per case | Cost: cheap; rarely applied retrospectively |
| Statistical under-power (~500 cases) | YES (data-collection) — order-of-magnitude more samples needed | Cost: institutional + cultural |
| Sensor diffraction limit | NO (HARD) | Per hexa-scope §2.1 — same physics applies |
| Bayesian likelihood-ratio for extraordinary prior | NO (HARD math) | Evidence quality must increase by orders of magnitude to overcome low prior; this is the *correct* response, not a fixable wall |
| Reporting / selection bias | PARTIAL | Anonymous structured-reporting channels (AARO since 2022) reduce but do not eliminate |

---

## §4 Top-3 highest-impact unmovable walls (evidence-quality only)

1. **Single-sensor range ambiguity** (operational) — most pre-2023
   famous cases (Nimitz 2004, GIMBAL 2015, GOFAST 2015) are
   single-sensor and therefore have wide-band uncertainty on speed,
   size, and trajectory. Multi-sensor fusion is the only way past this,
   and the institutional + budgetary cost is high.
2. **Bayesian posterior ceiling given current evidence likelihood-
   ratios** (mathematical) — for any extraordinary-prior hypothesis,
   the likelihood-ratio of the typical UAP evidence stack is modest
   relative to the prior. This is **not** a critique of UAP-reality;
   it is a statement that *current* evidence cannot move the posterior
   far either way.
3. **Statistical under-power at ~500–800 cases** (data-volume) — tail-
   distribution analysis of rare events requires 10⁴+ structured
   reports with sensor-grade telemetry. Until that population exists,
   any claim about per-event base rate (e.g. "X% are unexplained
   after analysis") has wide confidence intervals.

---

## §5 Caveats

- **No origin claim.** This audit makes zero claim that UAP are or are
  not engineered, extraterrestrial, or prosaic. It bounds *evidence
  quality*, period.
- **Speculative-propulsion verbs are out of scope.** The repo's
  Alcubierre / Morris-Thorne / KK-ladder verbs are SPECULATIVE and not
  audited as physical realizations here. Their feasibility under
  general relativity + standard model requires exotic matter not yet
  observed.
- **No n=6 lattice anchors used** (per LATTICE_POLICY §1.2). The
  repo's "alien_index" chain (🛸6 → 🛸ABSOLUTE = 𝔚) is an internal
  organizing fiction; it does not bound UAP physics or evidence
  statistics.
- **Bayesian framing is mathematics, not advocacy.** It works equally
  well to update toward or away from any hypothesis given suitable
  evidence likelihood ratios.
- **Falsifier register inside the repo is the right form.** 13 OPEN
  falsifiers in `.roadmap.hexa_ufo` are the correct response to
  speculative claims — pre-register, do not retro-fit.

---

## §6 References

- Condon, E.U. (1968). *Scientific Study of Unidentified Flying Objects.* University of Colorado / Air Force.
- Sturrock, P. (1999). *The UFO Enigma: A New Review of the Physical Evidence.* Warner.
- AARO (All-domain Anomaly Resolution Office), *Historical Record Report Vol. I & II* (2023, 2024) — current DoD UAP review.
- Galileo Project (Loeb et al., Harvard, 2021–) — structured multi-sensor data collection initiative.
- Sagan, C. (1979). *Broca's Brain*, on extraordinary claims.
- Jaynes, E.T. (2003). *Probability Theory: The Logic of Science* — Bayesian update mathematics, Ch. 4.
- Alcubierre, M. (1994). *The warp drive: hyper-fast travel within general relativity.* Class. Quantum Grav. (cited for context; theoretical exotic-matter requirement noted).
- Morris, M.S., Thorne, K.S. (1988). *Wormholes in spacetime and their use for interstellar travel.* Am. J. Phys.

---

*End of LIMIT_BREAKTHROUGH.md (hexa-ufo, Wave M). Epistemic stance: bounded analysis, no ontological claim.*
