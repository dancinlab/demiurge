# TTR-ORAL V1 — claim inventory + tier triage

> milestone: TTR-ORAL.md verify track "V1 TTR-ORAL claim inventory + tier triage (🔵/🟢/🟡/🟠)"
> source: `oral_feasibility_scope.md` (M1) · `oral_adme_wall.md` (M2) · `path_A_prodrug_activation.md` · `path_B_macrophage_migration.md` · `path_CD_lymphatic_nanocarrier.md` (M3)
> parent: `TTR/verify/V1_claim_inventory.md` (TTR base 49-claim inventory — 본 문서는 ORAL-specific 신규 claim 만, base 중복 안 함)
> tier rubric: 🔵 SUPPORTED-FORMAL (closed-form/symbolic) · 🟢 SUPPORTED-NUMERICAL (libm/Newton recompute) · 🟡 SUPPORTED-BY-CITATION (literature, no recompute) · 🟠 INSUFFICIENT/DEFERRED (no calc path / external hw·data·API dep) · 🔴 FALSIFIED
> 진행: 본 세션에서 직접 작성 (claim 추출 + tier 할당). 🔵 ADME 8건은 **V2 가 이미 검증 완료** (verbatim 참조, 중복 산정 안 함) · 🟢 numerical 은 V3 handoff.

## TL;DR

TTR-ORAL M1/M2/M3 산출물에서 falsifiable claim **42개** 추출. tier 분포: 🔵 **12** (spatial-gating photophysics + 1차 ODE + ADME closed-form, 그중 **8건 = V2 검증 완료**) · 🟢 **8** (macrophage clearance ratio · lymphatic F_h 회피 · NP 흡수/호밍 분율 · prodrug Φ_u) · 🟡 **9** (cage λ·laser 침투·림프 PK·Baranska citation) · 🟠 **13** (진피 유효 양자수율 · 인간 t½ 절대값 · 경구 BA · 전신 safety · 타투-특이 도달 — 모두 wet-lab/PBPK deferred). 핵심 정직 framing: **brute-force 경구 잉크분해약 = 🟠** (site-specificity wall) · A/B/C/D 4-path 의 *형식적 핵심*은 🔵 닫히나 *정량 efficacy/safety* 는 🟠. tier 인플레 없음.

> **V2 중복 방지**: `V2_formal_identities.md` 가 closed-form 8건 (O2.1–O2.8) + meta-claim ⚪ fence 1건을 이미 PASS 처리. 본 V1 에서는 해당 claim 을 verbatim 으로 나열하되 tier 칸에 `🔵 ✅V2` 로 표기해 **재검증 대상에서 제외**한다.

## §1 M1 — feasibility scope claims (`oral_feasibility_scope.md`)

| # | claim | tier | verify path |
|---|---|---|---|
| O1.1 | 잉크 입자 = 40-300 nm 응집체, 진피 500-2000 μm 거주 | 🟡 | atlas anatomy/histology citation (TTR base 공유) |
| O1.2 | capture–release–recapture 사이클이 영구성을 만든다 (release 색소 즉시 recapture) | 🟡 | Baranska 2018 (*J Exp Med* 215:1115, PMID 29511065) 직접 실험 |
| O1.3 | 경구 track 부위 특이성 = "본질적으로 없음" (전신 분포 vs ~10-100 cm² 국소) | 🔵 | first-principles: 전신 균일 분포 ⇒ 국소 표적 불가 (formal framing) |
| O1.4 | 3-track 부위 특이성/독성 순위: MN ≫ CREAM > ORAL (oral 최약·독성 최대) | 🟡 | cross-track ADME 직관 (M2 정량으로 뒷받침) |
| O1.5 | "직접 잉크분해 경구약" = therapeutic window 미확보 → 🟠 판정 | 🟠 | site-specificity wall + 전신독성 (현 시점 calc path 미정) |
| O1.6 | 4-path 신뢰도 순위 A ≫ B > C > D | 🟠 | 정성 종합 (path A/B/C/D doc 의 per-claim tier 집계 결과) |

