# TTR-ORAL — M4: 활성성분 / 모달리티 후보 (LEAD track A · B)

> 마일스톤 **M4-ORAL** 산출물 · current-state · no history.
> 입력 = `path_A_prodrug_activation.md` (track A) · `path_B_macrophage_migration.md` (track B) · `TTR/research/moa_shortlist.md` §2(F2)/§3(F3)/§5(F5) · `TTR/research/ink_classes.md` §2.2.1(azo)/§3(Fe oxide) · `oral_adme_wall.md` (f_target·amplification).
> 출력 = track A caged pro-drug→active 쌍 ≥6 · track B 경구 면역조절 ≥4 · 트랙별 down-select(top-2) · M5 sim / M6 safety 로의 open-gap handoff · per-claim tier.
> 정직 원칙 (@D d5/d6): "된다"를 압력으로 강제하지 않음. positive verdict 강제 금지. 정량 효율/경구 BA/전신 safety 는 미해소면 그대로 🟠 기록.

scope:
- in-scope: active 분자 + caging group/trigger 매핑 · 경구 BA(uncaged) · caged 형태 전신 inertness · 표적 ink class · TTR base M2(F2/F3/F5) ∩ M6(MW/ink-affinity) 교집합 · 트랙별 ranking
- out-of-scope: caged 분자 진피 유효 Φ_u TDDFT(M5) · macrophage trafficking PK/PD(M5) · 전신 off-target 정식 safety(M6) · 합성 route(M7) · 제형(M7) · ex-vivo/in-vivo(M8-9)

> M3 우선순위 (TTR-ORAL.md): **A ≈ B ≫ C > D**. 본 M4 는 LEAD 두 트랙(A·B)의 active/modality 후보만 다룬다. C/D(lymphatic·NP)는 후순위 — 본 문서 out-of-scope.

---

## 0. 두 트랙의 active 가 풀어야 할 제약 (M2-ORAL + base M2/M6 교집합)

```
   track A (caged pro-drug)               track B (immunomodulator)
   ─────────────────────────              ─────────────────────────
   active = 잉크 화학 cleaver              active = 내인성 청소 가속
   (azo 환원 F2 · Fe³⁺ chelate F3)        (k_emig↑ 또는 recapture r↓)
        ▲                                      ▲
   3 제약 (path_A §3.3):                   2 제약 (path_B §3.1):
   ① caged 형태 경구 BA                    ① 경구 BA (전신 도달)
   ② 전신 inertness (r_dark≈0)            ② 전신 면역조절 therapeutic window
   ③ clean uncaging (high Φ_u)            (부위 특이성 없음 — M6 결정 gate)
        ▲                                      ▲
   ▶ off-site 활성 = trigger 장이 0 으로     ▶ f_target 무관 (반응성 화학 미전송)
     decouple → f_target~10⁻⁴ 무력화           내인성 경로 → 전신 효과 감내 질문
```

- **base M2 우선순위** (`moa_shortlist.md` §0): F2 reductive + F3 chelation 이 시장 60-70%(azo+Fe oxide)의 직접 cleavage 핸들 · F5 enzymatic 은 azo 보조. → track A active 는 **F2/F3 우선**, F5(azoreductase cofactor)는 secondary.
- **base M6 제약** (MW / ink-affinity, `moa_shortlist.md` §9·`ink_classes.md` §5): caging 은 MW 를 키운다 → 경구 BA(rule-of-5 MW<500 선호)와 진피 phagolysosome 도달을 동시에 깎음. azo cleavage 산물 = 방향족 아민(IARC group 1/2A)은 M6 1순위.

---

## 1. TRACK A — caged pro-drug → active 쌍 (≥6)

active 는 base M2 의 MoA 를 *실행*한다: **azo N=N 환원 절단(F2)** · **Fe³⁺ chelation(F3)** · **Fe³⁺→Fe²⁺ 환원 후 chelation(F2→F3 직렬)**. caging group 은 active 의 결합/chelate site 를 차폐해 전신 inert 화 + trigger 로 풀린다. trigger 는 track A modality(`path_A §2`): **A 광-uncaging · B FUS/photothermal · C 잉크-as-sensitizer**.

### 1.1 후보 표 (caged → uncaged · trigger · 경구 BA · 전신 inertness · 표적 ink)

