# TTR-ORAL M3 — breakthrough path C + D 심층 (lymphatic lipid · ink-homing NP)

> milestone: TTR-ORAL.md M3-ORAL "site-specificity 돌파 메커니즘 short-list — lymphatic-targeting lipid · ink-homing NP"
> base: `oral_feasibility_scope.md` (4 path 개요) — 본 문서는 그중 **C (림프 표적 지질제형)** · **D (잉크-호밍 경구 NP)** 두 경로를 first-principles 로 심층.
> 정직 원칙 (@D d2/d5/d6): "된다"를 압력으로 강제하지 않음. C/D 는 4 path 중 **가장 약한 두 경로**임을 명시하고, 그럼에도 정량적으로 어디까지 닫히고 어디서 막히는지 기록.

## TL;DR

- **Path C (림프 지질제형)**: long-chain TG 제형으로 친유성 cargo (logP > 5) 를 chylomicron 에 실어 **장 림프관 → 전신 림프** 로 우회 (간 first-pass 회피). lymph:plasma 比 최대 ~10-100× 까지 보고 (halofantrine·testosterone undecanoate 선례). **그러나 표적은 "전신 림프 일반"이지 "타투 배출 림프"가 아님** — 정밀도 path A ≪. 잉크가 모이는 sentinel node 와의 동선 겹침은 우발적·미미. honest 판정 **🟠** (림프 일반 도달은 🟢, 타투-특이 도달은 🟠).
- **Path D (잉크-호밍 NP)**: 두 벽이 직렬(stacked) — (i) 경구 NP bioavailability 본질적 ~0.1-1%, (ii) 흡수돼도 deep dermal ink site 로의 호밍이 perfusion/diffusion-limited. 두 작은 분율의 **곱**이 표적 도달 = ~10⁻⁵-10⁻⁴. ink-affinity 화학(π-stacking·catechol·metal-oxide ligand) 은 in vitro 결합은 닫히나 in vivo 도달이 안 됨. honest 판정 **🟠** (개별 화학 🟢, 통합 경로 🟠).
- **C vs D 순위: C > D.** C 는 검증된 림프 PK 메커니즘 위에 서 있어 적어도 "전신 림프 도달"은 닫힌다. D 는 두 벽의 곱으로 도달 분율이 한 자릿수 ppm 수준 → **4 path 중 최약**.

---

# PATH C — 림프 표적 경구 지질제형 (lymphatic-targeted lipid)

## C§1 장 림프 수송 물리 (왜 친유성 cargo 가 chylomicron → 림프 로 가나)

경구 흡수 cargo 의 운명은 장세포(enterocyte) 안에서 **두 갈래**로 갈린다:

```
   경구 dose → 장 내강 → enterocyte 흡수
                              │
              ┌───────────────┴───────────────┐
              │                               │
    [portal 경로]                     [lymphatic 경로]
    수용성/저친유 분자                  고친유 + chylomicron 결합 분자
    문맥혈 → 간(first-pass) → 전신      장 림프관(lacteal) → 흉관 → 쇄골하정맥
              │                               │
       간 대사 손실 大                   간 first-pass 우회 (대사 손실 小)
       (F_h 만큼 손실)                   → 전신 림프 경유 후 혈류 합류
```

cargo 가 림프 경로를 타려면 enterocyte 내에서 **chylomicron (CM) 지질코어에 분배**되어야 한다. 1차 분배 조건:

```
   분배 driving force ≈ logP (octanol-water) + TG-solubility
   ─────────────────────────────────────────────
   조건 1: logP > 5         (CM 지질코어로 분배되는 친유성 하한)
   조건 2: TG 용해도 > 50 mg/g  (CM 적재량 충분)
   조건 3: long-chain TG (C18, oleic/linoleic) vehicle
           → CM assembly 를 trigger (MCT/SCT 는 portal 로 감)
```

- **왜 long-chain TG 인가**: 장세포는 C14+ long-chain fatty acid 를 re-esterify 해 TG 로 만들고 apoB-48 와 함께 CM 으로 패키징 → lacteal 로 분비. medium-chain (C8-C12) 은 re-esterify 없이 문맥혈로 직행 → CM 형성 안 됨 → 림프 우회 실패. **vehicle 의 chain length 가 routing switch.**
- **왜 first-pass 회피가 이득인가**: CM 은 흉관(thoracic duct) → 쇄골하정맥으로 들어가 **간을 거치지 않고** 전신 순환에 합류. 간 추출률 E_h 가 높은 약(예: E_h > 0.7)은 portal 경로로 가면 F_h = 1-E_h < 0.3 으로 대부분 소실 → 림프 경로가 bioavailability 를 수배~수십배 끌어올림.

