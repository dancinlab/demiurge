<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory (cross-group anchor) -->
---
depth_dir: hexa-silicon
axis_group: (cross-group anchor; not a single AXIS.md group)
spans:
  - GROUP_CER (silicon as SiO₂/SiC/Si₃N₄ ceramics)
  - GROUP_MET (Si as alloy element)
  - GROUP_PRC (Si as synthesis-platform substrate)
verb_members:
  - silicon
cross_links:
  - hexa-ceramic/ (SiO₂ → glass; SiC/Si₃N₄ → ceramics; perovskite ABO₃ Si feedstock)
  - compound-semi/ (SiC wafer device aspect)
  - 2d-materials/ (silicene 2D Si allotrope)
  - hexa-chip (semiconductor device layer; OUT-OF-SCOPE here)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-silicon — Si material-aspect depth directory

> **Cross-group anchor.** Silicon is the ONLY verb in hexa-matter that
> explicitly bridges three AXIS groups (CER, MET, PRC). This depth dir
> aggregates the bridge points without duplicating the verb spec at
> `silicon/silicon.md` (gold-standard, 350 lines) or the root deep-dive
> at `SILICON.md` (350 lines).

> ~600 mm CZ crucible, ~200 mm FZ rod, 1687 K T_m, 2.329 g/cm³, 1.12 eV
> bandgap, 3.26 eV 4H-SiC bandgap are **metallurgy + thermal physics +
> vendor engineering** anchors — not n=6 lattice anchors. Wacker, GCL,
> Hemlock, OCI, REC, Shin-Etsu, SUMCO, Siltronic, GlobalWafers, SK Siltron,
> Wolfspeed publish their own batch numbers. No lattice fit is applied to

---

## §1 Scope

The silicon material layer covers four distinct forms:

| Form | Where it lives | Verb / file |
|------|----------------|-------------|
| Elemental Si (poly-Si, mono-Si) | `silicon/silicon.md` | silicon |
| SiO₂ (quartz, fused silica, silicate glass) | `glass/` + cross-link | glass + silicon |
| SiC / SiN / Si₃N₄ ceramics | `ceramics/` + `compound-semi/` | ceramics + compound-semi |
| Silicone (Si-O polymer, PDMS) | (no dedicated verb yet; lives in adhesive/elastomer scope) | (cross-domain) |

**Out of scope here**: the semiconductor *device* — transistor architecture,
lithography, EUV resist stack, FinFET / GAA, advanced node design — lives
in sister-substrate `hexa-chip`. Call `hexa-chip materials` for that layer.

## §2 Member verbs

Single verb in this anchor dir; cross-linked verbs are aggregated:

- **silicon** → [`../silicon/silicon.md`](../silicon/silicon.md) (350 lines, gold-standard template)

Cross-linked verbs from other groups:
- **ceramics** (CER) → [`../ceramics/ceramics.md`](../ceramics/ceramics.md) — Si₃N₄, SiC ceramic forms
- **glass** (CER) → [`../glass/glass.md`](../glass/glass.md) — SiO₂ fused silica T_g 1473 K
- **compound-semi** (CER, Phase D) → [`../compound-semi/compound-semi.md`](../compound-semi/compound-semi.md) — SiC 3.26 eV wide-bandgap wafer
- **2d-materials** (CER, Phase D) → [`../2d-materials/2d-materials.md`](../2d-materials/2d-materials.md) — silicene
- **perovskite** (CER, Phase D) → [`../perovskite/perovskite.md`](../perovskite/perovskite.md) — oxide-perovskite cross-link
- **metallurgy** (MET) → [`../metallurgy/metallurgy.md`](../metallurgy/metallurgy.md) — Si as alloy element (Al-Si, Fe-Si, Cu-Si)
- **synthesis** (PRC) → [`../synthesis/synthesis.md`](../synthesis/synthesis.md) — Siemens, FBR, CZ, FZ as synthesis routes

## §3 Cross-links to root deep-expansion docs

