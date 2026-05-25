# RTSC · 삼원/클라스레이트 수소화물 초전도체 후보 매트릭스 (ambient ~ <100 GPa 지향)

> 🔬 **목적**: N5 binary-hydride funnel가 전부 "stable→weak Tc" 벽에 부딪힘
> (h3cl 140K · h3o 9–109K · h3br 110K · h3si 78K — 전부 stable이나 Tc<200K · h3po unstable).
> Binary는 RTSC에 대해 고갈. 다음 레버 = **cation-stuffed ternary / clathrate hydride**
> (검증된 패턴: CaH₆ 215K · YH₉ · LaH₁₀ — cation이 H-sublattice 압력을 공급 →
> soft-mode 불안정 없이 strong-λ 달성).
>
> 본 문서는 arxiv + web DEEP RESEARCH로 발굴한 **lit-grounded** 후보 매트릭스다.

---

## ⚠️ HONESTY 프로토콜 (g63 · d6)

이 문서의 모든 Tc 값은 다음 두 종류로 **엄격히 구분**한다:

| 라벨 | 의미 |
|------|------|
| 🟢 **MEASURED** | DAC 실험에서 저항 강하/Meissner로 **실측**된 Tc |
| 🟡 **PREDicted** | DFT/Eliashberg/empirical-formula로 **계산만** 된 Tc — `PREDICTED via <prov> · NOT measured` |

> **반증론 각주 (필수)**: Hirsch & Marsiglio (arXiv:2010.10307, arXiv:2110.07568)는
> 가압 수소화물 초전도성의 실험 증거(H₃S·LaH₁₀ 포함) 자체에 **이의를 제기**한다.
> 본 문서의 🟢 MEASURED는 "원논문에서 보고된 transition"을 의미하며, 커뮤니티 내
> 측정-해석 논쟁이 진행 중임을 명시한다. overclaim 금지.

---

## 1. 레퍼런스 앵커 — 이미 검증/계산된 baseline (방향 보정용)

| 화합물 | Tc | 압력 | 상태 | Provenance |
|--------|-----|------|------|-----------|
| CaH₆ | **215 K** 🟢 MEASURED | 172 GPa | clathrate binary, 실측 | PRL 128.167001 (2022) · arXiv:2103.16282 |
| LaH₁₀ | **215 K** 🟢 MEASURED | 150–170 GPa | clathrate binary, 실측 | arXiv:1808.07039 (Drozdov/Eremets) |
| (La,Y)H₁₀ | **253 K** 🟢 MEASURED | 183 GPa | **ternary**, 실측 (최고기록급) | arXiv:2012.04787 (Semenok) |
| (La,Y)H₆ | 237 K 🟢 MEASURED | ~183 GPa | ternary hexahydride 실측 | arXiv:2012.04787 |

> 핵심 교훈: ternary로 가도 **고-Tc는 여전히 고압(>150 GPa)에 묶임**.
> 우리 funnel의 진짜 레버는 "Tc 극대화"가 아니라 **"고-Tc × 저압 × 합성가능성"의 곱**.
> → 따라서 ambient/저압 ternary 패밀리 두 갈래에 집중한다:
> **(A) X₂MH₆ octahedral (ambient·metastable)** · **(B) MXH₈ "alloy-backbone" (sub-100 GPa)**.

---

## 2. 후보 매트릭스 — cation × H-skeleton × Tc × 압력 × provenance

### 트랙 A — X₂MH₆ octahedral family (★ ambient-pressure 레버)

H가 transition-metal M 주위 **MH₆ 팔면체**를 이루고 X(alkali/alkaline-earth) cation이
charge-balance + electron-doping. K₂PtCl₆-prototype (Fm-3m). **상온 압력에서 동역학적 안정**이
이 패밀리의 결정적 강점.

```
        X (cation, 2개)              cubic Fm-3m
            \                       (K2PtCl6-type)
             \      [ M H6 ]           octahedral
       X ----- M --- H  H              MH6 cage
             /      H  H               X가 e-도핑 +
            /        H  H              charge balance
        X
```