> closed-form: 림프 수송 분율 f_lymph ≈ (CM 분배상수 · TG 적재)/(1 + portal 분배). f_lymph 는 logP 와 단조 증가하나 logP > 8 에서는 용해도 한계로 plateau. → **🔵 routing 방향성은 닫힘.**

## C§2 림프 표적 정량 — lymph:plasma 比 · 타투 특이성 (정직)

| 지표 | 값 | 근거 / tier |
|---|---|---|
| 림프 수송 분율 f_lymph (최적 제형) | 흡수량의 ~30-90% | 🟡 halofantrine 선례 (Khoo 2003) |
| lymph:plasma 농도 比 (흉관 림프) | ~10-100× (초기 흡수상) | 🟡 (Trevaskis 2008 review) |
| 간 first-pass 회피 → 상대 BA 증가 | 고-E_h 약에서 2-10× | 🟢 closed-form (F_h 회피) |
| **타투 배출 림프(sentinel node) 특이 농도 증가** | **거의 없음 (전신 림프로 희석)** | **🟠** |

핵심 정직 포인트 — **"림프 표적" ≠ "타투 표적":**

```
   장 림프 경로가 도달하는 곳:
   흉관 → 쇄골하정맥 → 전신 혈류 → 전신 림프계 전체 (수백 개 node)
                                         │
                              그중 타투 배출 node = 1-3 개 (전체의 <1%)
   
   ⇒ 타투 림프와의 "동선 겹침"은 전신 림프의 한 미세 분획.
     장 림프 경로는 부위를 선택하지 못함 (CM 은 흉관에서 정맥으로 합류 후
     일반 혈류 분포를 따름) → 부위 특이성 wall 을 실질적으로 풀지 못함.
```

- 즉 path C 가 닫는 것은 **"간 first-pass 회피 + 친유성 cargo 의 전신/림프 전달"**까지다. 진피 잉크 든 macrophage 나 타투 배출 node 에 **선택적으로** 농축시키는 메커니즘은 없다.
- path A (pro-drug + 외부 국소 활성화) 의 공간 게이팅에 비해 정밀도가 본질적으로 낮다. C 의 가치는 "site-specific delivery" 가 아니라 "친유·고-first-pass 약을 전신(림프 포함)에 더 잘 보내는 제형 도구"에 가깝다.

## C§3 제형 levers + 선례 (SEDDS/SMEDDS)

| lever | 작용 | 효과 |
|---|---|---|
| Long-chain TG (C18 oleic/linoleic) | CM assembly trigger | 림프 routing ON (핵심 switch) |
| **SEDDS / SMEDDS** (self-(micro)emulsifying) | 위장관에서 자발 미세에멀전화 → 용해도·흡수 ↑ | 친유 cargo 가용화, f_abs ↑ |
| Surfactant + co-solvent (Cremophor·PEG·propylene glycol) | 미세 droplet 안정화 | droplet 20-100 nm → 흡수 표면 ↑ |
| cargo logP 튜닝 / 친유성 pro-moiety conjugation | logP > 5 로 끌어올림 | CM 분배 ↑ (예: 지방산 에스터화) |

선례 (🟡 citation):

| 약물 | 림프 수송 증거 | 비고 |
|---|---|---|
| Halofantrine | LCT 제형서 림프 수송 ↑, lymph:plasma 高 | 림프 PK 의 classic model 화합물 (Caliph 2000·Khoo 2003) |
| Testosterone undecanoate | 경구 + 식이 지방 → 림프 흡수, 간 first-pass 회피 (Andriol®) | 시판 oral lymphatic-routed 제품 — 메커니즘 임상 입증 |
| Ontazolast·CsA·일부 retinoid | logP↑ 시 림프 수송 분율 ↑ (logP-의존성 확인) | logP-f_lymph 상관 데이터 source |

> ⇒ 제형 toolbox 자체는 성숙·시판 선례 있음. 막히는 건 제형이 아니라 **표적이 "전신 림프"라는 점**. M5-ORAL 에서 lymphatic partition MD 로 f_lymph 를 정량할 수 있으나, "타투 node 특이 농축"은 시뮬로도 닫히지 않는 생리적 한계.

## C§4 honest tier — path C

