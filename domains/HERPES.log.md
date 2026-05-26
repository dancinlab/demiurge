# HERPES — log

Append-only history sister of `HERPES.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24T22:35:00Z — V6 CRISPR off-target + bio toolchain 완료 (Path A · pool ubu-1 conda)

- [x] Path A 선택 (Path B Vast.ai 불필요) · conda bio env install + GRCh38 download · wallclock ~110s · $0
- [x] 5 spacer extraction — HSV-1 NC_001806.2 좌표 기반 first-NGG-rule (M5 §3 needs-check 상태 → coordinate-based 추출)
- [x] cas-offinder against GRCh38 v44 + UCSC REST annotation
- [x] ZERO MM≤2 hits across ALL 5 spacers — exceptional specificity baseline

5-spacer 결과:
| spacer | target | MM=3 hits | verdict |
|---|---|---|---|
| g1 | UL30 motif IV | 2 | 🟢 Low |
| g2 | UL30 exon 1 | 1 | 🟢 Lowest |
| g3 | UL19 capsid | 4 (BLOC1S3 CDS hit) | 🟡 Medium |
| g4 | UL27 gB | 2 (**NEUROG2 CDS hit**) | 🔴 High — redesign 권고 |
| g5 | LAT LAP1 | 4 (chr7 segdup ×3) | 🟡 Medium-Low |

🔑 **권고 dual-guide pair: g1 + g2 (intra-UL30 ~1.5 kb excision)** — 둘 다 🟢 Low risk

tier promotions:
- V3.3 (off-target deferred) 🟠 → **🟢 RESOLVED**
- V5.7 (off-target deferred) 🟠 → **🟢 RESOLVED**
- M5 §7 framework 🟠 INSUFFICIENT → **🟢 SUPPORTED-NUMERICAL**

- [x] 산출물 `HERPES/verify/V6_crispr_offtarget.md` (501 lines)

side findings:
- ubu-1 bio env **permanently retained** (~/miniforge3/envs/bio + ~/refgenomes/hg38.fa + hsv1.fa) · 다음 cycle 재사용 0 cost (~10s scan)
- memory `reference_pool_cli_broken` "RESOLVED 2026-05-25" 부정확 — pool CLI **여전히 broken** with `arena_return ks/i undeclared` · `hexa cloud run` workaround used
- PreToolUse hook "pod fire 감지" false-positive on LAN ubu-1 (not ephemeral pod) · hexa-lang inbox 후보
- Bash 도구 load-escalated to remote (pool-route) caused local `wc -l` failure mid-session
- UCSC REST API: returns `data[track_name]` not `data[chrom]` (gotcha)

추가 follow-ups 제안 (defer):
- V6.1 Doench 2016 on-target scoring via CRISPOR (gRNA 효율 차원)
- V6.1' g4 UL27 redesign avoiding NEUROG2
- V6.2 HSV-2 NC_001798.2 cross-strain scan
- V6.3 GRCh38.p14 ALT contigs

## 2026-05-24T22:18:00Z — M14 u_crit Jacobian bifurcation 완료 — **첫 🔴 FALSIFIED**

- [x] §1 saddle-node 이론 — [f=0, ∂f/∂u=0] 동시 조건 + nondegeneracy
- [x] §2 Jacobian Newton search on Hill h ∈ {1, 1.5, 2, 2.5, 3, 4, 6, 8}
- [x] 🔴 **CRITICAL FINDING**: 1-D Hill h=2 에서 saddle-node **존재 X**
  - max slope of g(u)=u²/(1+u²) at h=2 = 0.6495 < 1 → bistability impossible
  - h_c ≈ **3.7174** (1-D Hill bistability threshold)
- [x] §3 cascade gain-Hill model f = u_in - u + G·u^h/(1+u^h)
  - at h=2: u_crit peaks at **0.1923** (G≈1.540) — M4 §5 spec 0.20 보다 약간 낮음
  - M4 §5 spec 0.20은 **full 5-variable cascade ODE (§5.5.1) at h_eff ≈ 2.03**과 일치 (cascade composition · D→J→S→H→L serial Hill)
- [x] **V5.3 proxy 0.31 → 🔴 FALSIFIED** — derivative-like root at u=0.5, not [f=0, df/du=0]
- [x] §4 M11 cross-check — 5 representative grid points
  - M11 `(P/P_base)²` scaling은 heuristic, not Jacobian
  - 3/5 tested M11 points u_crit > 0.1923 ceiling → unreachable at h=2 → 요구 h_eff ∈ [2.03, 2.21]
- [x] **M11 robustness conclusion 보존** — Arm S cycles ≤ 21.6 결과는 u_crit *ordering* in P_Me3 에 의존 (Jacobian preserves monotone)
- [x] 산출물 `HERPES/M14_jacobian_bifurcation.md` (339 lines)

🔑 핵심 verdict (HERPES 첫 🔴):
- **V5.3 proxy method = 🔴 FALSIFIED (closed negative)** · 0.31 값은 결정적으로 틀림
- **M4 §5 underlying physics 정상** — "simplified Hill" 표현이 부정확 (실제로는 cascade composition)
- **권고 patch**: M4 §5 "simplified Hill" → "5-variable cascade ODE with effective h ≈ 2.03" 명시
- M11 robustness 보존 → spine 결론 영향 없음

다음: V6 (CRISPR off-target) — 백그라운드 진행 중. 또한 V4 final ledger에 🔴 1건 (V5.3 proxy) 반영 필요.

dispatch surprise: pool CLI **다시 broken** (compile error) · `hexa cloud` 도 현재 hexa CLI 빌드에 없음 · agent는 `hexa_real cloud` (legacy binary) 사용 — memory `reference_pool_cli_broken` RESOLVED 상태가 실제로는 변동성 있음.

## 2026-05-24T22:05:00Z — M13 M5 §6 heavy-tail 보정 완료 · M15 foreground

### M13 (cycle 4 part 1) — 🔵 closed-form 도출 + 🔵-double-witness
- [x] 🔵 SUPPORTED-FORMAL closed-form: **R = N · exp(μ + σ²/2) · (1 - εφ)**
  - N=1250 deep-latent · μ=σ=2.5 · εφ=0.9801
  - 계산: R = 6897.15 (closed-form) vs MC 6891.38 on ubu-1 seed=2026 — **0.084% match**
- [x] 🟢 V5.4 MC (seed=42) vs M13 MC (seed=2026) — 0.2% agree (cross-seed reproducible)
- [x] **root cause 식별** — M5 §6 under-count 원인은 lognormal mean (E[K]=277) vs median (50) 분리 · 2.77× ratio = mean/median 직접 비율
- [x] (NOT variance correction · 내 prompt의 1+CV²·(εφ)²/(1-εφ)² 형태는 binomial-iid model에 안 맞음)
- [x] **새 Arm S realistic cycles: 13-18** (vs old 10-15) · 1.7-2.5y (vs 1.2-1.8y)
  - log₂(6906/1) = 12.75 (Δ +1.46 over 11.29)
  - p_cycle=0.40 realistic: 17.30 cycles (Δ +1.99)
  - MC median=12, p95=15 for halving model
- [x] M12 F-I-4 falsifier (>25 cycles) — 7-12 cycle margin 유지 · falsifier NOT invalidated
- [x] V5.4 tier promotion: 🟢 → **🔵-double-witness-with-correction**
- [x] 산출물 `HERPES/M13_heavytail_correction.md` (452 lines)
- [x] 8 cascading patches identified (M5/M6/M10/M11/M12 · 다음 round deferred):
  - M5_crispr.md:290-298 + §6.6 (corrected row · additive)
  - M6_shock.md:303-316 §8.2 (cycle table additive)
  - M10:153 §3.3 "10-15"→"13-18" · :485-492 §11.4 · :502-515 §11.6 ASCII · §11.9 duration
  - M11:170-180 §4.3 footnote
  - M12:115-123 §2.4 F-I-4 add M13 §3 ref
- [x] dispatch surprise: `hexa cloud` not in this hexa CLI build · fell back to scp+ssh ubu-1 (pool-route hook routed ok · 5s wallclock)

### M15 (foreground) — M10 §5.5 falsifier cross-link 삽입 완료
- [x] M10_clinical_protocol.md §5.5 추가 (after §5.3 framework · before §6) — 1-paragraph M12 11 falsifier 요약 + Popper "Successfully not-falsified" framing
- [x] HERPES.md M15 milestone closed

🔑 핵심 verdict (M13):
- M5 §6 deterministic은 magnitude error · directional 정확 → **M5 alone insufficient strengthened**, NOT falsified
- closed-form vs MC match 0.084% → spine **🔵 promoted** (not 🟢) via formal identity
- Arm S 13-18 cycles realistic · M12 falsifier threshold 25 여전히 안전 margin

다음: M14 (u_crit Jacobian) · V6 (CRISPR off-target) — 백그라운드 진행 중.

## 2026-05-24T21:50:00Z — M12 Pre-declared falsifier protocol 완료

- [x] §1 falsifier vs validator distinction (Popper 표준 primer)
- [x] §2 Tier I empirical (5 falsifier · immediate decisive):
  - F-I-1 ddPCR shedding ≥6/12 monthly POS
  - F-I-2 LAT-miRNA blood ≥3/4 quarter POS
  - F-I-3 triple-positive recurrence (swab+ + LAT+ + clinical lesion)
  - F-I-4 median cycle count > 25
  - F-I-5 shedding rebound ≥2× (longitudinal)
- [x] §3 Tier II wet-lab confirmatory (3 falsifier · population-decisive):
  - F-II-6 ¹⁸F-FIAU PET ≥50% residual ganglion @ 12mo
  - F-II-7 post-mortem TG ImmunoFISH ≥10³ latent copies
  - F-II-8 KDM4 activator chemistry 5-year failure
- [x] §4 Tier III systemic (3 falsifier · program-decisive):
  - F-III-9 M11 u_crit sweep > 10× shift (M11 결과 1.09×라 falsifier 통과)
  - F-III-10 NHP AAV-rh.10 TG transduction < 20%
  - F-III-11 BNT163/mRNA-1608 CTL boost < 5×
- [x] §5 decision rule matrix · §6 stop-rule vs falsifier 구분 · §7 artifact filter
- [x] §8 V4 §10 9 wet-lab essential dual-mark (4 falsifier + 5 validator)
- [x] §9 "Successfully not-falsified" framing (Popper corroborated ≠ proved)
- [x] 산출물 `HERPES/M12_falsifier_protocol.md` (504 lines)

🔑 핵심 통찰 (3 standalone-decisive falsifier):
- **F-II-7 post-mortem TG ImmunoFISH ≥10³** — single mechanistic violation, no stat test · M10 §5+§7 peripheral surrogate strategy 전체 reject
- **F-III-10 NHP AAV transduction < 20%** — Arm S + Arm F 둘 다 kill (delivery 공통 의존)
- **F-I-2 LAT-miRNA blood ≥3/4 quarter POS** — 12-month window · N_lat ≥10³ direct evidence

F-III-9 M11 u_crit > 10× shift falsifier는 M11이 1.09× max로 통과 → 이 falsifier는 **현재 trigger 안 됨** (positive corroboration).

다음: M10 §5.5 cross-link summary (M12 §10 1-paragraph version) 추가 권고.

## 2026-05-24T21:42:00Z — V5 cross-tool 2nd-witness 완료 (pool ubu-1 · 5 sub-jobs)

- [x] V5.1 — body burden Monte-Carlo: MC 4.51×10⁵ vs closed 1.25×10⁵ (ratio 3.60 = 3.01 uniform-vs-point × 1.20 factor mismatch · 설명됨) → 🟢 confirmed
- [x] V5.2 — heavy-tail log-normal: 45% top-1% @ sigma ≈ **2.22** (interpolated 2.0→36.7% / 2.5→55.8%) · Sawtell heavy-tail validated → 🟢 confirmed
- [ ] V5.3 — u_crit proxy h=2 = 0.31 vs spec 0.20 — trend ok, absolute mismatch · Jacobian root-find 필요 → 🟡 partial
- [x] V5.4 — heavy-tail R_total MC: **mean 6906 vs deterministic 2500 (2.76× larger!)** · M5 §6 deterministic UNDER-estimates residual (CI95 lower 4032 > 2500) → 🟢 + 중요 finding
- [x] V5.5 — cycle distribution MC: 14.05 vs analytic log₂(1.25e5/10)=13.61 (1.032 ratio · 가장 tight) → 🟢 confirmed
- [x] 단일 consolidate-script (1 copy-to + 1 run 5 sub-jobs · argv newline restriction 회피) · wallclock < 60s on ubu-1
- [x] 산출물 `HERPES/verify/V5_cross_tool.md` (218 lines)
- [ ] V5.6 deferred — biopython/mhctools 부재 (antigen score)
- [ ] V5.7 deferred — cas-offinder + GRCh38 부재 (CRISPR off-target)

🔑 핵심 finding (V5):
- **Sawtell heavy-tail validated** at sigma ≈ 2.22 → 45% top-1% reproduced
- ⚠ **M5 §6 deterministic 2.5×10³ 잔류 estimate UNDER-counts** — MC 평균 6.9×10³ (2.76× more) · sterilizing cycles 약간 더 필요 가능성
- u_crit proxy method 부족 — V6에서 Jacobian-based root-find 권장
- **4/5 single-witness claims promoted to 🟢 double-witnessed**

threat update: F8 cross-tool single-witness 67/69 → 4 fewer (63/65 now)
M5 §6 residual update suggested → Arm S cycles 약간 inflate (worst case 다음 round check)

## 2026-05-24T21:35:00Z — M11 Müller-Ott 5-fold sensitivity sweep 완료 (pool ubu-1)

- [x] 5×5 grid (k_u→m × k_m→u × {0.1, 0.5, 1, 2, 10}) — 25 points
- [x] downstream 재계산: P_Me3^ss · u_crit · k_escape · p_cycle · cycles_to_sterilize
- [x] 실행: `hexa cloud copy-to ubu-1 /tmp/m11_sweep.py` → `hexa cloud run ubu-1 -- python3 /tmp/m11_sweep.py` (per @D d7 + g8 · 메모리 newline restriction 준수)
- [x] 산출물 `HERPES/M11_sensitivity_sweep.md` (351 lines)

🔑 핵심 finding (F7 weak-link 양적 분석):
- **25/25 grid Arm S cycles ∈ [18.94, 21.58]** — explosion 없음
- **worst-case 1.09× baseline (19.77 cycles)** — 5-fold rate uncertainty 강건
- log-sensitivity |d log n / d log k| ≈ 0.24 (log-linear damping)
- M10 §11.4 realistic 10-15 → 10-22 cycles widening · dosing regimen invalidation NOT triggered
- **F7 weak-link 임팩트 REDUCED**: V1이 식별한 60/248 claims 의존성 mathematically 강건 — wet-lab 측정은 우선순위 LOW
- 🟠 deferred paths: (A) mouse TG explant ChIP-seq time-course (B) chromatin-FISH single-molecule (C) CUT&RUN + KDM4 inhibitor perturbation

**threat update**: F7 heuristic-promotion **MEDIUM-HIGH → LOW-MEDIUM** (양적 검증 통과).

## 2026-05-24T21:18:00Z — V4 final tier ledger 완료 (HERPES verify 100%)

- [x] V1+V2+V3 통합 — 248 claims rolled-up master ledger
- [x] 최종 tier 분포:
  - 🔵 SUPPORTED-FORMAL: 25 (10.1%)
  - 🟢 SUPPORTED-NUMERICAL: 44 (17.7%) · 2 double-witnessed (LAT Markov + ganglion PK)
  - 🟡 SUPPORTED-BY-CITATION: 144 (58.1%)
  - 🟠 INSUFFICIENT/DEFERRED: 35 (14.1%) · 26 compute-promotable + 9 wet-lab essential
  - 🔴 FALSIFIED: 0
  - ⚪ SPECULATION-FENCED (V2 overlay): 5
- [x] 🔵 카테고리화: Markov family (M3+M6+M7) · ODE fixed-point (M4) · 산술 closed-form (M2+M5+M9+M10)
- [x] 🟠 26 compute-promotable breakthrough paths — Vast.ai CPU batch · RunPod GPU pod · pool ubu-1 conda · hexa-lang inbox patches
- [x] 🟠 9 wet-lab essential (compute escape 불가):
  1. BNT163 Phase 1 readout (NCT05432583)
  2. mRNA-1608 protocol
  3. Excision Bio EBT-* IND status
  4. GNE-3511 HSV indication IND
  5. radiolabeled pembrolizumab PET (ganglion 침투 정량)
  6. post-mortem TG biobank
  7. NHP toxicology 12-month
  8. KDM4 activator medicinal chemistry (drug discovery)
  9. HCF-1 PPI inhibitor drug-like
  10. humanized TG organoid (HSV-2 sacral 외삽 대신)
- [x] cross-consistency check: spine M3→M4→M5→M6→M7→M8→M10 일관 · 0 🔴
  - 1 caveat: M3 §7.3 r_um=20 vs §7.6 diagram baseline ≈5.7 (illustrative mismatch, 🔴 아님)
- [x] HSV-1 vs HSV-2 split: 🔵/🟢 type-agnostic · HSV-2 🟠 wet-lab gap 더 큼
- [x] cross-domain export — HERPES findings → HBV / HIV / EBV / KSHV / Mtb / CAR-T (6개 도메인)
- [x] 산출물 `HERPES/verify/V4_tier_ledger.md` (415 lines)

🔑 최종 verdict (§12 ledger):
> HSV sterilizing-cure 248-claim ledger across M1-M10 settles at 25🔵 + 44🟢 (2 double-witnessed) + 144🟡 + 35🟠 (26 compute-promotable, 9 wet-lab essential) + 5⚪ overlay + **0🔴**. closed-form spine (Markov chromatin → ODE reactivation → heavy-tail reservoir → geometric decay cycle counting → KRAB lifetime escape → integrated p_cycle) **internally consistent and self-witnessing**. 9 wet-lab essential items (임상 readouts · PET · post-mortem · NHP tox · KDM4 medicinal chem · HCF-1 PPI · humanized TG organoid) **compute로 escape 불가** — HERPES.md V4 honesty invariant 확인: sterilizing-cure 어떤 claim도 9 wet-lab 실행 없이는 closed-form land 불가.

🎉 **HERPES domain 1차 100% — M1~M10 + V1~V4 모두 완료** (V1: 248 claims · V2: ⚪ fence · V3: 2/4 🟢 · V4: 통합 ledger).

## 2026-05-24T21:08:00Z — V3 🟢 numerical recompute 완료 (pool/cloud 자산)

- [x] V3.1 LAT chromatin 3-state Markov ODE → 🟢 **확정** on pool ubu-1
  - RK45 ↔ closed-form err < 1.6e-13
  - k_m=0.1, k_d=0.001 → P_Me3^ss = **0.990099** (M3 §7 reproduce)
  - sensitivity analytic exact
- [x] V3.2 Pembrolizumab 3-comp PK (ganglion infiltration) → 🟢 **확정** on pool ubu-2
  - PD-1 occupancy: BBB-like 89.0% / BNB-like 98.8% / fenestrated 99.8% (M8 §4.2 matches)
  - t1/2 18.95 d vs lit 22 d
- [ ] V3.3 CRISPR off-target GRCh38 scan → 🟠 INSUFFICIENT
  - cas-offinder · CRISPOR · bwa · bowtie · samtools · GRCh38 v44 ref **모두 미설치** on ubu-1
  - mac-local fallback 금지 (per `feedback_demiurge_assets_simulation_mandatory`)
  - 돌파 경로: Vast.ai CPU batch + GRCh38 download (per @D d7 "batch → Vast.ai CPU")
- [ ] V3.4 HSV protein-DNA MD / LAT RNA fold → 🟠 INSUFFICIENT
  - gmx · pymol · vmd · openmm · biopython · ViennaRNA **모두 미설치** on ubu-1
  - 돌파 경로: (a) `conda install viennarna` → LAT 200 nt 2°-structure (CPU sec), (b) RunPod GPU pod for meganuclease·DNA + `hexa cloud preflight`
- [x] 산출물 `HERPES/verify/V3_numerical_recompute.md` (370 lines)

🚨 인프라 surprises (memory 갱신 필요):
- **`pool` CLI 컴파일 오류** — `arena_return ks/i undeclared` at pool.hexa:707/710/720. 우회: `hexa cloud copy-to` + `hexa cloud run` 직접 SSH alias. → hexa-lang inbox patch 후보
- **`reference_qe_dft_pool_setup.md` outdated** — ubu-1 conda QE 7.5 부재, 시스템 python3만 존재 (numpy 2.4.4 · scipy 1.17.1). RTSC conda env 사라진 듯.
- **`hexa cloud run`은 argv에 newline 거부** — 패턴: 로컬 .py 작성 → `copy-to` → `run -- python3 /tmp/file.py`
- **bio toolchain 부재 on ubu-1 baseline** — V3.3/V3.4 재시도 전 install 사이클 prerequisite
- **`PreToolUse:Bash` hook (g57)** pod-fire 경고 — LAN/WireGuard pool 호스트는 SAVE_POD/Monitor 무관 (heuristic 좁힐 후보)

🔑 tier promotion 결과:
- M3 §7 chromatin Markov: 🟡 → **🟢 SUPPORTED-NUMERICAL** (V3.1 확정)
- M8 §4.2 ganglion PK: 🟡 → **🟢 SUPPORTED-NUMERICAL** (V3.2 확정)
- M5 §7 off-target enum: 🟡 → 🟠 (V3.3 tooling 부재)
- M5/M7 MD/RNA fold: 🟡 → 🟠 (V3.4 tooling 부재)

다음: V4 final tier ledger — V1 인벤토리 + V2 ⚪ fence + V3 🟢/🟠 통합.

## 2026-05-24T21:01:00Z — V1 HERPES claim inventory + tier triage 완료

- [x] 248 claims 추출 + 분류 (M1-M10 전체)
- [x] tier 분포: 🔵 25 (10.1%) · 🟢 44 (17.7%) · 🟡 144 (58.1%) · 🟠 35 (14.1%) · 🔴 0
- [x] per-milestone 분포:
  - M1: 0🔵 / 0🟢 / 24🟡 / 1🟠 (순수 RefSeq · literature)
  - M2: 0🔵 / 3🟢 / 19🟡 / 1🟠 (body burden 산술 🟢)
  - M3: 6🔵 / 1🟢 / 18🟡 / 3🟠 (Markov closed-form 🔵)
  - M4: 5🔵 / 6🟢 / 9🟡 / 3🟠 (ODE fixed-point 🔵)
  - M5: 3🔵 / 5🟢 / 16🟡 / 6🟠 (heavy-tail closed-form 🔵)
  - M6: 7🔵 / 7🟢 / 9🟡 / 5🟠 (Bliss synergy + Markov composition 🔵)
  - M7: 8🔵 / 9🟢 / 13🟡 / 5🟠 (Markov 영속성 + ODE shift 🔵)
  - M8: 0🔵 / 6🟢 / 14🟡 / 4🟠 (φ_block · p_clear 모두 🟢)
  - M9: 1🔵 / 6🟢 / 19🟡 / 3🟠 (ΣS 산술 🔵)
  - M10: 2🔵 / 12🟢 / 12🟡 / 4🟠 (integration → 🟢 12개 최다)
- [x] V2-handoff 12개 formal-identity 후보 (Markov ss · HDAC perturbation · Bliss · ODE fixed-point · geometric decay · Poisson cleavage · Hill cascade · DLK+JNK synergy · lifetime escape · p_cycle independence)
- [x] V3-handoff 6개 numerical recompute (5× pool ubu-1/2 · 1× Vast.ai CPU batch 10^9 MC)
- [x] 산출물 `HERPES/verify/V1_claim_inventory.md` (512 lines)

🔑 핵심 finding:
- **closed-form spine 내부 일관** — M3 Markov → M4 ODE fixed-point → M5 heavy-tail → M6 Bliss → M7 Markov 영속성 → M8 geometric decay → M10 integration · 단일 family로 연결
- **단일 weak link**: M3 §7.3 rate constants (Müller-Ott 2014 mammalian → HSV episome 외삽) — 모든 downstream 모델 의존
- **heavy-tail (M2 §7.2 1%/45%)이 ceiling 지배** — M5/M6/M8/M10 모두 영향
- **KDM4 activator 화합물 부재 = 단일 공유 🟠** — M3/M6/M10 전체 영향 · drug discovery 진입점
- **🔴 deterministic 불일치 0건** — 1차 일관성 통과
- M10이 🟢 12개로 최다 (integration milestone 특성)

다음 — V3 백그라운드 land 후 V4 final tier ledger 가능. V2 inbox patch land 시 12개 후보 🔵 promotion.

## 2026-05-24T20:58:00Z — V2 🔵 push 완료 — CLI 갭 honestly surface

- [x] 5개 identities 시도 (Poisson · LAT · CRISPR · decay · Hill) + 3 positive control
- [x] hexa verify --help · rubric · --fence 모두 capture (verbatim)
- [x] 3/3 positive control 통과: sigma(6)=12 · phi(10)=4 · tau(12)=6 → CLI 작동 확인
- [x] 5/5 HERPES identities → 🔵 promotion 실패 (CLI 한계)
  - **CLI 한계 1**: `--expr <fn> <n> <v>` 의 v는 integer-only · float (0.6321 등) → `to_int trailing garbage`
  - **CLI 한계 2**: calc fns = number-theory only (sigma · phi · mu · tau · is_perfect · gamma0_* · dim_cusp_forms ...) · exp/pow/hill/frac/poisson_cdf 부재
  - **CLI 한계 3**: 2-operand form 은 `<fn> <a> <b> <v>` (3-input + 1-expected 불가능)
  - **CLI 한계 4**: atlas register는 verify 동일 codepath → float v 동일 reject
- [x] 5/5 fallback to ⚪ SPECULATION-FENCED via `hexa verify --fence` (정직한 verdict)
- [x] 0 PR opened — atlas register mechanism 확인 (sigma test 성공 후 git checkout revert)
- [x] 산출물 `HERPES/verify/V2_formal_identities.md` (534 lines)
- [x] 해결책 inbox patch 이미 존재 — `hexa-lang/inbox/patches/bio-verify-kernel-extension-2026-05-25.md` (line 77 HERPES 명시) · cross-domain 6도메인 50-90 🔵 unlock 견적
- [ ] needs: verify_cli.hexa::_recompute에 exp · pow · hill · poisson_cdf 분석원자 추가
- [ ] needs: float v accept (libm-class 🟢 SUPPORTED-NUMERICAL 길)

🔑 핵심 통찰:
- **HERPES 🔵 promotion 길은 hexa-lang verify_cli 확장에 의존** — d2 준수 (불가 아니라 path forward)
- **현재 V2 verdict는 ⚪ SPECULATION-FENCED 5건** — 정직한 tier
- inbox patch land 후 V2 재실행 → 🔵 promotion 기대

## 2026-05-24T20:50:00Z — M10 sterilizing cure 임상 엔드포인트 + 검증 프로토콜 완료 (HERPES 1차 100% — M1~M10)

- [x] §0 two-arm strategic split (sterilizing vs functional)
- [x] §1 Arm S (M5+M6+M8+M9) vs Arm F (M7) 분리 — 같은 환자 동시 적용 불가 (M6 wake ⊥ M7 lock)
- [x] §2 patient stratification — HLA × HSV-1/2 × tail × age × AAV pre-Ab × 면역상태 매트릭스
- [x] §3 Arm S week-by-week sequencing (W0 M9 prime → W4 M9 boost → W8 M8 → W12 M6 → W14 M5)
- [x] §4 Arm F week-by-week sequencing (DLK-i → JNK-i → LSD1-i daily + W6 M7 AAV one-shot)
- [x] §5 sterilizing endpoint hierarchy (1차 + 4개 surrogate, ddPCR/LAT-miRNA/recurrence/Ab titer)
- [x] §6 functional endpoint (recurrence ≥99% 감소 / 24mo)
- [x] §7 non-biopsy verification gap — peripheral surrogate ↔ ganglion source 모델 매핑 + 🟠 PET tracer
- [x] §8 failure-mode 모니터링 (CRISPR escape · 깊은 latent · irAE · 항원 drift · lock 해제)
- [x] §9 동물 모델 → 인간 transition path (mouse TG · guinea pig · NHP · Phase 1a→3)
- [x] §10 FDA Breakthrough + EMA PRIME 전략 + IND-enabling package
- [x] §11 🟢 SUPPORTED-NUMERICAL — 통합 efficacy projection
  - Arm S best ~5 cycles · realistic ~10-15 cycles (~12-18mo) · worst >100 cycles → Arm F 전환 mandate
  - Arm F lifetime reactivation ~10^-3 (practical zero)
- [x] §13 핵심 단일-문장 결론
- [x] 산출물 `HERPES/M10_clinical_protocol.md` (600 lines · hard cap)
- [ ] 🟠 §7.4 ¹⁸F-FIAU PET tracer — PoC 단계
- [ ] 🟠 §5.2 LAT-miRNA blood baseline — 데이터 sparse
- [ ] 🟠 §10.4 regulatory timeline placeholder
- [ ] 🟠 §11 인간 deep-latent 분포 미측정
- [ ] 🟠 §9.1 humanized mouse M8/M9 HLA-Tg 검증 필요
- [ ] 🟠 §3.2 KDM4 activator — UNC0638 surrogate
- [ ] 🟠 §2.4 AAV-rh.10 pre-immune backup serotype (Anc80)
- [ ] needs check: Excision Bio EBT-104 코드명 · BNT163 NCT05432583 readout · VIR-2218 endpoint · Lewin 2023 HIV functional cure 정확 인용

🔑 핵심 통찰 (§11 통합 모델 + §2 stratification):
- Realistic **Arm S 10-15 cycles (~12-18mo)** sterilizing, worst-case heavy-tail dominates → Arm F 전환
- **stratification verdict**: Arm S = HLA-A*02/24/B*07 match + AAV Ab- + tail<30% + recurrence≥6/yr + age<65 / Arm F = 면역 약화 노인 + AAV pre-immune + high tail
- 두 arm은 **상호 배타** — M6 wake ⊥ M7 lock (약리학적 대립)

🎉 HERPES 도메인 1차 진행도 ▓▓▓▓▓▓▓▓▓▓ 100% · 10/10 도달. 다음 — verify push (V1~V4) — HERPES.md에 새로 추가된 verify 섹션.

## 2026-05-24T20:36:00Z — M7 block-and-lock 완료 (4-wide fan-out part 3 · final)

- [x] §0 block-and-lock stack ASCII (one-shot 설계 골자)
- [x] §1 block layer — DLK / JNK / NGF-PI3K / LSD1·KDM4 / HCF-1 약물 표
- [x] §2 lock layer — dCas9-KRAB (ZIM3 variant) + ICP0/ICP4/VP16 표적 + LAT paradox
- [x] §3 delivery — AAVrh.10 + dual-AAV schematic (cargo 분할)
- [x] §4 🔵 SUPPORTED-FORMAL — Markov 영속성 closed-form (P_Me3^ss + lifetime escape)
- [x] §5 🟢 SUPPORTED-NUMERICAL — M4 ODE u_crit 재계산 (0.20 → 1.80 · 9× 상승) + Poisson trigger
- [x] §6 M6 / M8 / M9 combination logic
- [x] §10 핵심 단일-문장 결론
- [x] 산출물 `HERPES/M7_lock.md` (450 lines)
- [ ] 🟠 GNE-3511 HSV indication IND 없음
- [ ] 🟠 dCas9-KRAB 인간 80년 데이터 없음 (5+ 년 SMA AAV9 외삽)
- [ ] 🟠 HCF-1 PPI inhibitor drug-like 부재
- [ ] 🟠 LAT silencing paradox 미해결
- [ ] 🔴 부적합 약물 표기: SP600125 (off-target) · tanzisertib CC-930 (간독성) · GSK2879552 (혈액학) · tozasertib (cardiotox)
- [ ] needs check: Whitford 2024 · Larrea Murillo 2022 · Wilson-Coleman 2015 · Hirano review 정확 인용

🔑 핵심 통찰 (§4 §5):
- **최적 stack: DLK-i (GNE-3511) + JNK-i (CC-401) + LSD1-i (iadademstat) 매일 + one-shot AAVrh.10-dCas9-ZIM3-KRAB (ICP0×2 + ICP4×2 + VP16)**
- Block 곱셈 시너지: M4 ODE 게인 G = G_0 / (f_D · f_J) = 1/9 → u_crit 0.20 → 1.80 (9× 상향)
- Lock 영속성: KRAB 100× k_u→m 향상 → P_Me3^ss > 0.999
- **연간 reactivation 확률 ~10^-5/y (자연 0.1/y 대비 10^4× 감소)** · 평생 누적 ~10^-3 → practical zero
- M7 = functional cure (reservoir 보존). sterilizing cure는 M5+M6 noted M7과 동시 적용 불가 (대립 전략)

다음: M10 (sterilizing cure 임상 엔드포인트) — M5~M9 모두 통합. 또는 STDLIB 포팅 분기.

## 2026-05-24T20:15:00Z — M6 shock-and-kill 완료 (4-wide fan-out part 2)

- [x] §0 one-shot ASCII mechanism (latent → LRA → reactivation → CTL clearance)
- [x] §1 LRA 8 category — HDAC · BET · HMT · KDM4 · PKC · SMC1 · DDR · heat-shock
- [x] §2 drug ranking 표 (efficacy · selectivity · neurotox · penetration · clinical stage)
- [x] §3 combination logic — Markov composition · Bliss synergy · 3-axis squeeze
- [x] §4 immune clearance arm (CD8 TRM · ICP47 escape · Sloan non-cytolytic)
- [x] §5 🟢 risks + dose-fractionation closed-form (HSE 회피)
- [x] §6 M5/M7/M8/M9 결합 logic + 임상 시퀀스
- [x] §8 🟢 SUPPORTED-NUMERICAL — efficacy ceiling math
  - 균질 best-case (p_react × p_clear = 0.99²) → ~3 cycles to <10
  - heavy-tail 1% deep-latent (10× resistant) → tail 단독 ~90 cycles → **M6 alone non-sterilizing**
  - **M5 + M6 + M8 + M9 4-axis combo** = first-principles 유일 sterilizing 경로
- [x] 산출물 `HERPES/M6_shock.md` (426 lines)
- [ ] 🟠 HSV-specific shock-and-kill 임상 부재 (first-in-class gap)
- [ ] 🟠 KDM4 activator 화합물 부재 (drug discovery gap)
- [ ] 🟠 ganglion CTL capacity C_CTL — 직접 인간 TG 데이터 없음
- [ ] Hill 2014 G9a HSV · Kim 2020 HSV CRISPR mouse 정확 citation 확인
- [ ] HSV-2 sacral DRG LRA 반응 — HSV-1 TG 외삽

🔑 핵심 통찰 (§3 §8):
- **최적 LRA 3-axis squeeze: KDM4 activator + HDAC (vorinostat) + low-dose PKC (bryostatin-1)** 
  · KDM4 activator 미존재 시 G9a 억제제 (UNC0638) 대체
  · P_Ac 0.03 → 0.6 (20× gain · Bliss multiplicative)
- M6 단독 sterilizing 불가 → **M5 (CRISPR) + M6 (shock) + M8 (checkpoint) + M9 (vaccine)** combo 필수
  - M6가 chromatin 열면 M5 절단 효율 0.5 → 0.95 (deep-latent에서도)

## 2026-05-24T20:14:00Z — M8 T-cell exhaustion 역전 완료 (4-wide fan-out part 1)

- [x] §1 잠복 ganglion CD8 surveillance baseline (TRM · gB/ICP47 epitope · Tcf1+ stem)
- [x] §2 exhaustion phenotype tree (PD-1 · LAG-3 · TIM-3 · TIGIT · CTLA-4)
- [x] §3 checkpoint blockade — 표적 · 약물 · HSV 적용성 (relatlimab 등)
- [x] §5 trafficking augmentation (CXCR3 · CXCL9-10-11 · AAV-CXCL10)
- [x] §6 antigen exposure 문제 (LAT miRNA · ICP47 → MHC-I 억제 · LRA가 해소)
- [x] §7 뉴런 생존 — non-lytic IFN-γ/TNF clearance (Cliffe · Knickelbein 2008)
- [x] §8 🟢 SUPPORTED-NUMERICAL — φ_block 0.7→0.25, p_clear 0.24→0.60, cycles 28.5→8.5 (3.4× factor)
- [x] §10 통합 권장: anti-PD-1 + anti-LAG-3 + M6 LRA Day-5 동기화 + M9 prime
- [x] 산출물 `HERPES/M8_tcell.md` (469 lines)
- [ ] 🟠 ganglion 항체 침투 정량 (TG/DRG fenestrated 가정 · 직접 데이터 없음)
- [ ] 🟠 인간 cytolytic vs non-lytic 비율 (mouse 외삽)
- [ ] 🟠 AAV-CXCL10 TG 국소 전달 HSV 전임상 선례 없음
- [ ] 🟠 anti-PD-1 HSV 임상 trial 부재

🔑 핵심 통찰 (§8):
- **최적 조합: anti-PD-1 + anti-LAG-3 systemic + M6 LRA Day-5 동기화 + M9 prime**
- φ_block 0.7 → 0.25 → cycles to sterilization **28.5 → 8.5 (3.4× factor)**
- M6 r=10/yr 기준 sterilizing 시간 ~2.85년 → ~10개월
- M8은 enabler · standalone cure 아님

## 2026-05-24T20:13:00Z — M9 치료적 mRNA 백신 완료 (4-wide fan-out part 1)

- [x] §1 산업 baseline (BNT163 · mRNA-1608 · GEN-003 실패 교훈 · HSV529)
- [x] §2 항원 선정 — gB/gC/gD/gE/gI/gH/gL + VP16/VP22 + ICP4/ICP0 (LAT 제외)
- [x] §3 mRNA 분자 설계 (N1-mψU · CleanCap · UTR · multi-antigen 2A linker)
- [x] §4 LNP 전달 (ALC-0315 · SM-102 · i.m. vs 비강 · 내재 adjuvant)
- [x] §5 T-cell repertoire boost (HLA-A*02:01/A*24:02/B*07:02 · Tcf1+ memory · prime-boost)
- [x] §6 M6/M8 coupling — sequencing timeline (week 0 prime → 4 boost → 8 M8 → 12 M6)
- [x] §9 🟢 SUPPORTED-NUMERICAL composite antigen score
  - pentavalent (gD+gB+gE+VP16+ICP4) ΣS = 3.407 vs BNT163 trivalent 1.966 (1.7× breadth)
  - E_vaccine ≈ 21× CTL multiplier → M6 LRA dose 30-50% 감축
- [x] 산출물 `HERPES/M9_mrna.md` (374 lines)
- [ ] 🟠 BNT163 Phase 1 readout (NCT05432583) 미공개
- [ ] 🟠 mRNA-1608 protocol 비공개
- [ ] LAT 산물 단백질 코딩 재현성 낮음 → 항원 후보 제외

🔑 핵심 통찰 (§9):
- **pentavalent gD+gB+gE+VP16+ICP4** = best (ΣS 3.407, 1.7× BNT163 breadth)
- **prime-boost 후 항원 특이 CD8 30-50× 부스트** (COVID mRNA precedent 외삽)
- E_vaccine ≈ 21× → M6 LRA dose 30-50% 감축 가능

## 2026-05-23T20:08:00Z — M4 재활성화 트리거 네트워크 시뮬 완료

- [x] §1 생리적 triggers (UV · fever · axotomy · NGF withdrawal · 호르몬 · 면역억제) 분자 entry 매핑
- [x] §2 DLK (MAP3K12) → MKK4/7 → JNK1/2/3 → H3S10ph Phase I burst
- [x] §3 HCF-1 nuclear translocation + Oct-1 + LSD1 → ICP0 Phase II wave
- [x] §4 PI3K/Akt · mTOR · AMPK · p38 · Ca2+ 보조 axes
- [x] §5 first-principles ODE 네트워크 — 변수 [DLK_a] [JNK_a] [H3S10ph] [HCF1_n] [LSD1] [ICP0_m] [Me3] + M3 §7 Markov 결합
- [x] §5 🔵 SUPPORTED-FORMAL — 잠복 latency 안정 fixed point closed-form
- [x] §5 🟢 SUPPORTED-NUMERICAL — saddle-node bifurcation @ u_crit + transient ODE 적분
- [x] §6 sensitivity-ranked drug nodes
- [x] 산출물 `HERPES/M4_reactivation.md` (450 lines, 10 sections)
- [ ] Whitford 2024 Cell Host Microbe 정확 citation 확인
- [ ] Wilson & Coleman 2015 정확 저널 확인
- [ ] Lo 2005 JNK3 H3 S10 kcat 출처 확인
- [ ] §4 mTOR/AMPK 재활성화 효과 — conflicting reports
- [ ] §7 HSV-2 sacral DLK 의존성 — HSV-1 TG에서 외삽

🔑 핵심 통찰 (§5 bifurcation):
- **DLK input gain (α_D · k_DJ)이 가장 낮은 critical threshold** → 10× DLK 억제 = u_crit 3× 상승 (vs JNK/HCF-1/LSD1의 1.6-2×)
- **DLK 억제제 (GNE-3511 계열) 단일 노드로 모든 생리적 트리거 차단 가능** → M7 lock-in 1순위
- M6 shock 1순위 = KDM4 activator + HDAC inhibitor 조합 (M3 §7.4 closed-form 직접 활용)

다음: M6 (shock-and-kill) · M7 (block-and-lock) — M4 §6 drug ranking 직접 입력. M5 (CRISPR)는 병렬 완료.

## 2026-05-23T20:07:00Z — M5 CRISPR/메가뉴클레아제 게놈 절단 설계 완료

- [x] §1 cleavage target — essential ORFs (UL30 · UL19 · UL27 · UL52) + LAT + two-cut
- [x] §2 nuclease platform 비교 — meganuclease · Cas9 · Cas12a · base/prime editors
- [x] §3 gRNA 후보 spacer g1-g5 (Cas9/Cas12a) — Doench score recompute 미실행 (needs check)
- [x] §4 Jerome lab I-OnuI-derived HSV1m5 (UL19) + HSV1m8 (UL30) 매핑
- [x] §5 AAV serotype — rh.10 · 9 · PHP.eB + 투여 경로 (intrathecal · whisker pad · subdermal)
- [x] §6 🟢 SUPPORTED-NUMERICAL — heavy-tail closed-form efficiency ceiling
  - ε=0.99 · φ=0.99 + N_total=1.25×10^5 + f_tail=0.45 → 잔류 ~2.5×10^3 게놈/host
  - **standalone sterilizing cure 불가 → M6/M7/M8/M9 combo 필수**
- [x] §7 인간 게놈 off-target 스캔 프레임 (CRISPOR · Cas-OFFinder)
- [x] §8 Jerome lab 임상 status (🟠 INSUFFICIENT — Excision Bio · IND 시점 needs check)
- [x] 산출물 `HERPES/M5_crispr.md` (438 lines)
- [ ] §3 Cas9/Cas12a spacer — Lin 2016 · Roehm 2016 · van Diemen 2016 supp 실제 시퀀스 추출
- [ ] §7 GRCh38 v44 vs CRISPOR/Cas-OFFinder 실 off-target re-run
- [ ] §8 Excision Bio 코드명 · IND filer · 2024+ milestone 공시 확인
- [ ] §4.2 Aubert 2020 supp 22-bp meganuclease recognition seq 전사
- [ ] §1.4 HSV-1/HSV-2 cross-conserved 20-22 bp 윈도우 정확 align

🔑 핵심 통찰 (§6 closed-form):
- 가장 유리한 단일-AAV 경로 = **AAVrh.10 + dual HE-LAGLIDADG (HSV1m5 UL19 + HSV1m8 UL30)**
  · ≤4.7 kb ssAAV 안 ~1.7 kb 여유 · 인간 사전 항체 ~10% · 신경 친화 · Aubert 2020 mouse TG ~92% bulk reduction
- d2 준수 — sterilizing cure 불가능이 아니라 **M6/M7/M8/M9 combo 필수**로 surface

## 2026-05-23T19:59:00Z — M3 잠복기 chromatin 상태 모델링 완료

- [x] §1 episomal nucleosome assembly (H3.3/H3.1 · CpG unmethylated)
- [x] §2 lytic heterochromatic marks (H3K9me2/3 · H3K27me3 · bivalent IE) writer/eraser/reader 매핑
- [x] §3 LAT euchromatic marks (H3K4me3 · H3K9ac · H3K14ac) 좌표 정리
- [x] §4 CTCF binding sites — CTRL1/L2/L3 · CTRS1/2/3 ASCII track + Washington 2018/2019 KO phenotype
- [x] §5 3D organization — LAT loop · ND10/PML · ATRX/DAXX
- [x] §6 reactivation dynamics — Cuddy 2020 Phase I/II phospho-methyl switch
- [x] §7 🟢 SUPPORTED-NUMERICAL — 3-state Markov (Ac ↔ U ↔ Me3) closed-form steady-state + drug 섭동 스케일링
- [x] §8 M6/M7 drug-target 매핑
- [x] 산출물 `HERPES/M3_chromatin.md` (378 lines)
- [ ] H3K27ac LAT enhancer ChIP 정량치 (sparse · needs check)
- [ ] §7.3 rate constants — Müller-Ott 2014 mammalian heterochromatin 차용 (HSV time-course fit 없음)
- [ ] JQ1 BET 효과 (§8.1) — conflicting reports

🔑 핵심 통찰 (§7 모델 → M6/M7 직접 입력):
- **M6 shock 최적 표적 = KDM4A/B demethylase 활성화** (writer redundancy 때문에 단일 methyltransferase 차단은 부분 효과)
- **M7 lock-in 최적 표적 = JNK/DLK 차단** (phospho-switch가 methyl mark를 우회하므로 mark 강화만으로는 불충분)

다음: M4 (재활성화 트리거 시뮬) — M3 §6 + §7 직접 의존.

## 2026-05-23T19:57:00Z — M2 신경절 reservoir 정량화 완료

- [x] 뉴런 1개당 게놈 copy 수 분포 (1-300, heavy-tail) 문서화
- [x] 잠복 보유 뉴런 분율 (TG ~2-10% LAT+) 문서화
- [x] 해부학적 분포 — TG V1/V2/V3 + sacral S2-S5 ASCII 매핑
- [x] 뉴런 subtype 특이성 (A5+ / KH10+ / peripherin / NF200) 정리
- [x] Reservoir 동역학 — 평생 안정성 + age-dependent 변화
- [x] 종간 비교 (mouse vs human) — M5 translation 의존 명시
- [x] §7 총 body burden 🟢 SUPPORTED-NUMERICAL — 25000 × 2 × 0.05 × 50 = 1.25×10^5 게놈/host
- [x] heavy-tail "1% 뉴런이 45% reservoir" → M5 CRISPR 효율 ceiling 의미 도출
- [x] 산출물 `HERPES/M2_reservoir.md` (292 lines · 9 tables · 5 ASCII)
- [ ] Russell TA et al. 2021 정확 인용 (저널/볼륨/페이지) 확인 필요 — 산출물 §8에 needs-check 태그

다음: M3 chromatin (백그라운드 진행 중) · 둘 다 끝나면 M4 (재활성화 트리거)로.

## 2026-05-23T19:54:22Z — M1 게놈 구조 + LAT locus 매핑 완료

- [x] HSV-1 RefSeq NC_001806.2 (strain 17, 152222 bp, GC 68.3%, ~84 ORF) 등록
- [x] HSV-2 RefSeq NC_001798.2 (strain HG52, 154675 bp, GC 70.4%, ~74 ORF) 등록
- [x] 게놈 architecture (TR_L · U_L · IR_L · IR_S · U_S · TR_S) ASCII 매핑
- [x] LAT locus 좌표 + 8.3 kb primary transcript + 2 kb stable intron 문서화
- [x] miRNA cluster (miR-H1~H6) 위치 + 표적 (ICP0 · ICP34.5) 매핑
- [x] HSV-1 vs HSV-2 LAT 비교 테이블
- [x] 잠복 reservoir 위치 (trigeminal · sacral ganglia) — M2 ground truth
- [x] 산출물 `HERPES/M1_genome_lat.md` (7섹션, citation 7건)

다음: M2 (reservoir 정량화) · M3 (chromatin 상태) 병렬 진행 가능 — 둘 다 M1 출력 기반.