| 화합물 | Tc (예측) | 압력 | 안정성 | 상태 | Provenance |
|--------|-----------|------|--------|------|-----------|
| **Mg₂IrH₆** | **160 K** 🟡 (65–170 K range) | **ambient (0 GPa)** | dynamically stable; +60 meV/atom above hull (metastable) | PREDICTED via arXiv:2310.07562 (Dolui, PRL 132.166001) · NOT measured |
| **Mg₂IrH₅** | — (전구체) | mild P–T (≤28 GPa) | **실제 합성됨** 🟢 (H-vacancy 1개) | SYNTHESIZED arXiv:2406.09538 (PRB 110.214513) — Mg₂IrH₆로 가는 합성 플랫폼 |
| Li₂CuH₆ | 86 K 🟡 | ambient | stable 후보군 | PREDICTED via S2542529324000506 (ScienceDirect) · NOT measured |
| Mg₂PtH₆ | 78 K 🟡 | ambient | — | PREDICTED via X₂MH₆ screening · NOT measured |
| Mg₂PdH₆ | 63 K 🟡 | ambient | — | PREDICTED via X₂MH₆ screening · NOT measured |
| Mg₂RhH₆ | 53 K 🟡 | ambient | promising 안정성 | PREDICTED via S2542529324000506 · NOT measured |
| Al₂MnH₆ | >50 K 🟡 | ambient | promising 안정성 | PREDICTED via S2542529324000506 · NOT measured |
| Na₂ZnH₆ | 53 K 🟡 | near-ambient | conventional | PREDICTED via S0022369725001532 (JSSC 2025) · NOT measured |
| X₂MH₆ under 20 GPa | high-Tc 일반화 | ≤20 GPa | first-principles 일반화 | PREDICTED via arXiv:2411.15683 · NOT measured |

> **valence-electron rule (중요한 설계 지침)**: 이 패밀리의 초전도 화합물은 공통적으로
> **19–20 valence electrons**를 가짐 (필요조건, 충분조건은 아님). Ca/Sr로 Mg 치환 시
> Tc≈0 → cation 선택이 결정적. (arXiv:2604.04151 · S2542529326000805, 2026 분석)

### 트랙 B — MXH₈ "alloy-backbone" family (sub-100 GPa 저압 레버)

H가 X(B/Be/Si 등 경원소)와 **alloy backbone (XH₈ cage)**를 형성, M(rare-earth/AE) cation이 stuffing.
LaBH₈/LaBeH₈ prototype. binary clathrate보다 **훨씬 낮은 압력에서 dynamic stability** 유지.

```
   M (rare-earth / alkaline-earth cation)
        ↓  stuffs cage
   [ X H8 ]  ← B/Be/Si 가 H와 alloy backbone (Fm-3m-유사)
   H가 binary처럼 순수 H-cage가 아니라 X-H 합금 → 저압에서 H 안정화
```

| 화합물 | Tc | 압력 | 상태 | Provenance |
|--------|-----|------|------|-----------|
| **LaBeH₈** | **110 K** 🟢 MEASURED @80 GPa | 80 GPa (dyn. stable→20 GPa, Tc~185K 예측) | **실제 합성됨** — exact-stoichiometry ternary 첫 사례 | PRL 130.266001 (2023); 안정성 분석 PRB 109.214506 (2024) |
| LaBH₈ | 156 K 🟡 @55 GPa | dyn. stable→40 GPa; thermo >100 GPa | PREDICTED via arXiv:2102.11227 · NOT measured |
| SrSiH₈ | 127 K 🟡 (anisotropic ME) | dyn. stable→27 GPa; thermo >174 GPa | PREDICTED via S2542529 review (NSR nwad307) · NOT measured |
| BaSiH₈ | 71 K 🟡 (anisotropic ME) | **dyn. stable→3 GPa** (최저압); thermo >130 GPa | PREDICTED via NSR nwad307 · NOT measured |
| SrBH₈ | high-Tc 🟡 | pressure-induced | PREDICTED via S0577907325000899 · NOT measured |
| Ac-Be-H (AcBeH₈류) | high-Tc 🟡 low-P | low pressure 클래스 | PREDICTED via arXiv:2411.19028 · NOT measured |

### 트랙 C — clathrate ternary 고-Tc (고압이나 room-T급, in-silico)