| claim | tier | 근거 |
|---|---|---|
| long-chain TG → CM → 림프 routing (방향성) | 🔵 | enterocyte CM assembly + first-pass 회피 closed-form |
| 간 first-pass 회피로 고-E_h 약 BA 2-10× | 🟢 | F_h = 1-E_h 회피 numerical |
| lymph:plasma 10-100×, f_lymph 30-90% | 🟡 | halofantrine·TU 선례 |
| **타투 배출 node 특이 농축** | **🟠** | 전신 림프 희석 — 부위 특이성 미돌파 |
| SEDDS/SMEDDS 가용화 흡수 ↑ | 🟡 | 시판 제형 선례 |

**path C top-line: 전신/림프 전달 도구로는 닫히나(🔵/🟢/🟡), 타투-특이 표적으로는 🟠.** 부위 특이성 wall 을 정면 돌파하지 못함.

---

# PATH D — 잉크-호밍 경구 흡수 나노입자 (ink-homing oral NP)

## D§1 두 개의 직렬(stacked) 벽 — 정량

path D 는 **두 독립 벽의 곱**으로 표적 도달이 결정된다. 어느 한쪽만 풀어도 소용 없다 (직렬).

```
   경구 NP dose
       │  ① 위장관 흡수 벽 (mucus + epithelium)
       ▼
   전신 흡수 NP  (흡수 분율 f_oral ≈ 0.1-1%)
       │  ② 진피 잉크 site 호밍 벽 (perfusion + diffusion + EPR 부재)
       ▼
   잉크 site 도달 NP  (호밍 분율 f_home ≈ 0.1-1%)

   ⇒ 표적 도달 = f_oral × f_home ≈ 10⁻⁵ ~ 10⁻⁴  (dose 의 0.001-0.01%)
```

### 벽 ① — 경구 NP bioavailability (본질적으로 낮음)

```
   위장관 NP 흡수 장벽 stack (위→아래 통과 순서):
   ─────────────────────────────────────────
   [점액층 mucus]   ~50-450 μm · mesh 20-200 nm
                    → 40-300 nm 응집 NP 는 mesh 에 trap (크기 배제)
   [unstirred water layer]  확산 저항
   [epithelium / tight junction]  TJ pore ~0.3-1 nm
                    → NP (수 십 nm) 는 paracellular 불가
                    → transcellular endocytosis 만 가능 (M-cell/enterocyte)
   [basolateral → 문맥혈]  대부분 간 first-pass
   ─────────────────────────────────────────
   경구 NP 흡수 분율 f_oral 문헌 범위: ~0.1-1% (예외적 ≤ few %)
```

- 점액 mesh (20-200 nm) 가 40-300 nm 잉크-크기 NP 를 1차 배제. PEG 화(mucus-penetrating particle) 로 일부 개선되나 epithelium TJ (sub-nm) 가 2차 벽.
- 흡수 경로는 M-cell/Peyer's patch transcytosis 가 주력이나 용량(throughput)이 작음 → f_oral 가 본질적으로 ~1% ceiling.
- (🔵) TJ pore < 1 nm ≪ NP 직경 → paracellular 경로 closed-form 차단.

### 벽 ② — deep dermal ink site 호밍 (perfusion/diffusion-limited)

```
   흡수된 NP 가 진피 잉크 site 에 닿으려면:
   혈류 → 진피 모세혈관 → 혈관벽 외유출(extravasation) → 진피 간질 확산 → 잉크
   ─────────────────────────────────────────
   · 정상 진피 혈관은 연속성 내피 (fenestration 없음)
     → 종양의 EPR 효과 같은 수동 누출 거의 없음
   · 외유출돼도 진피 간질 확산 D ≈ 10⁻⁸-10⁻⁷ cm²/s (NP 는 collagen mesh 에 지연)
     depth(t) = 2√(D·t) → 수백 μm 도달에 수 시간~일
   · 잉크는 macrophage 세포 내(intracellular) → 세포외 NP 가 닿아도
     세포막 통과/탐식이 또 다른 관문
   ─────────────────────────────────────────
   호밍 분율 f_home ≈ 0.1-1% (전신 분포 NP 중 진피 잉크 site 도달분)
```

- 핵심: 진피는 종양과 달리 **EPR 효과(leaky vasculature)가 없다** → 수동 축적 driving force 부재. "ink-affinity ligand 가 끌어당긴다"는 ligand 가 잉크 표면에 **물리적으로 닿은 다음** 이야기인데, 닿기 전 단계(extravasation+확산)에서 이미 막힘.
- 표적은 60-70 kg 전신 vs 타투 10-100 cm² 국소 → 농도 희석이 path 전체를 지배 (oral_feasibility_scope §2 ADME 직관과 동일).

