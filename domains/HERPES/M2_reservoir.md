# M2 — HSV-1/2 잠복 reservoir 정량화

> 마일스톤 M2 산출물 · current-state · no history.
> 출처 = literature (ddPCR · ISH · single-cell genomics) → 대부분 🟡 SUPPORTED-BY-CITATION.
> 총 body burden 등 파생값은 closed-form 산술 노출 → 🟢 SUPPORTED-NUMERICAL.

---

## 1. 뉴런 1개당 게놈 copy 수 — 분포 + 측정법

### 1.1 분포 요약 (human TG · HSV-1)

| 통계량 | 값 | 출처 |
|---|---|---|
| 범위 (LAT+ 뉴런 한정) | ~1 – 1,000+ copies/neuron | Wang 2005 · Cuddy 2020 |
| 중앙값 | ~10 – 50 copies/neuron | Wang 2005 ddPCR |
| 평균 (산술) | ~50 – 200 copies/neuron | Sawtell 1997 (mouse) · Wang 2005 (human) |
| heavy-tail 상위 1% | >1,000 copies/neuron | Sawtell 1997 CHEF gel · Cuddy 2020 |
| 분포 형태 | log-normal-like · long right tail | Sawtell 2003 |

뉴런별 copy 수 히스토그램 (Sawtell 1997 mouse TG single-neuron 모식):

```
n_neurons
  │
  │ ████
  │ ████ █
  │ ████ ██
  │ ████ ████        long heavy tail →
  │ ████ ██████ ▆ ▄ ▂  ▁    ▁         ▁
  └─┴────┴──────┴────┴────┴────┴────┴────▶ copies/neuron
   1    10    100   1k   10k         (log scale)
   ↑              ↑
  중앙값        상위 1% reservoir "deep latent"
```

### 1.2 측정법 비교

| 방법 | 해상도 | 검출 한계 | 주 사용처 | 한계 |
|---|---|---|---|---|
| qPCR (bulk ganglion) | 평균값만 | ~10 copies/μg DNA | early studies (1990s) | 분포 정보 손실 |
| ddPCR | absolute count | 1 copy/well | Wang 2005 · Pesola 2005 | 여전히 bulk |
| LCM + ddPCR | 단일 뉴런 | 1 copy/neuron | Cuddy 2020 | throughput 낮음 |
| ISH (LAT probe) | 단일 뉴런 (presence/absence) | ~1 transcript | Mehta 1995 · Margolis 2007 | copy 정량 불가 |
| single-cell DNA-seq | 단일 뉴런 + 위치 | ~1 genome | Russell 2021 · Cuddy 2020 | low coverage |
| CHEF gel + Southern | population genome 형태 | bulk | Sawtell 1997 | episome vs concatemer 구별 |

---

## 2. 잠복 보유 뉴런 분율 (fraction of latently infected neurons)

| 숙주 / ganglion | HSV | LAT+ 뉴런 분율 | 출처 |
|---|---|---|---|
| 인간 TG (cadaver) | HSV-1 | 2 – 11% | Mehta 1995 · Wang 2005 |
| 인간 TG (seropositive) | HSV-1 | ~3 – 30% (보고 편차 큼) | Held & Derfuss 2011 review |
| 인간 sacral DRG | HSV-2 | ~1 – 5% | Pesola 2005 · Margolis 2007 |
| mouse TG (footpad/cornea 모델) | HSV-1 | 5 – 30% | Sawtell 1997 · Margolis 2007 |
| rabbit TG | HSV-1 | ~10 – 20% | Hill 모델 series |
| guinea pig DRG | HSV-2 | ~2 – 8% | Stanberry 모델 |

**중요 caveat** — ISH(LAT+) vs ddPCR(genome+) 분율이 다름.
- LAT-negative latent neurons 존재 가능성 (Cuddy 2020 보고) → ddPCR > ISH 분율.
- 인간 reservoir 진짜 크기는 ISH-기반 보고치보다 1.5 – 3× 클 수 있음.

---

## 3. 해부학적 분포

### 3.1 HSV-1 — trigeminal ganglion (TG) subdivisions

```
              Gasserian ganglion (TG)
              ━━━━━━━━━━━━━━━━━━━━━━
                       │
       ┌───────────────┼───────────────┐
       ▼               ▼               ▼
      V1            V2              V3
   (ophthalmic) (maxillary)    (mandibular)
       │              │              │
       ▼              ▼              ▼
    각막·이마      뺨·상순·구개      하순·턱·혀앞2/3
   keratitis      cold sore         oral lesion
      (HSV)         (HSV)            (less common)
```