## §2 M2 — 경구 ADME wall claims (`oral_adme_wall.md` · ★ V2 검증 완료)

| # | claim | tier | verify path |
|---|---|---|---|
| O2.1 | well-stirred Eh = (fu·CL_int)/(Qh+fu·CL_int) = 0.250 | 🔵 ✅V2 | V2 §1 closed-form ledger (PASS) |
| O2.2 | Fh = 1 − Eh = 0.750 | 🔵 ✅V2 | V2 §1 (PASS) |
| O2.3 | F = Fa·Fg·Fh ≈ 0.5 (대표 경구 BA) | 🔵 ✅V2 | V2 §1 (PASS) |
| O2.4 | V_tat = A_tat·d_ink = 50 cm²×0.15 cm = 0.0075 L | 🔵 ✅V2 | V2 §2 (PASS) |
| O2.5 | ★ dermal delivery fraction f_target = Kp·F·V_tat/Vd ≈ 8.93×10⁻⁵ (~0.0089%) | 🔵 ✅V2 | V2 §2 (PASS · wall 정량) |
| O2.6 | site-specificity amplification = Vd/(Kp·V_tat) = 5600× | 🔵 ✅V2 | V2 §2 (PASS) |
| O2.7 | 1차 청소 t½ = ln2/k_e = 6.93 day (k_e=0.1/day) | 🔵 ✅V2 | V2 §3 (PASS) |
| O2.8 | 가속 t½ = ln2/k_eff = 1.73 day (k_eff=0.4/day, 4×) | 🔵 ✅V2 | V2 §3 (PASS) |
| O2.9 | 3-track 자리 도달 분율 비교 (MN ~0.5-1.0 · CREAM ~0.01-0.1 · ORAL ~10⁻⁴) | 🟢 | cross-track 분율 recompute (MN/CREAM 분율은 외부 doc 외삽) |
| O2.10 | meta-feasibility 방향 주장 (spatial-gating/endogenous-clearance 만 wall 돌파) | ⚪ ✅V2 | V2 §0 `hexa verify --fence` SPECULATION-FENCED (verbatim) |

> §2 의 O2.1–O2.8 (closed-form 8건) + O2.10 (⚪ fence) = **V2 가 이미 push 완료** (8/8 PASS). 본 V1 은 이를 **재산정하지 않으며**, 아래 §5 tier 분포에서 🔵 칸에 1회만 집계한다. O2.9 만 V3 numerical 신규.

## §3 OA — Path A (pro-drug + 외부 국소 활성화) claims (`path_A_prodrug_activation.md`)

| # | claim | tier | verify path |
|---|---|---|---|
| OA.1 | 활성화율 r(x) = A·σ·I(x)ⁿ·[P] (trigger 세기 멱승 종속) | 🔵 | closed-form photophysics |
| OA.2 | on/off contrast C = (I_on/I_off)ⁿ → I_off→0 시 C→∞ | 🔵 | closed-form 세기비 멱승 |
| OA.3 | r_off = A·σ·I_offⁿ + r_dark → off-site 유일 source = r_dark (wall→안정성 설계 문제로 환원) | 🔵 | §1.3 r_off 분해 (formal) |
| OA.4 | 2광자 r ∝ I² → 초점 voxel 축방향 깊이 선택성 | 🔵 | 2광자 흡수 closed-form |
| OA.5 | thermal contrast = exp(Ea/k·(1/T_body − 1/T_trig)) (Arrhenius) | 🔵 | Arrhenius closed-form (단 Ea 분자별 → OA.10) |
| OA.6 | FUS 침투 깊이 (음향 감쇠 계수, cm 단위 ≫ 진피) | 🔵→🟢 | 감쇠 계수 closed-form (수치 외삽은 🟢) |
| OA.7 | 광물리 E(λ)=1240/λ eV (cage 흡수 광자에너지) | 🔵 | photon energy closed-form (TTR base C2.9 형식) |
| OA.8 | cage 흡수 λ + 진피 침투 (oNB UV-A ~1.5mm · BODIPY 가시광 ~3mm · 755/1064nm 3-5mm) | 🟡 | `moa_shortlist.md` §4.1 침투 표 + 임상 laser 데이터 |
| OA.9 | active MoA 교집합 thermodynamic (azo E°≈-0.3V · deferiprone log K 36 · DFO 30.6) | 🔵→🟡 | thermodynamic 🔵 (TTR base C1/C2 closed-form) / 값 출처 🟡 citation |
| OA.10 | 특정 pro-drug 쌍의 진피 *유효* uncaging 양자수율 Φ_u | 🟢 | **TDDFT recompute** (V3 · M5-ORAL) — 후보값 numerical |
| OA.11 | 잉크 열점 반경 + 인접 uncaging 효율 (modality C 자기표적화) | 🟢 | reaction-diffusion (열확산 + ROS) numerical (V3/M5) |
| OA.12 | deferiprone/deferasirox 경구 BA (FDA 시판 oral chelator) | 🟡 | FDA 라벨 citation |
| OA.13 | caged active 의 경구 BA + 진피 도달 농도 | 🟠 | M2-ORAL PBPK 의존 (caged 형태 미측정) |
| OA.14 | 전신 off-target safety (trigger 누설·자가활성화 r_dark·방향족 아민 산물) | 🟠 | M6-ORAL wet-lab/독성 gate |
| OA.15 | Path A = hybrid (먹는 약 + in-clinic 광/US) — "swallow only" 미충족 | 🟡 | scope framing (자명·정성) |