> **곱 효과 (🔵 정직)**: f_target = f_oral × f_home ≈ (0.001-0.01) × (0.001-0.01) ≈ 10⁻⁶ ~ 10⁻⁴. dose 100 mg NP 면 잉크 site 도달 ~0.01-10 μg. ink-binding 으로 그 자리 농축돼도 시작 질량이 거의 0.

## D§2 잉크-친화 functionalization 화학

잉크 표면 화학별 결합 ligand (in vitro 결합 자체는 닫힘):

| 잉크 성분 | 표면 화학 | 호밍 ligand | 결합 기전 | tier |
|---|---|---|---|---|
| Carbon black (가장 흔함) | sp² graphitic π 평면 | pyrene·perylene·다환방향족 | **π-π stacking** | 🟢 (흡착 등온식 closed-form) |
| (eu)melanin 유사/유기 안료 | catechol·indolequinone | boronate·catechol·amine | catechol H-bond/배위 | 🟡 (mussel-adhesion 유사) |
| 금속 산화물 (TiO₂·Fe₂O₃·ZnO) | 표면 -OH / Lewis acid | bisphosphonate·hydroxamate·catechol | metal-oxide 배위 결합 | 🟢 (bisphosphonate-금속 친화 강함) |

```
   NP 표면 설계 (이상적):
   ┌─────────────────────────┐
   │  PEG corona (mucus 통과·stealth)   │
   │   + 호밍 ligand (pyrene/catechol/  │  ← 잉크 표면 표적
   │     bisphosphonate)               │
   │  core (생분해 PLGA/lipid · cargo)  │
   └─────────────────────────┘
   설계 tension: mucus 통과엔 PEG corona(stealth) 필요 ↔
                 ligand 노출(끈끈)은 mucus·혈장단백 응집 유발
                 → 한 입자에서 두 요구가 상충 (D§3 gap)
```

- π-stacking 결합 친화는 정량 가능 (Langmuir/Freundlich 등온식 · 흡착 closed-form) → in vitro 잉크 분말 결합 assay 는 닫힘 (🟢).
- catechol-melanin 친화는 홍합 접착 단백(DOPA) 화학에서 검증된 모티프 (🟡).
- bisphosphonate-금속산화물 친화는 매우 강함 (골 표적 BP 약물 선례) (🟢).

## D§3 정직한 선례 + reality gap

| 선례 | 무엇이 입증됐나 | 무엇이 안 됐나 (gap) |
|---|---|---|
| 경구 NP (인슐린 등) | M-cell transcytosis 로 미량 흡수 가능 | f_oral 여전히 ~1% ceiling — 30년 연구에도 미돌파 |
| 종양 표적 NP (EPR) | leaky tumor vasculature 로 수동 축적 | **진피 잉크 site 는 EPR 없음** → 이 메커니즘 차용 불가 |
| 골 표적 bisphosphonate-NP | metal/mineral 친화 호밍 작동 (골은 혈류 풍부·노출 표면) | 골 = 고관류 노출 무기질 vs 진피 잉크 = 세포내·저관류 |
| 잉크 결합 in vitro | π-stacking·catechol 결합 친화 측정됨 | **흡수 후 도달**이 없음 — 결합은 닿은 뒤의 이야기 |

reality gap 요약:
- 개별 조각(경구 흡수, 결합 화학, 골 호밍)은 각각 선례가 있으나 **"경구 흡수 + deep dermal 비-EPR site 호밍"의 결합 선례는 부재**.
- 곱 효과(D§1)로 표적 도달이 ppm 수준 → 잉크를 의미 있게 결합/제거할 질량이 site 에 모이지 않음.

## D§4 honest tier — path D

| claim | tier | 근거 |
|---|---|---|
| 경구 NP f_oral ~0.1-1% (mucus+TJ 벽) | 🟢 | mesh 배제 + TJ pore<1nm closed-form/문헌 |
| 진피 잉크 site 호밍 f_home ~0.1-1% (비-EPR) | 🟢 | 연속내피·간질확산 numerical |
| 표적 도달 = f_oral × f_home ≈ 10⁻⁶-10⁻⁴ | 🔵 | 직렬 분율 곱 closed-form |
| π-stacking / catechol / BP-금속 결합 친화 | 🟢/🟡 | 흡착 등온식 · 홍합·골 선례 |
| 통합: 경구 NP 가 진피 잉크를 결합·제거 | **🟠** | 두 벽 곱 → 도달 질량 무의미 |

