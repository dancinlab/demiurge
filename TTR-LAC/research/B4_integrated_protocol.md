# TTR-LAC — B4: 통합 5-stage 세션 프로토콜 (EMLA → wipe → r↓pre → PFD → laser → r↓post)

> ❄️ **TTR-LAC** track B 최종 — A1(마취 onset) + B2(PFD frosting-clear) + B3(토픽 r↓) 를 **단일 chair-time 흐름**으로 통합. B2 §6 의 핵심 제약(**EMLA-PFD 직접혼합 ✗ → 순차 적용 필수**)을 골격으로, B3 의 **pre + post double-coat** 적용순서 최적화를 더한다. sim = `sim/b4_integrated_protocol.hexa`. @D d5/d6 — carbon floor 명시.
>
> **3-step UI** (사용자 관점) = `EMLA → r↓ + PFD → laser`. 내부적으로는 5-stage (아래).

---

## 1. 5-stage 세션 타임라인 + chair-time 비교 (🟢/🟡)

```
   ┌──────────────────────────────────────────────────────────────────────────┐
   │ T-60min  ─ EMLA + occlusion ─────── (A1 SC lag-time t_lag=h²/6D ≈ 28min) │
   │                  · lidocaine 2.5%/prilocaine 2.5% eutectic emulsion       │
   │                  · 폐색 → D 3× (수화·지질 fluidization) → onset 56→19min │
   │ T-0    ─── wipe EMLA ─────────────  (B2 §6: PFD-EMLA emulsion 깨짐 → 必)  │
   │                  · gauze + saline (1min)                                  │
   │ T+0    ─── r↓ topical PRE-coat ───  (B3 rhein gel 흡수 5-10min)          │
   │                  · β_pre ≈ 0.30 (SR-A on resident dermal Mφ)              │
   │ T+8    ─── PFD patch apply ──────  (B2 DESCRIBE patch · RI 1.313 + O₂)   │
   │ T+9    ─── multi-pass LASER ─────  (n=3.7 passes · frost-clear 3-5s/pass)│
   │                  · PASS1 → frost → PFD clear 5s → PASS2 → ... → PASS4    │
   │                  · 총 ~8min (5 패스 × 90s + 인터-패스 PFD 재적용)         │
   │ T+17   ─── r↓ topical POST-coat ─  (B3 rhein gel · 방출 잉크 재포획前 창)│
   │                  · β_post ≈ 0.45 (interstitium free pigment · dominant)  │
   │ T+22   ─── 세션 종료 (총 ~83min)                                          │
   └──────────────────────────────────────────────────────────────────────────┘
```

### chair-time 비교 (분/세션)

| 시나리오 | EMLA wait | PFD/laser | r↓ pre+post | inter-pass wait | **총 분** | per-session 변화 |
|---|---:|---:|---:|---:|---:|---|
| **SoC laser-alone** (n=1.4) | 60 | ~7 | — | — | **~67** | 기준 |
| **SoC R20** (Kossida, n=4 · 20min 대기) | 60 | 20 | — | 60 | **140** | +73 min (참기 어려움) |
| **SoC DESCRIBE** (EMLA + PFD, n=3.7) | 60 | 5-10 | — | — | **~70** | per-session +3min |
| **B4 integrated** (PFD + double-coat r↓) | 60 | 9 | 13 | — | **~83** | per-session +13min vs DESCRIBE |

> **chair-time 진단**: B4 가 PFD-only 대비 +13min/세션 추가, 그러나 R20 대비 **−57min**. 세션 *수* 절감과 곱해 누적 시간은 압승(아래 §4).

---

## 2. 화학 양립성 매트릭스 (🟡 + 🟠)

성분 6개 페어와이즈. 색 코드 — ✅ 양립 · ⚠ 순차/조건부 · ✗ 직접혼합 금지.

