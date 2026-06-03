# aga-cure-4arm-restoration — paper status

@title: 📄 An in-silico four-arm regimen for complete androgenetic-alopecia restoration
@goal: Design the constructive 4-arm AGA complete-restoration regimen (reactivate · reverse · permanence · neogenesis) under the reversible/dormant/lost tissue-class framework, and show the strict ≥90% never-bald cure gate reduces to a single measurable parameter (E_max ≥ 0.96).

- [x] draft v1 — 11pp, §pipeline/method/results(4 arms + composition + lock-timing + neogenesis + permanence + delivery + re-gate)/discussion/limitations/reproducibility
- [x] figures complete — fig01 per-arm marginal value + composed restoration vs gates, fig02 lock-timing saturation (DC6)
- [x] references ≥10 — 11 DOIs (Turing·Ito·Hawkshaw·Clevers·VanNeste·Cotsarelis·Halloy·Wu·Xu CasMINI·Kageyama organoid·SciRep)
- [x] compile clean — tectonic, 0 errors / 0 undefined, 11pp
- [ ] arxiv submit ready (`/paper arxiv-prep .`) — pending user go

## frame (constructive design — d_paper_on_discovery)
- 4-ARM 🟢: ① MPC/LDH reactivation (fit 0.798) · ② SFRP1/Dkk1 reversal (fit 0.762) · ③ Cas12f single-AAV epigenetic lock (fit 0.766) · ④ Wnt/Dkk Turing neogenesis (native ~278/cm²)
- COMPOSED 🟢: MC mean 78.7% restoration; strong-cosmetic ≥70% P=0.872; strict ≥90% P=0.043 (current efficacies)
- VALUE DRIVER 🟢: permanence arm ③ = −37.3 pp if removed (dominant); no single arm > 37 pp → combination
- LOCK TIMING 🟢: saturating function, knee ~month 18 (0.946 = 99.6% of month-36 asymptote 0.950)
- SINGLE-PARAM GATE 🟢: with all decisions wired in, strict gate ⇔ E_max ≥ 0.96 (98.6% of variance)
- FALSIFIED 🔴: single-AAV dCas9-KRAB (cargo overflow ~4.1kb+KRAB+promoter > 4.7kb)

## honest tiers (g63)
🟢 mechanism/sequencing/lock-timing/delivery/neogenesis-density (in-silico resolved) · 🟡 AGA E_max clinical anchor 0.59 (VanNeste 2020) ·
🟠 per-class η literature-order + epigenetic-mark heritability (f≥0.98) + Cas12f off-target/AE order-of-magnitude (DC8/11/12) · 🔴 dCas9-KRAB single-AAV cargo overflow.
No efficacy claimed; strict ≥90% gate explicitly NOT closed (reduces to unmeasured E_max). 3 pre-registered in-vitro experiments defined.

## source
exports/AGA-CURE/ (round1-design, round1-arms, round1-verify, round2-deep, round3-deep, round4-deep, round5-emax-anchor)
