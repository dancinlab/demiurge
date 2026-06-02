<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_GEM -->
---
depth_dir: hexa-gem
axis_group: GROUP_GEM
verb_members:
  - gemology
cross_link_members:
  - carbon (diamond cross-link)
  - ceramics (corundum Al₂O₃ ↔ alumina ceramic)
  - perovskite (oxide structure overlap)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-gem — GROUP_GEM depth directory

> **Aggregates the gem / mineral group.** Single member verb (gemology),
> cross-linked to carbon (diamond) and ceramics (alumina/Al₂O₃ ↔ corundum
> sapphire/ruby). Root deep-expansion is `GEMOLOGY.md`.

> **Honesty.** Mohs 10 (diamond) is the practical hardness HARD wall
> (L4 in `LIMIT_BREAKTHROUGH.md`). Lonsdaleite + w-BN (calc 150 / 85 GPa
> Vickers) remain non-synthesized in bulk despite 60+ years — preserved
> verbatim from `carbon/carbon.md`.

---

## §1 Scope

GROUP_GEM has 1 verb: `gemology`. The "axis" angle is **non-destructive
characterization** — refractive index, dispersion, dichroism, inclusions,
fluorescence — rather than processing. The same Al₂O₃ that lives in
corundum-as-gem also lives in alumina-as-ceramic; the verb separation is
about *which face of the material* you care about.

## §2 Member verbs

- **gemology** → [`../gemology/gemology.md`](../gemology/gemology.md) — diamond, corundum (ruby, sapphire), beryl (emerald, aquamarine), garnet group, spinel, topaz, tourmaline

Cross-linked:
- **carbon** (CER) — diamond as carbon allotrope (Mohs 10) — [`../carbon/carbon.md`](../carbon/carbon.md)
- **ceramics** (CER) — corundum Al₂O₃ as engineering ceramic (alumina) — [`../ceramics/ceramics.md`](../ceramics/ceramics.md)
- **perovskite** (CER) — some gemstones have perovskite-related structure (e.g., loparite, tausonite)

## §3 Cross-links to root deep-expansion docs

- [`../GEMOLOGY.md`](../GEMOLOGY.md) — root stub
- [`../GRAPHENE-CARBON.md`](../GRAPHENE-CARBON.md) — diamond (Mohs 10, L4 ceiling); 353 lines
- [`../CERAMIC-ENGINEERING.md`](../CERAMIC-ENGINEERING.md) — corundum / spinel / silicate ceramic chemistry
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L4 Mohs 10 (diamond) HARD wall

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 1/1 GEM verb spec-present | gemology.md exists |
| (b) | **UNVERIFIED** — 2 parity gates queued (B-GEM-1, B-GEM-2) | Phase B |
| (c) | **OUT-OF-REPO** — lab-grown diamond CVD/HPHT bench; treatment audit | vendor / lab |

## §5 UNPROVEN / UNVERIFIED markers (verbatim)

- **carbon** (cross-link) — bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED
- **gemology** — lab-grown diamond identification (CVD vs HPHT vs natural) is ongoing GIA / IGI / GCAL methodology development

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| GEM ↔ CER | corundum Al₂O₃ ceramic; spinel MgAl₂O₄ ceramic; diamond C ceramic | hexa-ceramic/ |
| GEM ↔ MET | gold/platinum/palladium mountings | hexa-metal/ |
| GEM ↔ PRC | hydrothermal synthesis (synthetic quartz, ruby); HPHT/CVD synthetic diamond | hexa-synthesis/ |
| GEM ↔ FAS | jewelry as fashion accessory (not a strong material boundary) | (cultural overlap) |

## §7 Files in this depth dir

- `README.md` (this file)
- [`gem-architecture.md`](gem-architecture.md) — gem species table, RI / dispersion / dichroism / hardness / treatment overview
- [`gem-data-anchors.md`](gem-data-anchors.md) — NIST/GIA/IGI/Mohs scale anchor table
- [`gem-closure-status.md`](gem-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13. Single-verb group — narrow scope
but explicit cross-link discipline preserved.*
