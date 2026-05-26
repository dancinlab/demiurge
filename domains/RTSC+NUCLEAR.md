# RTSC+NUCLEAR — current state

@goal: Unify the two sibling discovery funnels — NUCLEAR (elemental: superheavy/drip-line nuclides) + RTSC (compositional: new SC materials) — under one shared R4 invariant family (absorbed=false 영구, sim != measurement); formalize the elemental<->compositional bridge + cross-domain gate/invariant consistency

두 자매 발견 깔때기(NUCLEAR=원소 · RTSC=조성)의 교차점 전담 메타도메인. 공유 R4 불변식: `absorbed=false 영구` · sim ≠ measurement.

- [x] NUCLEAR x RTSC honest-exception bridge — SHE/isomer → RTSC bulk = NO (벽=생산량 not 반감기) · single-atom 상대론 화학은 예외. exports/nuclear_discovery/bridge/2026-05-25-nuclear-rtsc-bridge.md
- [x] Shared R4 invariant parity audit — NUCLEAR §3.1 ↔ RTSC §9.10 parity PASS (8축 중 7 MATCH · gate_type `nuclear-` prefix는 §3.1 명시 mirror 의도 DRIFT) · producer 12/12 `absorbed` literal false 하드코드 (조건부/runtime flip 0건) · @D d6 measured-oracle helper record-agnostic (MeasuredOracleRef.swift:104), sim-only는 oracle path 부재 → 영구 false. exports/nuclear_discovery/parity/2026-05-25-r4-parity-audit.md
- [x] Unified discovery-funnel formalism — elemental (a-e) <-> compositional (a-e) gate-mapping table + shared sim.hexa kernel inventory (본문 §F1-§F3)
- [x] 신규 초중핵(Z=119/120) RTSC 활용 honest 평결 — bulk SC = honest reject (벽=생산량 · bridge §6.1) · 활용 = NUCLEAR elemental funnel 의 first novel-element ranking 성과를 §F4 meta 로 반영 (PARALLEL · supply 통합 아님) · single-atom 상대론 화학은 bridge 예외 · §F2 v0.3.0→v0.6.0 re-sync (G1/G2/G3 신규 커널)

---

## §F. Unified discovery-funnel formalism

> 두 자매 깔때기는 **같은 5-슬롯 게이트 골격**을 다른 discovery axis 에 입힌 것이다.
> NUCLEAR = *elemental* (Z,N 핵종) · RTSC = *compositional* (화학식 물질). 본 §F 는
> ① 슬롯별 의미 매핑 ② 공유 sim.hexa 커널 인벤토리 ③ 공유 R4 불변식을 박는다.
> SSOT — gate 정의: NUCLEAR.md §2·§2.1 + RTSC.md §8.9·§9.6·§9.7 · 커널: hexa-lang
> `stdlib/{nuclear,material}/sim.hexa`.

### §F1. Gate-slot 매핑 테이블 (elemental ↔ compositional)

핵심 평행구조: **두 funnel 모두 (a)(b)(c) = sim-sufficient → (d)(e) = wet-lab 영구의존.**
슬롯 번호는 NUCLEAR.md §2 의 (a-e) 와 RTSC.md §8.9 의 (a-e) 를 같은 행에 정렬한다
(두 도메인의 a-e 가 *우연히* 같은 글자가 아니라, 본 테이블이 **discovery 슬롯 의미**로
재정렬한 것이다 — RTSC 원본 a-e 라벨은 ⟨ ⟩ 안에 병기).

