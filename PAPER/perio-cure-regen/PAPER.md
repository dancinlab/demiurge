# perio-cure-regen — paper status

@title: 🦷 In-silico senolytic-enabled regimen for complete periodontal regeneration
@goal: Show complete periodontal regeneration BLOCKs below the ≥90% cure gate on a single binding axis (lost alveolar-bone/cementum neogenesis), and that senolytic niche senescent-cell clearance lifts η_bone enough to CLOSE the gate at ~73–80% clearance. Periodontal instance of the universal neogenesis-bottleneck framework.

- [x] draft v1 — 10pp, §Full Pipeline/Method/Results(block+per-class+robustness+senolytic)/Discussion/Limitations/Reproducibility
- [x] figures complete — fig01 senolytic clearance→cure-ceiling gate crossing, fig02 periodontal class decomposition bar
- [x] references ≥10 — 19 bib entries (template reuse + Kao·Nyman·Hammarström·Seo·Komori·Wozney·Baker·Coppé real DOIs)
- [x] lint pass — /paper lint → 9/9 ✓
- [x] compile clean — tectonic, 0 errors/undefined, 10pp
- [ ] arxiv submit ready (`/paper arxiv-prep .`) — pending user go

## frame (positive structural result — d_paper_on_discovery)
- BLOCK 🟢: ceiling Σ m_c η_c = 0.80 < 0.90 gate; gingiva 0.40(η0.95)/PDL 0.30(η0.85)/bone+cem 0.30(η0.55)
- AXIS 🟢: binding = lost bone/cementum neogenesis; η_bone ≥ 0.88 needed to close gate
- KEY 🟢: senolytic niche-clearance η_bone = 0.55 + φ·0.45 → gate CLOSES at φ ≈ 73–80% (η_bone 0.88–0.91)
- ARM 🟡: BMP/Wnt/RUNX2 osteo-/cemento-neogenesis run inside the cleared window
- ROBUST: binding axis holds under ±0.1 η perturbation (structure 🟢, absolute magnitudes 🟠)

## honest tiers (g63)
🟢 axis-collapse + ceiling 0.80 + PD gate (within model) ·
🟡 PDL stem reservoir / BMP-RUNX2 arm / senescent-niche SASP (cited) ·
🟠 class masses + per-class η + φ→η_bone coupling literature-order.
No efficacy claimed; senescent gingival/PDL fibroblast SASP accumulation in chronic periodontitis motivates the senolytic leg. In-vitro gates (2 pre-registered experiments) defined.

## source
exports/PERIO-CURE/round1/ · exports/CURE-PRIMITIVE/round1/ · domains/PERIO-CURE.md