- [`../SILICON.md`](../SILICON.md) — root deep-expansion (350 lines): Si-L1..Si-L12 limits enumerated
- [`../CERAMIC-ENGINEERING.md`](../CERAMIC-ENGINEERING.md) — SiC/Si₃N₄ ceramic engineering deep-dive (299 lines)
- [`../COMPOUND-SEMI.md`](../COMPOUND-SEMI.md) — SiC wide-bandgap device-aspect stub
- [`../2D-MATERIALS.md`](../2D-MATERIALS.md) — silicene 2D allotrope reference
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — Wave M real-limits audit (Si-L1..Si-L12 entries authoritative)

## §4 Group-level closure status (per AXIS_CLOSURE_PLAN.md)

| Category | Status | Notes |
|----------|--------|-------|
| (a) in-repo SW | **100%** — silicon/silicon.md present, 4/4 verify PASS | gold-standard template |
| (b) NIST/CRC parity | **UNVERIFIED** — 5 gates queued (B-CER-1..B-CER-5) | Phase B selftest target |

(b) gates queued for Phase B:
- B-CER-1 NIST SRM quartz refractive index vs `glass/glass.md`
- B-CER-2 Si density CRC 2.329 g/cm³ vs Si-L6
- B-CER-3 Si bandgap NIST/Sze 1.12 eV vs Si-L7
- B-CER-4 SiC bandgap Saddow & Agarwal 2004 vs Si-L11 (3.26 eV)
- B-CER-5 Si₃N₄ flexural 600–1200 MPa ASM vol. 21 vs Si-L12

(c) hand-offs:
- C-CER-1 Wacker poly-Si batch lot purity audit — DEST: Wacker Polysilicon AG (no contract; vendor numbers only)
- C-CER-2 Wolfspeed SiC wafer fabrication — DEST: Wolfspeed Inc.
- C-CER-5 Isotope-separated Si-28 production — DEST: International Avogadro Project / quantum-compute consortia

## §5 UNPROVEN / UNVERIFIED markers (preserved verbatim from verb specs)

From `silicon/silicon.md` and `compound-semi/compound-semi.md`:
- **Wacker batch lot purity** UNVERIFIED at the 9N digit count (vendor publishes spec, not lot-by-lot trace)
- **CZ crucible >600 mm production class** UNVERIFIED for sustained 450 mm wafer pull
- **Isotope-separated Si-28** UNVERIFIED at commercial scale for quantum compute
- **6/8" bulk GaN ammonothermal** UNVERIFIED (compound-semi)
- **diamond-as-semi wafer** UNPROVEN (compound-semi)
- **silicene ambient stability** UNVERIFIED beyond Ag(111) substrate (2d-materials)


Silicon is the canonical example of why the cross-link policy exists. Three groups touch it:

| Group | Si's contribution | Boundary anchor |
|-------|-------------------|-----------------|
| CER | poly-Si feedstock, mono-Si wafer, SiO₂ → fused silica, SiC/SiN/Si₃N₄ ceramics, perovskite oxide Si feedstock | `silicon/silicon.md §1`, `silicon/silicon.md §7` |
| MET | Si as alloy element (Al-Si Sirocast, Fe-Si electrical steel, Cu-Si silicon-bronze) | `metallurgy/metallurgy.md` (Si as alloy element) |
| PRC | Siemens TCS distillation, FBR, CZ ingot pull, FZ refining, CVD epitaxy | `synthesis/synthesis.md` (Si synthesis routes) |

The line between hexa-matter and hexa-chip is enforced at `silicon/silicon.md §7`:
- `hexa-matter/silicon/` = material aspect (purity, dimension, vendor tonnage, SiO₂/SiC/SiN cross-links)
- `hexa-chip` = device + fab process (lithography, transistor, EUV resist, fab capacity)

No n=6 lattice arithmetic is applied to Si-L1..Si-L12 — they are NIST/CRC/SEMI/ASTM/vendor anchors only.

---

*Phase C depth-dir, authored 2026-05-13 by 박민우 <nerve011235@gmail.com>.*
