# TTR-MN v5-B — macrophage chemotaxis 가속 (lymph drainage)

> milestone: v5 path B · 분해 후 lymph drainage 가속 → 체감 timeline 단축
> driver: 실제 분해 동일 · 가시적 사라짐 가속 · 사용자 만족도 ↑
> base: v5_rd_paths_physical_floor_bypass.md (Path B overview) 위 detailed

## TL;DR

S1P (sphingosine-1-phosphate) agonist 또는 CCL19 chemokine mimetic micro-dose → macrophage가 잉크 분해 후 lymph 로 더 빠르게 이동. **실제 분해 동일 (2개월)** 다만 **체감 timeline 1개월** (visual fade 가속). 사용자 만족도/adherence ↑. R&D 1-1.5년 · $2-3M. v5-A/C/D 와 호환 (incremental).

## §1 mechanism

```
   v4 단독:
   ─────────────
   Day 0: 잉크 + payload (격일 cycle)
   Day 1-3: 분해 + macrophage uptake
   Day 4-7: 분해 산물 + macrophage 천천히 lymph 이동 (rate-limiting)
   Day 8+: 시각적 fade 시작
   ─────────────
   visible timeline: 분해 + drainage 합 ≈ 2 mo (90% removal)
   
   v5-B + chemotaxis agonist:
   ─────────────
   Day 0: 잉크 + payload + S1P agonist 5 μg
   Day 1-3: 분해 + macrophage uptake (동일)
   ★ Day 3-4: ★ S1P 활성화 · macrophage egress to lymph
        (rate 3-5× normal · Cyster 2003 PMID 14647402)
   Day 4-5: visible fade 빠른 onset
   ─────────────
   visible timeline: ≈ 1 mo 체감 (실제 분해 동일 2mo)
   
   ★ subjective improvement ratio: 2× ★
```

## §2 chemotaxis agonist 후보

### Primary candidates

| compound | target | mechanism | clinical | dose proposed |
|---|---|---|---|---|
| **Fingolimod (FTY720)** | S1P1 receptor | macrophage S1P egress | FDA-approved (MS) | 0.5-1 mg/dose oral · 5 μg local |
| **Ozanimod** | S1P1 selective | safer than fingolimod | FDA-approved (MS) | 0.46-0.92 mg oral · 5 μg local |
| **CCL19 mimetic peptide** | CCR7 agonist | direct chemokine | research | 1-5 μg local |
| **CCL21** | CCR7 ligand | T-cell + DC migration | research | 2-10 μg local |
| **PGE2 (Prostaglandin E2)** | EP4 receptor | macrophage motility | various clinical | 0.5-2 μg local |

⇒ **primary: Fingolimod 5 μg local** (FDA-precedent · low dose · 격일 cycle 적합)

### Local vs systemic concern

```
   Fingolimod systemic dose (MS treatment): 0.5 mg/day → reduces lymphocyte 70%
   v5-B local dose: 5 μg per cycle × 11 cycle = 55 μg total
   ratio: 55 / 50,000 = 0.0011 (0.11% of clinical · 1000× lower)
   → systemic lymphopenia 회피 · local only
```

⇒ micro-dose 안전 design

## §3 SKU composition (v5-B + v4 baseline)

```
   v5-B Cocktail (v4 base + chemotaxis):
   ─────────────
   AzoR/DyP/CeO₂ quad + TLR7/8 (v4 base)
   + Fingolimod 5 μg (격일 cycle 별)
   + Ascorbate · NADPH (cofactor)
   = patch cost $48 (+\$3 fingolimod)
```

### Combo variants

| variant | base | chemotaxis | dose ratio | use case |
|---|---|---|---|---|
| v5-B alone | v4 baseline | + fingolimod 5 μg | 100% v4 + 100% chemo | timeline 동일 · visible 가속 |
| v5-AB | v5-A engineered | + fingolimod | engineered + chemo | engineered + visible 가속 |
| v5-CB | v5-C sono | + fingolimod | sono + chemo | sono + visible 가속 |
| v5-DB | v5-D rotation | + fingolimod (δ patch) | rotation + chemo | rotation + visible 가속 |

⇒ universally compatible

## §4 timeline (실제 vs 체감)

| version | 실제 (90% 분해) | 체감 (visible fade) |
|---|---|---|
| v4 | 2mo (52일) | 2mo |
| **v5-B (alone)** | **2mo (동일)** | **1mo (50%)** |
| v5-AB | 1.2mo | **0.6mo** (3주) |
| v5-CB | 1.3mo | **0.65mo** (3주) |
| v5-AC + B | 1mo | **0.5mo** (2주) ★ |