| # | active (uncaged) | caging group | uncaging trigger (modality) | uncaged 경구 BA | caged 전신 inertness | 표적 ink class (F#) | MW 메모 |
|---|---|---|---|---|---|---|---|
| **A1** | **deferiprone (L1)** | C-3 hydroxyl O-(2-nitrobenzyl) 또는 coumarinylmethyl ester | 광-uncage UV-A~가시 (modality A) | **높음 — oral FDA 약 (Ferriprox)** | chelate O 차폐 → Fe³⁺ 결합 0 | Fe oxide PR101/PY42 (F3) | active MW 139 (소형) → cage 후도 BA 여지 큼 |
| **A2** | **deferasirox** | tridentate phenol/triazole donor O-ester cage (coumarin/BODIPY) | 광-uncage 가시~적색 (modality A) | **높음 — oral FDA 약 (Exjade/Jadenu)** | donor site 차폐 → Fe³⁺ 결합 0 | Fe oxide (F3) | active MW 373 → cage 후 MW↑ BA 재평가(M2) |
| **A3** | **DFO (deferoxamine)** | hydroxamate N-OH ×3 의 oNB/BODIPY cage | 광-uncage 가시/적색 또는 FUS-thermal (B) | 낮음 (DFO 경구 BA<1%; IV/SC 약) | hexadentate 전부 차폐 시 inert | Fe oxide (F3) | active MW 561 + cage → 경구엔 A1/A2 우선 (DFO 는 caged-topical 대안) |
| **A4** | **ascorbate (Vit C)** | oNB-ester 또는 thermo-labile linker | 광-uncage(A) 또는 잉크-광-Fenton(C) | 높음 (식이 흡수 확립) | enediol 산화환원 site 차폐 → 환원력 0 | Fe oxide (Fe³⁺→Fe²⁺ 후 chelate, F2→F3) · azo radical | active MW 176 (소형) — 직렬 reductant |
| **A5** | **유리 thiol / GSH** (azo 환원체) | disulfide-mask 또는 oNB-thioether | 광-uncage(A) | GSH 경구 BA 낮음·가변 (thiol 산화·1차통과) | thiol 차폐 → azo 환원력 0 | **azo N=N (F2, 시장 60-70%)** | thiol 산화 안정성이 r_dark 의 약점 |
| **A6** | **NADPH (azoreductase cofactor)** | caged-NADPH (nicotinamide/phosphate cage) | 광-uncage(A) | 낮음 (대형 극성 — 경구 BA 미미) | cofactor 차폐 → 내인성 azoreductase 미구동 | **azo N=N (F5/F2, AzoR·NQO1·CYP-reductase)** | 내인성 효소 활용 = active 자체는 경구 부적, cofactor 경구 BA 가 wall |
| **A7** | **azo-quinone redox pro-drug** | 잉크 ROS/열-labile linker | 잉크-as-sensitizer (modality C · 755/1064 nm) | (잉크가 흡수체 → trigger 정렬 불요) | 체온/가수분해 안정성에 의존 (thermo/ROS-labile = r_dark↑ risk) | azo + Fe oxide photo-Fenton (F1+F2 hybrid) | 자기표적화(잉크 분포=μm 정밀도) |

> ≥6 충족 (A1–A7, 7개). **azo(F2/F5) 2종 · Fe³⁺(F3) 3종 · Fe³⁺환원직렬(F2→F3) 1종 · 잉크-sensitizer hybrid 1종** — base M2 의 F2/F3 우선순위에 정렬.

### 1.2 caging group ↔ trigger ↔ 진피 침투 매핑 (path_A §2 인용)

```
   caging chemistry        흡수 λ          침투(진피 500-2000μm)     r_dark 부담
   ─────────────────────────────────────────────────────────────────────────
   o-nitrobenzyl (oNB)     254-365 UV-A    ~1.5 mm (경계)            낮음(광 전용)
   coumarin-4-yl(DEACM)    350-470 청색     수 mm 경계               낮음
   BODIPY-cage (meso-Me)   500-650 가시~적   ~3 mm (진피 관통) ★      낮음
   thermo-labile linker    (FUS/NIR ΔT)    cm(FUS)·~5mm(NIR)        중간(체온 r_dark>0)
   ROS/열-labile (잉크인접) (잉크 흡수)       잉크 분포=μm 정밀도       중간(ROS-labile)
```

