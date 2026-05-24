# M1 — Lp(a) 구조 + apo(a) KIV-2 isoform

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = literature + UniProt → 🟡 SUPPORTED-BY-CITATION.

---

## 1. Lp(a) 정체 — LDL + apo(a) 결합 입자

Lp(a) = LDL 입자 1개 + **apo(a)** 1개가 **disulfide bond**로 공유결합. 1963년 Berg 발견.

```
   ┌─────────────────────────────────┐
   │      LDL core (TG · CE)         │
   │   ┌───────────────────────┐     │
   │   │   apoB-100 (단일)     │◀──┐ │
   │   └───────────────────────┘   │ │
   │            ▲                  │ │
   │            │ disulfide        │ │
   │            │ (Cys4326-CysIV9) │ │
   │   ┌────────┴────────┐         │ │
   │   │  apo(a)         │         │ │
   │   │  ━━━━━━━━━━━━━━━│         │ │
   │   │  KIV · KV · pro │         │ │
   │   └─────────────────┘         │ │
   └───────────────────────────────┴─┘
            ↓                       ↓
       LDL 유사 죽상화          plasmin 유사
       (apoB 매개)             (피브린 결합 → 혈전촉진)
```

→ Lp(a)는 **죽상경화 + 혈전촉진 + 염증** 3중 위험 — LDL과 별개 위험 인자.

---

## 2. apo(a) 도메인 구조

apo(a)는 **LPA 유전자** (chr6q25-q27) 산물. plasminogen 유전자 복제에서 진화.

| 도메인 | 풀이 | 개수 | 기능 |
|---|---|---|---|
| signal peptide | — | 1 | 분비 신호 |
| **KIV-1** | Kringle IV type 1 | 1 | apoB 결합 보조 |
| **KIV-2** | Kringle IV type 2 | **3-40+ (개체별 가변!)** | **isoform 크기 결정** |
| KIV-3 ~ KIV-10 | Kringle IV type 3-10 | 1 each | KIV-9 = apoB disulfide site · KIV-10 = LBS (lysine binding site) |
| **KV** | Kringle V | 1 | plasminogen KV 유사 |
| **protease-like** | inactive serine protease | 1 | catalytic Ser → Ser 활성 X (가짜 protease) |

```
N ─ SP ─ KIV1 ─ [KIV-2 × n] ─ KIV3 ── KIV9 ── KIV10 ─ KV ─ Pr ─ C
                  ↑                ↑       ↑
                  반복 (3~40+)    apoB    LBS (lysine
                  유전적 가변     결합     binding site)
```

---

## 3. KIV-2 copy number ↔ Lp(a) plasma level (inverse)

```
KIV-2 copy 수            isoform 크기            Lp(a) plasma
   ──────                   ──────                  ──────
   3 ─ 7    →    small (high)         →     높음 (≥50 mg/dL)
   8 ─ 14   →    medium               →     중간
  15 ─ 40+  →    large (low)          →     낮음
```

→ KIV-2 copy 수와 plasma Lp(a)는 **inverse** 관계 (작은 isoform = 분비 효율 ↑).
→ Lp(a) 농도는 **유전 결정성 ~90%** — 식이/운동/스타틴 거의 영향 X.

---

## 4. Lp(a) 농도 분포 + cutoff

| cutoff | 임상 의미 |
|---|---|
| < 30 mg/dL (< 75 nmol/L) | 정상 |
| 30-50 mg/dL (75-125 nmol/L) | borderline |
| **≥ 50 mg/dL (≥ 125 nmol/L)** | **고위험 (~20% 인구)** |
| **≥ 180 mg/dL (≥ 430 nmol/L)** | **고도 고위험 (~1%)** |

⚠️ **단위 caveat**: mg/dL vs nmol/L 환산 1:1 X — isoform-dependent. 가급적 **nmol/L** (입자 수 기반) 사용.

---

## 5. 인종/지역별 Lp(a) 분포 (M2 입력)

| 인종 | 중앙값 (mg/dL) | ≥ 50 mg/dL 비율 | 비고 |
|---|---|---|---|
| 백인 (유럽) | ~10-14 | ~20% | 표준 reference |
| **한국인** | **~13** | **~10-15%** | KoGES — M2에서 상세 |
| 동아시아 | ~10-15 | ~10-15% | |
| 남아시아 | ~17 | ~25% | 일관되게 높음 |
| 흑인 (아프리카) | **~33-50** | **~35-40%** | 글로벌 최고 |