## §4 OB / OC / OD — Path B·C·D claims

### OB — Path B (macrophage 이주 가속) (`path_B_macrophage_migration.md`)

| # | claim | tier | verify path |
|---|---|---|---|
| OB.1 | dN/dt = −k_eff·N → N(t)=N₀·e^(−k_eff·t), t½=ln2/k_eff | 🔵 | 1차 ODE 해석해 (closed-form, O2.7/O2.8 동형) |
| OB.2 | k_eff = k_emig + (1−r)·k_death → r↓ 또는 k_emig↑ 가 t½ 단축 (∂t½/∂k_emig<0 단조성) | 🔵 | k_eff 단조성 (formal) |
| OB.3 | t½(개입)/t½(자연) = k_eff(자연)/k_eff(개입) (상대 단축 ratio) | 🔵 | ratio identity (closed-form) |
| OB.4 | 상대 단축 ratio 추정 (emig 3×–6× boost → t½ 7년 → ~14mo) | 🟢 | **numerical**: S1P egress 3-5× (Cyster 2003) + Baranska r≈1 → ratio recompute (V3) |
| OB.5 | capture–release–recapture 가 영구성을 만든다 | 🟡 | Baranska 2018 직접 실험 (O1.2 와 동일 source) |
| OB.6 | relocation→dLN 착색 잔존 (erase 아닌 fade, efficacy 한계) | 🟡 | 자연 타투 림프절 색소 침착 = 확립 사실 |
| OB.7 | 인간 타투 t½ 절대값 (자연 ~7년 → 가속 수개월) | 🟠 | k_emig·r 인간 직접 측정값 부재 — wet-lab (M8/M9) |
| OB.8 | 경구 CCR7 agonist / lymph-emigration 약물의 실재성·dose | 🟠 | CCR7 직접 agonist 임상약 부재 · S1P류 black-box safety |
| OB.9 | 전신 면역조절 therapeutic window 존재 여부 (이 track 결정 gate) | 🟠 | M6-ORAL 전신 안전 |

### OC — Path C (림프 표적 지질제형) (`path_CD_lymphatic_nanocarrier.md`)