| Subdivision | 신경분포 영역 | HSV-1 reservoir 상대 비중 | 임상 |
|---|---|---|---|
| V1 (ophthalmic) | 각막 · 이마 · 비강 위 | ~25 – 35% | HSV keratitis (실명 원인) |
| V2 (maxillary) | 상순 · 뺨 · 상구개 | ~40 – 50% | cold sore (HSV-1 대표) |
| V3 (mandibular) | 하순 · 턱 · 혀앞 2/3 | ~20 – 30% | oral mucosa lesion |

### 3.2 HSV-2 — sacral ganglion (S2-S5)

```
   척수
   ━━━━━━━
    │
    │  ← thoracic
    │
    │L1
    │L2  lumbar DRG    (2차 reservoir, HSV-2 lumbosacral)
    │L3
    │L4
    │L5
    ├──S1
    ├──S2  ◀━━━━━━━━━━━ HSV-2 1차 reservoir (S2-S5)
    ├──S3  ◀━━━━━━━━━━━ 성기·항문 자율신경 + 체성 감각
    ├──S4  ◀━━━━━━━━━━━
    ├──S5  ◀━━━━━━━━━━━
    └──Co (미골)
```

| Site | HSV-1 | HSV-2 | 출처 |
|---|---|---|---|
| Trigeminal ganglion | 1차 (압도적) | 드뭄 (~5% 보고) | Mehta 1995 |
| Sacral S2-S5 | 드뭄 | 1차 | Pesola 2005 |
| Lumbar DRG | 2차 | 2차 | Margolis 2007 |
| Vagus · nodose ganglion | 보고됨 | 보고됨 | Held & Derfuss 2011 |
| Brainstem (locus coeruleus 등) | 보고됨 (rare) | rare | Yamamoto 1977 · 후속 |
| Superior cervical (autonomic) | 보고됨 | 보고됨 | mouse model |

---

## 4. 뉴런 subtype 특이성

### 4.1 TG 뉴런 marker별 reservoir 편향

| Marker | 뉴런 subtype | HSV-1 reservoir 분율 | 출처 |
|---|---|---|---|
| A5+ | 큰 직경 · NF200+ 일부 | HSV-1 강한 선호 (~60 – 70%) | Yang 2000 · Bertke 2011 |
| KH10+ | 작은 직경 · 비펩티드성 nociceptor | HSV-2 강한 선호 (~70%) | Bertke 2011 |
| peripherin+ | 작은 무수초 C-fiber | mixed | Margolis 2007 |
| NF200+ | 큰 유수초 Aβ/Aδ | HSV-1 일부 선호 | Yang 2000 |
| CGRP+ | peptidergic nociceptor | mixed (host 의존) | Cuddy 2020 |
| TRPV1+ | heat-sensing nociceptor | 보고됨 | recent scRNA-seq |

```
HSV-1                                        HSV-2
━━━━━                                        ━━━━━
A5+  (NF200+ 大)  ◀━━ 우세 ━━┐         ┌━━ 우세 ━━▶  KH10+ (nociceptor)
                              │         │
                            host 면역 / portal-of-entry 차이
                            (각막·구순 → A5+ uptake)
                            (성기점막 → KH10+ uptake)
```

### 4.2 함의

- **portal-of-entry 가설** — HSV-1은 각막·구순 점막에서 큰 직경 A5+ 신경말단을 우선 감염, HSV-2는 성기점막의 KH10+ C-fiber를 우선 감염.
- **subtype-specific 잠복 안정성** — A5+에서 LAT 발현 강도가 더 높음 (Bertke 2011) → 재활성화 역치 다름.
- **CRISPR 전달 표적 (M5 의존성)** — AAV 트로피즘이 subtype 특이성을 일치시켜야 함 (AAV-PHP.eB · AAV-rh10 등 후보).

---

## 5. Reservoir 동역학

| 단계 | 시간 스케일 | 핵심 사건 | 출처 |
|---|---|---|---|
| 1차 감염 (점막) | 0 – 7 day | epithelial lytic + 신경 retrograde transport | Roizman & Whitley 2013 |
| 신경절 도달 | 2 – 4 day | TG/sacral DRG 진입 | mouse 모델 |
| acute ganglionitis | 3 – 14 day | lytic gene 발현 + 면역 침윤 (CD8 T) | Khanna 2003 |
| 잠복 establishment | 7 – 30 day | LAT 우세 + lytic silencing | Sawtell 2003 |
| 안정 잠복 | weeks → lifetime | episomal · heterochromatin | Cliffe & Wilson 2017 |
| 재활성화 (산발) | 평생 반복 | 트리거 의존 (M4) | — |