- **깊이 ↔ cage 선택은 묶여 있다**(path_A caveat 2): UV-A oNB 는 깊은 진피 잉크에 fluence 부족 → 깊은 표적은 BODIPY-cage(가시·적색) 또는 modality B/C 로 깊이를 푼다.
- **off-site 활성의 유일 source = r_dark** (path_A §1.3, 🔵). 광-전용 cage(oNB/coumarin/BODIPY)는 r_dark 낮음 → spatial-gating 유리. thermo/ROS-labile(A7·DFO-thermal)은 체온 37°C 에서 r_dark>0 → §1.3 contrast 분모 악화 risk → M6 핵심 평가.

### 1.3 경구성 핵심 — 왜 deferiprone/deferasirox 가 track A 의 anchor 인가

```
   oral track 최대 장벽 = 경구 BA.  active 중 deferiprone·deferasirox 는
   이미 FDA 승인 oral iron-chelator (Ferriprox / Exjade·Jadenu).
   → "active 의 경구 BA" 가 처음부터 풀려 있는 유일 후보군.
   남은 일 = caging 추가 후 BA 재평가(MW↑) + clean uncaging(M5) + 전신 safety(M6).
```

- deferiprone(MW 139)·deferasirox(MW 373) 둘 다 base M2 F3 chelation 표(`moa_shortlist.md` §3.1, log K(Fe³⁺) deferiprone 36·deferasirox 22)에 등재 → **MoA thermodynamic 🔵 + 경구 BA 🟡(FDA 라벨)** 동시 만족.
- DFO(A3)·NADPH(A6)·GSH(A5)는 경구 BA 가 active 단계에서 이미 약점 → caging 으로 풀리지 않음 → A1/A2 가 경구 anchor, 나머지는 *modality/표적 보완* 후보.

---

## 2. TRACK B — 경구 면역조절 (≥4) · macrophage emigration↑ / turnover

active 는 잉크를 분해하지 않고 capture–release–recapture 정상상태를 net clearance 로 기울인다(`path_B §1-2`): **k_emig↑** (림프 이주 가속) 또는 **recapture 확률 r↓**. k_eff = k_emig + (1−r)·k_death, t½ = ln2/k_eff.

### 2.1 후보 표 (mechanism · 대표 agent class · 경구 BA · 전신-safety flag)

| # | 레버 (k_eff 항) | mechanism | 대표 agent class | 경구 BA | 전신-safety flag |
|---|---|---|---|---|---|
| **B1** | CSF1R modulation (r↓) | macrophage turnover 조절 → 재포획 pool 일시 감소 → 자유 색소↑·재증식 window 에 dLN 배수 | **pexidartinib / PLX-class** CSF1R 억제제 (FDA 승인 TGCT) | 경구 (pexidartinib oral 승인) | 🔴 높음 — 전신 macrophage/Kupffer/osteoclast 고갈 → 간효소↑·감염·골대사. transient·저용량 필수 |
| **B2** | CCR7/CCL21 + S1P emigration (k_emig↑) | 잉크-load macrophage 의 afferent lymph 이주 가속 (Förster 2008 · S1P egress 3-5× Cyster 2003) | **S1P1 modulator** (fingolimod/ozanimod class); CCR7 직접 agonist 는 임상약 부재 | S1P modulator 경구 (fingolimod oral) | 🟠 중-높음 — S1P modulator black box: 림프구감소·서맥·황반부종. CCR7 agonist 실재성 🟠 |
| **B3** | depletion→repopulation timing (r↓) | clodronate-liposome / CSF1R pulse 후 **재증식 window** 에 색소 자유 상태 — 외부 보조(레이저)와 시너지 | clodronate-liposome · CSF1R pulse (B1 의 timing 변형) | clodronate 경구 BA 낮음(~1-2%); CSF1R pulse 는 B1 따름 | 🔴 B1 과 동일 risk + timing 의존 — pulse 설계 정밀도 |
| **B4** | lymphangiogenesis / lymph-flow (k_emig sink↑) | dLN 배수 용량↑ — VEGF-C 축 또는 **비약물(운동·온열·압박 마사지)** | VEGF-C agent (약물) · 비약물 lymph-flow 지원 | 비약물 = N/A(BA 무관); VEGF-C 약물 경구 부재 | 🟢 비약물 safety 최상 · 🟠 VEGF-C 약물은 혈관신생·종양 promotion 우려 |