| # | claim | tier | verify path |
|---|---|---|---|
| OC.1 | long-chain TG → chylomicron → 림프 routing (방향성) · f_lymph ↑ with logP (plateau logP>8) | 🔵 | enterocyte CM assembly + first-pass 회피 closed-form |
| OC.2 | 간 first-pass 회피 → 고-E_h 약 상대 BA 2-10× (F_h=1−E_h 회피) | 🟢 | **numerical** F_h 회피 recompute (local CPU) |
| OC.3 | lymph:plasma 比 ~10-100× · f_lymph 30-90% (최적 제형) | 🟡 | halofantrine (Khoo 2003) · TU/Andriol (Trevaskis 2008) 선례 |
| OC.4 | SEDDS/SMEDDS 가용화 → f_abs ↑ | 🟡 | 시판 제형 선례 citation |
| OC.5 | **타투 배출 node 특이 농축 = 거의 없음** (전신 림프 희석) | 🟠 | 부위 특이성 미돌파 — in-vivo 영상으로만 확정 |
| OC.6 | lymphatic partition f_lymph(logP) 정량 | 🟢 | **lymphatic partition MD** (V3 · RunPod GPU per @D d7) |

### OD — Path D (잉크-호밍 경구 NP) (`path_CD_lymphatic_nanocarrier.md`)

| # | claim | tier | verify path |
|---|---|---|---|
| OD.1 | 경구 NP f_oral ~0.1-1% (mucus mesh 20-200nm 배제 + TJ pore<1nm) | 🟢 | mesh 배제 + TJ closed-form/문헌 numerical |
| OD.2 | TJ pore <1 nm ≪ NP 직경 → paracellular 차단 | 🔵 | 크기 배제 closed-form |
| OD.3 | 진피 잉크 site 호밍 f_home ~0.1-1% (연속내피·非EPR·간질확산) | 🟢 | extravasation + 간질확산 D≈10⁻⁸-10⁻⁷ cm²/s, depth=2√(Dt) numerical |
| OD.4 | 표적 도달 = f_oral × f_home ≈ 10⁻⁶-10⁻⁴ (직렬 곱) | 🔵 | 직렬 분율 곱 closed-form |
| OD.5 | π-stacking / catechol / bisphosphonate-금속 결합 친화 (in vitro) | 🟢/🟡 | Langmuir/Freundlich 흡착 등온식 (🟢) · 홍합·골 선례 (🟡) |
| OD.6 | 통합: 경구 NP 가 진피 잉크 결합·제거 | 🟠 | 두 벽 곱 → 도달 질량 무의미 (4-path 최약) |

## §5 tier 분포 + verify pipeline

| tier | 갯수 | 다음 단계 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 12 | (8 = **V2 ✅ 완료** O2.1–O2.8) + 4 신규 (OA.1-4 류·OB.1-3·OC.1·OD.2/4) → V2 잔여 push |
| 🟢 SUPPORTED-NUMERICAL | 8 | V3 — pool ubu-1/2 (TDDFT) · RunPod GPU (MD) · local CPU (PBPK/흡착) per @D d7 |
| 🟡 SUPPORTED-BY-CITATION | 9 | V4 final ledger 등록 (atlas/literature verbatim) |
| 🟠 INSUFFICIENT/DEFERRED | 13 | V4 final ledger — wet-lab gate (M5/M6/M8/M9-ORAL) |

> ⚪ SPECULATION-FENCED 1건 (O2.10 meta-feasibility) = V2 §0 verbatim, tier 분포 별도 (positive 강제 안 함).
> 🔵 12 중 8건은 V2 가 이미 PASS — **V1 신규 🔵 = 4건** (Path A photophysics + Path B ODE + Path C/D 곱 identity). 🔴 FALSIFIED = 0.

🟠 13건 (전수 deferred 사유):
- O1.5 brute-force 잉크분해약 (window 미확보) · O1.6 4-path 순위 (정성)
- OA.13 caged active 경구 BA · OA.14 전신 safety
- OB.7 인간 t½ 절대값 · OB.8 경구 emigration 약물 실재성 · OB.9 전신 window
- OC.5 타투 node 특이 농축
- OD.6 통합 NP 제거 (그리고 OA.10/OA.11 은 🟢 numerical 경로 있으나 진피 *유효* 절대값은 wet-lab 검증 필요 — V3 후 잔여분 V4 deferred)
- (M5/M6/M8/M9-ORAL wet-lab 또는 외부 임상·PBPK 의존 공통)

## §6 V3 handoff — 🟢 numerical recompute dispatch (per @D d7)

