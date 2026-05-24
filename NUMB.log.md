# NUMB — log

## 2026-05-25T20:15Z — G4 SKU split — DUAL (OTC-A + Rx-V1) 권고 · V2 trigger 게이트 deferred

round-3 G4 milestone CLOSED. 격리 worktree `/tmp/numb-g4-13d09607` (branch `numb-g4-sku-13d09607`, base origin/main d686334).

- [x] **G4** (`G4_sku_split.md` + `g4_sku_split.hexa`) — 🟢 numerical + 🟡 cite + 🟠 V2 wet-lab gate honest
  - **결정 트리 verdict = DUAL** (OTC-A + Rx-V1) — single (Rx-V1 only) 대비 +29pp TAM / +$3.5M / 0yr critical-path 추가, triple (V2 추가) 는 +9pp TAM 에 +$40M·+2yr·+10pp cannib 으로 incremental NPV 음수
  - **OTC-A spec**: lidocaine 4% 단독 · no eutectic · no epi · onset 55.6min (LMX-class) · margin 179× @ 400 cm² · indication = minor cuts/burns/sunburn/scrapes/irritation/insect bites (21 CFR 348.50 fixed wording) · 면적 cap 200 cm² (성인) · 100 cm² (소아 ≥2y) · cost $2-5M / 1-2 yr
  - **Rx-V1 spec**: hexa-LAC v1 (lid 7+tet 7+epi+peel-film) · onset 2.78min · depth ~95% MEC · duration 105min · margin 68× · Pliaglis-class indications (laser hair removal/IPL/filler/dermal proc) · cost $15-50M / 5-7yr (505(b)(2))
  - **Rx-V2 spec (deferred)**: V1 + capric 10-15% ternary · onset = V1 (N6 honest: a/K_sc != t_lag) · depth C/MEC 12 · duration 195min · 안와 contra · 소아 contra · cost $20-60M / 6-8yr
  - **V2 trigger 가드레일** (3 조건 동시): N6 DSC+Franz PASS + tattoo-sleeve TAM ≥$200M 측정 + V1 yr2 trailing revenue ≥$50M
  - **indication × SKU 매트릭스**: OTC-A primary = I2 needle + I5 biopsy + I6 pediatric · V1 primary = I1 hair (face/leg) + I3 vasc + I4 typ + I7 filler · V2 primary = I1-back + I4-max sleeve
  - **소아 SKU 매핑** (G3 prilocaine-free): OTC-A primary (monograph ≥2y, MetHb 경로 자체 부재) · V1 secondary (clinic, +epi 면적 cap 50 cm²) · V2 contra (capric pH-sting)
  - **안와 / G6 사전 정의**: V2 CONTRA (BLT corneal class wall, JCAD 2016) · V1/OTC-A "avoid contact with eyes" (FDA 표준)
  - **TAM 추정**: single ~62% / dual 91% / triple 100% — cannib-adjusted dual 85.9% · triple 85.0% (triple 가 dual 에 패배)
  - **deep research** (d18 정합 round-3): 21 CFR 348.10/348.50 lid/tet 한도 + Drug Facts fixed wording verbatim · LMX-4 (Ferndale) drugs.com/SingleCare 가격 ~$42/30g · Pliaglis 2008 voluntary withdrawal + Galderma reapproval (PracticalDermatology) · Lidocaine HCl market $701M→$964M CAGR 5.53% (Mordor Intelligence)
  - **honest framing**: V2 정량 (a-boost · K_sc shift · J_ss 6×) 은 Schröder-VL 예측 only → wet-lab gate 까지 🟠. cannibalization 5%/15% 는 추정 (가격/면적 분리 가정). market capture 5-15% addressable conversion 도 추정
  - **재현**: `cd /tmp/numb-g4-13d09607 && hexa run NUMB/sim/g4_sku_split.hexa`

남은 게이트: G5 (포장/안정성) · G6 (인접토픽 양립성) · G7 (사용자 가이드) · NUMB-oracle (multi-indication wet-lab PASS).

## 2026-05-25T17:30Z — /cycle round-2 완결 (d18 정합): G2 regulatory + G3 pediatric + N6 ion-pair eutectic — 3개 milestone CLOSED