> ≥4 충족 (B1–B4). 경구 호환성 순위(path_B §3.1): **(d) lymph-flow ─ (b) S1P/CCR7 ─ (a) CSF1R ─ (c) depletion pulse**. leverage(k_eff↑)는 (a)(c) 큼 ↔ safety 는 (d)(b) 우수 → trade-off.

### 2.2 정직 caveat (track B 본질 한계, path_B §4 인용)

- **relocation ≠ destruction**: 잉크는 진피→배출 림프절(dLN)로 *옮겨질* 뿐, dLN 착색 잔존(자연 타투 림프절 색소침착의 가속판). 분자는 사라지지 않음 → "erase" claim 금지, fade 만.
- **부위 특이성 없음**: 경구 면역조절은 전신 macrophage/림프계 전체에 작용. "타투 부위만 가속"은 불가 → 질문이 "전신 효과를 감내 가능 수준으로 낮추되 진피 fade 를 얻는 therapeutic window 가 존재하나"로 바뀜 → **M6-ORAL 이 이 트랙의 결정 gate**.
- **느림**: ratio 6× 라도 절대 t½ 가 크면 길다(수주-수개월-년). 시각적 onset ≠ 90% clearance.

---

## 3. Down-select — 트랙별 ranking + top-2 lead + open design gaps

### 3.1 track A ranking (제약 ①경구BA ②inertness ③clean uncaging + base M2 F-우선 + M6 MW)

| rank | 후보 | 경구BA | inertness | uncaging/깊이 | F-우선·MW | 종합 |
|---|---|---|---|---|---|---|
| **1** | **A1 caged deferiprone** | ◎ FDA oral·MW139 | ◎ chelate site 차폐 | BODIPY-cage 로 진피 깊이 | F3 · 소형 MW | **LEAD** |
| **2** | **A2 caged deferasirox** | ◎ FDA oral | ◎ donor 차폐 | 가시~적색 cage | F3 · MW373(BA 재평가) | **LEAD** |
| 3 | A4 caged ascorbate | ○ 식이흡수 | ○ enediol 차폐 | 잉크-Fenton 직렬(C) | F2→F3 · 소형 | 보완(Fe 직렬) |
| 4 | A7 잉크-as-sensitizer azo | (정렬불요) | △ thermo/ROS-labile r_dark↑ | 자기표적 μm | azo+Fe hybrid | 보완(자기표적·기존 레이저 인프라) |
| 5 | A5 caged thiol/GSH | △ thiol 산화 | △ thiol 산화 r_dark | 광(A) | **azo(시장 최대)** but BA 약점 | azo 직접엔 매력·경구 BA wall |
| 6 | A6 caged-NADPH | △ 대형극성 BA미미 | ○ cofactor 차폐 | 광(A) | azo via 내인성 효소 | BA wall — secondary |
| 7 | A3 caged DFO | ✗ 경구<1% | ◎ hexadentate | 가시/FUS | F3 · MW561 | caged-topical 대안(경구 X) |

→ **track A top-2 lead: A1 (caged deferiprone) · A2 (caged deferasirox)** — 둘 다 active 가 *이미 oral FDA iron-chelator* → 경구 BA wall 을 active 단계에서 통과한 유일군 + base M2 F3 thermodynamic(🔵).

**track A open design gaps (→ M5/M6):**
1. caged 형태의 **진피 유효 양자수율 Φ_u** (BODIPY-cage deferiprone/deferasirox) — TDDFT recompute (M5).
2. caged active 의 **경구 BA 재평가** (cage 추가 MW↑ — deferasirox+cage 가 rule-of-5 경계 넘는지) — PBPK (M2 확장 입력 → M6).
3. **r_dark 절대값** (체온/가수분해 자가-uncage) — spatial gating 의 전신 safety 분모 (M6 1순위).
4. uncaging **부산물 안전성** (oNB→nitroso · azo→방향족 아민 IARC) — M6.
5. A1 의 cage 절단 후 deferiprone 의 **진피 도달 농도** vs Fe oxide chelation 임계 — f_target~10⁻⁴ 가 trigger-decouple 로 무력화되는지 정량(M5).