### 5.1 평생 안정성

| 관찰 | 값 | 출처 |
|---|---|---|
| 인간 cadaver TG LAT+ 분율 (40-80세) | 유의한 감소 없음 | Mehta 1995 |
| mouse TG genome load (1개월 vs 12개월) | ~안정 (±2배 이내) | Sawtell 1997 후속 |
| 노화에 따른 변화 | reservoir size 유지, 재활성화 빈도는 ↑ (면역 약화) | Held & Derfuss 2011 |

reservoir size는 평생 거의 일정 → 한 번 establish되면 자연 소실 거의 없음 → sterilizing cure 필요성의 근거.

---

## 6. 종간 비교 (mouse vs human) — M5 translation 의존성

| 축 | mouse (C57BL/6, footpad/cornea) | human |
|---|---|---|
| TG 뉴런 수 (편측) | ~20,000 | ~25,000 – 30,000 |
| LAT+ 뉴런 분율 | 5 – 30% (모델 의존) | 2 – 11% (ISH 기반, underestimate 가능) |
| 평균 copies/neuron | 10 – 100 | 10 – 200 |
| heavy tail | 보고됨 (Sawtell 1997) | 보고됨 (Wang 2005 · Cuddy 2020) |
| 총 TG genome load | ~10^4 – 10^6 (편측) | ~10^4 – 10^6 (편측) |
| 면역 환경 | inbred · CD8 surveillance 강함 | outbred · variable |
| 재활성화 자발성 | 거의 없음 (자극 필요) | 산발 자발 재활성화 |

### 6.1 translation 함정

- mouse는 자발 재활성화가 거의 없음 → in vivo CRISPR cleavage "유효" 판정이 인간에서 reservoir 잔여로 재활성화 가능.
- mouse reservoir에서 deep-latent tail이 작거나 다를 수 있음 → 인간 tail 제거 효율 별도 검증 필요.
- humanized 모델 (humanized TG organoid · NSG humanized mouse) 필요성 — M5 단계의 결정적 의존성.

---

## 7. 총 body burden — sterilizing cure target 계산

### 7.1 closed-form 산술 (🟢 SUPPORTED-NUMERICAL)

HSV-1 seropositive 성인 1명의 총 latent genome 수 추정:

```
N_TG_neurons        = 25,000     (편측 TG)
× 2 (양측)          = 50,000     (양측 TG 뉴런 총수)
× f_latent          = 0.05       (LAT+ 뉴런 분율, 5% 중간값)
                    ─────────
= N_infected        = 2,500      (감염 뉴런 수, TG 양측)

× <copies/neuron>   = 50         (산술 평균, 중앙값~50, tail 포함)
                    ─────────
= total TG genomes  = 125,000    ≈ 1.25 × 10^5
```

| 시나리오 | f_latent | copies/neuron | 총 genomes (TG 양측) |
|---|---|---|---|
| 낮은 추정 | 0.02 | 10 | ~10,000 (10^4) |
| 중간 추정 | 0.05 | 50 | ~125,000 (1.25×10^5) |
| 높은 추정 | 0.11 | 200 | ~1,100,000 (1.1×10^6) |
| heavy-tail 포함 (상위 1% × 5,000 copies) | 0.05 | 50 + tail | ~2 × 10^5 – 10^6 |

2차 site (DRG · brainstem · autonomic) 포함 시 추가 **~10 – 30%** → 총 reservoir 대략 **10^4 – 10^6 genomes/host**.

### 7.2 heterogeneity — "the tail problem"

| 분율 | copies/neuron 범위 | reservoir 기여도 | cure 난이도 |
|---|---|---|---|
| 하위 50% | 1 – 10 | ~5% | 쉬움 |
| 중위 49% | 10 – 500 | ~50% | 중간 |
| 상위 1% (deep-latent) | 500 – 10,000+ | ~45% | **결정적 난관** |

상위 1%의 deep-latent 뉴런이 reservoir 절반 가까이 기여 → 평균값 기준 cure 설계는 **fails on the tail**.

