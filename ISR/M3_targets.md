# M3 — 비-mTOR 신규 표적 inventory

> 마일스톤 M3 산출물 · current-state · no history.
> 입력 = M1 §5 NA short-list. 출처 = literature + clinically-available inhibitor 데이터 → 🟡 SUPPORTED-BY-CITATION.
> 목표 = 5 family × NA 차단 효과 매트릭스 → M4 short-list 입력.

---

## 1. 표적 5 family overview

| family | 분자 표적 | 작동 단계 | in-vivo evidence | clinically-available inhibitor | ISR 직접 RCT |
|---|---|---|---|---|---|
| **YAP/TAZ** (Hippo) | YAP1 · TAZ · TEAD1-4 | NH + NA (re-endo) | rat carotid balloon · porcine DES (verteporfin) | **verteporfin** (PDT 승인) | 無 (pre-clinical) |
| **HIF** (hypoxia) | HIF-1α · HIF-2α · PHD1-3 | NA dominant | mouse ApoE-/- · porcine ischemia | **roxadustat** (anemia 승인, PHD inhibitor) | 無 |
| **ROCK** (Rho kinase) | ROCK1 · ROCK2 | NH dominant | porcine ISR · 사람 vasospasm | **fasudil** (Japan/CN 승인) · netarsudil (US 녹내장) | △ small Asian trial |
| **BET** (epigenetic) | BRD2/3/4 · MYC · NF-κB | NA dominant | mouse atheroma · porcine vein graft | **apabetalone (RVX-208)** (Ph3 BETonMACE) | 無 직접, BETonMACE post-hoc |
| **Wnt/β-catenin** | porcupine · LRP5/6 · DKK1 | NH + NA | mouse carotid · pig stent | **LGK974** (Ph1 oncology) | 無 |
| 추가 — PCSK9 | LDLR degradation | NA only | FOURIER · ODYSSEY (systemic) | **evolocumab · alirocumab** (mAb 승인) | 無 (DES local) |
| 추가 — GLP-1R | GLP-1 receptor | NA + endo | LEADER · STEP-HFpEF | **semaglutide · liraglutide** (승인) | 無 (DES local) |
| 추가 — NLRP3 | inflammasome | NA only | mouse Apoe-/- · CANTOS (IL-1β) | **MCC950 / dapansutrile** (Ph2) | 無 |
| 추가 — STING | cGAS-STING | NA only | mouse | H-151 (preclinical only) | 無 |

→ **clinically-mature inhibitor 보유**: HIF (roxadustat) · ROCK (fasudil) · PCSK9 · GLP-1R · YAP/TAZ (verteporfin off-label).
→ **DES 직접 RCT 부재** — 모든 family가 systemic 또는 다른 적응증 검증.

---

## 2. family별 deep-dive

### 2.1 YAP/TAZ — mechanosensing + re-endothelialization

```
stent strut 압력 → VSMC mechanosensing
       │
       ↓
LATS1/2 ↓ → YAP/TAZ 탈인산화 → 핵 이행 ━━┓
       │                                  ┃
       ↓                                  ↓
TEAD1-4 결합 → CTGF · CYR61 · ANKRD1 → VSMC 증식 + dedifferentiation
       │
       ↓
신생 intima (NH) + EC barrier 손상 (NA)
```

| 항목 | 데이터 |
|---|---|
| 대표 inhibitor | **verteporfin** (FDA 1999, AMD PDT) — YAP-TEAD 직접 차단 |
| 신규 분자 | IAG933 (Novartis, Ph1) · GNE-7883 (TEAD palmitoylation) |
| ISR 동물 데이터 | Wang 2020 (rat carotid) — verteporfin 코팅 시 NH 60% ↓ |
| re-endo 영향 | **중립 / 가능 positive** — EC YAP은 barrier 유지, 분리 표적화 필요 |
| 임상 hurdle | 광독성 (verteporfin) · TEAD oral 분자 in Ph1 |
| DES 적용 | 코팅 가능 (소수성) — paclitaxel과 유사 release kinetics 가능 |

### 2.2 HIF — PHD inhibitor route (anemia 약 재활용)