### 3.2 track B ranking (leverage k_eff↑ ↔ safety trade-off · 경구 native)

| rank | 후보 | leverage | safety | 경구 native | 종합 |
|---|---|---|---|---|---|
| **1** | **B2 S1P/CCR7 emigration** | k_emig↑ (3-5× egress) | 🟠 black box but tunable | ◎ S1P modulator oral | **LEAD** — 직접 k_emig 노브·경구약 실재 |
| **2** | **B1 CSF1R modulation** | r↓ (큰 leverage) | 🔴 전신 macrophage 고갈 | ◎ pexidartinib oral | **LEAD** — leverage 최대·FDA oral but safety gate |
| 3 | B4 lymph-flow(비약물) | k_emig sink↑(보조) | 🟢 최상(비약물) | (BA무관) | 보조 — 단독 약함, 병용 안전 |
| 4 | B3 depletion pulse | r↓ + 외부 시너지 | 🔴 B1+timing | △ clodronate BA 낮음 | hybrid(레이저 병용)·순수경구 약함 |

→ **track B top-2 lead: B2 (S1P/CCR7 emigration axis) · B1 (CSF1R modulation)** — B2 는 경구 native + k_emig 직접 노브, B1 은 leverage 최대 + FDA oral(pexidartinib)이나 safety 가 M6 결정 gate.

**track B open design gaps (→ M5/M6):**
1. 인간 타투 **k_emig·r 직접 측정값 부재** → t½ 절대값 미정 (상대 ratio 만 🟢) — macrophage trafficking PK/PD 시뮬(M5).
2. **CCR7 직접 agonist 임상약 부재** — S1P modulator 가 k_emig 를 *실제로* 올리는지(림프구 trapping 부작용 없이) — 약물 실재성 🟠.
3. **전신 면역조절 therapeutic window 존재 여부** — B1/B3 의 전신 macrophage 고갈 독성 정량 (M6 — 이 트랙의 결정 gate).
4. dLN 착색 잔존(relocation 한계)이 efficacy 천장을 어디에 두는가 — fade vs erase 정량(M5/M8).
5. depletion window 와 레이저 병용 시너지(B3) — 순수 경구 단독 효과 분리(M5).

---

## 4. Per-claim tier ledger (project rubric · 🔵/🟢/🟡/🟠 · positive 강제 금지)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | deferiprone/deferasirox/DFO 의 Fe³⁺ chelation log K (36·22·30.6) | 🔵→🟡 | thermodynamic 🔵 closed-form / 값 출처 🟡 (`moa_shortlist.md` §3.1) |
| 2 | deferiprone·deferasirox·pexidartinib·fingolimod = 승인 경구약 | 🟡 SUPPORTED-BY-CITATION | FDA 라벨 (uncaged active / track B agent) |
| 3 | DFO·NADPH·GSH 의 낮은 경구 BA | 🟡 SUPPORTED-BY-CITATION | DFO IV/SC 약 · NADPH 대형극성 · thiol 1차통과 (문헌) |
| 4 | cage 차폐 시 off-site 활성의 유일 source = r_dark → spatial gating | 🔵 SUPPORTED-FORMAL | path_A §1.3 r_off 분해 (closed-form) |
| 5 | k_eff = k_emig+(1−r)k_death · t½=ln2/k_eff · r↓/k_emig↑ → t½↓ | 🔵 SUPPORTED-FORMAL | path_B §2 1차 ODE 해석해 + 단조성 |
| 6 | emigration 상대 단축 ratio (3-5× egress boost) | 🟢 SUPPORTED-NUMERICAL | S1P egress 3-5× (Cyster 2003) · Baranska r≈1 정성 |
| 7 | cage 흡수 λ·진피 침투 (oNB 1.5mm·BODIPY 가시 3mm) | 🟡 SUPPORTED-BY-CITATION | path_A §2 + `moa_shortlist.md` §4.1 침투 표 |
| 8 | caged active 진피 유효 Φ_u / r_dark 절대값 / 잉크 열점 반경 | 🟠 INSUFFICIENT-DEFERRED | M5-ORAL TDDFT + reaction-diffusion |
| 9 | caged active(MW↑) 경구 BA + 진피 도달 농도 | 🟠 INSUFFICIENT-DEFERRED | M2-ORAL ADME PBPK 확장 |
| 10 | 인간 타투 t½ 절대값 (자연→가속) · 전신 면역조절 window | 🟠 INSUFFICIENT-DEFERRED | M6-ORAL (track B 결정 gate) · M8/M9 wet-lab |
| 11 | CCR7 직접 agonist 실재성·dose | 🟠 INSUFFICIENT-DEFERRED | 임상약 부재 · S1P 류 black box safety |
| 12 | uncaging 부산물(nitroso·방향족 아민) systemic safety | 🟠 INSUFFICIENT-DEFERRED | M6-ORAL (base M2 §9 azo 산물 IARC) |

