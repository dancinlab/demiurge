# DEEP DC2 — per-arm in-silico→in-vivo gate spec (what measurement closes each arm)

Each AGA-CURE arm's in-silico result + the SINGLE wet-lab measurement that converts its 🟠/estimate to 🟢 (the bracket-collapsing assay, per AGA-RX D5 logic that one parameter dominates).

| arm | in-silico state | gating in-vivo measurement | converts |
|---|---|---|---|
| ② 되돌리기 (Wnt) | anagen +8.9% (E_max-bracketed, D5: 98.6% of variance) | **ex-vivo human hair-organ-culture: SFRP1-inhibition → anagen-duration ΔΔ (E_max)** | the dominant cure-uncertainty → collapses [4.1,13.8]% to a point |
| ① 깨우기 (HFSC) | LDHA −9.68 selective; HFSC-reactivation assumed | **CD200+/CD34+ progenitor re-proliferation assay on AGA bald-scalp biopsy** (do dormant HFSC re-enter cycle?) | the "reservoir preserved but activatable?" assumption |
| ③ 영구잠금 (AAV) | T=1 capsid valid, ~540× durability (modeled) | **AAV→dermal-papilla transduction efficiency + episome persistence (DPC turnover)** in scalp explant/primate | the tropism + durability claims (out-of-silico) |
| ④ 신생 (neogenesis) | Gray-Scott 290/cm² reachable (phenomenological) | **dose-controlled WIHN density assay** (verteporfin+Wnt → new-follicle count/cm² in a wound/dose model) — the neogenesis-efficiency f4 | f4 bracket [0.3,0.9] → measured T3-restore |
| combination | restore 78.7% mean, durability-anchored | **staged in-vivo regimen on an AGA model (humanized/macaque): terminal-density + relapse-free at withdrawal** | the strict CURE gate (≥90% + relapse-0) |

## priority (highest-value first, per variance dominance)
1. **E_max (arm②)** — single biggest lever (D5: 98.6% of efficacy variance). One ex-vivo assay collapses the whole cure-probability band.
2. **f4 neogenesis (arm④)** — sets T3 ceiling.
3. AAV tropism (arm③) — the durability/permanence claim.
4. HFSC re-activation (arm①) — the reversibility-mechanism confirm.

All are inherently wet-lab (out-of-software-scope per d19) — the in-silico path has driven each arm to its measurement-ready gate; these 4 assays are the hand-off to the bench, prioritized by in-silico-quantified leverage.