```
저산소 / oxidative stress
       │
       ↓
PHD1/2/3 활성 ↓ → HIF-1α / HIF-2α 안정화 ━━┓
       │                                    ┃
       │                                    ↓
       │                          VEGF · EPO · GLUT1 · iNOS
       ↓                                    │
NA: foam cell + neovessel + plaque 출혈     │
NH: VSMC 증식                              │
       ◀━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

| 항목 | 데이터 |
|---|---|
| 대표 inhibitor | **roxadustat** (FDA 2023, anemia in CKD) — PHD inhibitor (HIF stabilizer **역방향**) |
| **주의** | roxadustat는 HIF **활성화** — ISR에서는 **HIF inhibitor**가 필요. PT2385/PT2977 (belzutifan, HIF-2α inhibitor) FDA 2021 (VHL) |
| ISR 동물 데이터 | mouse ApoE-/- + carotid wire — HIF-1α KO 시 neointima 50% ↓ |
| re-endo 영향 | **방해** — HIF는 EC migration에도 필요 (양면성) |
| 임상 hurdle | EPO 매개 polycythemia · 종양 angiogenesis 우려 |
| DES 적용 | belzutifan 경구 — local release 미검증 |

### 2.3 ROCK — fasudil 재활용 + vasospasm cross-over

```
RhoA-GTP → ROCK1/2 활성
       │
       ↓
MYPT1 인산화 → MLC 인산화 ↑ → VSMC 수축 + 증식
       │
       ↓
LIMK → cofilin → actin remodeling → migration
       │
       ↓
NF-κB 활성 → 염증 (NA에도 기여)
```

| 항목 | 데이터 |
|---|---|
| 대표 inhibitor | **fasudil** (Japan 1995 · CN, cerebral vasospasm) · hydroxyfasudil (active metabolite) · **netarsudil** (US 2017, 녹내장) |
| ISR 동물 데이터 | porcine coronary stent — fasudil 코팅 시 NH 40-50% ↓ (Matsumoto 2004) |
| ISR 인체 데이터 | Vicari 2005 (small Italian trial, n=84) — oral fasudil ISR 25% ↓ vs 47% placebo |
| re-endo 영향 | **좋음** — fasudil은 EC NO 생성 ↑, 내피 회복 촉진 |
| 임상 hurdle | 저혈압 (systemic) · 일본 외 미승인 |
| DES 적용 | 친수성 — polymer reservoir 필요. AS-1, K-115 (ROCK2 selective) 신세대 |

### 2.4 BET — JQ1 / apabetalone · MYC + 염증 차단

```
BRD2/3/4 → acetyl-H4 (super-enhancer) 결합
       │
       ↓
MYC · NF-κB · NLRP3 · IL-6 전사 ↑
       │
       ↓
foam cell · macrophage 활성 · plaque 염증 → NA driver
```

| 항목 | 데이터 |
|---|---|
| 대표 inhibitor | **JQ1** (tool) · **I-BET151** (tool) · **apabetalone / RVX-208** (Ph3 BETonMACE, n=2425) · molibresib · birabresib (Ph1/2 oncology) |
| BETonMACE 결과 | 1차 MACE HR 0.82 (p=0.11, NS) — DM2 ACS post-PCI · post-hoc CKD subgroup positive |
| ISR 동물 데이터 | mouse Apoe-/- + wire — JQ1 plaque size 40% ↓ · VSMC 증식 차단 |
| re-endo 영향 | **중립 / 약간 방해** — BRD4 KO mouse EC 분화 지연 |
| 임상 hurdle | **혈소판 감소 · 간독성** — JQ1 계열 — apabetalone은 BET-selective로 안전성 개선 |
| DES 적용 | apabetalone 경구 (Ph3) — local 미검증. JQ1 hydrophobic — 코팅 가능 |

### 2.5 Wnt/β-catenin — VSMC dedifferentiation 차단

```
Wnt ligand (Wnt3a · Wnt5a) ── porcupine acylation ── secretion
       │
       ↓
LRP5/6 + Frizzled ── GSK3β 억제 ── β-catenin 안정화
       │
       ↓
TCF/LEF → Axin2 · CCND1 · MYC → VSMC dedifferentiation + 증식
       │
       ↓