| | **EMLA** | **PFD** | **rhein gel** | **lido/prilo** | **epi(VC)** | **CPE(enhancer)** |
|---|---|---|---|---|---|---|
| **EMLA** | — | ✗ emulsion 깨짐 (B2 §6) | ⚠ pH (rhein pKa~6.8) | (자기조성) | ⚠ off-label 병용 (LMX+epi 선례) | ⚠ D↑ but barrier risk |
| **PFD** | ✗ 순차+wipe 필수 | — | ✅ fluorocarbon 비활성 (twin-phobic) | ⚠ free-base 不溶 (third phase) | ✅ 비반응 | ✅ 비반응 (분리상) |
| **rhein gel** | ⚠ pH | ✅ | — | ⚠ acid(rhein pKa 6.8) vs amine base — pH 6-7 완충 | ⚠ vasoconstriction 시 흡수↓ | ✅ rhein 흡수↑ |
| **lido/prilo** | (=EMLA) | ⚠ | ⚠ pH | — | ✅ off-label (lidocaine+epi 임상 표준) | ✅ |
| **epi(VC)** | ⚠ | ✅ | ⚠ | ✅ | — | ✅ |
| **CPE(enhancer)** | ⚠ | ✅ | ✅ | ✅ | ✅ | — |

### 핵심 incompat + 우회

| pair | 문제 | 우회 |
|---|---|---|
| **EMLA × PFD** | emulsion phase-separation (PFD = oleo+hydro 이중기피 third phase) | **wipe → 순차** (B2 §6 결론) |
| **PFD × free-base lidocaine** | PFD 가 비극성·비지용성 — 마취제 용해 못함 | PFD 도포 *전* lido 흡수 완료 |
| **rhein × EMLA pH** | rhein anthraquinone pKa~6.8 · EMLA pH ~9 (지용성 free-base) → 침전 | **wipe + 분리 도포** (rhein 자체 gel pH 6-7) |
| **rhein × epi** | epi vasoconstriction → 진피 흡수↓ | r↓ pre-coat 적용 *후* 진피 도달 확보 시 epi 추가 (또는 epi 생략) |
| **lido × epi** | (off-label 양립) — EMLA 자체엔 epi 無, 추가는 compound 처방 | LMX-4 + epi compound 선례 (얕은 시술) |

### 안정성·저장

| 성분 | 보관 | shelf-life | 주의 |
|---|---|---|---|
| EMLA cream | 실온 · sealed tube · 폐색 후 사용 | 라벨 ~3년 | 개봉 후 microbial · prilocaine→metHb (>1300 cm²/8 mg/kg) |
| PFD (DESCRIBE patch) | 4°C·실온 · sealed 실리콘 patch | 18-24개월 | 패치 미봉입시 휘발 (bp 142°C이지만 표면적 大 → 분당 손실); **patch 형태가 필수** |
| rhein gel (topical) | 차광·실온 | ~12개월(추정) | **anthraquinone photo-labile** (UV 분해) → amber tube + sealed sachet; 산소 안정 |
| lidocaine/prilocaine raw | 실온 | ~5년 | 산성 가수분해 미미 (amide) |
| epi raw | 2-8°C · 산화방지 | ~12개월 | 광·산화 분해 大 (갈색 → 불활성) |

⇒ **kit packaging 함의**: (a) EMLA tube + occlusion film 별도 · (b) PFD patch sealed pouch · (c) rhein gel **amber single-dose ampoule** (광분해 회피) · (d) epi 옵션은 별도 vial. 4 SKU 멀티-콤포넌트 kit.

---

## 3. 적용순서 sensitivity — pre-laser vs post-laser r↓ (🟢)

**물리적 추론**: rhein 은 SR-A on macrophage (Baranska 의 재포획 receptor) 길항. 시점별 표적군이 다름:

| 시점 | 표적 macrophage 풀 | rhein 작용 가설 | β 기여 추정 |
|---|---|---|---|
| **pre-laser** (T+0~8min) | 진피 *resident* Mφ (잉크 보유) | 미리 SR-A 점유 → 다음 capture cycle 차단 (Baranska 90-d cycle) | β_pre ≈ **0.30** (resident 만) |
| **post-laser** (T+17min) | *방출 잉크 단편* in interstitium (재포획 *전*) | 잉크 표면을 rhein 코팅 → 인근 Mφ SR-A 결합↓ + lymph drainage↑ window | β_post ≈ **0.45** (free pigment dominant) |
| **double-coat** | 둘 다 | (1−β_pre)(1−β_post) → β_combined = **0.615** | 곱셈 |

