# NUMB — current state

> 🧊 **NUMB** — "범용 빠른 마취 크림" · procedure-agnostic 토픽 마취 (주사·레이저·문신제작·피부과·소아·미용) (per @D d10)

@goal: **범용(procedure-agnostic) 토픽 마취 크림** — onset ≤ 20min(target) / ≤ 10min(stretch) · 다양한 indication 한 제형으로 커버 · LAST 안전 envelope 면적·소아 체중별 정합 · OTC(저농도) ↔ Rx(고농도+epi) 듀얼 SKU. measured-oracle PASS 까지 absorbed=false

> **parent**: 스핀오프 from `TTR-LAC.md` (track A · 레이저-병용 한정) — A1·A2+A3·A4·A5 의 SC permeation·D-boost·depth·LAST 모델 *전부 상속*.
> **확장 범위 vs TTR-LAC-A**: indication map (8+ 사용처) · regulatory pathway (US/EU/KR · OTC vs Rx) · 소아 LAST 스케일링 · multi-indication 제형 variant (저농도 OTC ↔ 고농도+epi Rx) · 단회용 ampoule/패치 vs 튜브 포장.
> **honest framing (@D d5/d6)**: 마취 chemistry·PK는 well-established (수십 년 임상) · 본 도메인 = *제형 최적화 + 다용도 매핑 + 규제*. 새 화학 발견 가능성 낮음 → "더 빠르고 안전한 *제품화*" 목표. 과대 약속 금지.

## 핵심 상속 (TTR-LAC A 트랙)

| 자산 | 값 | 출처 |
|---|---|---|
| SC 율속 `t_lag = h²/(6D)` | EMLA D=1e-10 → 27.8min×2=55.6min ≈ 임상 60min | TTR-LAC/A1 |
| D-boost 메커니즘 | CPE(LA+EtOH MD 42× · Franz 10-15× · in-vivo 5-10×) · eutectic · supersat · liposomal | TTR-LAC/A2+A3·A5 |
| 깊이 모델 | `C(z)=C_surf·exp(−z/λ)` · epi 1:200k → λ 40→60μm | TTR-LAC/A3 |
| LAST 정량 | Pliaglis k=0.0533 ng/mL/mg lido · 100cm²×30min+epi → Cmax 18 ng/mL (273×) | TTR-LAC/A4 |
| 기준 제형 | lid 7%+tet 7% eutectic + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film | TTR-LAC/A2+A3·A4 |

## Milestones (progress)

### G — 범용 확장 (general-purpose mapping)
- [x] G1 → `NUMB/research/G1_indication_map.md` (+ sim) · 🟢 · **hair-removal anchor 스펙** = onset ≤30min · 100-400cm² · LAST ≥10× margin · 30min apply · +epi mandatory · 시장 $1.4-1.6B 2025 · 95% topical 사용 · **hexa-LAC v1 = 7/8 indication 단일 SKU 커버** (예외: 타투 *제작* sleeve 1000cm²×120min → 5+5% de-rate+split) · gap = **OTC 5+5% ↔ Rx 7+7%+epi+peel-film 듀얼 SKU** (🚨 G2 에서 OTC monograph WALL 로 보정)
- [x] G2 → `NUMB/research/G2_regulatory_pathway.md` (+ sim `g2_regulatory_matrix.hexa`) · 🟡 · **Rx variant** = US 505(b)(2) (Pliaglis NDA 21-717 직접 RLD, $15-50M·5-7yr) · EU national+MRP (EMLA 1984 SE 선례, $0.5-1.5M·1.5-3yr) · KR 자료제출의약품 전문 (~$1.5-7.5M·3-5yr) · **OTC variant 🚨 WALL**: 21 CFR 348.10 lid 0.5-4% / tet 1-2% → G1 OTC 5+5% 가정 + 2.5+2.5 *둘 다* tet 한도 초과 → **flagship OTC 재정의 = lid 4% 단독** (LMX-5 class, $2-5M·1-2yr) · **SHORTEST commercial** = KR 일반의약품 (리도카겔 5% 선례, ~$2M·2-4yr) · device-drug = drug PMOA → CDER NDA 단일 path (Synera 선례 · 별도 510(k) 불필요) · G1→G2 보정: OTC SKU 농도 재조정 (G4 territory)
- [x] G3 → `NUMB/research/G3_pediatric_LAST.md` (+ sim) · 🟢 · **6 연령대 (신생아 → 청소년) 모두 PASS** (Cmax_pred margin 68-1947× vs age-adj threshold 2500-5000 ng/mL) · 신생아 (<28d) row = 수치 PASS 이지만 **honest framing BORDERLINE/clinical-defer** (PK 미성숙 · AAG 0.5× · CL 0.5×) · **prilocaine-free NUMB v1 → EMLA <37wk preterm 금기 + <12mo MetHb-inducer 병용금기 wall composition 으로 제거** · +epi 50% Cmax reduction = dominant headroom · MetHb 우위 100× (EMLA ~10% vs NUMB ~0.1% pooled >3% rate) · I6 (G1 deferred) CLOSED
- [ ] G4 — 제형 variant — 🚨 **G2 wall 후 재설계 필요** · OTC 후보 A=lid 4% 단독 (LMX-5 class) / B=lid 4+tet 2 한도내 / C=OTC switch NDA · Rx hexa-LAC v1 + Rx hexa-LAC v2 (+ N6-C capric ternary) 듀얼 · indication 매핑
- [ ] G5 — 포장/안정성 — 단회용 ampoule (procedure 직전) · multi-dose tube (홈케어) · patch (DESCRIBE 형식) · 광안정성 (LA·rhein·capric 가족) · shelf-life 24mo+ 목표
- [ ] G6 — 인접 토픽 양립성 — sunscreen · antiseptic (chlorhexidine·povidone) · moisturizer · 화장품 · 동일부위 시간차 도포 가이드
- [ ] G7 — 3-step 사용자 가이드 (indication 별) — 도포→대기→procedure 시점 (소비자 친화 워크플로 + 시각 가이드 + onset 타이머) · OTC vs Rx 라벨 자동 분기