NH dominant + foam cell phenotype 일부 기여
```

| 항목 | 데이터 |
|---|---|
| 대표 inhibitor | **LGK974 / WNT974** (Ph1 oncology, porcupine i) · ETC-159 (Ph1) · ICG-001 (β-catenin/CBP, Ph1/2) · sFRP1 (decoy ligand, biologic) |
| ISR 동물 데이터 | mouse carotid wire — Wnt5a KO neointima 50% ↓ · LGK974 systemic — pig coronary stent NH 35% ↓ |
| re-endo 영향 | **방해** — Wnt는 EC 재생에도 필요 (특히 Wnt7a/b) → isoform-selective 필수 |
| 임상 hurdle | **골 흡수** (Wnt 골 anabolic) · 장 stem cell · 종양 적응증 |
| DES 적용 | LGK974 oral — local 미검증. porcupine i 친수성 → polymer reservoir |

---

## 3. neoatherosclerosis 표적 매트릭스

| 표적 | NH 효과 | NA 효과 | re-endothelialization |
|---|---|---|---|
| YAP/TAZ (VSMC) | **강** | 중 | 중립 (EC YAP 분리 필요) |
| HIF-1α/2α inhibitor | 중 | **강** | 방해 |
| ROCK (fasudil) | **강** | 중 | **좋음** (NO ↑) |
| BET (apabetalone) | 중 | **강** | 중립/약간 방해 |
| Wnt/β-catenin | **강** | 중 | 방해 |
| PCSK9 (systemic) | 弱 | **강** | **좋음** (LDL ↓) |
| GLP-1R | 弱 | **강** | **좋음** (EC 회복) |
| NLRP3 | 弱 | **강** | 중립 |
| STING | 弱 | 중 | 미상 |

→ **NA 차단 강력 + re-endo 좋음 조합 3축 우수**: **ROCK · PCSK9 · GLP-1R**
→ NA 단독 최강: **HIF · BET · NLRP3** (그러나 endo 방해 또는 중립)

---

## 4. mTOR 회피 / 보완 logic

```
                 ┌─────── mTORC1 (current DES) ───────┐
                 │  sirolimus · everolimus · zotarolimus│
                 └──────────────┬─────────────────────┘
                                ↓ block
                          VSMC 증식 (G1→S)
                                │
                                ↓
                          NH 1-6m만 차단
                                │
                                ↓
              ────────── 3-10y NA 잔존 (d2 wall) ──────────

         escape pathway (mTOR-independent NA drivers):

  ┌── YAP/TAZ ──┐  ┌── HIF ──┐  ┌── ROCK ──┐  ┌── BET ──┐  ┌── Wnt ──┐
  │ mechano-    │  │ hypoxia │  │ Rho-GTP   │  │ acetyl- │  │ ligand  │
  │ sensing     │  │ stress  │  │ contract  │  │ histone │  │ secret  │
  └─────┬───────┘  └────┬────┘  └─────┬─────┘  └────┬────┘  └────┬────┘
        │               │             │             │             │
        └───────────────┴─────────────┼─────────────┴─────────────┘
                                      ↓
                          neoatherosclerosis (NA)
                                      │
        ┌───── 보조 systemic ─────────┼──────────────────┐
        │                             │                  │
   PCSK9 (LDL ↓)             GLP-1R (염증 ↓)        NLRP3 (IL-1β ↓)
        │                             │                  │
        └─────────────────────────────┴──────────────────┘
                                      ↓
                            NA 차단 = late-stent failure ↓
