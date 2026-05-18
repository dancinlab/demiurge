# domains/ — per-domain shallow public-surface maps

> Cohorts 1+2 (named, `design.md` Decisions 3 and 6): chip is the **deep**
> domain (mapped in `HANDOFF.md` §5 + `proposals/rfc_001_*`); these 13
> are **shallow** public-surface maps — breadth over depth. **Plus a
> 14th, `component.md`** — added later by `design.md` Decision 21 as the
> meta-conductor chain's 3rd-pass domain (rfc_008 seam), **not** part of
> the original 13-domain Agent-3/4 breadth survey (distinct provenance:
> cited research this session — see its own §5). The "13-domain"
> synthesis figures below (e.g. 8/13) are the *historical survey* and
> are deliberately left un-recounted (g3 — `component` was not in it).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · `design.md` Decision 5). Source:
> Agent-3 (Cohort 1) + Agent-4 (Cohort 2), cited per file.

## Files — Cohort 1 (`design.md` Decision 3)

- [`cern.md`](cern.md) — particle accelerator (CERN-class)
- [`antimatter.md`](antimatter.md) — antiproton / positron trap + PET cyclotron
- [`rtsc.md`](rtsc.md) — high-field / superconducting magnet & coil
- [`space.md`](space.md) — spacecraft / launch / mission (NASA-class)
- [`energy.md`](energy.md) — battery / nuclear / grid / fuel-cell
- [`brain.md`](brain.md) — implantable neural interface (Neuralink-class)

## Files — Cohort 2 (`design.md` Decision 6)

- [`fusion.md`](fusion.md) — D-T / p-11B fusion reactor / powerplant
- [`scope.md`](scope.md) — segmented-mirror space telescope (JWST-class)
- [`sscb.md`](sscb.md) — solid-state DC circuit breaker (HEXA-SSCB mk1)
- [`mobility.md`](mobility.md) — Stage-5 autonomous-driving vehicle platform
- [`bot.md`](bot.md) — robot platform (URDF + control stack)
- [`grid.md`](grid.md) — datacenter / network fabric
- [`aura.md`](aura.md) — post-aural wearable BCI (non-implantable)

## Files — chain-stage domain (`design.md` Decision 21)

- [`component.md`](component.md) — part / package / system design
  (FEM/EM/thermal/SI-PI). The meta-conductor chain's 3rd 7-verb pass,
  fed by the `chip→component` typed seam (rfc_008). Provenance: cited
  public-surface web research (this session), parity with the
  Agent-cited maps — **not** part of the original Cohort 1/2 breadth
  survey above.

## Cross-domain synthesis (Agent-3 output, condensed)

1. **A recurring 5-stage tool-binding pattern holds across all 6 domains**
   (model → synthesize/size → layout → verify → simulate) — maps onto the
   7-verb spine as DESIGN, SYNTHESIZE+ANALYZE, SYNTHESIZE, VERIFY, ANALYZE
   respectively. The remaining 7-verb slots (SPECIFY, ARCHITECT, HANDOFF)
   are domain-specific processes without consistent OSS tooling.
2. **OSS is strongest at DESIGN / SYNTHESIZE-size** (MAD-X, GMAT, PyBaMM,
   OpenMC, FEMM, PyPSA — all credible open tools), and **weakest at
   high-fidelity 3-D multiphysics ANALYZE / VERIFY**, where proprietary
   tools (FLUKA, ANSYS / COMSOL, CST / OPERA, Sim4Life) dominate every
   domain.
3. **Two shared tool-classes appear in 5 of 6 domains**:
   **Monte-Carlo particle transport** (Geant4 / OpenMC / FLUKA) and
   **FEM EM/thermal** (FEMM / COMSOL / Maxwell). A single demiurge
   `transport` abstraction + `fem` abstraction would serve those 5 — a
   concrete lever for demiurge's "integration glue" niche (point 5).
4. **Proprietary gap by domain**: smallest in `space` (NASA's fully open
   GMAT / OpenMDAO / OpenVSP / Trick / Basilisk stack); largest in
   `brain` (regulatory-grade implant safety sim has no open equivalent);
   `cern` and `rtsc` sit in between (open 2-D / proprietary 3-D split).