### hexa-native recompute (verbatim · 🟢)

```
[4] Order-of-op sensitivity (pre vs post vs double):
    pre-only  (beta=0.30)              N= 1.1306
    post-only (beta=0.45)              N= 0.871269
    double-coat (combined 0.615)       N= 0.667579
    -> post-laser is the higher-yield single coat (released pigment in interstitium)
    -> double-coat is multiplicatively superior; ~1.69x cut vs pre-only
```

> **결론**: post-laser 단일 도포가 pre-laser 단일보다 yield↑ (방출 잉크 = 더 큰 표적집단) — 하지만 **double-coat 가 multiplicatively 우월** (~1.69× vs pre-only).

```
   세션수 N (post-laser dominant)
   pre-only  ███▏ 1.13     β_pre=0.30  (resident Mφ 만)
   post-only ██▍  0.87     β_post=0.45 (released pigment in interstitium ← winner)
   double    █▊   0.67     β_combined=0.615 (multiplicative ✓)
```

---

## 4. 통합 타임라인 — months-to-clearance (🟢)

A1 onset + B2 frosting + B3 r↓ 합산 recompute (per `sim/b4_integrated_protocol.hexa`):

```
[2] Session count N (90% clearance) — recompute B1/B2/B3 stack:
    beta_combined (1-(1-bp)(1-bq))     = 0.615   (double-coat)
    r_effective                        = 0.2695
    c_pass (B4)                        = 0.606
    c_session (n=3.7, PFD)             = 0.968
    N_sessions (B4 integrated, model)  = 0.668

[3] Months to 90% clearance (1.6 mo/session, 7-week interval):
    SoC (n=1.4, β=0)                          9.19 mo
    PFD only (n=3.7, β=0)                     3.48 mo
    PFD + single-coat r↓ (β=0.50)             1.28 mo
    B4 PFD + double-coat r↓ (β=0.615)         1.07 mo  [model]
    fold (months) vs SoC                      8.60×    [model]
```

### honest carbon floor — 모델 < 실제

| 항목 | 값 | 근거 |
|---|---:|---|
| 모델 N (B4) | 0.67 세션 | hexa § [2] |
| 모델 months | 1.07 mo | hexa § [3] |
| **carbon 비분해 floor** | **~25% non-clearable** | TTR-ORAL N1/N3 상속 |
| **실용 floor N** | **~1.5 세션** | "carbon 단편화 가능, 화학분해 ✗" |
| **실용 months** | **~2.4 mo** | 1.5 × 1.6 mo/session |
| **B4 vs SoC fold (floor 반영)** | **~3.8× (9.19 / 2.4)** | 정직 |
| **B4 vs SoC fold (model 천장)** | ~8.6× | 모델 한계 — 보고 X |

```
  months-to-90%-clearance (lower = better)
  SoC               █████████████████████ 9.19 mo  (n=1.4, β=0)
  PFD only          ████████              3.48 mo  (n=3.7, β=0)
  PFD + single r↓   ███                   1.28 mo  (n=3.7, β=0.50)
  B4 (double r↓)    ██                    1.07 mo  [model 천장 — 비물리]
  ─────────────────────────────────────────
  honest floor (carbon-25%) █████          2.40 mo  ← B4 실용 보고값
```

> **정직 보고**: 모델은 ~1mo 까지 떨어지지만 carbon black 화학 floor 가 ~75% 절대 clearance 를 강제 → **실용 추정 ~2.4 mo, ~3.8× cut vs SoC**.

---

## 5. 안정성·shelf-life 함의 (🟡)

| 성분 | 분해 모드 | 회피 |
|---|---|---|
| EMLA emulsion | microbial · phase-separation (>30°C) | sealed tube · 실온 · 단회개봉 |
| PFD | 매우 안정 (C-F bond) · 휘발 (open) | sealed silicone patch (DESCRIBE 형태) |
| rhein (anthraquinone) | **photo-labile** (UV → quinone redox) · 산소·열 안정 | **amber single-dose ampoule** + 차광 sachet |
| lidocaine/prilocaine | 가수분해 ✗ (amide) — 매우 안정 | 표준 |
| epi (optional) | 광·산화 (갈변 → 불활성) | 2-8°C · 산화방지제 · single-dose vial |