round-2 fan-out 결과 통합 entry. 3 agent 모두 d18 정합 (NOVEL + arxiv + web deep research 내장).

- [x] **G2** (`G2_regulatory_pathway.md` + `g2_regulatory_matrix.hexa`) — 🟡 cite-based
  - **선례 9건 매핑**: Pliaglis NDA 21-717 · EMLA 1984 SE national · LMX-4/5 · Synera NDA 21-623 · DESCRIBE 510(k)+drug · LET/BLT compounded · 국내 리도카겔 5% · 엠마오플러스 9.6%
  - **Rx variant path 확정**: US 505(b)(2) (Pliaglis 직접 RLD, $15-50M·5-7yr) · EU national→MRP (EMLA 1984 SE 선례, $0.5-1.5M·1.5-3yr) · KR 자료제출의약품 전문 (~$1.5-7.5M·3-5yr)
  - 🚨 **OTC variant WALL**: 21 CFR 348.10 lid 0.5-4% / tet 1-2% → G1 round-1 OTC 5+5% 가정 + 2.5+2.5 *둘 다* tet 한도 초과 → **flagship OTC 재정의 = lid 4% 단독** (LMX-5/Aspercreme class)
  - 4 OTC workaround: A=lid-only 4% (✓ $2-5M·1-2yr) · B=lid 4+tet 2 한도내 ($10-30M·4-6yr) · C=OTC switch NDA ($30-60M·6-8yr) · D=compounded
  - **SHORTEST commercial path**: KR 일반의약품 (리도카겔 5% 선례, ~$2M·2-4yr) · MFDS 2025 reform 420→295일·fee ₩410M
  - **device-drug 결정**: HPC peel-film = 수동 carrier = drug PMOA → CDER NDA 단일 path (Synera 선례, 별도 510(k) 불필요)
  - **deep research** (d18): 21 CFR 348 정확 한도 fetch (Cornell LII), Pliaglis Phase 3 n=50/indication, EMA Article 30 EMLA referral
  - **G1→G2 보정**: OTC 5+5% 가정 US monograph 불가 → G4 spec 재조정 트리거 (G-track fix-introduces-axis)

- [x] **G3** (`G3_pediatric_LAST.md` + `g3_pediatric_LAST.hexa`) — 🟢 numerical
  - **체중 기반 closed-form**: `Cmax(ng/mL) = 0.1834 × A(cm²)` (G1 inheritance) · age-adjusted threshold = 5000 × (CL_age/CL_adult × AAG_adult/AAG_age) → 신생아 2500 · 영아<6mo 2500 · 6-12mo 3500 · 1-3y 4200 · 3-6y 4500 · ≥6y 5000 ng/mL
  - **6 연령대 envelope** (모두 ≥10× spec ✅): 신생아 (3.5kg/7cm²/60min · margin 1947× **BORDERLINE clinical-defer**) · 영아 1-6mo (6kg/20cm² · 682×) · 6-12mo (8.5kg/20cm² · 954×) · 유아 1-3y (12.5kg/100cm² · 229×) · 학령전 3-6y (18kg/100cm² · 245×) · 학령 6-12y (28kg/200cm² · 136×) · 청소년 12-18y (55kg/400cm² · 68×)
  - **+epi 50% Cmax reduction** = dominant headroom (Pliaglis k=0.0533 × f_epi 0.5 anchor)
  - **prilocaine-free 정합**: NUMB v1 (lid 7%+tet 7%) → o-toluidine MetHb path 자체 없음 → EMLA <37wk preterm 금기 + <12mo MetHb-inducer 병용금기 wall composition 으로 제거 (FDA DailyMed 019941s021)
  - **MetHb 우위 정량**: EMLA pediatric pooled >3% MetHb rate ~10% (Essink-Tjebbes/Brisman/Frey) vs NUMB v1 ~0.1% (Ametop UK 20yr surveillance proxy) = **100× 우위**
  - **honest framing**: 신생아 수치 margin 1947× 이지만 PK 미성숙 (AAG 0.5×·CL 0.5×) + 임상 데이터 부족 → "권고 사용은 ≥1mo + clinical confirmation" 명시
  - **deep research** (d18): 9 clinical (Brisman 1998 · Essink-Tjebbes 1999 · Frey 1998 · Jain 2000 · Lemyre 2006 · Reis 2003 · Lander 2005 · PMC9746881 SR · LMX-4) + 3 arxiv (Sopasakis 2019 fractional PK · Saffaran 2025 neonate digital twin · Wesolowski 2021 gamma-Pareto)