```
   tier 분포:  🔵 2  ·  🔵→🟡 1  ·  🟢 1  ·  🟡 4  ·  🟠 5  ·  🔴 0
   ──────────────────────────────────────────────────────────────────
   active MoA·spatial-gating·kinetic = 닫힘(🔵).  ratio·승인약 = 🟢/🟡.
   진피 유효효율·caged 경구 BA·전신 window·부산물 safety = 🟠 deferred.
   → positive verdict 강제 안 함. M4 는 "후보 식별 + 제약 매핑" 까지가 completed-form;
     정량 효율/safety 는 M5/M6 gate 로 정직하게 넘긴다.
```

---

## 5. 진행 상태 + 다음 (M5/M6-ORAL 입력)

- ✅ track A caged→active 쌍 7종 (A1-A7) — F2/F3/F5 우선 정렬 · trigger×깊이×r_dark 매핑
- ✅ track B 경구 면역조절 4종 (B1-B4) — k_eff 항 매핑 · 경구 BA · safety flag
- ✅ 트랙별 ranking + top-2 lead — **A: A1 caged deferiprone · A2 caged deferasirox** / **B: B2 S1P/CCR7 emigration · B1 CSF1R modulation**
- ✅ 트랙별 open design gap (각 5항) → M5/M6 handoff
- ✅ tier ledger (🔵2·🔵→🟡1·🟢1·🟡4·🟠5·🔴0) — positive 강제 없음
- next:
  - **M5-ORAL** — A: caged deferiprone/deferasirox 진피 Φ_u TDDFT (pool ubu-1/2) · A7 잉크 열점 reaction-diffusion / B: macrophage trafficking PK/PD (k_emig·r 민감도 → t½ 곡면)
  - **M6-ORAL** — A: r_dark 자가-uncage + 방향족 아민/nitroso 전신 노출 / B: 전신 면역조절 therapeutic window (CSF1R 고갈 독성 정량 — 이 트랙 결정 gate)
  - **M2-ORAL 확장** — caged active(MW↑) 경구 BA PBPK 재평가 (deferasirox+cage rule-of-5 경계)

---

## Cross-reference

- track A 입력: `path_A_prodrug_activation.md` §1.3(r_dark·contrast) · §2(modality A/B/C) · §3(pro-drug→active 쌍·3 제약)
- track B 입력: `path_B_macrophage_migration.md` §2(k_eff·t½) · §3(4 레버·precedent·safety) · §4(relocation/fade caveat)
- base M2: `TTR/research/moa_shortlist.md` §2(F2 reductive·azo/Fe) · §3(F3 chelation·DFO/deferiprone/deferasirox log K) · §5(F5 azoreductase) · §9(방향족 아민 IARC safety)
- base M1: `TTR/research/ink_classes.md` §2.2.1(azo N=N BDE 167) · §3(Fe oxide log K·chelation) · §5(입자 크기·단백질 코로나)
- M2-ORAL: `oral_adme_wall.md` (f_target≈8.9×10⁻⁵ · amplification 5600× — track A 가 trigger-decouple 로 무력화하는 wall)
- @D d1 (non-wet-lab 완료형) — M4 는 후보 식별+제약 매핑까지 completed-form; 정량 효율/safety 는 M5/M6
- @D d2 (wall breakthrough) — "불가능" 미언급; 모든 wall(경구 BA·전신 window)을 후보/gap 으로 분해
- @D d5/d6 (정직·first-principles) — log K·E°·BDE·1차 ODE·photophysics 인용만, positive 강제 없음, ML 의존 X