### N — NOVEL probes (round-1 · round-2)
- [x] N1 phase-change peel-film → `NUMB/research/N1_phase_change_peelfilm.md` (+ sim) · 🟠 plausibly-novel · **Pliaglis와 mechanism 축 다름** (water-evap vs body-T 32-35°C PCM carrier melt · capric+palmitic 32.17°C 후보) · 🚨 **정직 재포지셔닝**: activity a 는 Fick lag-time 무관 → **onset 가속 ✗** · 진짜 가치 = a 2→5 (2.5×) **flux multiplier @ steady-state** → **depth 보전+duration↑** → G3 소아·G4 OTC 저농도 SKU 에 기여 (C_surf 낮춰도 같은 depth) · wall = latent-heat 28min full-melt → 100μm sub-layer 아키텍처 fix
- [x] N5 Mg²⁺ multi-modal → `NUMB/research/N5_Mg_multimodal.md` (+ sim) · 🟠 INSUFFICIENT/DEFERRED · 기전: NMDA+VGCC 직렬 차단 → MEC↓ · r_mg=0.30 (IV/perineural 25-40% 외삽) → **lid 7→4.9%, A_max +43%, 타투 sleeve 400-800cm² 단일세션 unlock** · 🚨 deep research 확인: 임상 Mg+lido *주사형*만(IANB·femoral·brachial RCT) · **토픽 직접 MEC shift 측정 ZERO** = central r_mg=0.30이 단일 missing measurement에 의존 · breakthrough = Phase 1 Franz/pin-prick ED50 study → 🟠→🟡/🔴
- [x] N6 ion-pair / ternary eutectic → `NUMB/research/N6_ion_pair_eutectic.md` (+ sim) · 🟠 INSUFFICIENT/DEFERRED (Schröder-VL framework validated · Yuan 2015 anchor lid+tet 29.95°C measured) · 3 후보 정량: A=BLT-ternary 1.1× · B=lid+tet+LA 5× · **C=lid+tet+capric 6× (TOP · N1 PCM cross-axis triple-stack)** · honest framing (N1 학습 적용): a·K_sc 는 J_ss flux multiplier · `t_lag` 무관 → **depth+duration**, NOT onset · 🚨 safety: BLT corneal damage → 안와 contraindicated (JCAD 2016) · IP freedom-to-operate ✅ (WO2004103260A2 prilocaine 중심) · breakthrough min-spend $700-1500 (DSC + Franz 1-point)

### oracle
- [ ] NUMB measured-oracle — multi-indication PASS (onset 95% ≤target · LAST < threshold · pediatric envelope · OTC/Rx 듀얼 승인) → absorbed=true

## verify (per @D g5 · hexa-native)
- [ ] V1 claim inventory + tier triage (🔵/🟢/🟡/🟠) — TTR-LAC V1 38 claim 흡수 + NUMB G-track 신규
- [ ] V2 🔵 — LAST 체중 스케일 closed-form · indication 매핑 정합 · OTC/Rx 농도-onset 곡선
- [ ] V3 🟢 — hexa-native recompute (체중별 dose · 농도-onset · indication PASS rate)
- [ ] V4 final tier ledger
