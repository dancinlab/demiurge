<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_FAS -->
---
depth_dir: hexa-fashion
axis_group: GROUP_FAS
verb_members:
  - fashion-textile
  - textile-dyeing
cross_link_members:
  - fabric (FIB)
  - nylon (POL textile fiber)
  - pet_film (POL polyester fiber form)
  - aramid (POL/FIB high-performance)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-fashion — GROUP_FAS depth directory

> **Aggregates the fashion / textile-dyeing group.** Member verbs span
> wet-process chemistry (reactive dye, vat dye, direct dye, mordant) and
> the industrial-textile supply chain. Distinct from `hexa-fiber/` (FIB):
> FIB is dry-mechanical fiber/fabric assembly; FAS is wet-process and
> dye-uptake.

> **Honesty.** This is the smallest group by spec depth in hexa-matter.
> The fashion-textile + textile-dyeing verbs are SPEC_FIRST stubs; rich
> trade-supply-chain content lives upstream in `canon/` and was imported
> per `IMPORTED_FROM_CANON.md`.

---

## §1 Scope

GROUP_FAS has 2 verbs. Per `AXIS.md §0`, they are NOT in the 29-verb CLI
dispatch (`hexa.toml [verbs]`) — they are industrial-textile lineage
tracked separately. They have spec presence (4/4 verify scripts PASS) but
are not dispatchable as standalone CLI verbs.

| Layer | Verbs | Chemistry |
|-------|-------|-----------|
| Core FAS | fashion-textile, textile-dyeing | dye-substrate covalent + vdW + H-bond + mordant |

## §2 Member verbs

- **fashion-textile** → [`../fashion-textile/fashion-textile.md`](../fashion-textile/fashion-textile.md) — industrial textile, fabric grade, garment lineage
- **textile-dyeing** → [`../textile-dyeing/textile-dyeing.md`](../textile-dyeing/textile-dyeing.md) — reactive dye, vat dye, direct dye, mordant, pigment, indigo

Cross-linked (fiber substrate for dyeing):
- **fabric** (FIB) → [`../fabric/fabric.md`](../fabric/fabric.md) — woven, knit, non-woven substrate
- **nylon** (POL) → [`../nylon/nylon.md`](../nylon/nylon.md) — acid-dye-uptake amide
- **pet_film** (POL, fiber form) — polyester fiber, disperse-dye uptake
- **aramid** (POL/FIB) — high-performance fiber; difficult to dye

## §3 Cross-links to root deep-expansion docs

- [`../FASHION-TEXTILE.md`](../FASHION-TEXTILE.md) — fashion-textile root stub
- [`../TEXTILE-DYEING.md`](../TEXTILE-DYEING.md) — textile-dyeing root stub
- [`../POLYMER-CHEMISTRY.md`](../POLYMER-CHEMISTRY.md) — textile-grade polymer chemistry (root, 439 lines)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 2/2 FAS verbs spec-present | not in CLI dispatch but spec-present |
| (b) | **UNVERIFIED** — 2 parity gates queued (B-FAS-1, B-FAS-2) | Phase B |
| (c) | **OUT-OF-REPO** — dye-house pilot; indigo fermentation cross-domain | external |

## §5 UNPROVEN / UNVERIFIED markers

(GROUP_FAS verbs are thin specs at present — no Phase D additions. UNVERIFIED
markers are mostly (c) wet-process pilot items.)

- textile-dyeing — reactive-dye covalent yield UNVERIFIED at large-scale (ISO 105 parity needed)
- fashion-textile — supply chain transparency (cotton, wool, silk yields) UNVERIFIED — global supply chain trace

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| FAS ↔ FIB | textile substrate (cotton, wool, silk, synthetic fiber) | hexa-fiber/ |
| FAS ↔ POL | textile-grade polymer (nylon, polyester, acrylic, spandex) | hexa-polymer/ |
| FAS ↔ PRC | wet-process dyeing route; mordant uptake; vat reduction | hexa-synthesis/ |
| FAS ↔ bio (cross-substrate) | indigo fermentation (microbial production); natural-dye revival | hexa-bio/ |
| FAS ↔ MET | metallic thread (gold thread); embellishment; zipper / snap | hexa-metal/ |

## §7 Files in this depth dir

- `README.md` (this file)
- [`fashion-architecture.md`](fashion-architecture.md) — dyeing chemistry, mordant, fiber-dye affinity, supply chain
- [`fashion-data-anchors.md`](fashion-data-anchors.md) — ISO 105 / AATCC anchor table
- [`fashion-closure-status.md`](fashion-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13.*
