# M1 — HSV-1/2 게놈 구조 + LAT locus 매핑

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = RefSeq + literature → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).

---

## 1. 참조 게놈 (RefSeq)

| 축 | HSV-1 | HSV-2 |
|---|---|---|
| RefSeq accession | NC_001806.2 | NC_001798.2 |
| 균주 | strain 17 (lab reference) | strain HG52 |
| 길이 (bp) | 152,222 | 154,675 |
| GC content | 68.3% | 70.4% |
| 어노테이션 ORF | ~84 | ~74 |
| 1차 시퀀싱 | McGeoch et al. 1988 | Dolan et al. 1998 |
| 일치도 (AA, 공통 ORF) | — | ~83% vs HSV-1 |

---

## 2. 게놈 아키텍처 — UL · US + 반복 영역

```
5'  ┌──────┬──────────────────────────┬──────┬──────┬───────┬──────┐  3'
    │ TR_L │   U_L  (~108 kbp, ~56유전자)   │ IR_L │ IR_S │ U_S   │ TR_S │
    │ ◀──── │                          │ ────▶│ ◀────│ (~13k)│ ────▶│
    └──────┴──────────────────────────┴──────┴──────┴───────┴──────┘
            ↑                            ↑    ↑
            unique long segment       반전 반복 (inverted repeats)
                                     LAT는 IR_L (= TR_L) 안에 있음 → 게놈당 2 copy
```

| 영역 | 약자 풀이 | 크기 (HSV-1) | 역할 |
|---|---|---|---|
| TR_L · IR_L | Terminal / Internal Repeat Long | ~9 kbp each | LAT · ICP0 · ICP34.5 보유 |
| U_L | Unique Long | ~108 kbp | ~56 유전자 (capsid · DNA pol · tegument …) |
| IR_S · TR_S | Internal / Terminal Repeat Short | ~6.6 kbp each | ICP4 · α-genes |
| U_S | Unique Short | ~13 kbp | ~12 유전자 (gG · gD · gI · gE …) |

게놈은 L 세그먼트와 S 세그먼트가 서로 반전된 4가지 isomer로 존재 (UL-US 방향 조합).

---

## 3. LAT (Latency-Associated Transcript) locus — 잠복기의 유일한 주역

```
LAT 발현 모식도 (HSV-1)
─────────────────────────────────────────────────────────
                LAP1   LAP2
                 ↓       ↓
TR_L  ─┬─────────┬───────┬──────────────────────────────┬─  IR_L
       │  LAT promoter   │   primary LAT transcript ~8.3 kb     │
       │                 └──────▶  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━│
       │                          │     │       │              │
       │                       [intron 2 kb (mLAT, 안정 lariat)] │
       │                       miR-H1/H2/H3/H4/H5/H6 위치       │
       └─────────────────────────────────────────────────────────┘
                              (반대쪽 ICP0 mRNA가 antisense로 겹침)
```

| 축 | HSV-1 LAT | HSV-2 LAT |
|---|---|---|
| 위치 | IR_L + TR_L (게놈당 2 copy) | 동일 (IR_L + TR_L) |
| primary transcript | ~8.3 kb | ~7-8 kb |
| 안정 산물 (mLAT) | 2 kb intron lariat (높은 안정성) | 유사 |
| 좌표 (strain 17) | ~118,866–127,150 (primary) · ~119,465–121,417 (2 kb) | ~120,000–127,000 (HG52, 대략) |
| 프로모터 | LAP1 (latency) + LAP2 (long-term) — 신경세포 특이 | 동일 구조 |
| 코딩 miRNA | miR-H1 ~ miR-H6 (6개 confirmed) | miR-H2/H3/H4/H6 ortholog |
| antisense overlap | ICP0 mRNA · ICP34.5 | 동일 |

### 3.1 LAT 기능 — 잠복 유지의 4가지 축

| 기능 | 메커니즘 | 임팩트 |
|---|---|---|
| 항-아폽토시스 | LAT가 caspase-8/9 경로 억제 | 감염 뉴런 생존 → reservoir 유지 |
| Lytic gene 억제 (miRNA) | miR-H2 → ICP0 mRNA cleave · miR-H3/H4 → ICP34.5 | 재활성화 트리거 차단 |
| Heterochromatin 유도 | LAT 영역 H3K9me3 · H3K27me3 농축 | lytic promoter 침묵 (M3로 연결) |
| 신경세포 특이 발현 | LAP1/2가 CRE · USF · Sp1 binding 의존 | 다른 조직에서 침묵 |

---

## 4. 잠복 reservoir 위치 (M2 ground truth)

| HSV | 1차 reservoir | 2차 reservoir | 임상 manifestation |
|---|---|---|---|
| HSV-1 | trigeminal ganglia (V1/V2/V3) | dorsal root ganglia (DRG) · 뇌간 | 입술·각막 (HSV keratitis) |
| HSV-2 | sacral ganglia (S2-S5) | DRG (lumbosacral) | 성기·항문주위 |

잠복 게놈은 뉴런 핵 안 episomal circular DNA로 존재 (히스톤 결합, 통합 X).

---

## 5. 참고문헌

- McGeoch DJ et al. (1988) *J Gen Virol* 69:1531 — HSV-1 strain 17 complete sequence
- Dolan A et al. (1998) *J Virol* 72:2010 — HSV-2 HG52 complete sequence
- Stevens JG, Cook ML (1971) *Science* 173:843 — LAT 최초 보고
- Umbach JL et al. (2008) *Nature* 454:780 — HSV-1 LAT miRNA cluster
- Knipe DM, Cliffe A (2008) *Nat Rev Microbiol* 6:211 — latency chromatin review
- Bloom DC (2016) *Adv Virus Res* 94:53 — LAT 기능 종합 리뷰
- Cliffe AR, Wilson AC (2017) *J Virol* 91:e01419-16 — 재활성화 신호 (M4 입력)

---

## 6. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 게놈 길이 · GC · ORF count | 🟡 SUPPORTED-BY-CITATION | RefSeq NCBI 등록 데이터 |
| LAT 좌표 · miRNA 수 | 🟡 SUPPORTED-BY-CITATION | Umbach 2008 + RefSeq annotation |
| LAT 기능 모델 | 🟡 SUPPORTED-BY-CITATION | Knipe/Cliffe 2008 리뷰 + 후속 연구 |

다음 단계 M3 (chromatin 상태) · M4 (재활성화 트리거)는 first-principles 모델링 → 🟢/🔵 등급 목표.