- [x] **N6** ion-pair / ternary eutectic (`N6_ion_pair_eutectic.md` + `n6_ion_pair_eutectic.hexa`) — 🟠 INSUFFICIENT/DEFERRED · **PR #110 MERGED**
  - Schröder-Van Laar framework + Yuan 2015 PMC4444629 anchor (lid+tet 1:1 measured 29.95°C)
  - 3 후보: A=BLT-ternary (lid+tet+benzo 8:4:20) 1.1× flux · B=lid+tet+LA (0.4:0.4:0.2) 5× · **C=lid+tet+capric (0.4:0.4:0.2) 6× (TOP · N1 PCM cross-axis triple-stack)**
  - **honest framing (N1 학습 적용 · @D d6)**: a (활동도) + K_sc 는 `J_ss = D·K·a` flux multiplier → **steady-state** · `t_lag = h²/(6D)` D-driven UNCHANGED → **onset 무관, depth + duration + SC delivery 효율**, NOT onset 가속
  - 🚨 **safety wall**: BLT compounded 임상 corneal damage → 안와 사용 contraindicated (JCAD 2016 PMC4896822)
  - **IP freedom-to-operate**: WO2004103260A2 (Pliaglis family) prilocaine 중심 4-mer 청구 → BLT + lid+tet+capric/LA 회피 여지 ✅
  - **breakthrough min-spend**: DSC $200-500 + Franz 1-point $500-1000 = **$700-1500** → 🟠→🟡 승격 (cheapest NOVEL probe)
  - **deep research** (d18): arxiv Pontrelli 2014 · Potticary 2019 DES · web Yuan 2015 anchor · BLT compounded JCAD · Tatara 2021 sucrose laureate 11.95× flux · IP WO2004103260A2

**round-2 종합 cross-finding**:

```
G2 OTC-wall (tet 한도 2%)  ──┐
G3 prilocaine-free 우위    ──┼──→ G4 SKU split 재설계:
N6 N1 cross-axis 가능        ──┘    OTC = lid 4% 단독 (소아 1순위 후보 · prilocaine-free)
                                    Rx = hexa-LAC v1 · hexa-LAC v2 (+ capric ternary N6-C)
```

G-track 진행 = **3/7 closed** (G1·G2·G3) · NOVEL = **3 active** (N1·N5·N6). 잔여 = G4·G5·G6·G7·oracle.

## 2026-05-25T07:05Z — G3 agent 보고 (worktree → main untracked · roundup 통합 흡수됨)

(상기 17:30Z entry 의 G3 row 가 본 entry 를 흡수. 격리 위반 cleanup: 본 entry 의 원본 untracked 파일은 roundup PR 에서 정리 commit 으로 land.)

## 2026-05-25T01:00Z — /cycle round-1 완결: G1 hair-removal anchor + N1·N5 NOVEL (정직 재포지셔닝)

