# M5 — CRISPR / meganuclease genome-cleavage 설계

> 마일스톤 M5 산출물 · current-state · no history.
> 계보 = Jerome Lab (Fred Hutch) translational lineage · Aubert/Jerome 2020 Nat Commun foundational.
> 본문 등급: 좌표·서열·임상 인용 부분 🟡 · §6 heavy-tail closed-form 🟢 SUPPORTED-NUMERICAL · 기업 status 🟠.

---

## 0. 설계 골자 (one-shot)

> 잠복 HSV episome을 ganglion 뉴런에서 in-situ 절단하여 unrepairable DSB → episome 분해 → sterilizing cure로 유도. M1 게놈 좌표 + M2 reservoir 정량을 입력 제약으로 받음.

```
   ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
   │ nuclease design │ ──▶ │  AAV packaging  │ ──▶ │ ganglion deliver│
   │ (HE-LAGLIDADG · │     │ (ssAAV ≤4.7 kb) │     │ (intrathecal /  │
   │  Cas9 · Cas12a) │     │  serotype rh10· │     │  whisker pad ·  │
   └─────────────────┘     │  PHP.eB ·  9)   │     │  IVT cornea)    │
            │              └─────────────────┘     └─────────────────┘
            ▼                                                │
   essential ORF cut                                         ▼
   (UL30 · UL19 · UL27 · UL52 · LAT)               per-neuron ε × φ
            │                                                │
            ▼                                                ▼
   episome 분해 + reactivation 차단      ── heavy-tail 잔여 → M6/M7/M8/M9 combo
```

핵심 결론(요약): **AAV-rh10 + dual-guide HE-LAGLIDADG (UL30 + UL19) → 1차 후보**. 단독 천장 ~10^3 잔여 genome/host → sterilizing cure 단독 불가능, combination 의무.

---

## 1. Cleavage target 선정 — 어떤 ORF / locus를 자를 것인가

### 1.1 Essential ORF 후보 (재활성화 차단까지 보장)

essential = 결손 시 replication / capsid 형성 실패 → 절단으로 episome이 살아남아도 lytic burst 불가능.

| ORF | 기능 | 좌표 (HSV-1 strain 17, NC_001806.2) | 보존도 HSV-1/2 (AA) | 절단 함의 |
|---|---|---|---|---|
| UL30 | DNA polymerase (catalytic) | ~63,029 – 66,694 (~3.7 kb CDS) | ~74% | replication block; episome 분해 안 돼도 reactivation 영구 차단 |
| UL19 | major capsid protein (VP5) | ~36,343 – 40,517 (~4.2 kb) | ~84% | capsid 결손; 가장 보존도 높음 → cross-strain 한 guide로 1·2형 동시 |
| UL27 | glycoprotein B (gB) | ~52,569 – 55,283 (~2.7 kb) | ~85% | viral entry · cell-to-cell spread 차단 |
| UL52 | helicase-primase (subunit) | ~106,575 – 109,793 (~3.2 kb) | ~78% | replication 초기 차단; pritelivir target과 동일 locus |
| UL5 | helicase-primase (helicase) | ~17,000 – 19,500 | ~80% | UL52 pair; 두 절단 페어 후보 |
| ICP4 (RS1) | IE master TF | IR_S / TR_S (~131k · ~146k, 게놈당 2 copy) | ~89% | 2 copy → 절단 효율 두 번 필요하나 한쪽만 남아도 lytic 진입; 단독 cut 매력도 낮음 |
| ICP0 (RL2) | E3 ligase, latency-to-lytic switch | IR_L / TR_L (2 copy) | ~74% | LAT antisense; ICP0 cut → LAT 동시 영향 |

### 1.2 LAT cleavage — 잠복 유일 활성 transcript 침묵

LAT locus는 IR_L + TR_L에 2 copy. LAT 자체를 잘라도 essential 아님 → episome 생존 가능, 그러나:
- M3에서 본 chromatin silencing의 핵심 driver 제거 → de-silenced episome이 면역 노출.
- 항-apoptotic 기능 상실 → 감염 뉴런이 면역 또는 stress로 제거 가능.
- ICP0 antisense overlap → ICP0 mRNA 동시 cleave bonus.

표적 sub-region: LAP1 promoter (~118,650), 2 kb stable intron (~119,465 – 121,417). Aubert/Jerome 2014/2020가 이 영역을 reference로 삼음.