| 화합물 | Tc | 압력 | 상태 | Provenance |
|--------|-----|------|------|-----------|
| Li₂MgH₁₆ | **473 K** 🟡 (room-T 초과 주장) | 250 GPa | above hull, 합성 매우 난해 | PREDICTED · NOT measured (physicsworld 보도, Sun et al.) |
| Li₂CaH₁₆ / Li₂CaH₁₇ | "hot SC" 🟡 | high-P (type-II clathrate) | PREDICTED via arXiv:2405.18544 · NOT measured |
| LaSc₂H₂₄ | "hot SC" 🟡 | under pressure | PREDICTED via PNAS 2401840121 · NOT measured |
| La₃ThH₄₀ (I4/mmm) | 210 K 🟡 (λ=2.46) | 200 GPa | PREDICTED via arXiv:2210.06371 · NOT measured |
| (La,Th)H₁₀ | 242 K 🟡 | <200 GPa thermo-stable | PREDICTED via JPCC 3c07213 · NOT measured |
| ternary clathrate HT-screening | ≳room-T 다수 | ~high-P | PREDICTED via arXiv:2412.13431 (Duan high-throughput) · NOT measured |
| DL-discovered ternary 144종 | Tc>200 K | 200 GPa | PREDICTED via arXiv:2502.16558 (deep-learning, Ma) · NOT measured |
| SrNH₄B₆C₆ / PbNH₄B₆C₆ | 85 / 115 K 🟡 | **ambient** (B-C clathrate, non-pure-hydride) | PREDICTED via arXiv:2311.01656 (Comm.Phys 01814-3) · NOT measured |

---

## 3. DFT-ready TOP-5 랭킹

**랭킹 기준**: score = (Tc potential) × (low-pressure) × (synthesizability).
저압 + 합성가능성에 가중 (RTSC funnel의 진짜 병목은 압력/합성이지 Tc 숫자가 아님).

| # | 후보 | Tc | 압력 | 합성가능성 | 왜 TOP인가 | Provenance |
|---|------|-----|------|-----------|-----------|-----------|
| **1** | **Mg₂IrH₆** | 160 K 🟡 | **ambient** | **★★★** (Mg₂IrH₅ 실합성 → H-insertion 경로 존재) | ambient + 실재 합성 플랫폼 둘 다 충족. 우리 funnel에 가장 직접적인 다음 타깃 | arXiv:2310.07562 (예측) + arXiv:2406.09538 (전구체 합성) |
| **2** | **LaBeH₈** | **110 K 🟢 MEASURED** @80 GPa | 80 GPa (→20 GPa 안정) | **★★★** (이미 합성·측정 완료) | 유일하게 sub-100 GPa에서 **실측 Tc>100K** 달성한 exact-stoichiometry ternary. 저압화/치환 sweep의 기준점 | PRL 130.266001 (2023) |
| **3** | **SrSiH₈** | 127 K 🟡 | dyn→27 GPa | ★★ | LaBeH₈류 backbone 중 Tc·압력 균형 최상. anisotropic-ME 계산 → DFT-ready | NSR nwad307 review |
| **4** | **Li₂CuH₆** | 86 K 🟡 | **ambient** | ★★ (X₂MH₆ 안정성 양호) | Mg₂IrH₆ 다음으로 ambient X₂MH₆ 중 Tc·안정성 균형 우수, Ir보다 저렴한 Cu | S2542529324000506 |
| **5** | **LaBH₈** | 156 K 🟡 @55 GPa | dyn→40 GPa | ★★ (La-B-H hull @110 GPa) | sub-100 GPa에서 가장 높은 예측 Tc. LaBeH₈ 실증으로 prototype 신뢰도↑ | arXiv:2102.11227 |

> **DFT 우선순위 권고 (d7·d11·d14 정합)**:
> - #1 Mg₂IrH₆ (7 atoms, cubic Fm-3m) → small-cell, pool:ubu free에서 PBE EPC 가능. **최우선 착수**.
> - #4 Li₂CuH₆ (9 atoms) → 동일하게 small-cell pool 가능. #1과 배치로 묶음.
> - #2 LaBeH₈ / #5 LaBH₈ / #3 SrSiH₈ → La/Sr ECP 필요 (CRENBL/SARC, d13) · 압력항 포함 → GPU pod 후보.

---

