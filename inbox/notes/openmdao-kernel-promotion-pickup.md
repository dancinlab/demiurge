# OpenMDAO kernel-promotion pickup — 2026-05-20

> D72 classify-FIRST trigger note. **space+synthesize** has now landed
> as the FIRST consumer of OpenMDAO (substrate at
> `~/core/hexa-lang/stdlib/space/openmdao_mission.py`, demiurge consumer
> `cockpit/Sources/DemiurgeCore/Loaders/SpaceSynthProducer.swift`).
> When **scope+synthesize** lands as the 2nd consumer, OpenMDAO becomes
> a kernel-promotion candidate per D72 (2 consumers = promotion
> candidate).

## Why this note exists

D72 says: classify FIRST — OpenMDAO is generic MDO (domain-independent).
Two follow-on cells in the empty-cells research want OpenMDAO:

- **space + synthesize** — landed this round (ROI rank 8 ⭐⭐⭐⭐, NASA
  GSC-17177-1). substrate: `stdlib/space/openmdao_mission.py`
  (Tsiolkovsky rocket-equation rollup, ΔV-vs-payload trade).
- **scope + synthesize** — ROI rank 4 ⭐⭐⭐⭐⭐ (POPPY/synphot couple
  via OpenMDAO; coupled optics+structure opt per inbox §3 scope block).
  NOT yet landed.

At 1 consumer, OpenMDAO stays in `stdlib/space/` as a domain-local
adapter (D72 — "if not already promoted, keep in domain adapter").
At 2 consumers (when scope+synthesize lands), promote to a generic
kernel.

## Promotion target

```
~/core/hexa-lang/stdlib/kernels/mdo/
  ├── openmdao_mission_base.py        # shared base — Problem + driver
  │                                     setup, version pinning, summary
  │                                     line emission protocol
  └── README.ai.md                    # kernel contract: input dict →
                                       NDJSON sample sweep + meta.json
                                       + OPENMDAO_MISSION_RESULT line
```

Then `stdlib/space/openmdao_mission.py` becomes a thin caller
(domain-specific: Tsiolkovsky model + wet-mass sweep), and the new
`stdlib/scope/openmdao_optics.py` becomes the parallel thin caller
(domain-specific: aperture/segment-tilt design vars + Strehl objective).

## Promotion checklist (when 2nd consumer lands)

1. `mkdir ~/core/hexa-lang/stdlib/kernels/mdo/`
2. Extract from `stdlib/space/openmdao_mission.py`:
   - `openmdao_versions()` → kernel
   - `model_input_hash()` → kernel (generalise: takes any dict)
   - The "build Problem, attach ExecComps, attach driver, set bounds,
     run_driver, harvest result" scaffold → kernel base class
   - The OPENMDAO_MISSION_RESULT summary-line protocol → kernel
3. Update `stdlib/space/openmdao_mission.py` to call the kernel
   (model spec + sample iterator stay domain-local).
4. Wire the new `stdlib/scope/openmdao_optics.py` against the kernel.
5. Update D72 § in design.md noting OpenMDAO promotion landed.
6. Both Swift consumers (`SpaceSynthProducer.swift` +
   `ScopeSynthProducer.swift`) keep their existing typed-record
   discipline — only the substrate is consolidated, not the Swift
   wrappers (Swift consumers can stay domain-specific since they
   parse domain-specific meta.json).

## Honesty note (g3)

Promotion is a refactor, NOT an absorption claim. Even after
promotion, `absorbed=false` stays — OpenMDAO is still an EXTERNAL
Python library. The promotion just deduplicates the Python-side
scaffolding across the two consumers.

GMAT coupling (the "real" mission-design absorption path) is ROI
rank 15 (binary download) and is deliberately deferred. closedMeasured
on either space+synthesize OR scope+synthesize requires that GMAT
parity (or equivalent flight-validated reference), not a kernel
promotion.

## Owner

Pickup agent: whoever picks up `scope + synthesize` (ROI rank 4
⭐⭐⭐⭐⭐ — pure pip, smallest install cost remaining in the empty-
cells research note).