⇒ **kit SKU 구성**: 4 SKU — (1) EMLA + occlusion film · (2) rhein amber ampoule · (3) PFD patch sealed pouch · (4) [optional] epi single-dose vial. **direct-mix 단일 SKU 불가능** (B2 §6 + rhein photo-labile).

---

## 6. 규제 포지셔닝 (🟡)

| 성분 | FDA status | 임상 경로 |
|---|---|---|
| **PFD patch (DESCRIBE)** | **510(k) cleared** device accessory (Merz 2015·2020 expansion) | 즉시 활용 가능 |
| **EMLA cream** | Rx topical (lidocaine 2.5%/prilocaine 2.5%, 1995) | 즉시 활용 (off-label expansion) |
| **LMX-4** | OTC topical (lidocaine 4% liposomal) | 대체 가능 (EMLA 무폐색 30min 등가) |
| **rhein topical** | **미승인** — diacerein 경구 (EU 골관절염) 만 승인 | **신규 IND/505(b)(2) 필요** (1-3년 + Ph II) |
| **epi (compound)** | LMX+epi compounded — pharmacy 한정 | 약국 처방 |

### 단계별 시장 출시 경로

```
   Phase 0 (즉시):  EMLA + DESCRIBE PFD patch         → 의사 office workflow (off-label) — chair-time SoC 70min · ~3.5mo
   Phase 1 (단기):  + LMX-4 옵션 (EMLA 무폐색 대안) → onset 60→30min · 환자 편의↑
   Phase 2 (1-3y): + rhein topical (505(b)(2) IND)   → ~3.8× clearance · 진정한 차별화 (B4 full)
   Phase 3 (3-5y): + Syk-class topical (β=0.70)      → aspirational ceiling
```

> **near-term 제품 = Phase 0/1 (EMLA/LMX + PFD)** — rhein 은 Phase 2 add-on. B4 의 full integrated form 은 Phase 2 entry point.

---

## 7. honest tier + 한계

| claim | tier |
|---|---|
| 5-stage 타임라인 (60+1+8+1+8+5=83min) · A1 lag·B2 frost-clear·B3 r↓ 곱셈 | 🟢 verbatim (sim §1-3) |
| EMLA-PFD direct-mix ✗ → 순차 (emulsion phase-sep) | 🟠 (B2 §6 추론 · 직접 측정 無) |
| PFD-rhein 양립 (fluorocarbon 비활성) | 🟠 (호환 시험 부재) |
| rhein pre β=0.30 · post β=0.45 · combined 0.615 multiplicative | 🟠 (β 값은 BP1a scaffold · 직접 측정 ✗) |
| post-laser 단일 > pre-laser 단일 (released pigment ↑) | 🔵 (생물학적 추론 · interstitium free vs resident) |
| chair-time 83min vs SoC R20 140 / DESCRIBE 70 | 🟡/🟢 (시간 가산) |
| months-to-clearance 1.07 (model) → 2.4 (floor-honest) | 🟢 / 🟡 (model 천장 · carbon floor 상속) |
| PFD 510(k) DESCRIBE cleared · EMLA Rx · rhein 미승인 | 🟡 (FDA · Merz · drugs.com) |
| anthraquinone photo-labile · PFD volatile w/o patch · EMLA emulsion 안정 | 🟡 (제형 화학 표준) |

### residual gaps (정직)

1. **🟠 rhein topical 의 *재포획 β* 임상 실측 부재** — BP1a scaffold (SR-A 길항 · diacerein 경구 선례) 에서 β=0.50 추정, *실제 잉크-Mφ 재포획 정량 측정 없음*. ex-vivo M8 + in-vivo M9 필요.
2. **🟠 PFD-rhein joint shelf-stability 미시험** — 화학적 비반응은 강한 추론이지만 *공동 patch* 형태 (PFD 함침 patch 표면 + rhein 코팅) 의 12-month 안정성 데이터 없음.
3. **🟠 EMLA-PFD wipe completeness** — 완전 wipe 가정. residual EMLA 가 PFD patch 부착에 미치는 임상 영향 미측정.
4. **🟠 임상 *topical SR-A 길항제 부재*** — rhein 은 후보지 *clinical-grade topical* 제형 부재. compound pharmacy 경로만 가능 (Phase 0).