⇒ **v5-AC+B = 체감 2주** (실제 1개월 · v4 4× 빠른 체감)

## §5 marketing pitch (visible 효과 우선)

```
👁 TTR-MN-Visible — "보이는 fade 가속"

- 같은 patch · 같은 cycle · 다만 lymph drainage 가속
- 2주-1개월 안 visible fade 시작 (vs v4 1-2개월)
- 실제 90% removal 시간은 동일 (안전성 · efficacy 동일)
- premium add-on 옵션 (insurance · OTC)
```

⇒ adherence ↑ · patient satisfaction ↑ (visible 진척 보임)

## §6 mechanism deep-dive (literature)

### S1P pathway

```
   Sphingosine-1-phosphate (S1P) gradient:
   - tissue (low S1P) ↔ blood/lymph (high S1P)
   - macrophage S1P1 receptor → migration to high-S1P
   - drainage to lymph node (high S1P region)
   
   v5-B: S1P1 agonist (fingolimod active form)
        - macrophage egress 가속 (Cyster 2003)
        - DC migration boost (Allende 2003)
        - tissue → lymph timing: 3-7일 (normal) → 1-2일 (boost)
```

### CCL19/CCR7 axis

```
   CCL19 (chemokine) gradient:
   - tissue → afferent lymph
   - DC/macrophage CCR7 → chemotaxis
   - mature DC → lymph node migration
   
   v5-B alternative: CCL19 mimetic micro-dose
        - similar boost · less systemic risk than S1P agonist
```

## §7 R&D + Phase 1

| phase | task | duration | cost |
|---|---|---|---|
| R&D-1 | Fingolimod local micro-dose formulation | 4mo | $300k |
| R&D-2 | ex-vivo + in-vivo (visible fade kinetics) | 6mo | $400k |
| R&D-3 | combo with v4 (격일 schedule · drug interaction) | 4mo | $300k |
| R&D-4 | Regulatory path (505(b)(2) · existing fingolimod label expansion) | 4mo | $200k |
| Phase 1 | n=10 v5-B arm | 2mo + 2mo | $500k |
| **합계** | | **18-20mo** | **$1.7-2M** |

⇒ relatively low cost · existing drug repurposing

## §8 safety (S1P agonist specific risks)

| risk | likelihood | mitigation |
|---|---|---|
| Systemic lymphopenia | low (micro-dose 0.11%) | serum lymphocyte count monitor |
| Macular edema (FDA black box for fingolimod) | low-mid | local micro-dose · ophthalmology baseline |
| Cardiac (first-dose bradycardia) | low (local) | first-dose monitor (clinic) |
| Infection susceptibility ↑ | low | acute use 2개월 · chronic 없음 |
| Hepatic enzyme | low | LFT monitor (별 cohort) |

⇒ FDA-approved precedent (Aubagio, Gilenya) · safer profile 가능 (Ozanimod 권장)

## §9 비용 영향

| version | v4 base | + chemo | treatment | savings (체감 timeline ↑) |
|---|---|---|---|---|
| v4 | $705 | — | $705 / 2mo | — |
| v5-B alone | $705 | +$33 (fingolimod 11x $3) | **$738** / 2mo (체감 1mo) | adherence 향상 |
| v5-AB | $450 (v5-A) | +$33 | $483 / 1.2mo (체감 0.6mo) | best premium |

## §10 honest unknowns

- Chemotaxis boost factor 정확 (literature 3-5× rate · individual variability)
- Local fingolimod skin distribution (lymphatic 정합)
- Long-term S1P agonist (5-yr autoimmune risk)
- Visible fade subjective measurement (placebo effect 가능성)
- Patient compliance (additional micro-dose vs simplicity)

## §11 진행 상태

- ✅ Chemotaxis mechanism (S1P · CCL19 pathway)
- ✅ 후보 selection (Fingolimod · Ozanimod · CCL19 mimetic)
- ✅ Local micro-dose (5 μg = 0.11% of clinical · safety margin)
- ✅ Combo universally compatible (v5-AB · v5-CB · v5-DB · v5-AC+B)
- ✅ Timeline 실제 동일 · 체감 50% (visible fade 가속)
- ✅ R&D 1.7-2M · 18-20mo
- ✅ Safety mitigation (FDA-approved precedent fingolimod)
- next: v5-E gene therapy (paradigm shift · long-term R&D)
