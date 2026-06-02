<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_POL -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2 -->
---
depth_dir: hexa-polymer
axis_group: GROUP_POL
verb_members:
  - epoxy
  - nylon
  - pet_film
  - microplastics
  - biodegradable-plastics
  - elastomer
  - adhesive
  - liquid-crystal
cross_link_members:
  - aramid (POL, lives in hexa-fiber/ for fiber form-factor)
  - tire_cord (POL, downstream)
  - mof (organic linkers; ZIF imidazolate)
  - 2d-materials (polymer hybrids)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-polymer — GROUP_POL depth directory

> **Aggregates the polymer group.** Member verbs span chain-growth and
> step-growth polymerization, amide / ester / epoxide / urea linkages, and
> the full T_g / T_m / σ_th engineering tradition. Root deep-expansion is
> `POLYMER-CHEMISTRY.md` (439 lines, largest deep-dive).

> **Honesty.** Frenkel σ_th = E/10 polymer cap ~30 GPa for ideal CNT yarn;
> aramid lab ~5 GPa; CNT theoretical ~150 GPa. Bio-isoprene + self-healing
> rubber + marine-biodegradable plastic claims UNVERIFIED at production
> (preserved verbatim from `elastomer/`, `biodegradable-plastics/`).
> Polymer-recycling ΔS_mix Gibbs floor is a HARD entropy wall per L12
> (`LIMIT_BREAKTHROUGH.md`).

---

## §1 Scope

GROUP_POL covers 9 dispatchable verbs (per `AXIS.md §0` post-Phase D):

| Layer | Verbs | Linkage class |
|-------|-------|---------------|
| Core POL (v1.0.0) | epoxy, nylon, pet_film, aramid, tire_cord, microplastics | amide / ester / epoxide / mixed |
| Phase D POL | elastomer, adhesive, biodegradable-plastics, liquid-crystal | mixed (urea / cyanoacrylate / PLA-ester / mesogen) |

Note: `aramid/` and `tire_cord/` live primarily in `hexa-fiber/` due to fiber
form-factor, but are POL by chemistry. They are cross-linked here.

## §2 Member verbs

POL verbs hosted here:
- **epoxy** → [`../epoxy/epoxy.md`](../epoxy/epoxy.md) — DGEBA/DETA, anhydride cure, prepreg
- **nylon** → [`../nylon/nylon.md`](../nylon/nylon.md) — nylon-6, nylon-6,6, nylon-12
- **pet_film** → [`../pet_film/pet_film.md`](../pet_film/pet_film.md) — biaxially oriented PET film
- **microplastics** → [`../microplastics/microplastics.md`](../microplastics/microplastics.md) — environmental fate, partition
- **biodegradable-plastics** (Phase D) → [`../biodegradable-plastics/biodegradable-plastics.md`](../biodegradable-plastics/biodegradable-plastics.md) — PLA, PHA, PBS, starch blends
- **elastomer** (Phase D) → [`../elastomer/elastomer.md`](../elastomer/elastomer.md) — NR, SBR, EPDM, silicone, PU, fluoroelastomer
- **adhesive** (Phase D) → [`../adhesive/adhesive.md`](../adhesive/adhesive.md) — PSA, structural, CA, anaerobic, hot-melt
- **liquid-crystal** (Phase D) → [`../liquid-crystal/liquid-crystal.md`](../liquid-crystal/liquid-crystal.md) — thermotropic + lyotropic

Cross-linked from other groups:
- **aramid** → [`../aramid/aramid.md`](../aramid/aramid.md) — fiber form-factor (FIB) + amide chemistry (POL)
- **tire_cord** → [`../tire_cord/tire_cord.md`](../tire_cord/tire_cord.md) — nylon-66 / polyester / aramid downstream
- **mof** → [`../mof/mof.md`](../mof/mof.md) — coordination polymer (CER + POL bridge)

## §3 Cross-links to root deep-expansion docs

- [`../POLYMER-CHEMISTRY.md`](../POLYMER-CHEMISTRY.md) — root deep-dive (439 lines)
- [`../EPOXY.md`](../EPOXY.md) — epoxy chemistry stub
- [`../NYLON.md`](../NYLON.md) — nylon stub
- [`../PET-FILM.md`](../PET-FILM.md) — PET film stub
- [`../ARAMID.md`](../ARAMID.md) — aramid stub
- [`../ELASTOMER.md`](../ELASTOMER.md) — elastomer Phase D stub
- [`../ADHESIVE.md`](../ADHESIVE.md) — adhesive Phase D stub
- [`../BIODEGRADABLE-PLASTICS.md`](../BIODEGRADABLE-PLASTICS.md) — bio-plastic Phase D stub
- [`../LIQUID-CRYSTAL.md`](../LIQUID-CRYSTAL.md) — LC Phase D stub
- [`../MOF.md`](../MOF.md) — MOF (coord polymer cross-link)
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L1 (Frenkel σ_th), L2 (practical tensile), L12 (ΔS_mix recycling)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 9 dispatchable POL verbs spec-present | post-Phase D |
| (b) | ✅ **CLOSED 2026-05-13** — 6/6 POL parity gates landed (B-POL-1..B-POL-6) under `tests/pol_b*_parity.py`; sweeps by `selftest/parity_gates_smoke.sh` | Phase H + I.1 + I.2 (all closed) |
| (c) | **OUT-OF-REPO** — DuPont/BASF/Toray batch trace; aramid pilot; field-mass-balance | vendor numbers only |

## §5 UNPROVEN / UNVERIFIED markers (verbatim from verb specs)

- **elastomer** — self-healing rubber + bio-isoprene UNVERIFIED at production
- **adhesive** — bio-based + self-healing + gecko-inspired aerospace UNVERIFIED
- **liquid-crystal** — polymer-stabilized blue-phase commercial display UNVERIFIED
- **biodegradable-plastics** — marine-biodegradability UNVERIFIED most grades (only certain PHA D7081); cost parity to PE UNVERIFIED

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| POL ↔ FIB | aramid, tire_cord, pet_film (film/fiber form-factor of POL chemistry) | hexa-fiber/ |
| POL ↔ CER | composite matrix (epoxy in CFRP); silicone (Si-O-C); MOF (coordination polymer) | hexa-ceramic/ |
| POL ↔ FAS | textile-grade nylon, polyester, spandex (elastomer) | hexa-fashion/ |
| POL ↔ MET | rubber-bonded metal (engine mount); adhesive-bonded metal joint | hexa-metal/ |
| POL ↔ PRC | step-growth + chain-growth polymerization; chemical recycling | hexa-synthesis/ + hexa-recycle/ |

## §7 Files in this depth dir

- `README.md` (this file)
- [`polymer-architecture.md`](polymer-architecture.md) — chain-growth vs step-growth, MW, Tg/Tm domains
- [`polymer-data-anchors.md`](polymer-data-anchors.md) — CRC/ASTM/ISO anchor table
- [`polymer-closure-status.md`](polymer-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13.*