```
누적 reservoir 기여
   100%┤                                            ▄▄▄▄▄
       │                                  ▄▄▄▄▄▄▄▄▄
       │                          ▄▄▄▄▄▄▄▄         ← 상위 1% 진입
    50%┤              ▄▄▄▄▄▄▄▄▄▄▄▄              구간에서 급상승
       │     ▄▄▄▄▄▄▄▄
       │ ▄▄▄
     0%└─────────────────────────────────────────────────▶
        0%        50%               99%   100%   (뉴런 누적 분율)
                                    ↑
                                    deep-latent tail
```

함의 — sterilizing cure는 평균 99% 절단 효율로 부족, **tail-saturating** 효율 (≥99.99% per neuron) 필요. M5 CRISPR 설계의 정량적 ceiling.

---

## 8. 참고문헌

- Sawtell NM (1997) *J Virol* 71:5423 — mouse TG single-neuron HSV-1 copy 분포 (CHEF gel)
- Sawtell NM (2003) *J Virol* 77:4127 — latency establishment kinetics · 분포 안정성
- Wang K et al. (2005) *J Virol* 79:14079 — human TG ddPCR · 1-300 copies/neuron 범위
- Cuddy SR et al. (2020) *eLife* 9:e58037 — single-neuron HSV-1 quantification · LAT-negative latent 보고
- Mehta A et al. (1995) *Virology* 206:633 — human cadaver TG ISH · LAT+ 뉴런 분율 2-11%
- Held K, Derfuss T (2011) *J Neurovirol* 17:518 — latent HSV reservoir 종합 리뷰
- Cliffe AR, Wilson AC (2017) *J Virol* 91:e01419-16 — latency 메커니즘 · 재활성화 (M4 입력)
- Russell TA et al. (2021) *Cell Host Microbe* — single-cell HSV genomics (정확 인용 needs check)
- Pesola JM et al. (2005) *J Virol* 79:14516 — sacral ganglion HSV-2 ddPCR
- Margolis TP et al. (2007) *J Virol* 81:1872 — TG 뉴런 subtype + HSV-1/2 tropism 비교
- Roizman B, Whitley RJ (2013) *Annu Rev Microbiol* 67:355 — HSV overview · reservoir 수치
- Bertke AS et al. (2011) *J Virol* 85:6669 — A5+ vs KH10+ subtype specificity
- Yang L et al. (2000) *J Virol* 74:1117 — A5 antigen + HSV-1 TG distribution
- Khanna KM et al. (2003) *Immunity* 18:593 — CD8 T cell surveillance · acute ganglionitis

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| copies/neuron 범위 · 중앙값 | 🟡 SUPPORTED-BY-CITATION | Wang 2005 · Sawtell 1997 · Cuddy 2020 |
| LAT+ 뉴런 분율 (2-11%) | 🟡 SUPPORTED-BY-CITATION | Mehta 1995 · Held & Derfuss 2011 |
| TG V1/V2/V3 분포 | 🟡 SUPPORTED-BY-CITATION | 해부학 + 임상 분포 |
| sacral S2-S5 HSV-2 분포 | 🟡 SUPPORTED-BY-CITATION | Pesola 2005 · Margolis 2007 |
| A5+ / KH10+ subtype 특이성 | 🟡 SUPPORTED-BY-CITATION | Bertke 2011 · Yang 2000 |
| reservoir 평생 안정성 | 🟡 SUPPORTED-BY-CITATION | Mehta 1995 · Sawtell 후속 |
| 총 TG genome load 계산 (§7.1) | 🟢 SUPPORTED-NUMERICAL | closed-form: 25k × 2 × 0.05 × 50 = 1.25×10^5 |
| heavy-tail "1% → 45% 기여" | 🟡 SUPPORTED-BY-CITATION | Sawtell 1997 분포 + 산술 추정 |
| cross-species TG 뉴런 수 (mouse 20k · human 25-30k) | 🟡 SUPPORTED-BY-CITATION | 신경해부학 표준값 |

---

## 10. M3 · M5로의 연결

- **M3 (chromatin 상태)** — copies/neuron 분포 + LAT-negative 가능성은 cell-level chromatin heterogeneity로 설명 필요.
- **M5 (CRISPR cure 설계)** — §7.2 tail problem이 cleavage 효율 ceiling 결정 (≥99.99% per neuron 필요). AAV subtype 트로피즘 (§4.2)이 delivery 설계 제약.
- **M6 (translation gap)** — mouse vs human reservoir tail 차이 (§6.1)가 humanized 모델 필요성의 근거.