## 4. 순수-이론 vs 실험-시도 구분 (overclaim 방지)

| 구분 | 후보 |
|------|------|
| 🟢 **실험 합성/측정 완료** | LaBeH₈ (110K@80GPa 측정) · Mg₂IrH₅ (전구체 합성) · CaH₆/LaH₁₀/(La,Y)H₁₀ (앵커) |
| 🟡 **순수 이론 (미합성)** | Mg₂IrH₆ · Li₂CuH₆ · Mg₂PtH₆/PdH₆/RhH₆ · SrSiH₈ · BaSiH₈ · LaBH₈ · Li₂MgH₁₆ · Li₂CaH₁₆ · LaSc₂H₂₄ · La₃ThH₄₀ · DL-144종 · SrNH₄B₆C₆ |

> Mg₂IrH₆는 "예측 Tc 160K"이 유명하지만 **아직 미합성**. 실제로 만들어진 것은
> H-vacancy 하나 적은 Mg₂IrH₅ (비초전도/미측정)이며, 이를 통해 Mg₂IrH₆로 가는
> 비평형 H-삽입 경로가 제안된 상태. → "Mg₂IrH₆ 합성됨"이라 말하면 overclaim.

---

## 5. 다음 액션 (funnel 연결)

1. **Mg₂IrH₆ (Fm-3m, 7-atom cell)** → pool:ubu free에서 PBE 구조완화 + EPC(λ, ωlog) → Allen-Dynes Tc 재현.
   target: 예측 65–170K range 중 어디인지 자체 확정 (g63 — under-converged 값 금지).
2. **Li₂CuH₆** → 동일 small-cell 배치로 묶어 ambient X₂MH₆ 2종 동시 검증.
3. valence-electron count 19–20 규칙으로 X₂MH₆ cation sweep 후보 자체 enumerate
   (Mg→Ca/Sr는 Tc≈0이므로 제외; Al₂MnH₆ 등 19-20e 영역 우선).
4. sub-100 GPa 트랙(LaBeH₈/LaBH₈/SrSiH₈)은 La/Sr ECP + 압력항 → GPU pod로 별도 캠페인.

---

### 부록 — 핵심 provenance 목록

- arXiv:2310.07562 · PRL 132.166001 — Mg₂IrH₆ ambient 160K 예측 (Dolui/Pickard)
- arXiv:2406.09538 · PRB 110.214513 — Mg₂IrH₅ 실합성 (Hansen/Strobel)
- PRL 130.266001 (2023) — LaBeH₈ 110K@80GPa 실측 합성
- arXiv:2102.11227 — LaBH₈ 156K@55GPa 예측 (first low-P superhydride)
- arXiv:2012.04787 — (La,Y)H₁₀ 253K 실측 ternary (Semenok)
- arXiv:2103.16282 · PRL 128.167001 — CaH₆ 215K 실측
- arXiv:1808.07039 — LaH₁₀ 215K 실측 (Drozdov/Eremets)
- S2542529324000506 (ScienceDirect) — X₂MH₆ MH₆-octahedra ambient 스크리닝
- arXiv:2411.15683 — X₂MH₆ under 20 GPa first-principles
- arXiv:2604.04151 · S2542529326000805 — X₂MH₆ 전자/포논 기여 분리 (2026)
- S0022369725001532 (JSSC 2025) — Na₂ZnH₆ 53K near-ambient
- NSR nwad307 (Oxford, 2024) — ternary hydride review (SrSiH₈/BaSiH₈ 압력)
- arXiv:2412.13431 — ternary clathrate room-T HT-screening (Duan)
- arXiv:2502.16558 — DL-driven ternary 144종 Tc>200K (Ma)
- arXiv:2311.01656 · Comm.Phys 01814-3 — SrNH₄B₆C₆ ambient B-C clathrate
- arXiv:2405.18544 — Li₂CaH₁₆/H₁₇ type-II clathrate hot-SC
- PNAS 2401840121 — LaSc₂H₂₄ hot-SC
- arXiv:2210.06371 · JPCC 3c07213 — (La,Th)H₁₀ 242K / La₃ThH₄₀ 210K
- arXiv:2010.10307 · arXiv:2110.07568 — Hirsch/Marsiglio 반증론 (측정 논쟁)