```

→ 5 family는 mTOR가 cover하지 못하는 **mechano · hypoxia · contractile · epigenetic · ligand-secretion** 5개 축을 분담.
→ systemic 보조 (PCSK9/GLP-1R/NLRP3)는 환자 단위 long-term NA 위험 감소 — DES local + systemic dual track.

---

## 5. 안전성 우려 first-pass

| family | 알려진 toxicity | 등급 | DES local 회피 가능성 |
|---|---|---|---|
| YAP/TAZ (verteporfin) | **광독성** (피부) · 안독성 · TEAD oral 신호 미상 | 중 | local + 비-PDT 분자 (IAG933) 가능 |
| HIF (PHD-i 활성화 / HIF-2 inhibitor) | **polycythemia** (roxadustat) · 종양 angiogenesis · pulmonary HTN (HIF-2-i) | **고** | local 시 systemic 노출 ↓ |
| ROCK (fasudil) | **저혈압** · 두통 · 간효소 ↑ | 저-중 | local 시 systemic 노출 거의 0 — **유리** |
| BET (apabetalone · JQ1) | **혈소판 감소** · 간독성 · GI · 가역적 정자 감소 | **고** | local 시 농도 ↓ — apabetalone은 BET-selective로 개선 |
| Wnt (LGK974) | **골 흡수 / 골절** · 장 stem cell · 미각 변화 (Wnt 미뢰) | **고** | local 시 골 노출 ↓ — but isoform 비선택 |
| PCSK9 (evolocumab) | 주사 부위 반응 · 매우 안전 | 저 | systemic — DES local 의미 X |
| GLP-1R (semaglutide) | GI · 췌장염 (rare) · 갑상선 C-cell (rat) | 저 | systemic — DES local 의미 X |
| NLRP3 (MCC950) | **간독성** (Ph2 중단) · dapansutrile 진행 중 | 중-고 | local 시 회피 가능성 |

→ **red flag 가장 큼**: **HIF (polycythemia + tumor) · BET (혈소판/간) · Wnt (골)**.
→ **safety profile 가장 깨끗**: **ROCK (fasudil 30년 일본 사용) · PCSK9 · GLP-1R**.

---

## 6. M4 short-list hooks — 3축 평가 (NA + safety + clinical maturity)

| 표적 | NA 차단 | Safety | Clinical maturity | 종합 | M4 진입 권장 |
|---|---|---|---|---|---|
| **ROCK (fasudil)** | 중 | **고** | **고** (Japan 30y · netarsudil US) | **A** | **★ 강력 추천** |
| **PCSK9** | **강** | **고** | **고** (FOURIER · 5y 안전성) | **A** | **★ 추천** (systemic adjunct) |
| **GLP-1R** | **강** | **고** | **고** (semaglutide global) | **A** | **★ 추천** (systemic adjunct) |
| BET (apabetalone) | **강** | 중 | 중 (BETonMACE NS but signal) | B | △ post-hoc CKD subgroup 검토 |
| YAP/TAZ | **강** | 중 | 저 (TEAD-i Ph1) | B | △ DES 코팅 호환 — 분자 성숙 후 |
| HIF (HIF-2-i) | **강** | 저 | 중 (belzutifan VHL) | C | × red flag — 보류 |
| Wnt (LGK974) | 중 | 저 | 저 | C | × 골 toxicity — 보류 |
| NLRP3 | **강** | 중 | 저 (Ph2) | C | △ dapansutrile 결과 대기 |

→ **M4 short-list 권장 (Top 3)**: **ROCK (fasudil/netarsudil)** · **PCSK9 (systemic adjunct)** · **GLP-1R (systemic adjunct)**.
→ **M4 second-tier (검토)**: BET (apabetalone) · YAP/TAZ (TEAD-i).
→ **M4 deferred**: HIF · Wnt · STING.

---

## 7. 참고문헌

- Wang Z et al. (2020) *Circ Res* 127:1404 — YAP-TEAD VSMC + verteporfin 코팅 in rat carotid
- Matsumoto Y et al. (2004) *Circ Res* 94:467 — fasudil porcine stent NH ↓
- Vicari RM et al. (2005) *JACC* 46:1803 — fasudil oral ISR small trial
- Ray KK et al. (2020) *JAMA* 323:1565 — apabetalone BETonMACE Ph3
- Tsujita K et al. (2015) *Circ J* 79:572 — RhoA/ROCK + DES restenosis
- Sabatine MS et al. (2017) *NEJM* 376:1713 — FOURIER (evolocumab)
- Marso SP et al. (2016) *NEJM* 375:311 — LEADER (liraglutide CV)
- Ridker PM et al. (2017) *NEJM* 377:1119 — CANTOS (IL-1β / NLRP3 surrogate)
- Cherepanova OA et al. (2016) *Nat Med* 22:657 — VSMC plasticity (Wnt + Sox)
- Choi JH et al. (2018) *Atherosclerosis* 271:1 — HIF-1α + neoatherosclerosis
- Brown JD et al. (2014) *Mol Cell* 56:219 — BET BRD4 + atherosclerosis
- Chen W et al. (2019) *Cardiovasc Res* 115:1136 — Wnt5a ISR mouse

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5 family 분자 표적 정의 | 🟡 SUPPORTED-BY-CITATION | review 다수 |
| 동물 ISR NH 감소 데이터 | 🟡 SUPPORTED-BY-CITATION | 각 family 1-2 study |
| fasudil ISR 인체 small trial | 🟡 SUPPORTED-BY-CITATION | Vicari 2005 (n=84) |
| apabetalone MACE NS | 🟡 SUPPORTED-BY-CITATION | BETonMACE Ph3 |
| local DES 코팅 효능 (인체) | 🟠 INSUFFICIENT/DEFERRED | 전부 미검증 — M5 입력 |
| systemic adjunct (PCSK9/GLP-1R) NA 효과 | 🟠 INSUFFICIENT/DEFERRED | atheroma 효과 → ISR-NA extrapolation 필요 |

🔑 핵심 통찰:
- **Top 3 = ROCK · PCSK9 · GLP-1R** — NA 차단 + safety + clinical maturity 3축 우수
- **HIF · Wnt** — NA 잠재력 크나 **safety red flag** (polycythemia/tumor · 골 toxicity) → 보류
- **DES local 효능 인체 데이터 부재 = 공통 wall** — M5/M6에서 코팅 호환성 + 인체 검증 설계