**path D top-line: 모든 구성 조각은 닫히나(🔵/🟢/🟡), 직렬 곱이 경로를 죽인다 → 통합 🟠.** 4 path 중 **최약**.

---

## 종합 — C vs D 순위 + M3 handoff

| 축 | Path C (림프 지질) | Path D (잉크-호밍 NP) |
|---|---|---|
| 닫히는 부분 | 전신/림프 전달, first-pass 회피 (🔵🟢🟡) | 개별 화학·결합 친화 (🟢🟡) |
| 막히는 부분 | 타투-특이 표적 (전신 림프 희석) | 경구흡수 × 호밍 **두 벽 직렬 곱** |
| 표적 도달 분율 | 림프 일반 도달 ↑ · 타투 node 우발적 | ~10⁻⁶-10⁻⁴ (ppm) |
| 부위 특이성 wall | 미돌파 (정밀도 < A) | 미돌파 + 흡수 벽 추가 |
| 선례 성숙도 | 시판 제품(Andriol) 있음 | 통합 선례 부재 |
| honest 판정 | **🟠** (전달 도구로는 🟢) | **🟠** (최약) |

```
   4 path 신뢰도 정렬 (oral_feasibility_scope 종합):
   A (pro-drug+외부활성화) ≫ B (macrophage 이주가속) > C (림프지질) > D (잉크호밍 NP)
                                                       └── 본 문서의 두 경로 (최약 2) ──┘
```

- **C > D 명확.** C 는 검증된 림프 PK 위에 서서 적어도 "친유 약의 전신/림프 전달"은 닫힌다 — 타투 특이성만 못 풀 뿐. D 는 그 위에 경구 NP 흡수 벽까지 직렬로 얹혀 도달 분율이 ppm → 가장 약하다.
- 둘 다 **부위 특이성 wall 을 정면 돌파하지 못함** → A(공간 게이팅)·B(내인성 청소 경로)가 여전히 우선.
- C 의 잔존 가치: A/B 의 활성성분을 더 잘 전신 전달하는 **보조 제형 도구**로 재활용 가능 (단독 path 아님).
- D 의 잔존 가치: ink-affinity ligand 화학은 **TTR-MN/CREAM 의 국소 전달**(흡수 벽 없는 직접 진피 도달)에 재사용 가능 — 경구 경로에서만 곱이 죽음.

### M3-ORAL handoff
- C → M5-ORAL: lymphatic partition MD 로 f_lymph(logP) 정량 (RunPod GPU per @D d7) · 단 "타투 node 특이성"은 시뮬 불가 한계 명시.
- D → M4-ORAL: ink-affinity ligand (pyrene·catechol·bisphosphonate) 는 국소 트랙(MN/CREAM) candidate 로 cross-track 이전 검토.
- V2: f_oral × f_home 곱 · F_h 회피 BA 증가 closed-form → `hexa verify --expr` + atlas register.

## honest unknowns

- C: 인간 흉관 림프 cannulation 데이터 sparse (대부분 rat/dog) · 식이 지방 동시섭취 의존성 · "타투 node" 농도 직접 측정 부재.
- D: 경구 NP f_oral 의 입자별 편차 大 (크기·표면 의존) · 진피 비-EPR extravasation 정량 데이터 부족 · mucus-penetration(PEG) ↔ ink-binding(ligand 노출) 상충 설계의 미해결.
- 공통: 부위 특이성 정량은 in-vivo 영상(타투 부위 NP/cargo 축적)으로만 확정 — wet-lab deferred (🟠).

## 진행 상태

- ✅ Path C 림프 수송 물리 (CM routing switch · first-pass 회피) closed-form
- ✅ Path C lymph:plasma 정량 + 타투 특이성 정직 한계 (전신 림프 희석)
- ✅ Path C 제형 levers + 선례 (SEDDS/SMEDDS · halofantrine · TU)
- ✅ Path D 두 벽 직렬 곱 정량 (f_oral × f_home ≈ 10⁻⁶-10⁻⁴)
- ✅ Path D ink-affinity 화학 (π-stacking · catechol · metal-oxide)
- ✅ Path D 선례 + reality gap (EPR 부재가 핵심)
- ✅ honest tier per claim + C > D 순위 + 4-path 정렬
- ✅ M3-ORAL handoff (C→M5 · D→M4 cross-track · V2 closed-form)
- next: M4-ORAL (활성성분 oral-friendly constraint) · M5-ORAL (lymphatic partition MD)