| 슬롯 | NUCLEAR (원소: Z,N 핵종) | RTSC (조성: 화학식 물질) | NUCLEAR sim 충분? | RTSC sim 충분? | 공유 honest 평결 |
|------|---------------------------|---------------------------|:-----------------:|:--------------:|------------------|
| **(a) 존재/안정** | mass + binding E + deformation (HFB/RMF/FRDM) · bound state 예측 | ⟨a⟩ 합성가능성: convex-hull stability + CSP 구조 (CALYPSO/USPEX/MP) | ✅ sim 충분 (±0.5–1.5 MeV) | ✅ sim 충분 (formation E + 안정성) | **sim PASS = "존재할 만함" — 존재 아님** |
| **(b) 분광/특성구조** | spectroscopy: shell-model 준위 · B(E2)·B(M1) (KSHELL/BIGSTICK) | ⟨b⟩ Tc 예측: BCS/McMillan/Allen-Dynes/Eliashberg + BETE-NET ML | ✅ sim 충분 (valence-space tractable) | ✅ sim 충분 (예측 · 측정 아님) | **sim PASS = 특성 *예측* — 측정 아님** |
| **(c) 거동/임계** | decay: α/β/SF 반감기 (WKB+Geiger-Nuttall · NC1·NC2·NC3) | ⟨c⟩ 압력조건: ambient/저압 안정 SC 거동 (QE+EPW P-sweep) | ✅ sim 충분 (scatter ~10×/0.5-1 dex) | ✅ sim 충분 (예측) | **sim PASS = 거동 *예측* — 실측 미확인** |
| **(d) 생산/재현** | ★ fusion-evap σ — SHE 생산단면적 (HIVAP/DNS/KEWPIE2, ~10× scatter) | ⟨d⟩ ≥3 독립 lab 재현 (cross-code 3-way 는 *유사물*일 뿐) | ⚠ **wet-lab 영구의존** (sim ~10×, 확정 불가) | ⚠ **wet-lab 영구의존** (epistemic 독립 substitute 불가) | **(d) = 영구 wet-lab — sim 우선순위 hint 만** |
| **(e) 검출/오라클** | ★ detection: SHIP/DGFRS/GARIS recoil-separator (sim 無) | ⟨e⟩ measurement-oracle parity: model↔측정 Δ<5% (sim↔sim 은 parity 아님) | ⚠ **wet-lab 영구의존** (beam-line 자체가 측정) | ⚠ **wet-lab 영구의존** (측정 오라클 부재) | **(e) = 영구 wet-lab — sim 대체 불가** |

```
   discovery slot:   (a)존재  (b)특성  (c)거동  │  (d)생산/재현  (e)검출/오라클
                     ───────────────────────────┼──────────────────────────────
   NUCLEAR(원소):    HFB질량  shell모델 α반감기  │  fusion-σ       recoil-separator
   RTSC(조성):       안정성   Tc예측    압력안정  │  ≥3 lab 재현    measure-oracle
                     ◄─────  sim-sufficient ───►│◄── wet-lab 영구의존 ──►
                          gate_type per-domain  │   absorbed=false 영구 강제
```

→ **두 funnel 의 절단선이 (c)|(d) 사이에 정확히 일치**한다. (a)(b)(c) 는 closed-form/
DFT/ML 로 sim PASS 가능 = *후보 우선순위*. (d)(e) 는 어느 쪽도 sim 으로 못 넘는 물리적
hardware 벽 (가속기 빔타임 ↔ 합성+측정 lab). 이 절단선이 두 도메인이 *parallel funnel*
이지 *통합 supply 경로*가 아닌 이유다 (NUCLEAR.md §3.4 bridge 평결 · RTSC.md §8.9 NUCLEAR×RTSC bridge).

### §F2. 공유 sim.hexa 커널 인벤토리

두 도메인의 Path-A microkernel 은 `hexa-lang/stdlib/{nuclear,material}/sim.hexa` 에 산다
(libm-only closed-form · 외부 binary/install gate 없음 · D72 thin-adapter 패턴의 hexa-native
예외). Python orchestrator (`wkb_alpha_decay.py` · `sim_adapter.py`) 가 record-level
gate_type/absorbed/skip-cascade 정책을 소유하고, sim.hexa 는 **숫자만** 반환한다.