### 단일 *가장 큰* gap

> 🚨 **#1 — 임상 topical SR-A 길항제(rhein-class)의 in-vivo β 실측 부재** — B4 의 전체 leverage(double-coat 0.615)는 *rhein β=0.30/0.45 추정* 위에 서 있다. wet-lab M8/M9 가 이 숫자를 확정해야 B4 가 🟠 → 🟡 로 올라간다.

---

## 8. B4 verdict

> **5-stage 통합 프로토콜**: EMLA(60min·A1) → wipe(1min·B2제약) → **rhein pre-coat(8min·B3·β=0.30)** → PFD patch(1min·B2) → **multi-pass laser(8min·n=3.7·B2 knee)** → **rhein post-coat(5min·B3·β=0.45)** = **총 ~83min chair-time** (SoC R20 140min 대비 −57min, SoC DESCRIBE 70min 대비 +13min). 모델 N=0.67 세션 (1.07mo), carbon-25% floor 반영 시 **~1.5세션 (~2.4mo) — SoC 9.2mo 대비 ~3.8×** (정직 보고값). 양립성 = **순차 적용 의무** (EMLA-PFD emulsion 깨짐 · rhein pH/photo 분리 ampoule), **direct-mix 단일 SKU 불가**, 4-SKU kit 형태. 적용순서 = **post-laser 단일 > pre-laser 단일** (방출 잉크 = 더 큰 표적풀), **double-coat 가 multiplicatively 우월**. 규제 = Phase 0/1 (EMLA+PFD off-label, 즉시) · **Phase 2 (rhein 505(b)(2) IND, 1-3y) 가 진정한 B4 full**. 잔여 #1 gap = **rhein topical β 임상 실측 (M8 ex-vivo + M9 in-vivo)** — absorbed=false 유지.

---

## Sources

- B1/B2/B3 sims (`TTR-LAC/research/B1_laser_ratelimit.md`, `B2_frosting_clear.md`, `B3_topical_r_down.md`)
- EMLA emulsion 화학 — FDA label (accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf) · PFD-EMLA emulsion 깨짐 추론은 B2 §6 (직접 데이터 부재 🟠)
- PFD physicochem (n=1.313, O₂ 50 mL/100 mL, fluorocarbon 비활성) — refractiveindex.info · ScienceDirect Topics Perfluorodecalin · PMC11614965
- DESCRIBE PFD patch 510(k) — Merz Aesthetics press 2015·2020 expansion · describepatch.com
- Biesman 2017 PFD pivotal — *Lasers Surg Med* PubMed 28319270 (3.7 vs 1.4 passes)
- R20 Kossida 2012 — PubMed 22036610 (4 passes / 20 min waits · 140 min chair)
- Baranska 2018 capture-release-recapture (SR-A · 90-d cycle) — *J Exp Med* rupress.org/jem/article/215/4/1115
- rhein/diacerein anthraquinone (pKa~6.8, photo-labile) — PubChem CID 10168 · *Eur J Med Chem* anthraquinone photodegradation reviews
- LMX-4 (liposomal lidocaine 4%, 30min no-occlusion) — *USPharmacist* topical anesthesia · NCT01842373
- Lidocaine + epi off-label compounding — LMX-Plus 약국 처방 선례
- rhein 505(b)(2) 경로 — diacerein EU 경구 (Artrodar/Artrolyt) 1985 승인 · topical 신규 IND 필요
- 잉크 carbon-black 비분해성 floor — TTR-ORAL N1/N3 상속 (Cu-Pc 10% · Cr₂O₃ wall)
- (재현) `TTR-LAC/sim/b4_integrated_protocol.hexa` — `hexa run TTR-LAC/sim/b4_integrated_protocol.hexa`