5. **The consistent missing piece is integration glue** — every domain
   has strong point tools but weak open cross-stage / cross-domain
   coupling. **This is precisely demiurge's niche.**

## Cross-cohort synthesis update — Cohort 2 evidence (Agent-4)

When Cohort 2 landed, three things sharpened the picture beyond the
Cohort-1-only synthesis above. Preserved separately so the audit trail
shows what was true at each cohort close.

1. **`transport` + `fem` shared-abstraction lever strengthens: 5/6 → 8/13.**
   Cohort 2 adds three more major consumers of the MC-transport class
   (`fusion` adds OpenMC / Geant4 / FLUKA; `sscb` adds another power-
   electronics FEM via FEMMT / Sentaurus; `grid` adds high-frequency
   3-D EM via HFSS / Sigrity for SerDes channels). The single
   `transport` + `fem` abstraction now serves 8 of 13 surveyed domains
   (up from 5 of 6); the integration-glue lever is even stronger.

2. **`bot` is the all-open reference domain.** First domain in the
   13-domain survey where the open stack is reference-class at every
   verb (ROS 2 + Gazebo + MoveIt 2 + Drake + Pinocchio + OMPL +
   Crocoddyl + CasADi cover everything credibly). Proprietary advantage
   here is throughput (Isaac Sim photoreal-GPU) + regulatory
   qualification, **not capability**. Worth calling out explicitly as
   the "ceiling test" for what demiurge's integration glue can look
   like when the underlying tools have no proprietary gaps.

3. **New shared tool-class emerges: regulatory-verify proprietary
   lock-in.** Cohort 1 saw it once (`brain.md` Sim4Life MDDT). Cohort 2
   confirms it as a *pattern* in 3 more domains: `mobility` (ANSYS
   medini for ISO 26262 / 21448 work-products), `sscb` (UL 489I 1st-ed
   2025-10-22 accredited testhouses), `aura` (same Sim4Life MDDT,
   lower bar). This is the cleanest cross-domain proprietary gap — and
   unlike compute-fidelity gaps, **it cannot be closed by better
   algorithms; only by regulatory qualification campaigns**. Refines
   synthesis point 2 above to:
   *"OSS is strongest at DESIGN / ANALYZE / SYNTHESIZE-size; proprietary
   is strongest at high-fidelity 3-D multiphysics ANALYZE / VERIFY
   AND at regulatory-qualified VERIFY tooling."*
   The latter half is new Cohort-2 evidence.

## Flagged uncertainties (Cohort 1 — Agent-3)

- No single dominant open trap / non-neutral-plasma simulator confirmed
  for `antimatter` — most groups use custom codes.
- `KiCad` usage for neural probes is plausible / common but not directly
  evidenced in the retrieved sources for `brain`.
- `STK` named from general knowledge as the `space` proprietary
  counterpart, not from a retrieved source.

## Flagged uncertainties / corrections (Cohort 2 — Agent-4)

- **`fusion`**: SOLPS-ITER is restricted-distribution (ITER-member
  institutions only) despite a public GitHub repo — moved to the
  proprietary column with ⚠ flag. Fusion's plasma-edge "OSS" is not
  really OSS in the usable sense.
- **`scope`**: LSST / Roman dropped from the segmented-mirror
  architecture claim (LSST has 3-mirror anastigmat, not segmented;
  HabEx clarified as monolithic). JWST kept as the canonical n=6
  segmented reference.
- **`sscb`**: UL 489I 1st ed. is brand-new (2025-10-22) — first
  dedicated SSCB standard ever. HEXA-SSCB mk1 is designing into a
  standards landscape still solidifying. 4-foundry Korean stack
  identities not re-verified per-file.
- **`grid`**: OMNeT++ is non-commercial-academic license, not
  OSI-permissive — flag for downstream consumers.
- **`aura`**: Brian2 / NEST moved to an adjacency parenthesis (they're
  spiking-neuron simulators, not on-device EEG-DSP); MNE-Python is the
  actual EEG signal-processing tool.