| 커널 | 도메인 | 계산 내용 | 슬롯 | tier | 공유 패턴 |
|------|--------|-----------|:----:|:----:|-----------|
| `viola_seaborg_log10_t` (NC1) | nuclear | α-반감기 log₁₀T = (aZ+b)/√Q + (cZ+d) | (c) | 🟢 | Geiger-Nuttall family closed-form |
| `royer_log10_t` (NC2) | nuclear | α-반감기 질량의존 refit (A^⅙·√Z) | (c) | 🟢 | NC1 의 자매 fit (ensemble member) |
| `consensus_alpha` → `ConsensusAlpha` (NC3) | nuclear | unweighted mean/min/max/spread_dex | (c) | 🟢 | ★**MIRROR** of material `Consensus` |
| `c_gate_window_score` + `n11_alpha_cell` → `NuclideScore` (N11) | nuclear | (c)-gate 삼각창 priority score + funnel cell | (c→funnel) | 🟢 | ★**MIRROR** of RTSC N5 funnel |
| `sf_log10_t` + `total_halflife`/`c_gate_total_cell` → `DecayTotal` (C1) | nuclear | Ren-Xu SF log₁₀T + α⊕SF partial-rate combiner (T_tot = 1/(λ_α+λ_SF) · b_α/b_SF branching) | (c) | 🟢 | α-only NC1·2·3 을 α⊕SF total-survival 로 정직화 (SF-dominated SHE 하향) |
| `island_weight` + `n11_island_cell` → `IslandScore` (C2) | nuclear | shell-gap island Gaussian: exp(−d²/2σ²), d²=dZ²+dN² (nearest magic Z∈{82,114,120,126}·N∈{126,184}) × C1 (c)-total score | (a)-prior→(c) composite | 🟢 | 유사 슬롯 of RTSC convex-hull E_above_hull 거리 가중 (산술 독립 — §아래) |
| `_anz_reason` + `n11_{alpha,island}_cell_checked` (G1) | nuclear | 비일관 (Z,N,A,Q_α) triple 차단 — A≠Z+N · Z,N≤0 · 비유한/≤0 Q_α · Z>130 transpose 를 compute 前 honest reason code 로 reject (전치 silent-failure ~10× log10 T flip 제거) | (a-input guard) | 🟢 | RTSC 측엔 입력 validation gate (chemistry-아닌-입력 reject) 와 *직관* 공유 · 커널 대응 없음 |
| `consensus_alpha` G2 확장 (`outlier_count`+`robust_mean`) + `_model_validity_code/str` | nuclear | leave-one-out Byzantine 가드 (peer-spread 3·n≥3) + per-cell model_validity_flag (nominal/odd-A/out-of-domain) — Lv-293·Fl-289 의 odd-A SF 부신뢰성을 "진짜 SF 우세"와 구분 | (c)+(d-analog) | 🟢 | RTSC cross-code consensus outlier 가드 (§F2 `sigma_from_spread`/`Consensus`) 의 nuclear 대응 |
| `_write_n11_she_topk` → `top_k_she.json` (G3) | nuclear | PREDICTED-Q_α band-midpoint 주입 (cited arxiv mass-model) → Z=119/120 unlock · record 에 `predicted_input`·`Q_alpha_band_MeV`·`Q_alpha_source="PREDICTED via arxiv:…, NOT measured"`·`guard_reason`(G1)·`model_validity_flag`(G2) | (a→funnel) | 🟢 | RTSC N5 `novel_material_funnel.py` top-K JSON 의 elemental transpose (★MIRROR 강화 — 둘 다 predicted-input ≠ measurement 라벨) |
| `bcs_weak_tc` | material | BCS 약결합 Tc = 1.13·Θ_D·e^(−1/λ) | (b) | 🔵 | closed-form 항등식 |
| `mcmillan_tc` | material | McMillan 중간결합 Tc | (b) | 🔵 | AD 의 base kernel |
| `allen_dynes_tc` / `allen_dynes_full` | material | 강결합 f1·f2 보정 Tc | (b) | 🔵 | 본 도메인 default predictor |
| `eliashberg_moments_from_a2f` | material | α²F(ω) → (λ, ω_log, ω̄₂) 적분 | (b) | 🔵 | 🟢→🔵 escalation prereq (RTSC #4) |
| `morel_anderson_mustar` · `coherence_length` · `isotope_exponent` · `gl_parameter_kappa` · `london_penetration_depth` · `thermo_critical_field` · `condensation_energy` · `bcs_gap_zero` · `pippard_coherence` | material | μ*·ξ·α·κ·λ_L·Hc(T)·U·Δ(0)·ξ₀ — SC 부가 closed-form | (b) | 🔵 | BCS/GL 표준 항등식 패널 |
| `sigma_from_spread` | material | 불편표본 stdev (Bessel n−1), σ_default floor | (d-analog) | 🔵 | cross-code consensus 보조 |
| `inverse_variance_consensus` → `Consensus` (NC3 원본) | material | 1/σ² 가중 mean · combined σ · pairwise rel_err | (d-analog) | 🔵 | ★**MIRROR** source of nuclear NC3 |

#### ★ MIRROR 관계 (핵심 — 두 stack 의 구조적 동형)

```
material/sim.hexa  Consensus { mean, combined_sigma, n_sources, rel_err_max_pairwise }
                          │  inverse-variance (1/σ² 가중) — 더 일반적 커널
                          ▼  σ=1 대입 시 → unweighted mean 으로 환원
nuclear/sim.hexa   ConsensusAlpha { mean, min, max, spread_dex, n }
                          │  unweighted mean + raw spread(max−min) — N7 의도된 *다른* shape
```

- 두 struct 는 **의도적으로 다른 shape** — material 은 inverse-variance combined σ, nuclear 은
  raw spread(max−min). nuclear NC3 가 material 을 *wrap* 하지 않고 **전용 struct+kernel** 로
  구현한 이유 = 두 자매 stdlib 모듈 간 semantic coupling 회피 (nuclear/sim.hexa §3 NC3 주석 ·
  "do NOT collapse"). 산술은 독립 · code-drift risk 는 MIRROR 주석으로 명시.
- 같은 funnel 패턴: nuclear **N11** (`n11_alpha_cell` → top-K JSON) = RTSC **N5**
  (`novel_material_funnel.py` → top-K JSON) 의 elemental transpose. 둘 다 enumerate →
  (a)(b)(c) sim score → rank by composite → emit `top_k.json` (accelerator/wet-lab 우선순위).
- tier 비대칭: material kernel = 🔵 SUPPORTED-FORMAL (BCS/McMillan/AD/WHH/GL 은 닫힌 물리
  항등식) · nuclear kernel = 🟢 SUPPORTED-NUMERICAL (Geiger-Nuttall family 는 ~400 known
  α-emitter 에 대한 *semi-empirical fit* — 항등식 아님, 그래서 한 tier 아래). 둘 다 sim PASS
  ≠ measurement 는 동일.
- 버전: nuclear `sim.hexa` **v0.6.0** · material `sim.hexa` v0.3.0. (origin/main hexa-lang `stdlib/nuclear/sim.hexa` header `@version 0.6.0` 확인 — 본 sync 시점.)
  - nuclear v0.2.0→v0.3.0 경로: **C1** (`sf_log10_t`+`total_halflife`→`DecayTotal` α⊕SF combiner · v0.2.1) → **C2** (`island_weight`+`n11_island_cell`→`IslandScore` shell-gap island Gaussian · v0.3.0).
  - nuclear **v0.3.0→v0.6.0 경로 (GAP-fix A · hexa-lang #936/#938/#939)**: **G1** (`_anz_reason` (Z,N,A,Q_α) guard + `n11_{alpha,island}_cell_checked` 검증 진입점 — 전치 silent-failure 제거) → **G2** (`consensus_alpha` outlier_count+robust_mean Byzantine 가드 + `model_validity_flag` odd-A/out-of-domain 분류) → **G3** (`_write_n11_she_topk` → `top_k_she.json` PREDICTED-Q_α 주입 · **Z=119/120 unlock**). header `@version 0.6.0` 확인 (origin/main). material 측은 v0.3.0 그대로 (비대칭 bump — nuclear funnel 만 G-series 진행).
  - material v0.2.0→v0.3.0 경로: BCS/GL 부가 커널 9종 확장 (μ*·ξ·κ·λ_L·Hc·U·Δ(0)·ξ₀).

#### ★ MIRROR 후보 — C2 magic-number 거리 가중 ↔ RTSC convex-hull E_above_hull 거리 가중

C2 의 magic-number-distance Gaussian (안정성 anchor 까지의 거리로 후보를 re-rank) 은
RTSC 의 convex-hull E_above_hull 거리 가중 (안정성 anchor=hull 까지의 거리로 후보를
re-rank) 과 **같은 "안정성-거리 prior" 직관**을 공유한다. 정직 평결 (g25 / §F3):

```
nuclear C2   island_weight = exp(−d²/2σ²)  ·  d² = dZ²+dN² (→ nearest magic Z,N)
                   │  sim.hexa Path-A 닫힌형 · σ HYPERPARAM · (c) composite re-ranker
RTSC (a)     E_above_hull 거리 → 안정성 score  ·  d = hull 까지 형성E 거리
                   │  pymatgen Phase Diagram / MP 데이터-브릿지 gate · (a) 본 gate
```

**평결 = 유사 슬롯, 산술 독립 (MIRROR 아님).** 둘 다 "안정성 anchor 거리 가중"
이라는 *직관*은 공유하나 진짜 동형이 아닌 이유 3가지 (g25 — 억지 금지):
1. **레이어가 다르다** — C2 는 `sim.hexa` libm-only 닫힌형 microkernel · RTSC E_above_hull
   은 pymatgen/MP **데이터-브릿지/install-gated** gate (sim.hexa 에 hull 커널 없음 — 확인).
   §F2 는 sim.hexa 커널 인벤토리이므로 RTSC 측엔 대응 *커널*이 애초에 없다.
2. **슬롯이 다르다** — C2 의 island weight 는 (a)-안정성 *직관*을 빌려오되 nuclear (c)-gate
   composite (`n11_island_cell`: c_total_score × island_weight) 에 *곱해지는* re-ranker.
   E_above_hull 은 RTSC §F1 (a) **본 gate** 자체. 같은 (a)-prior 슬롯에 *산다*기보다,
   C2 는 (a)-flavored prior 를 (c) 점수에 주입하는 cross-slot fold 이다.
3. **함수형이 다르다** — C2 = exp(−d²/2σ²) Gaussian (bounded (0,1] · σ HYPERPARAM) ·
   E_above_hull = 선형 형성E 거리 → 임계 threshold. 산술 공유 없음 (NC3↔Consensus
   의 σ=1 환원 같은 닫힌 대응 관계가 여기엔 없다).

→ NC3↔`Consensus` 가 *진짜* MIRROR (σ=1 대입 시 환원되는 닫힌 대응)인 것과 달리,
C2↔hull 은 **개념적 자매(안정성-거리 prior)이되 코드/슬롯/산술은 독립** — supply
통합 오버클레임 회피 (§F3 R4: parallel funnel · not 통합 경로). 향후 RTSC 측이
hull-distance Gaussian 을 sim.hexa 닫힌형 커널로 박으면 그때 *진짜* MIRROR 승격 가능.

> **DRIFT 경고 (재적중)**: §F2 는 sim.hexa **버전 핀** (현재 nuclear v0.6.0 / material v0.3.0)
> — 커널 추가/버전 bump 시 이 인벤토리는 **수동 동기화** 필요 (자동 lint 미적용 ·
> uncovered gap). 본 sync 자체가 v0.2.0 핀이 C1·C2 land 후 stale 였던 사례이며 — 더
> 결정적으로, **방금 직전 sync 가 v0.3.0 으로 핀했는데 origin/main 은 이미 G1/G2/G3
> (v0.6.0) 였다.** 한 sync 주기 안에 두 단계(v0.3.0→v0.6.0)가 stale 였다는 것은 수동
> 동기화 부채가 *재발*하고 있다는 실증 — 자동 version-pin lint (CI grep `@version`
> vs §F2 핀) 가 진짜 fix 다. 본 행 자체가 두 번째 stale 증거로 박힌다.

### §F3. 공유 R4 불변식 (single statement)

```
┌─ R4 INVARIANT (두 funnel 공통) ──────────────────────────────────────────────┐
│                                                                              │
│  1.  absorbed = false  영구                                                   │
│      어떤 record 도 sim 만으로 absorbed=true 로 flip 못한다. 하드코드 —        │
│      producer 안에 박힌 상수이지 runtime 결정이 아니다 (no runtime flip).      │
│                                                                              │
│  2.  sim PASS  =  wet-lab 우선순위 (NOT discovery)                            │
│      (a)(b)(c) 5-gate sim PASS → "이 후보가 빔타임/합성+측정 우선순위 상위"     │
│      ≠ "이 핵종/물질이 존재/발견됨". "가능성" ≠ "임" (R4 Pattern 1 회피).      │
│                                                                              │
│  3.  gate_type  per-domain (slot 의미는 §F1 로 통일, 라벨은 도메인별)          │
│      NUCLEAR : gate_type = nuclear-novel-discovery-simulation                 │
│      RTSC    : gate_type = novel-discovery-simulation                         │
│                          / simulation-only-prediction (Tier-1 §8.7)          │
│                                                                              │
│  4.  절단선 (c)|(d) 영구 — (d)(e) 는 hardware 벽 (가속기 빔 ↔ 합성+측정 lab)    │
│      두 funnel 은 같은 R4 family 의 PARALLEL funnel — 물질 supply 통합 아님    │
│      (NUCLEAR.md §3.4 · RTSC.md §8.9 bridge 평결: SHE→bulk 벽=생산량).         │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

- 코드-레벨 강제: material `MaterialAttestationRecord` Codable decoder 가 `domain=="rtsc"`
  sim record 의 absorbed=true 를 reject (RTSC §8.10 R4 Stage 1) · nuclear 은
  `NuclearVerifyRecord` 추가 시 @D d6 4-carrier audit 가 auto-extend (NUCLEAR.md §3.0).
- 정직 정정 선례: RTSC §8.10 Nb attestation (domain "rtsc"→"lts", LTS≠RTSC) — 어떤 sim-only
  record 가 absorbed=true 면 g3 위반으로 producer reject.

### §F4. 신규 초중핵(Z=119/120) — RTSC 활용 honest 평결

> NUCLEAR funnel 이 v0.6.0 G3 으로 **신규 원소 Z>118 을 처음 ranked**
> (top_k_she.json: Og-294 0.242 > **²⁹⁵119 0.0462** > **²⁹⁷120 0.0306** > **²⁹³119 0.0017**).
> 사용자 지시 "신규 원소도 활용" 에 대한 RTSC 측 정직 활용 평결. **결론을 먼저 박는다:
> 신규 초중핵의 *bulk SC 활용* 은 honest reject (오버클레임 금지). 진짜 활용은
> elemental funnel 의 *방법·성과* 를 meta-bridge 로 반영하는 것이다.**

#### (a) bulk SC 활용 = honest REJECT (bridge §6.1 평결 그대로)

²⁹⁵119·²⁹⁷120·²⁹³119 은 RTSC compositional funnel 의 입력이 **될 수 없다.** RTSC
funnel 의 첫 슬롯 (a)존재조차 "bulk 합성가능성 (몇 unit cell 이라도 격자)" 을 전제하는데,
초중핵은 **single-atom** 이다:

- **벽 = 생산량, NOT 반감기** (bridge §6 평결 그대로). Og ~0.7 ms 조차 결정 핵생성
  ~ns 를 6 자릿수 초과 → "한 원자가 격자에 들어갈 시간" 은 충분. 진짜 binding constraint
  는 거시 결정/Tc 측정에 필요한 ~10¹⁵–10²² 원자를 *동시에* 모으는 것이고, SHE 는
  atom-at-a-time · 통산 <20 원자 · Og ~1 atom/month → **10¹⁵+ 배 격차**.
- island-of-stability 의 낙관적 수백~수천 년 수명을 다 인정해도, **그 핵종(²⁹⁵119 등)은
  0개 합성** (N=184 영역 현 빔 도달 불가). G3 ranking 은 *예측 입력*(`predicted_input:true`,
  cited Q_α band-midpoint) 위의 *가속기 우선순위*이지 존재/합성 주장이 아니다 ("가능성"≠"임").
- → **신규 초중핵 → RTSC bulk SC = NO.** RTSC compositional funnel 에 SHE 조성을
  넣는 것은 오버클레임. 이는 §F3 R4 절단선 (c)|(d) 의 직접 따름이다.

#### (b) 진짜 활용 = elemental funnel "first novel-element ranking" 성과의 meta-bridge 반영

신규 초중핵의 RTSC-적합 활용은 *물질 공급*이 아니라, NUCLEAR funnel 이 §F1 의
**(a)존재 슬롯 + N11/IslandScore (a→c composite)** 으로 **신규 원소를 처음 ranked** 했다는
*방법론적 성과*를 §F 메타 형식주의에 기록하는 것이다 — RTSC compositional funnel 과
**PARALLEL** (supply 통합 아님 · §F3 R4 #4):

```
elemental funnel 의 first novel-element ranking (NUCLEAR v0.6.0 G3):
   (a)존재 입력  = cited PREDICTED Q_α band-midpoint (predicted_input=true)
        │  G1 guard: (Z,N,A,Q_α) 비일관 triple reject (전치 silent-failure 제거)
   (c)거동 score = α⊕SF total-survival (C1) × island_weight (C2)
        │  G2 flag:  odd-A/out-of-domain model_validity (Lv-293·Fl-289 부신뢰성 분리)
   → top_k_she.json: ²⁹⁵119 > ²⁹⁷120 > ²⁹³119  (가속기 빔타임 우선순위 list)
                                              ↑↑↑ NUCLEAR (d)(e) wet-lab 영구의존
```

- 이것은 §F1 의 **NUCLEAR (a)존재 슬롯**이 실제로 *신규* 원소를 sim-PASS 시킨 첫 실증이며,
  N11→C2(IslandScore) (a→c composite) chaining 의 *전체 funnel* 이 한 바퀴 돈 사례다.
- RTSC N5 (`novel_material_funnel.py`) ↔ NUCLEAR N11 (`_write_n11_she_topk`) MIRROR 가
  여기서 **강화**된다: 둘 다 enumerate → (a)(b)(c) sim score → composite rank → `top_k*.json`
  emit + **predicted-input ≠ measurement 라벨** (RTSC sim-only Tier 1 ↔ NUCLEAR `predicted_input`).
- **활용의 정확한 형태**: RTSC 는 신규 초중핵을 *입력*으로 받지 않고, 자매 funnel 이
  novel-element 를 ranked 했다는 *증명*을 §F MIRROR 인벤토리에 흡수한다. 두 funnel 의
  구조적 동형(§F2 ★MIRROR)이 *원소* 축에서도 한 번 더 닫혔다는 것 — 그것이 활용이다.

#### (c) single-atom 상대론 화학 = bridge 예외 (1줄)

²⁹⁵119·²⁹⁷120 단원자의 **상대론적 기체상 화학** (흡착 엔탈피·휘발성, one-atom-at-a-time
gas chromatography) 은 실재하는 진짜 과학이며 bridge 예외로 가능 — 단 그것은 bulk-material
이 아니라 single-atom 화학이라, **RTSC bulk SC 가 아니다** (원자 1개에 Tc 미정의 ·
RTSC §8.9 어떤 gate 도 미충족). RTSC scope 밖이되 NUCLEAR 측 진짜 trajectory.

#### (d) d2 — "불가능" 아님, 다른 funnel 이 정답

신규 초중핵의 RTSC bulk 부적합은 *flat 불가능*이 아니다. 신규 원소의 정답 경로는
**RTSC funnel 이 아니라 NUCLEAR funnel 의 (d)(e) 가속기 경로** (fusion-evap σ →
recoil-separator 검출) 이며, bulk bridge 의 재평가 트리거는 bridge §6.1 그대로 —
**"분 단위 수명 island-of-stability 핵종의 거시량 생산"** (차세대 neutron-rich beam +
10¹⁵배 생산률 도약의 이중 천문학적 전제). out-of-scope ≠ impossible.