- [x] G1 (`G1_indication_map.md` + sim) — laser hair removal anchor ($1.4-1.6B 2025·95% topical 사용) → 스펙: onset ≤30min·100-400cm²·LAST ≥10× margin·+epi mandatory. 8 indication 매핑: hexa-LAC v1 **7/8 단일 SKU 커버** (예외: 타투 *제작* sleeve 1000cm²×120min Cmax 826ng/mL 6× margin → 5+5% derate+split → 16.9× margin). 🎯 gap = **OTC 5+5% ↔ Rx 7+7%+epi+peel-film 듀얼 SKU**. tier 🔵/🟢/🟡/🟠. (🚨 round-2 G2 에서 OTC monograph WALL 로 보정 — lid 4% 단독으로 재설계)
- [x] N1 phase-change peel-film — 🚨 **정직 재포지셔닝**. Pliaglis(water-evap)와 trigger 축 다름(body-T 32-35°C PCM carrier melt · capric+palmitic 32.17°C·lauric+myristic 34.28°C 후보). **그러나 첫 가설 "onset 가속" Fick first-principles로 반증** (activity a는 lag-time 무관, 정상상태 flux만 ×). 진짜 가치 = a 2→5 (2.5×) **flux multiplier @ steady-state** → C_surf 낮춰도 동일 depth → **G3 소아 / G4 OTC 저농도 SKU 기여** (onset이 아니라 depth/duration). wall = latent-heat 28min full-melt 100μm sub-layer 우회.
- [x] N5 Mg multi-modal — 🟠. NMDA+VGCC 직렬 + Na-channel(lid) 시너지. r_mg=0.30(IV/perineural 25-40% 외삽), lid 7→4.9% depth-matched, **A_max +43%, 타투 sleeve 400-800cm² 단일세션 unlock**. 🚨 토픽 Mg+lido MEC shift 임상 ZERO (deep research 4 RCT 모두 *주사형*). 1-point Franz cell ED50 study가 🟠 결정.
- 🔬 **deep research synthesis** (병렬 진행 · 본 세션):
  - Mg+lido 시너지: 임상 RCT 4건 견고 (IANB·femoral·brachial·dental) but 전부 주사형 — *토픽* unverified
  - N1 prior art: Pliaglis(Alster 2007 lid7+tet7 peel) + USPTO 9186334(heat-assisted 35-47°C lid+tet) — N1은 body-T(32-35°C)·PCM trigger로 차별화
  - 🚨 **소아 EMLA prilocaine wall**: o-toluidine → MetHb. 신생아<37주 금기·체중<20kg 면적시간 제한 → **NUMB 소아 SKU = prilocaine-free 필수 (lid+tet만)** 권고 — hexa-LAC v1이 이미 정합 ✅
  - arxiv SC 물리 5건 (2510.14606 등): MD 기반 SC permeation diffusivity 1자릿수 변동 = A5 honest gap 정합
- 종합 round-1 insight: hexa-LAC v1이 7/8 indication 커버 (✅) · 듀얼 SKU OTC/Rx gap 식별 · N1은 onset 아닌 depth/duration 기여 · N5는 large-area unlock but topical 실측 필요 · 소아 SKU prilocaine-free 정합.

## 2026-05-25T00:35Z — 도메인 생성 (TTR-LAC A 트랙 spinoff · 범용 마취 크림)

- [x] M0 — domain scaffold (사용자 지시: "마취크림만 추가진행하자 · 범용으로 많이 쓰이니까")
  - **스핀오프 모델**: TTR-LAC 의 A 트랙(A1·A2+A3·A4·A5)은 *레이저 타투제거 세션 한정* 컨텍스트였으나 — SC permeation/D-boost/depth/LAST 모델은 **procedure-agnostic 일반 자산**. NUMB 가 이 자산을 상속해 범용 indication·regulatory·OTC/Rx 듀얼·소아 안전으로 확장.
  - **핵심 상속**: t_lag=h²/(6D) · CPE 42×→in-vivo 5-10× · C(z) depth · Pliaglis LAST · hexa-LAC v1 제형. 본 도메인은 새 화학 *재발견 X* — 제형 최적화 + 다용도 매핑 + 규제 path 만.
  - **확장 7 milestone (G-track)**: G1 indication map · G2 regulatory pathway · G3 소아 LAST · G4 OTC/Rx variant · G5 포장/안정성 · G6 인접 토픽 양립성 · G7 사용자 가이드.
  - **honest framing (@D d5/d6)**: 마취 chemistry 는 수십 년 임상 well-established — 본 도메인 *새 발견 가능성 낮음*, *제품화*가 목표. 과대 약속 금지.
  - **시장 정합 신호**: EMLA(Rx) · LMX-4(OTC) · BLT(compounded) · Pliaglis(Rx peel-film) · DESCRIBE(PFD patch) 등 다양한 form factor 가 이미 존재 — gap = *범용 빠른 onset + LAST 안전 면적·소아 envelope* 의 한 제품군.

Append-only history sister of `NUMB.md`. `## <ISO timestamp> — <header>` (newest on top).