→ 한국인은 백인 대비 다소 낮으나 **≥ 50 mg/dL 군 분포는 비슷** → 절대 환자수 큼.

---

## 6. Lp(a) → 3중 위험 메커니즘

| 위험 축 | 메커니즘 | 임상 endpoint |
|---|---|---|
| **죽상경화** | apoB → 혈관벽 침착 + oxidized phospholipid (OxPL) carrier | MACE · MI · stroke |
| **혈전촉진** | KIV-10 LBS → 피브린 결합 → plasminogen 활성 방해 | thrombosis · MI |
| **염증** | OxPL → 단핵구·foam cell 활성화 | 진행성 ASCVD |
| **대동맥 협착** | aortic valve OxPL 침착 → 칼슘화 | calcific aortic stenosis |

---

## 7. Lp(a) 저감 가능 약제 (M3-M5 입력)

| 약제 | Lp(a) 저감 | 비고 |
|---|---|---|
| 스타틴 | ↑ 또는 무효 | 오히려 살짝 증가 |
| ezetimibe | 무효 | |
| PCSK9i (evolocumab · alirocumab) | -20-30% | 부분 효과 |
| niacin | -25% | 부작용 + outcome benefit X |
| **CETP inhibitor (obicetrapib)** | -50% | 임상 진행 중 |
| **ASO (pelacarsen)** | **-80%** | **HORIZON Ph3 (M3)** |
| **siRNA (olpasiran)** | **-95%** | OCEAN(a) Ph3 (M4) |
| siRNA (lepodisiran) | -94% | Ph2 완료 |
| siRNA (zerlasiran) | -82% | Ph2 |

→ **siRNA/ASO**가 유일한 임상 가능한 강력 저감 — M3/M4 핵심.

---

## 8. 참고문헌

- Berg K (1963) *Acta Pathol Microbiol Scand* 59:369 — Lp(a) 최초 발견
- McLean JW et al. (1987) *Nature* 330:132 — apo(a) cDNA cloning · plasminogen 상동성
- Boerwinkle E et al. (1992) *J Clin Invest* 90:52 — KIV-2 copy number ↔ level
- Tsimikas S (2017) *JACC* 69:692 — Lp(a) review (clinical)
- Kronenberg F et al. (2022) *Eur Heart J* 43:3925 — **EAS consensus** (current)
- Erqou S et al. (2009) *JAMA* 302:412 — Lp(a) ↑ → CHD risk (meta)
- Tsimikas S et al. (2020) *NEJM* 382:244 — pelacarsen Ph2
- O'Donoghue ML et al. (2022) *NEJM* 387:1855 — olpasiran Ph2 (-95%)
- Nissen SE et al. (2023) *JAMA* 330:2075 — lepodisiran Ph1
- Nicholls SJ et al. (2024) *JAMA* 332:1986 — obicetrapib Ph2

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| Lp(a) 구조 (LDL + apo(a) disulfide) | 🟡 SUPPORTED-BY-CITATION | McLean 1987 + UniProt |
| apo(a) 도메인 (KIV/KV/Pr) | 🟡 SUPPORTED-BY-CITATION | UniProt P08519 |
| KIV-2 copy ↔ plasma inverse | 🟡 SUPPORTED-BY-CITATION | Boerwinkle 1992 |
| 인종별 분포 | 🟡 SUPPORTED-BY-CITATION | Patel 2021 (UK Biobank) · KoGES → M2 |
| siRNA/ASO 저감 % | 🟡 SUPPORTED-BY-CITATION | NEJM Ph2/3 |
| 임상 outcome (MACE 감소) | 🟠 INSUFFICIENT/DEFERRED | HORIZON · OCEAN(a) Ph3 결과 대기 |

🔑 핵심 통찰:
- Lp(a) = **유전적 결정성 90%** → 식이/스타틴 무효 → siRNA/ASO만 강력 저감
- 한국인 ≥ 50 mg/dL **~10-15%** = 절대수 ~500만 명대 (M2에서 정량)
- **임상 outcome 데이터는 2026-2028 Ph3 (HORIZON · OCEAN(a))** — 임팩트 큰 분기점