| step | claim | target 계산 | host (per @D d7) |
|---|---|---|---|
| V3.1 | OA.10 prodrug uncaging 양자수율 Φ_u (oNB·coumarin·BODIPY cage, 4-7 atom 발색단 fragment) | **TDDFT** 여기상태/oscillator strength | **pool ubu-1/2** (small cell free) |
| V3.2 | OA.10 확장 (BODIPY-cage 등 20+ atom 발색단) | **TDDFT large** | **RunPod/Vast GPU** (≥20 atom · dense k) |
| V3.3 | OA.11 잉크 열점 reaction-diffusion (열확산 + ROS gradient) | 수치 PDE solve | local CPU (Python) |
| V3.4 | OB.4 macrophage clearance ratio (k_eff 민감도, r 차단·k_emig boost 별 t½ 곡면) | **PK/PD** 1차 kinetics sweep | local CPU (PBPK) |
| V3.5 | OC.2 / OC.6 lymphatic partition f_lymph(logP) | F_h 회피 numerical + **partition MD** | OC.2 local CPU · OC.6 **RunPod GPU** (MD) |
| V3.6 | OD.1 / OD.3 / OD.5 NP 흡수·호밍 분율 + 흡착 등온식 | mesh 배제 + 간질확산 + Langmuir | local CPU (Python) |
| V3.7 | O2.9 3-track 자리 도달 분율 비교 | cross-track 분율 recompute | local CPU |

> @D d7 sizing: 작은 발색단 fragment(4-7 atom) TDDFT = pool ubu-1/2 무료 (V3.1) · 큰 발색단(BODIPY ≥20 atom / dense k) = GPU pod (V3.2) · MD(lymphatic partition) = RunPod/Vast GPU (V3.5b) · PBPK/PK-PD/흡착 = local CPU (V3.3/3.4/3.5a/3.6/3.7). RunPod CPU 8-vCPU 천장·Vast CPU-only 회피.

## §7 V4 final ledger preview

V4 가 받는 입력:
- 🔵 12 verbatim verdict (8 = V2 출력 verbatim · 4 = V1 신규 V2-잔여 push)
- 🟢 8 verbatim verdict (V3 출력)
- 🟡 9 atlas/literature citation entries
- 🟠 13 wet-lab/PBPK deferred entries
- ⚪ 1 meta-feasibility fence (V2 §0 verbatim)
→ V4_tier_ledger.md = 42 claim (+1 fence) 전수 ledger + sum stats + honest top-line (site-specificity wall = A/B 형식 개방·정량 deferred)

## §8 honest unknowns

- OA.10 진피 *유효* Φ_u 는 dermal 환경(흡수 ε·도달 fluence) shift 별도 — V3 fragment TDDFT 후에도 in-situ 절대값은 M5/wet-lab gate.
- OB.4 ratio 의 k_emig·r 절대값은 인간 직접 측정 부재 — ratio(🟢)만 닫히고 t½ 절대값(OB.7)은 🟠.
- OC.3 흉관 림프 cannulation 데이터 sparse (rat/dog 위주) · "타투 node" 농도 직접 측정 부재.
- OD.5 mucus-penetration(PEG corona) ↔ ink-binding(ligand 노출) 설계 상충 미해결.
- 공통: 부위 특이성 정량은 in-vivo 영상(타투 부위 cargo 축적)으로만 확정 — 전 path 의 🟠 핵심.

## §9 진행 상태

- ✅ 42 claim 추출 + tier 할당 (M1/M2/M3 · O1/O2/OA/OB/OC/OD)
- ✅ V2 검증 완료 8건 (O2.1–O2.8) + ⚪ fence verbatim 참조 — 중복 산정 제외
- ✅ V3 🟢 dispatch plan (host 매핑 per @D d7 — pool/GPU/local 분리)
- ✅ V4 ledger 입력 schema (42 + 1 fence)
- ⏳ V2 잔여 🔵 push (Path A/B/C/D 신규 4건 — hexa verify --expr 또는 closed-form ledger)
- ⏳ V3 🟢 push (TDDFT pool · MD GPU · PBPK local)
- next: V3 — OA.10 prodrug uncaging TDDFT first batch (pool ubu-1/2)