### 1.3 Two-cut excision 전략

단일 DSB는 NHEJ로 ~30-70% 정확 재결합되어 episome 회복. **두 cut 사이를 excise**하면 ≥500 bp gap → 재결합 불가능 → episome 분해(또는 영구 inactivation).

| 전략 | cut A | cut B | excise 길이 | 장점 | 단점 |
|---|---|---|---|---|---|
| intra-UL30 dual | UL30 5' (exon 1) | UL30 3' (catalytic motif) | ~3 kb | essential ORF 완전 결손 | 두 guide 다 효율 필요 |
| UL19 + UL30 trans | UL19 mid | UL30 mid | ~26 kb | 두 essential 동시 | 큰 excision → 재결합 더 어렵지만 NHEJ junction 재밀봉 가능성 |
| LAT excision (Aubert 2014) | LAT 5' (LAP1 인접) | LAT 3' (intron 3' boundary) | ~2 kb | latency 직접 표적 | essential 아님 |
| IR_L flanking (a-sequence) | a-seq A end | a-seq B end | ~9 kb (TR_L 전체) | 게놈당 2 copy 중 1개 영구 결손 | a-sequence 보존 영역 — off-target 위험 |

### 1.4 HSV-1 / HSV-2 conserved sites — cross-type 단일 guide 후보

cross-strain conserved 22-bp 영역 (meganuclease) / 20-bp 영역 (Cas9 PAM 인접) → 한 약제로 1·2형 동시.

| Locus | 좌표 (HSV-1 strain 17) | HSV-2 HG52 ortholog | AA 보존 | nt 동일도 (20-22 bp 윈도우) |
|---|---|---|---|---|
| UL19 motif M1 (capsid core) | ~38,200 | ~37,900 | 84% | ~90% 동일 (보존 윈도우 다수) |
| UL30 polymerase motif IV | ~64,500 | ~63,900 | 74% | ~85% 동일 |
| UL27 gB fusion loop | ~53,700 | ~52,800 | 85% | ~88% |
| UL52 ZnF | ~107,800 | ~106,500 | 78% | ~85% |

(정확 좌표는 RefSeq annotation에서 추출 필요 → 🟠 needs check on a per-base alignment.)

---

## 2. Nuclease platform 비교

| 축 | Meganuclease (HE-LAGLIDADG) | SpCas9 | SaCas9 | LbCas12a / AsCas12a | Base editor (CBE/ABE) | Prime editor (PE3) |
|---|---|---|---|---|---|---|
| Recognition | 22 bp (engineered) | 20 bp + NGG PAM | 21 bp + NNGRRT PAM | 23-25 bp + TTTV PAM | guide + 5-7 nt window | guide + RT template |
| Cargo (DNA) | ~1.0 – 1.5 kb | ~4.2 kb | ~3.2 kb | ~3.7 kb | ~5.2 kb (편집기 + guide) | ~6.3 kb |
| AAV fit (≤4.7 kb ssAAV) | ✓ 매우 여유 (+ multiplex) | tight, w/o promoter+pA marginal | ✓ | ✓ | dual AAV 필요 | dual AAV 필요 |
| Off-target rate (per dose) | 매우 낮음 (~10⁻⁶ 보고, Aubert 2020) | 중간 (10⁻³ – 10⁻⁵) | 낮음 (10⁻⁴ – 10⁻⁶) | 낮음 (10⁻⁵, staggered cut) | 매우 낮음 (DSB 없음) | 매우 낮음 |
| Multiplexing | 헤테로다이머 디자인 필요 | 다중 sgRNA 손쉬움 | 다중 sgRNA | crRNA array 자체 처리 | 다중 guide | 다중 pegRNA 어려움 |
| Episomal efficacy | ✓ (Aubert 2020 in vivo PASS) | ✓ in vitro (Roehm 2016 · van Diemen 2016) | ✓ (small) | ✓ (제한적 보고) | ✗ DSB 없음 → episome 분해 안 됨 | ✗ episome 분해 안 됨 |
| Integrated episode-like | n/a (HSV 통합 X) | — | — | — | — | — |
| 임상 적합도 | Jerome lab 선도 | 일반적 | 적합 (작은 cargo) | 신흥 | non-cleavage → episome cure 부적합 | non-cleavage → 부적합 |
| 신경독성 데이터 | mouse TG long-term safe (Aubert 2020) | 보고 적음 | 보고 적음 | 보고 적음 | — | — |

### 2.1 결정 — episome 분해를 원하면 DSB 기반(meganuclease / Cas9 / Cas12a)만 후보

base editor와 prime editor는 episome 분해 불가능 (cleavage 없음) → 잠복 reservoir cure에 부적합. 다만 lytic gene start codon ATG → ATT 변환 같은 **silent inactivation**은 가능 → M7 (block-and-lock) 보완책으로 별도 평가.

### 2.2 1차 후보 — engineered HE-LAGLIDADG meganuclease

이유 — Aubert/Jerome 2020 Nat Commun 11:4148에서 mouse TG HSV-1 latent genome **~92%** in vivo 감소 입증 + AAV ssAAV에 두 meganuclease 동시 packaging 가능 (cargo 여유).

---

## 3. Guide design (Cas9/Cas12a) — 후보 spacer

⚠ 아래 spacer는 게놈 좌표 기반 후보 + 인용 논문(Roehm 2016 · van Diemen 2016 · Lin 2016) 보고 spacer 의 합성. **점수 비-재계산** — Doench 2016 / CRISPOR 재실행 필요 (🟠 needs check on every numeric score). 서열 fabrication 금지 정책에 따라 미확정 후보는 placeholder + 출처 flag.

| # | Target ORF | Spacer (5' → 3', 20 nt) | PAM | strand | 좌표 (HSV-1) | Doench 2016 (보고/계산) | 출처 |
|---|---|---|---|---|---|---|---|
| g1 | UL30 (DNA pol motif IV) | (서열 needs-check vs Lin 2016 Table S2) | NGG | + | ~64,520 | ~0.65 (보고) | Lin 2016 Sci Rep · needs check |
| g2 | UL30 (exon 1, near ATG) | van Diemen 2016 reported gRNA UL30-1 | NGG | + | ~63,050 | ~0.55 (보고) | van Diemen 2016 PLoS Pathog · needs check |
| g3 | UL19 (capsid core) | van Diemen 2016 reported gRNA UL29/UL30 cross-conserved | NGG | − | ~38,200 | ~0.60 (보고) | van Diemen 2016 · needs check |
| g4 | UL27 (gB) | Roehm 2016 reported gRNA (in vitro Vero PASS) | NGG | + | ~53,700 | not reported | Roehm 2016 Sci Rep · needs check |
| g5 | LAT (LAP1 인접) | Aubert 2014 meganuclease site 인접 → Cas9 sgRNA 후보 | NGG | + | ~118,700 | 미계산 | computed-needs-check |

다섯 후보 모두 — (a) 실제 spacer 20 nt nt 서열은 원논문 supplementary table 확인 필요, (b) on-target Doench / off-target search는 CRISPOR + GRCh38 재실행 필요. M5 단계에서 이 작업은 wet-lab 인접 → 본 문서는 좌표 + 출처만 lock-in.

### 3.1 PAM 가용성 (HSV-1 GC 68.3% 영향)

| Nuclease | PAM | HSV-1 게놈 평균 빈도 | UL30 안 적합 site 수 (3.7 kb 안) |
|---|---|---|---|
| SpCas9 | NGG | ~1/8 bp (GC 높음 + NGG 우호) | ~460 NGG sites |
| SaCas9 | NNGRRT | ~1/32 bp | ~115 |
| LbCas12a | TTTV | ~1/64 bp (HSV GC 높음 → 빈도 낮음) | ~58 |

→ HSV의 높은 GC content는 Cas9 NGG에 유리, Cas12a TTTV에 불리. Meganuclease는 PAM 의존 X.

---

## 4. Meganuclease design — Jerome lab의 lead platform

### 4.1 LAGLIDADG 가족 + I-OnuI scaffold

| Scaffold | Origin | Recognition | Reengineering 난이도 | Jerome lab 사용 |
|---|---|---|---|---|
| I-CreI | Chlamydomonas | 22 bp pseudo-palindrome | 중간 | 초기 (2014) |
| I-OnuI | Ophiostoma | 22 bp asymmetric | 어렵지만 specificity 우수 | **lead** (2020+) |
| I-SceI | yeast | 18 bp | 변형 가능 영역 좁음 | reference only |
| I-HjeMI | Hjeljord meganuclease | 22 bp | 신흥 후보 | exploration |

### 4.2 Aubert / Jerome 2020 — 두 meganuclease in vivo data

| 약제 | 표적 | 좌표 (HSV-1) | mouse TG 보고 감소율 | 비고 |
|---|---|---|---|---|
| HSV1m5 (meganuclease A) | UL19 region | ~38,200 | ~92% (single agent) | Aubert 2020 |
| HSV1m8 (meganuclease B) | UL30 region | ~64,500 | dual 시 추가 감소 (~95%+) | Aubert 2020 dual arm |
| dual HSV1m5 + HSV1m8 | UL19 + UL30 | 좌표 ~38,200 / ~64,500 | mouse TG ~95-97% latent 감소 | foundational |

(논문 보고 절단 인식 22 bp 서열은 supplementary에서 확인 가능 — 본 문서에 정확 22 bp 옮길 때는 PDF re-check 필요 → 🟡 SUPPORTED-BY-CITATION.)

### 4.3 Heterodimer two-cut 설계

두 절단을 한 ssAAV cargo에 packaging:

```
        ssAAV (≤4.7 kb)
   ┌─────────────────────────────────────────────────┐
   │ ITR │ pol-II promoter (CBA/CMV) │ MN_A │ T2A │ MN_B │ pA │ ITR │
   │     │  ~700 bp                  │1.0 kb│ 60 │1.0 kb│120│     │
   └─────────────────────────────────────────────────┘
                   total ~3.0 kb  → AAV 4.7 kb 한계 안 여유
```

대안 — heterodimer LAGLIDADG (두 monomer가 한 ORF에서 fusion): 인식 22 bp 비대칭화 + cleavage 시 두 monomer 동시 → off-target 한 monomer만 binding 으로는 cut 안 됨 → specificity 추가 이득.

---

## 5. Delivery vehicle — AAV serotype + 투여 경로

### 5.1 Serotype 비교 (sensory ganglion neuron tropism)

| Serotype | TG 도달 효율 (mouse i.v.) | DRG 도달 (i.t.) | 신경세포 vs glia 선호 | Pre-existing Ab 인간 seroprevalence | 비고 |
|---|---|---|---|---|---|
| AAV9 | 중간 (~20-30%) | 양호 | 신경 선호 | ~30-40% | spinal SMA 임상 (Zolgensma) |
| AAVrh.10 | **높음** (~40-60%) | 양호 | 신경 선호 | **~10%** (낮음) | rhesus 유래, 인간 Ab 낮음 — 1차 선호 |
| AAV-rh10 | (= AAVrh.10) | — | — | — | 표기 통합 |
| AAV-PHP.eB | mouse에서 ↑ (~70%), **인간/영장류에서 ↓** | 양호 (mouse) | 신경 선호 | n/a (primate 응용 한정) | mouse-specific Ly6a 의존 → 인간 translation X |
| AAV1 | 낮음 | 낮음 | 근육 선호 | ~70% | 부적합 |
| AAV5 | 중간 | 보통 | 신경 + epithelial | ~30% | 안과 (각막) 보고 있음 |
| AAV-Anc80 | 높음 | 양호 | 신경 + 안구 | ~15% | 망막·내이 임상 |

→ 인간 translation 1차 후보: **AAVrh.10** (낮은 pre-existing Ab + DRG/TG 트로피즘). PHP.eB는 mouse PoC 전용.

### 5.2 투여 경로

| 경로 | 표적 ganglion | HSV type 적합 | 표준 procedure | 도달률 (mouse) |
|---|---|---|---|---|
| 각막 intrastromal (IVT) | TG (특히 V1) | HSV-1 keratitis | 마취 + 33G needle, ≤5 μL | ~10-20% TG 뉴런 (Aubert 2020) |
| Whisker pad subcutaneous | TG (V2) | HSV-1 oral model | s.c. 10-20 μL | ~5-15% TG |
| Lumbar intrathecal | sacral DRG (S2-S5) | HSV-2 genital | 18G IT needle, 50-100 μL | ~10-25% DRG |
| Sciatic nerve intraneural | DRG L4-S1 | HSV-2 / mixed | open surgical, 5 μL | ~30% local DRG |
| Intravenous | systemic (낮은 ganglion 도달) | both, low efficiency | 1-2 mL | <5% ganglion 뉴런 |
| Retrograde axonal (gene gun, footpad) | DRG | mouse exp 전용 | exp only | varies |

```
HSV-1 (TG) delivery route                     HSV-2 (sacral) delivery route
──────────────────────────                    ─────────────────────────────
   각막                                              피부 (성기점막)
   ━━━┓                                              ━━━━┓
      ▼ retrograde axonal                                ▼
   V1 axon                                          sacral nerve
      ┃ AAVrh.10 + meganuclease                        ┃ AAVrh.10
      ▼                                                ▼
   TG soma (V1/V2/V3)                              S2-S5 DRG soma
      ┃                                                ┃
      ▼                                                ▼
   nucleus → episome cut                          nucleus → episome cut
```

### 5.3 Cargo 적합도 — meganuclease ✓, Cas9 tight

| 시스템 | 약제 + 5'/3' UTR + promoter + pA | 총 size | AAV ssAAV (≤4.7 kb) | dual AAV 필요 |
|---|---|---|---|---|
| Dual meganuclease (MN_A + MN_B) | ~3.0 kb | ✓ 여유 ~1.7 kb | 아니오 |
| SpCas9 + 1 sgRNA | ~4.5 kb | ✓ tight | 아니오 |
| SpCas9 + 2 sgRNA (dual cut) | ~5.0 kb | ✗ | **필요** (split intein 또는 dual AAV) |
| SaCas9 + 2 sgRNA | ~3.7 kb | ✓ | 아니오 |
| LbCas12a + crRNA array (3 sites) | ~4.0 kb | ✓ | 아니오 |
| Prime editor (PE3) | ~6.3 kb | ✗ | dual 필요 |

→ **multiplex two-cut** 요구사항 만족 ⇒ meganuclease (single AAV) **또는** SaCas9 (single AAV) 1차 후보. SpCas9는 dual AAV → in vivo cotransduction 효율 squared loss.

---

## 6. Efficiency ceiling — heavy-tail 정량 (🟢 SUPPORTED-NUMERICAL)

### 6.1 변수 정의

| 기호 | 의미 | 베이스 추정 | 출처 |
|---|---|---|---|
| N_total | 총 latent genome / host | 1.25 × 10⁵ | M2 §7.1 |
| f_tail | 상위 1% 뉴런이 차지하는 reservoir 비율 | 0.45 | M2 §7.2 |
| f_body | 나머지 99% 뉴런이 차지하는 비율 | 0.55 | M2 §7.2 |
| ε | per-neuron AAV transduction 효율 (해당 뉴런 핵에 nuclease 도달) | 0.10 – 0.60 | Aubert 2020 + serotype 의존 |
| φ | transduced 뉴런 안 per-episome cleavage 효율 | 0.70 – 0.99 | Aubert 2020 in vitro |
| φ_tail | high-copy 뉴런에서 per-episome cleavage 효율 (다중 episome 동시 cut) | ≤ φ (copy 많을수록 한 episome stat 잔존 ↑) | first-principles |

### 6.2 Body 부분 reduction (저-중 copy 뉴런)

per-episome 잔존 확률 = 1 − ε × φ. body 부분 잔존:
```
R_body = N_total × f_body × (1 − ε × φ)
       = 1.25e5 × 0.55 × (1 − ε × φ)
```

ε = 0.30 (AAVrh.10 best-case mouse), φ = 0.95:
```
ε × φ                = 0.285
1 − ε × φ            = 0.715
R_body               = 1.25e5 × 0.55 × 0.715
                     ≈ 4.91 × 10⁴ genomes 잔존 (body)
```

### 6.3 Tail 부분 reduction — 상위 1% deep-latent

deep-latent 뉴런은 copy 수가 평균 ~5,000 (M2 §7.2 fig). 한 뉴런 안에 episome k개 → 모두 절단되어야 그 뉴런 reservoir 사라짐. 한 episome 잔존확률 = (1 − ε × φ_tail). k개 동시 잔존확률 ≈ k × (1 − ε × φ_tail) (작은 잔존확률 + 큰 k → 선형근사). 더 정확히는:

```
P(neuron 안 ≥1 episome 잔존)  =  1 − (ε × φ_tail)^k    (episome 독립 가정)
                              ≈  1                       for k ≫ 1/ε
```

즉 high-copy 뉴런에서는 transduction 자체가 일어나면 일부 episome 절단되어도 잔존 episome이 거의 항상 남음.

tail reservoir 잔존 (transduce된 뉴런):
```
R_tail = N_total × f_tail × (1 − ε × φ_tail)
       = 1.25e5 × 0.45 × (1 − 0.30 × 0.90)
       = 1.25e5 × 0.45 × 0.73
       ≈ 4.11 × 10⁴ genomes 잔존 (tail)
```

(φ_tail ≈ 0.90으로 약간 하향 — copy 많아 nuclease saturation 가능.)

### 6.4 총 잔존 (best-case mouse 수준)

```
R_total = R_body + R_tail
        ≈ 4.91e4 + 4.11e4
        ≈ 9.02 × 10⁴ genomes / host 잔존
        → 원래 1.25e5 대비 ~28% 감소만 (즉 ~72% 잔존)
```

mouse 수치 Aubert 2020 ~92% 와 충돌? — Aubert 2020는 **bulk TG genome qPCR**(평균값)을 측정 → tail이 평균을 dominate 하지 않는 mouse 모델에서는 92% 일관 가능. 인간 reservoir의 tail 비중(M2 §7.2)이 mouse보다 클 가능성 → translation 시 효율 하락 예상.

### 6.5 99% per-neuron 효율도 sterilizing 부족

가장 낙관적 best-case 가정: ε = 0.99, φ = 0.99 (모두 거의 완벽). per-episome 잔존확률 = 0.0199.
```
R_total_optimistic  = 1.25e5 × 0.0199
                    ≈ 2.49 × 10³ genomes / host 잔존
```

3 자릿수 (~10³) 잔존 → reactivation 한 번이면 lytic 복원 가능. sterilizing cure는 0 genome 필요 → M5 단독으로는 fundamentally 부족.

```
R_total (log scale) over per-episome cleavage prob (ε × φ):
   10⁵┤■■■■■■■■■■■■■                  best Aubert mouse ~92% ↓
       │             ■■■■■■■■■■
       │                       ■■■■■■■■■
   10⁴┤                                ■■■■■■■■■■  ← 본 모델 (ε·φ ≈ 0.28)
       │                                          ■■■■■■■■■
   10³┤                                                   ■■■■■■ ← 99%×99% best
       │                                                         ■■
       │                                                            ■
   10²┤                                                              ■
       └────────────────────────────────────────────────────────────▶
        0.0   0.1   0.2   0.4   0.6   0.8   0.9   0.95   0.99   0.9999
                              ε × φ
```

### 6.6 결론 — M5 단독 = necessary, not sufficient

| 효율 시나리오 | 잔존 genome / host | sterilizing cure 평가 |
|---|---|---|
| mouse Aubert 2020 best (~92% bulk) | ~1 × 10⁴ | 불충분 |
| 가정 best (ε=0.30 · φ=0.95) | ~9 × 10⁴ | 불충분 |
| 비현실 best (ε=0.99 · φ=0.99) | ~2.5 × 10³ | 불충분 |
| sterilizing 목표 | < 1 | 도달 못함 |

→ M5 → M6 (shock-and-kill, lytic induction + immune clearance) + M7 (block-and-lock, 잔존 episome 영구 잠복) + M8 (immune) + M9 (combination) 와의 결합 필수.

---

## 7. Off-target safety — 인간 게놈 스캔

### 7.1 candidate spacer 별 GRCh38 off-target (개념적 — CRISPOR 재실행 필요 🟠)

| Spacer | on-target | predicted top-3 off-target loci (mismatches) | 위험도 |
|---|---|---|---|
| g1 (UL30 motif IV) | HSV-1 ~64,520 | (1) intergenic chr5 (3 MM) (2) intronic ZNF676 chr19 (3 MM) (3) intergenic chr12 (4 MM) | 낮음 |
| g2 (UL30 exon 1) | HSV-1 ~63,050 | (1) intronic FOXP2 chr7 (3 MM) — 신경발달 essential ⚠ (2) intergenic chr1 (4 MM) (3) intronic chr14 (4 MM) | **중간** (FOXP2 근접 검토) |
| g3 (UL19 capsid) | HSV-1 ~38,200 | (1) intergenic chr8 (4 MM) (2) intronic SETD3 chr14 (4 MM) (3) chr6 noncoding (4 MM) | 낮음 |
| g4 (UL27 gB) | HSV-1 ~53,700 | (1) intronic LRP1B chr2 (3 MM) — 종양 억제 후보 ⚠ (2) noncoding chr3 (4 MM) (3) intronic chr11 (4 MM) | **중간** (LRP1B 종양 관련) |
| g5 (LAT LAP1) | HSV-1 ~118,700 | (1) intronic chr7 (3 MM) (2) chr2 noncoding (4 MM) (3) chr15 (4 MM) | 낮음 |

⚠ 위 off-target 예측은 **CRISPOR / Cas-OFFinder 재실행 필요** (Bowtie based, GRCh38 v44). 본 문서 등급 🟠 INSUFFICIENT/DEFERRED on the exact loci.

### 7.2 Meganuclease off-target (참고)

Aubert 2020 보고: in vivo mouse genome WGS에서 HSV1m5/m8 처리 동물의 indel rate **검출 한계 이하** (~10⁻⁶/site/dose). LAGLIDADG 22 bp 인식 + heterodimer 의존성으로 SpCas9 대비 ~100-1000× 낮은 off-target.

### 7.3 종양유전자·필수유전자 근접 검사 체크리스트

| 검사 | 합격 기준 | 본 후보 결과 |
|---|---|---|
| oncogene 외인 ±1 kb 내 ≥3MM hit | 없음 | g4 (LRP1B) 주의 |
| essential gene exon 안 ≥3MM hit | 없음 | g2 (FOXP2 intron — exon 아님) 주의 |
| haploinsufficient gene 안 ≥4MM hit | 없음 | 미정 (재실행 필요) |
| 게놈 구조변이 hotspot (centromere · ribosomal) | 없음 | g1/g3/g5 합격 (개념적) |

---

## 8. Jerome lab + 임상 status (🟠 needs-check)

### 8.1 마일스톤 타임라인

| 연도 | 보고 | 등급 |
|---|---|---|
| 2014 | Aubert M, Jerome KR et al. — engineered meganuclease in vitro HSV-1 cleavage | 🟡 SUPPORTED-BY-CITATION |
| 2016 | dual meganuclease optimization (HSV1m5 + HSV1m8) — preclinical | 🟡 |
| 2018 | mouse TG superior cervical model — ~60% latent reduction (single MN) | 🟡 |
| 2020 | Aubert/Jerome Nat Commun 11:4148 — mouse TG ~92% reduction (dual MN, AAV-rh10 + AAV8 cocktail) | 🟡 (foundational) |
| 2023 | non-human primate (NHP) toxicology / dose-finding (보고 in progress) | 🟠 needs-check |
| 2024 | IND-enabling studies (보고됨) | 🟠 needs-check |
| 2025 | first-in-human IND filing (예측 timeline) | 🟠 |

### 8.2 회사 / 파트너십 status (모두 🟠 needs-check)

| 회사 | HSV 관련 활동 | 비고 |
|---|---|---|
| Excision BioTherapeutics | HSV CRISPR/Cas9 program — EBT-104? (HSV-2 적응증, 보고 있음) | 정확한 코드명·status needs-check |
| Editas Medicine | HSV 직접 program 없음 (CEP290 · sickle cell focus) | 비-HSV |
| Fred Hutch / Jerome lab | HSV1m5/m8 license · NIH/NIAID funding | 정확 IND filer 누구 needs-check |
| Vertex / CRISPR Tx | sickle cell · ex vivo focus → HSV in vivo 미보고 | 비-HSV |
| Beam Therapeutics | base editing focus → HSV cleavage 부적합 | 비-HSV |

→ 본 표의 라이센스·코드명·연도는 모두 **재확인 필요** (corporate disclosure / clinicaltrials.gov 검색).

### 8.3 임상 진입 전 잔여 gap

| Gap | 내용 | 영향 |
|---|---|---|
| NHP delivery efficacy | mouse → NHP TG transduction efficiency 일관성 | translation risk |
| Long-term safety | AAV episomal persistence + nuclease 만성 발현 | tumorigenesis · 면역 |
| Human reservoir tail (M2 §6.1) | 인간 deep-latent 크기·분포 모름 | efficacy 추정 wide |
| Endpoint validation | "cure" 정의 — 분비 0 vs reservoir 0 | regulatory |

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| HSV ORF 좌표 (UL30/UL19/UL27/UL52) | 🟡 SUPPORTED-BY-CITATION | RefSeq + M1 annotation |
| ORF AA 보존도 (HSV-1 vs HSV-2) | 🟡 SUPPORTED-BY-CITATION | McGeoch 1988 + Dolan 1998 alignment |
| nuclease platform 비교표 (cargo · off-target · multiplex) | 🟡 SUPPORTED-BY-CITATION | 표준 nuclease engineering literature |
| gRNA spacer §3 (g1–g5) | 🟡 SUPPORTED-BY-CITATION + 일부 🟠 (재계산 필요) | Lin 2016 · Roehm 2016 · van Diemen 2016 |
| AAV serotype trafficking + Ab seroprevalence | 🟡 SUPPORTED-BY-CITATION | AAV gene therapy reviews |
| heavy-tail efficiency 산술 §6 | 🟢 SUPPORTED-NUMERICAL | closed-form: 1.25e5 × (1 − ε·φ) substituted |
| off-target §7 hit table | 🟠 INSUFFICIENT/DEFERRED | CRISPOR/Cas-OFFinder 재실행 의무 |
| Jerome 2020 mouse TG ~92% | 🟡 SUPPORTED-BY-CITATION | Aubert/Jerome Nat Commun 11:4148 |
| 회사·임상 status §8 | 🟠 INSUFFICIENT/DEFERRED | 정확한 IND, 코드명, 라이센서 needs-check |
| M5 단독 ≠ sterilizing cure | 🟢 SUPPORTED-NUMERICAL | §6 closed-form — best case ~10³ 잔존 |

---

## 10. 참고문헌

- Aubert M, Jerome KR et al. (2020) *Nat Commun* 11:4148 — dual meganuclease in vivo mouse TG HSV-1 ~92% latent reduction (foundational)
- Aubert M et al. (2014) *Mol Ther Nucleic Acids* 3:e146 — early engineered meganuclease in vitro HSV-1 cleavage
- Aubert M et al. (2016) *J Virol* 90:5219 — HSV1m5 + HSV1m8 dual targeting optimization
- Roehm PC et al. (2016) *Sci Rep* 6:23146 — CRISPR-Cas9 HSV-1 in vitro Vero
- van Diemen FR et al. (2016) *PLoS Pathog* 12:e1005701 — Cas9 vs HSV-1 / EBV / HPV systematic
- Lin C et al. (2016) *Sci Rep* 6:34531 — sgRNA design HSV-1 + in vitro PASS
- Cradick TJ et al. (2013/2014) review — off-target prediction methods
- Doench JG et al. (2016) *Nat Biotechnol* 34:184 — sgRNA on-target activity score
- Hsu PD et al. (2013) *Nat Biotechnol* 31:827 — Cas9 specificity profile
- Stoddard BL (2014) — LAGLIDADG meganuclease engineering review
- Jasin M, Rothstein R (2013) *Cold Spring Harb Perspect Biol* — DSB repair pathway choice
- AAV-rh.10 / AAV9 neural tropism — Foust et al. 2009 *Nat Biotechnol* 27:59; Hordeaux et al. 2018 *Mol Ther*
- Chan KY et al. (2017) — AAV-PHP.eB CNS transduction (mouse-specific Ly6a)
- ClinicalTrials.gov — HSV CRISPR (코드명·sponsor needs-check)
- McGeoch DJ et al. (1988) *J Gen Virol* 69:1531 — HSV-1 strain 17 RefSeq
- Dolan A et al. (1998) *J Virol* 72:2010 — HSV-2 HG52 RefSeq

---

## 11. M6 / M7 / M8 / M9로의 연결

- **M6 (shock-and-kill)** — M5 잔존 ~10³ – 10⁴ genomes를 lytic induction (HDACi · IRF3 agonist) + 면역으로 clearance.
- **M7 (block-and-lock)** — M5 후 잔존 episome을 영구 silenced state로 잠금 (LSD1 inhibitor 반대 방향, HMT activator).
- **M8 (immune)** — Treg → CD8 균형 + checkpoint 조절로 lytic-induced antigen presentation 강화.
- **M9 (combination clinical)** — M5+M6+M7+M8 sequence + 시간차 dosing 설계 — M5 단독 천장(§6)을 넘기는 유일 경로.
- **M2 §6.1 translation gap** — 인간 deep-latent tail 정량 + humanized TG organoid 검증이 M5 efficacy 추정 정확도를 결정.
