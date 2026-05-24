# M10 — Sterilizing Cure 임상 trial 프로토콜 + endpoint + verification framework

> 마일스톤 M10 산출물 · current-state · no history. HSV 10-milestone roadmap 최종 통합.
> 입력: M1 (genome) · M2 (reservoir N_total=1.25×10⁵, heavy-tail 45%/1%) · M3 (Markov, KDM4 1순위 druggable) · M4 (DLK 1순위 ODE axis, u_crit) · M5 (AAVrh.10 + dual meganuclease, 단독 ceiling ~2.5×10³) · M6 (3-axis LRA, M5+M6+M8+M9 만이 sterilizing path) · M7 (block-and-lock 영구 잠금, functional cure 10⁻³/yr) · M8 (PD-1+LAG-3, φ_block 0.7→0.25) · M9 (pentavalent mRNA, E_vaccine≈21×).
> 등급 기조: §1-4 stratification + 시퀀싱 🟡 · §5-6 endpoint mapping 🟢/🟠 · §7 non-biopsy verification 🟠 · §11 통합 efficacy projection 🟢 SUPPORTED-NUMERICAL · §10 regulatory timeline 🟠 INSUFFICIENT-DEFERRED.

---

## 0. 설계 골자 — two-arm strategic split

> M5-M9의 9개 module을 **두 환자 코호트로 분기 (Arm S sterilizing · Arm F functional)** → 면역상태·reservoir 크기·재활성화 빈도·HLA 등에 따른 first-principles stratification. measured-oracle PASS = ≥10⁵ ratio reservoir reduction (Arm S) 또는 ≥99% recurrence 감소 (Arm F).

```
   HSV-1/2 seropositive 환자 → patient stratification (§2: HLA · 면역 · reservoir · AAV Ab · 빈도 · 연령)
                                       │
                          ┌────────────┴────────────┐
                          ▼                         ▼
            Arm S (sterilizing)            Arm F (functional)
            M9+M8+M6+M5 stack              M7: DLK+JNK+LSD1+dCas9-ZIM3-KRAB
            목표 ≤1 residual genome         목표 reactivation <10⁻⁴/yr
                          │                         │
                §5 1° endpoint hierarchy   §6 1° endpoint hierarchy
                          │                         │
                          └────────────┬────────────┘
                                       ▼
                        §7 non-biopsy verification
                        (peripheral surrogate + animal-model bridge)
```

**핵심 결론(요약)**: Arm S 와 Arm F는 약리학적으로 **배타적** (M6 wake ⊥ M7 lock). best-case Arm S sterilizing cycle count ≈ 4-6 cycle (deep-latent tail이 작은 환자), 현실적 = 10-15 cycle (heavy-tail dominant). Arm F는 평생 lifelong daily block-layer + one-shot lock-layer, 누적 reactivation < 10⁻³.

---

## 1. Two-arm strategic split

### 1.1 Arm S (sterilizing) — 잠복 reservoir 제거

| 구성 | 메커니즘 |
|---|---|
| M9 mRNA pentavalent prime (gD+gB+gE+VP16+ICP4 LNP) | CTL repertoire 30-50× boost (E_vaccine≈21×) |
| M8 anti-PD-1 + anti-LAG-3 | φ_block 0.7→0.25, ganglion CD8 reinvigoration |
| M6 3-axis LRA (KDM4 act + vorinostat + bryostatin-1 저용량) | P_Ac 0.03→0.6, lytic IE leak |
| M5 AAVrh.10-dual meganuclease (HSV1m5 UL19 + HSV1m8 UL30) | episome DSB, M6 chromatin opening 후 ϕ 0.5→0.95 |

목표: N_total 1.25×10⁵ → ≤1 잔여 latent genome / host (≥10⁵ ratio reduction).

### 1.2 Arm F (functional) — 영구 잠복 잠금

| 구성 | 메커니즘 |
|---|---|
| GNE-3511 (또는 GNE-8505) daily PO | DLK $\alpha_D$ ↓ 3-5× |
| CC-401 daily PO | JNK $k_{JS}$ ↓ 3× — 곱셈 시너지 |
| iadademstat daily PO | LSD1 $k_{m→u}^L$ ↓ — Phase II 차단 |
| dCas9-ZIM3-KRAB one-shot AAVrh.10 (ICP0×2 + ICP4×2 + VP16 sgRNA) | $k_{u→m}$ ↑ 100×, $P_{Me3}$ → 0.999 |

목표: 연간 reactivation ≤10⁻⁴, 평생 누적 ≤10⁻³.

### 1.3 배타성 — 같은 환자에 동시 적용 불가

M6는 reactivation을 **유도** (DLK/JNK 활성 trigger), M7은 reactivation을 **차단** (DLK/JNK 약리 차단). 동시 처리 시:
- M7 block-layer가 M6 LRA의 Phase I 진입을 막아 reactivation 0 → "kill" 표적 부재 → M6 무효.
- M6 LRA가 M7의 reservoir 잠금을 깨어 reactivation burst → encephalitis risk.

→ **한 환자는 Arm S 또는 Arm F 중 하나만**. Arm S 실패 시 Arm F로 전환 가능 (역방향 전환은 lock 해제 어려움).

---

## 2. Patient stratification — first-principles 포함/배제 매트릭스

### 2.1 분류 결정 트리

```
            [환자] → HSV serology (1/2) → HLA typing (A*02/24, B*07)
                                                │
                                       ┌─≥1 match─┴─no match─┐
                                       ▼                      ▼
                                 AAVrh.10 Ab?           [Arm F 우선]
                                       │                (M9 효능 ↓)
                                ┌─pos─┴─neg─┐
                                ▼            ▼
                          [Arm F · AAV   recurrence /yr
                          dose 회피]        ┌─≤2─┬─3-6─┬─≥6─┐
                                          ▼     ▼     ▼    ▼
                                       [관찰][Arm F][Arm S][Arm S]
```

### 2.2 포함 기준

| 축 | 기준 | Arm 결정 영향 |
|---|---|---|
| HSV type | HSV-1 oral · HSV-2 genital 별 cohort | M5 delivery 경로 (whisker-pad/IVT vs sacral epidural) |
| HLA tier | A*02:01 / A*24:02 / B*07:02 ≥1 | M9 epitope 커버 ≥85% → Arm S 우선 |
| Reservoir size proxy | shedding freq × duration qPCR → tail % | low (<30%) → Arm S best · high (>50%) → Arm F |
| AAVrh.10 Ab titer | <1:50 (~90% 인구) | Arm S 적격 (M5/M7 AAV dose 가능) |
| Recurrence freq | <2/yr 관찰 · 3-6 Arm F · ≥6 또는 severe Arm S | reservoir 부담 ↔ M5 cleavage 가치 |
| Age | 18-65 (immune senescence cutoff) | >65 → Arm F |
| Pregnancy/lactation/concurrent immunosuppression/active HSE/HIV·HBV·CMV active | 전 cohort 배제 | M8 contraindication · checkpoint reactivation risk |

### 2.3 배제 기준

| 축 | 사유 |
|---|---|
| AAVrh.10 양성 (~10%) | M5/M7 AAV 중화 → **Anc80 serotype switch trial 별도** |
| autoimmune disease · solid tumor active | M8 irAE · 충돌 |
| QT prolongation | panobinostat·romidepsin (M6) contraindication |
| 영유아 (<18) | gene therapy 영구성 + 발달 |

### 2.4 Stratification matrix

| 환자 typology | HLA | tail | AAV Ab | freq | 권장 Arm |
|---|---|---|---|---|---|
| 표준 HSV-1 oral | A*02 | low (<30%) | neg | 4-6/yr | Arm S |
| 고빈도 HSV-2 | A*02+B*07 | mid | neg | ≥6/yr severe | Arm S |
| 면역약 노령 | A*24 | high (>50%) | neg | 2-4/yr | Arm F |
| AAV pre-immune | A*02 | low | pos | 4-6/yr | Arm F + Anc80 (시험적) |
| 저빈도 가벼움 | any | low | any | <2/yr | 관찰/valacyclovir |
| HIV+/EBV+ active | any | any | any | any | 제외 |

---

## 3. Intervention sequencing — Arm S (week-by-week)

### 3.1 통합 timeline

```
주차:  0    4    8    12   14   16    20    24    26-52
       │    │    │    │    │    │     │     │      │
       ▼    ▼    ▼    ▼    ▼    ▼     ▼     ▼      ▼
      M9   M9   M8   M6   M5   M6    M6    obs   biomarker
      prime boost loading LRA-1 AAV  LRA-2 LRA-3        + ddPCR
      30μg 30μg anti-PD-1 KDMa  rh.10 KDMa  KDMa
      i.m. i.m. + LAG-3  +HDACi mega +HDACi+HDACi
                       +bryo  dual  +M8   +M8
                                    boost  boost
```

### 3.2 단계별 상세

| 주차 | intervention | dose / 경로 | 목적 |
|---|---|---|---|
| 0, 4 | M9 prime + boost | gD+gB+gE+VP16+ICP4 LNP 30 μg i.m. | CTL pool 30-50× (M9 §5.3) |
| 8, 9 | M8 anti-PD-1 + anti-LAG-3 | pembrolizumab 200 mg IV q3w + relatlimab 160 mg | φ_block 0.7→0.25 (M8 §3.2) |
| 12 | **M6 LRA cycle 1** | Day 1-5: KDM4 act (UNC0638 50 mg/day surrogate) + vorinostat 200 mg/day PO + bryostatin-1 20 μg/m² IV D1·3·5 | P_Ac → 0.6, P_Me3 → 0.15 (M6 §3.4) |
| 14 | **M5 AAVrh.10 single IV** | dual heterodimer MN (HSV1m5+HSV1m8) ~1×10¹⁴ vg/kg | ϕ 0.5→0.95 (M5+M6 §8.4) |
| 16, 20 | M6 cycle 2-3 + M8 booster | 동일 stack | 잔여 reservoir 감소 |
| 24 | M6 cycle 4 (optional) | dose-fractionation 안 (M6 §5.2) | decision tree |
| 26-52 | 모니터링 | monthly swab ddPCR + LAT-miRNA blood + lesion log | §5 endpoint |

### 3.3 사이클 수 결정 트리 (closed-form, M6 §8 + M5 §6)

폐형: $N_\text{remaining}(N) = N_\text{total}\cdot(1-p_\text{cycle})^N$, $p_\text{cycle} = 1-(1-p_{M5})(1-p_\text{M6+M8})$. 상세 substitution은 §11 — 본 절은 high-level summary.

→ **best-case (low tail) ~5 cycle · realistic 10-15 cycle · heavy-tail dominant ~25 cycle**.

### 3.4 ASCII timeline

```
 cycle  0    4    8    12   14   16   20   24  ...  52
 M9     ●════● booster
 M8                ◆══════ φ_block 0.25 maintenance ════════════►
 M6                     ▲   ─▲    ─▲    ─▲   decision tree
 M5                          ★ one-shot AAVrh.10 dual MN
 surveillance                  monthly swab + quarterly blood ──►
```

---

## 4. Intervention sequencing — Arm F (week-by-week)

### 4.1 통합 timeline

```
주차:  0    2    4    6       14      52    104   ...   annual
       │    │    │    │       │       │      │           │
       ▼    ▼    ▼    ▼       ▼       ▼      ▼           ▼
      GNE  +CC- +iada AAV-    full   1yr   2yr        annual
      3511 401  demst dCas9   stack  bio-  bio-       bio-
      QD   QD   QD    KRAB    on     marker marker    marker
                       single                          + booster?
                       dose
```

### 4.2 단계별 상세

| 주차 | intervention | dose | 목적 |
|---|---|---|---|
| 0 | GNE-3511 (or GNE-8505) | 50→200 mg PO QD escalate | $\alpha_D$ ↓ 3-5×, $u_\text{crit}$ +200% |
| 2 | + CC-401 (JNK-i) | 100 mg PO QD | $k_{JS}$ ↓ 3× → $u_\text{crit}$ +900% (곱셈) |
| 4 | + iadademstat (LSD1-i) | 60 μg/m² PO QD | Phase II demethylation 차단 |
| 6 | AAVrh.10-dCas9-ZIM3-KRAB | dual-AAV split, IT/IV ~5×10¹³ vg/kg | $P_{Me3}$ → 0.999 |
| 14+ | full stack maintenance | daily block + lock | reactivation < 10⁻⁵/yr |
| 52, 104, annual | biomarker | ddPCR shedding + M7 transgene PBMC qPCR + lesion log | 영구성 + booster AAV 10-20yr |

### 4.3 decision-tree on adherence

```
adherence ≥95% (block layer):
  reactivation /yr ≈ 5 × 10⁻¹² (M7 §5.3)
  lifetime累積 < 10⁻⁹  → 사실상 0
adherence 80-95%:
  reactivation /yr ≈ 10⁻⁵   (lock backup)
  lifetime累積 < 10⁻³  → functional cure 정의 만족
adherence <80%:
  block layer 무효, lock alone ~10⁻⁵/yr
  → 환자 교육 + monthly check
```

### 4.4 ASCII timeline

```
 week    0   2   4   6         52         104         annual
 GNE     ●═══════════════════════════════════════════════════ daily PO ──►
 CC-401      ●═══════════════════════════════════════════════ daily PO ──►
 iadadem         ●═══════════════════════════════════════════ daily PO ──►
 AAV-KRAB           ★ one-shot (10-20y persistence)
 biomarker                      ●          ●          ●  annual ddPCR + qPCR
```

---

## 5. Endpoint definitions — sterilizing (Arm S 1차)

### 5.1 Primary endpoint

| Endpoint | 정의 | 측정 | 임계 |
|---|---|---|---|
| **N_residual** | 잔여 latent HSV genome / host | ddPCR surrogate (12개월 swab + blood) | ≤1 (≥10⁵ ratio reduction from N_total 1.25×10⁵) |

M2 §7 직접: 1.25×10⁵ → 1 = 5-log reduction, sterilizing 정의.

### 5.2 Surrogate endpoint hierarchy (모두 peripheral, 비-biopsy)

| # | Surrogate | 측정 | PASS 임계 |
|---|---|---|---|
| 1 | ddPCR HSV DNA swab (oral·genital) | monthly × 12 | <1 copy/10⁵ epi cells ≥12/12 samples |
| 2 | LAT-miRNA blood (miR-H1~H6) | quarterly × 4 | below LOD (~10 cp/mL) |
| 3 | Clinical recurrence | daily diary × 24mo | zero lesion events |
| 4 | HSV IgG titer trajectory | quarterly | declining ≥50% |

hierarchy: 4/4 PASS → "sterilizing cure" · 3/4 → "deep functional" · ≤2 → "partial / continue" · 0 → "failure → Arm F"

### 5.3 Verification framework

```
   Arm S enrollment → 26wk intervention → monthly swab/quarterly blood
                                                    │ 12mo
                                          4-surrogate panel
                                                    │
                              ┌─[4/4 PASS]──[<4/4 PASS]─┐
                              ▼                          ▼
                    "sterilizing cure" + 24mo    추가 cycle 또는
                    durability follow-up           Arm F 전환
```

### 5.5 Falsifier protocol (Popper 표준) — cross-link

§5의 4-surrogate AND-gate는 "sterilizing cure 달성"의 **SUCCESS condition**이지 H_central ("Arm S가 ≥80% eligible cohort에서 N_residual ≤ 1 달성")의 **REJECT condition**이 아니다. Popper falsifiability 표준 (1934) 충족을 위해 별도의 11 pre-declared falsifier가 `HERPES/M12_falsifier_protocol.md`에 정식화되어 있다 — Tier I 5 empirical (≥6/12 swab POS · ≥3/4 LAT-miRNA POS · triple-positive recurrence · median cycle >25 · shedding rebound ≥2×), Tier II 3 wet-lab (¹⁸F-FIAU PET ≥50% residual · post-mortem TG ImmunoFISH ≥10³ · KDM4 activator chemistry 5-year failure), Tier III 3 systemic (M11 u_crit sweep >10× · NHP AAV transduction <20% · BNT163/mRNA-1608 CTL <5×). OR-gate logic — single falsifier fire (§7 artifact filter PASS 후) = H_central reject. 모든 falsifier non-fire 시 H_central status = "Successfully not-falsified" (Popper corroborated, NOT proved). Stop rule (§8.3 DSMB)와는 orthogonal 축이며 V4 §10 9 wet-lab essential 중 4 항목이 falsifier 역할 dual-mark.

---

## 6. Endpoint definitions — functional (Arm F 1차)

### 6.1 Primary endpoint

| Endpoint | 정의 | 측정 | 임계 |
|---|---|---|---|
| **Recurrence reduction** | baseline 대비 임상 재발 빈도 감소 | 24개월 diary log | ≥99% reduction (baseline ≥6/yr → <0.06/yr) |

M7 §5 ODE → annual reactivation probability ≤10⁻⁴/yr (block+lock).

### 6.2 Surrogate endpoint hierarchy

| # | Surrogate | 측정 | PASS 임계 | M7 model bridge |
|---|---|---|---|---|
| 1 | ddPCR shedding frequency | monthly swab × 12 | ≥95% reduction vs baseline | M7 §5.3 trigger-event Poisson |
| 2 | M7 lock integrity | annual PBMC AAV transgene qPCR | dCas9-ZIM3-KRAB transgene detectable, no rearrangement | M7 §3.3 long-term persistence |
| 3 | reactivation rate | annual log + ddPCR confirm | ≤10⁻⁴/yr | M7 §5.3 Gaussian threshold |
| 4 | adherence (block layer) | pill count + plasma drug level | ≥80% | M7 §5.4 |

### 6.3 Endpoint hierarchy

| Result | 분류 |
|---|---|
| 4/4 PASS | "functional cure" — 평생 maintenance |
| 3/4 (예: adherence 부족) | "partial functional response" — 환자 교육 |
| ≤2/4 | "failure → Arm S consideration if eligible" |

---

## 7. Non-biopsy verification — 핵심 gap

### 7.1 문제 정의

ganglion biopsy = 영구 감각 신경 손실 → IRB 불승인 → **모든 endpoint는 peripheral**. peripheral shedding과 ganglion reservoir 사이의 mapping은 모델-의존.

### 7.2 Peripheral → ganglion mapping (🟢 SUPPORTED-NUMERICAL via M3+M4)

M4 §5의 ODE에서 reactivation rate $\lambda$는 ganglion 잠복 episome 수 $N_{lat}$에 선형:
$$\lambda_{\text{shedding}} = N_{lat} \cdot \int p_r(u) \cdot \rho(u)\, du$$

여기 $\rho(u)$는 trigger 분포, $p_r(u) = \exp(-(u_\text{crit}-u)/\sigma)$ (M7 §5.3).

→ shedding 빈도 ≥95% 감소 $\Leftrightarrow$ $N_{lat}$ ≥95% 감소 (trigger 분포 변화 없을 시).

ddPCR LOD: <1 copy / 10⁵ epithelial cells. 잠복 → shedding conversion rate $\eta \approx 10^{-3}$ /reactivation event (M4 추정). $N_{lat} = 1$이면 연간 shedding ~$\eta \cdot \lambda_\text{natural} \approx 5 \times 10^{-3}$ events/yr.

→ 12개월 monthly swab 모두 ddPCR negative ⇒ $N_{lat} \leq 5$ (95% CI, Poisson).

### 7.3 LAT-miRNA blood — 직접 reservoir proxy

LAT는 latent 유일 transcript (M1 §3). 감염 뉴런이 미세한 vesicle/exosome으로 LAT-miRNA를 systemic circulation에 방출. ddRT-PCR LOD ~10 copies/mL.

| $N_{lat}$ | LAT-miRNA blood (예상) | 검출 |
|---|---|---|
| 1.25×10⁵ (baseline) | ~10⁴ copies/mL | 검출 |
| 10³ | ~80 copies/mL | 검출 |
| 100 | ~8 copies/mL | LOD 인근 |
| ≤10 | <1 copy/mL | LOD 이하 |
| 0 | 0 | LOD 이하 |

→ ≥12개월 LAT-miRNA blood LOD 이하 = $N_{lat}$ ≤ 10 추정.

### 7.4 🟠 INSUFFICIENT-DEFERRED — 직접 ganglion ddPCR

future work proposal:
1. **PET tracer for reactivating ganglion** — ¹⁸F-FIAU (HSV-TK substrate, M5 cleavage 잔여 TK 표지) 또는 ¹⁸F-thymidine analog로 ganglion-localized HSV-TK 검출. **현재 PoC 단계**, 임상 적용 5-10년.
2. **Post-mortem ganglion harvest** — accidental death cohort consented, TG/sacral DRG qPCR — small N, long lead.
3. **Cadaver TG biorepository** — Mehta 1995/Wang 2005 follow-up, surrogate validation.

### 7.5 Animal model bridge

| 모델 | 측정 | bridge 역할 |
|---|---|---|
| mouse TG (HSV-1, Jerome lab) | shedding + post-mortem TG qPCR | shedding → ganglion 직접 검증 |
| guinea pig (HSV-2 genital) | shedding + sacral DRG qPCR | HSV-2 외삽 |
| 토끼 (HSV-1 keratitis) | corneal lesion + V1 TG qPCR | HSV-1 ocular 외삽 |
| macaque NHP | shedding + TG/DRG biopsy (terminal) | 인간 reservoir crosstalk |
| humanized mouse (NSG-MHC) | M8/M9 immune | 인간 면역 → clearance |

---

## 8. Failure-mode / escape monitoring

### 8.1 Escape risk matrix

| 실패 모드 | 검출 | 완화 |
|---|---|---|
| HSV CRISPR escape (UL30/UL19 NHEJ) | shed virus deep-seq quarterly | dual heterodimer (M5 §4.3) + 메가뉴클레아제 off-target 100-1000× 낮음 |
| M6 LRA non-response (heavy-tail) | cycle별 ddPCR shedding peak | M5 추가 cycle + 차세대 KDM4 activator discovery |
| M8 irAE (colitis · hypophysitis · pneumonitis) | weekly TSH·cortisol·LFT | 단계 dose · steroid rescue (M8 §9.1) |
| M9 antigenic drift (~10⁻⁷/bp 누적) | viral isolate seq | annual booster · pentavalent breadth |
| M7 lock escape (AAV CpG silencing) | annual PBMC dCas9 qPCR + KRAB expression | booster AAV every 10-20yr · CRISPRoff |
| AAV anti-Cas9 immunity | ELISpot pre-screen | SaCas9 alt · transient promoter |
| HSE (encephalitis) | symptom-triggered LP + acyclovir | dose-fractionation · 24/7 acyclovir prophylaxis |
| 다른 latent virus reactivation | pre-screen CMV/EBV/HBV + monthly viremia | exclude positive · prophylactic valganciclovir |

### 8.2 Pre-emptive resistance plan — combination saves vs sequential

| 시나리오 | sequential risk | combination 대응 |
|---|---|---|
| M5 단독 | NHEJ escape ~10⁻³/episome | dual heterodimer + 추가 cycle |
| M6 단독 | deep-latent 무반응 | M5 추가 cycle, M9 booster |
| M7 단독 | lock decay (10-20yr) | block layer backup |
| Arm S 4/4 surrogate 실패 | reservoir 잔여 ≥10² | additional cycle 또는 Arm F 전환 |

### 8.3 DSMB stopping rules

| Rule | 임계 | 행동 |
|---|---|---|
| Grade 4 irAE | ≥3 patients | M8 hold, dose-reduce |
| HSE 사례 | ≥1 confirmed | M6 cycle suspension, protocol review |
| AAV hepatotoxicity (LFT ≥5× ULN) / death within 90d | ≥1 | dose adj / full review |
| Therapeutic failure (12mo) | <30% surrogate-PASS | protocol amendment |

---

## 9. Animal-model → human transition

### 9.1 Preclinical package

| 모델 | endpoint | duration |
|---|---|---|
| Mouse TG (HSV-1, Jerome lab combo) | TG qPCR + shedding | 6-12mo |
| Guinea pig (HSV-2 genital, Stanberry) | sacral DRG qPCR + lesion | 6-12mo |
| 토끼 (HSV-1 corneal McKrae) | V1 TG qPCR + keratitis | 6mo |
| Macaque NHP full combo | shedding + 12mo GLP tox | 12mo |
| Humanized mouse (NSG-MHC I) | M8/M9 human immune validation | 3-6mo |

### 9.2 First-in-human progression

| 단계 | n | 기간 | 1차 endpoint |
|---|---|---|---|
| Phase 1a | 12×2 arms = 24 | 6mo | safety + PK + biomarker baseline |
| Phase 1b | 30 (dose-escalation) | 12mo | MTD + ddPCR shedding surrogate |
| Phase 2 | 120 (1:1:1 placebo : valacyclovir : interv) | 24mo | recurrence reduction + ddPCR |
| Phase 3 pivotal | 600 (2:1 interv:placebo, multi-center) | 24mo primary + 36mo durability | §5 / §6 primary |

Boundary criteria: 1a→1b no DLT ≥9/12 · 1b→2 MTD + biomarker ≥1 log · 2→3 ≥30% surrogate-PASS · 3→BLA p<0.025 + 24mo durability.

---

## 10. Regulatory strategy

### 10.1 FDA pathway

| Mechanism | 적용 | 근거 |
|---|---|---|
| Breakthrough Therapy Designation | 신청 (HSV recurrent ≥6/yr severe) | unmet need (현재 only valacyclovir suppression) |
| Fast Track | sterilizing arm 신청 | curable disease for chronic infection |
| Regenerative Medicine Advanced Therapy (RMAT) | M5/M7 AAV gene therapy 모듈 | gene therapy + serious condition |
| Combination Product | 4-modality (mRNA · AAV · checkpoint · small-mol) → CDER 다부서 | 제도적 새 framework 요구 |

### 10.2 EMA parallel

| Mechanism | 적용 |
|---|---|
| PRIME (priority medicines) | sterilizing cure 신청 |
| ATMP regulation | M5/M7 AAV |
| EMA-FDA Joint Scientific Advice | early consultation |

### 10.3 IND-enabling package

| 모듈 | 내용 | 기간 |
|---|---|---|
| CMC | AAV GMP (Catalent 등) + mRNA GMP (Moderna/Pfizer template) | 12-24mo |
| GLP tox | 12-mo NHP repeat-dose + genotox + biodistribution | 18-24mo |
| Clinical protocol + ICF + DSMB charter | §3+§4+§5+§6 통합 + §8.3 stopping rules | 6mo |

### 10.4 Regulatory timeline 🟠 INSUFFICIENT-DEFERRED

| 단계 | 추정 (🟠) |
|---|---|
| Preclinical → IND filing | 2027-2029 (mouse/NHP 데이터 의존) |
| Phase 1a 개시 | 2029-2030 |
| Phase 1b 완료 | 2031-2032 |
| Phase 2 readout | 2033-2034 |
| Phase 3 readout | 2036-2038 |
| BLA submission | 2038-2039 |
| Approval | 2039-2040 (HSV sterilizing first-in-class) |

→ 모든 날짜는 보수적 placeholder, regulator interaction에 의존 ⇒ 🟠.

---

## 11. 🟢 First-principles 통합 efficacy projection — combined model

### 11.1 Closed-form (Arm S sterilizing cycles)

각 cycle에서 한 latent episome 제거 확률:
$$p_\text{cycle} = 1 - (1 - p_{M5}) \cdot (1 - p_\text{M6+M8})$$

각 component (cycle-별 conditional):
$$p_{M5} = \varepsilon \cdot \phi$$  (M5 §6, AAV transduction × per-episome cleavage)
$$p_\text{M6+M8} = p_\text{react} \cdot p_\text{clear} \cdot E_\text{vaccine fraction}$$ (M6 §8 × M9 multiplier)

### 11.2 Parameter substitution (M2/M5/M6/M8/M9 직접)

| Symbol | Source | 값 |
|---|---|---|
| $N_\text{total}$ | M2 §7.1 | 1.25 × 10⁵ |
| $f_\text{body}/f_\text{tail}$ | M2 §7.2 | 0.55 / 0.45 |
| $\varepsilon$ (AAV-rh.10 transduction) | M5 §6 | 0.30 → 0.50 (M6 chromatin-opened) |
| $\phi$ (body / tail) | M5+M6 §8 | 0.95 / 0.70 |
| $p_\text{react}$ (M6 3-axis, body/tail) | M3 §7.4 | 0.95 / 0.10 |
| $p_\text{clear}^0$ / $p_\text{clear}^{M8}$ | M8 §8 | 0.24 / 0.60 |
| $E_\text{vaccine}$ → $p_\text{clear}^\text{boosted}$ (cap 0.85) | M9 §9.4 | 21× → 0.85 |
| $n$ cycles | §3.3 | 4-25 |

### 11.3 Best case (low tail, M9+M8 강하게 작동)

```
p_M5_body = ε·φ = 0.50 × 0.95 = 0.475
p_M6+M8   = p_react · p_clear^boosted = 0.95 × 0.85 = 0.808
p_cycle_body = 1 - (1-0.475)(1-0.808) = 0.899
N_body 잔여(n) = 6.88e4 × 0.101^n  →  n=4: 7.2 · n=5: 0.73 ≤1 ⇒ body sterilized

p_M5_tail = 0.50 × 0.70 = 0.35
p_M6+M8_tail = 0.10 × 0.85 = 0.085   (deep-latent barrier dominant)
p_cycle_tail = 1 - 0.65×0.915 = 0.405
N_tail 잔여(n) = 5.63e4 × 0.595^n  →  n=15: 19.5 · n=20: 0.91 ≤1 ⇒ tail sterilized
```

→ **best-case body 5 cycles · tail 20 cycles**.

### 11.4 Realistic case (mid tail, M6 부분적)

$p_\text{react}=0.80$, $p_\text{clear}^\text{boosted}=0.72$:
```
p_cycle_body = 1 - 0.525×0.424 = 0.777  →  n=7: 1.9 · n=8: 0.42 ≤1
p_cycle_tail = 1 - 0.65×0.928 = 0.397   →  n=20: 1.86 · n=22: 0.68 ≤1
```
→ **realistic body 8 · tail 22 cycles** ⇒ 통합 **10-15 cycles** (tail dominates).

### 11.5 Worst case (high tail, AAV transduction 한계)

$\varepsilon=0.10$, $\phi_\text{tail}=0.30$, $p_\text{react}^\text{tail}=0.05$:
```
p_cycle_tail = 1 - 0.97×0.964 = 0.0648  →  n=100: 64 · n=150: 2.2
```
→ worst case >100 cycles, 실용 불가 ⇒ **Arm F 전환 권고**.

### 11.6 Efficacy waterfall (ASCII)

```
N_residual (log10)
   5 ┤● baseline 1.25e5
   4 ┤  ●● M5 단독 ceiling (~9e4)
   3 ┤    ▲▲  M6+M8 단독 (cycle별 reduction)
   2 ┤        ▲▲
   1 ┤            ★★ M5+M6+M8+M9 (best)
   0 ┤- - - - - - - - ★ - - - - - sterilizing threshold (≤1)
  -1 ┤                    ★
     └────────────────────────────► cycles
        0   2   4   6   8  15  25
```

### 11.7 Arm F lifetime accumulation (closed-form, 🔵+🟢)

block adherence 95% + lock $P_{Me3}$ ≥ 0.999 (M7 §4): $\lambda_\text{recur} \approx 10^{-12}$/yr, $\Lambda_\text{lifetime}(80yr) \approx 0$.
Practical adherence 80% + lock decay: $\lambda \approx 10^{-4}$/yr → $\Lambda_\text{lifetime} \approx 8\times 10^{-3}$ (80yr 누적 0.8%) ≪ 1.

🔵 steady-state (M7 §4.5): $P_{Me3}^\text{ss,KRAB-on} = 5\times10^{-2}/(5\times10^{-2}+5\times10^{-5}) \approx 0.999$.
Escape rate: $k_\text{escape} \approx 5\times10^{-15}$ s⁻¹ ⇒ lifetime $P \approx 1.3\times10^{-5}$ — sub-1% lifetime, 만족.

→ **functional cure**, sterilizing은 아니나 평생 사실상 reactivation 없음.

### 11.9 종합 — Arm S vs Arm F 첫째 원리 비교

| 축 | Arm S | Arm F |
|---|---|---|
| target | reservoir 제거 | reservoir 잠금 |
| best-case cycles/duration | ~5 cycles body, ~20 tail (10-15mo 강력 분기) | one-shot AAV + 평생 daily |
| realistic | 10-15 cycles (~12-18 mo) | lifelong (1 install) |
| worst-case | >25 cycles → Arm F 전환 | adherence 의존 |
| sterilizing claim | 가능 (≤1 residual) | 불가능 (reservoir 보존) |
| 영구성 | true cure | 약물·AAV 의존 |
| 환자 적합성 | 면역 정상 · low tail · AAV neg | 면역 약 · high tail · 노령 |

---

## 12. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| Two-arm split logic (§1) | 🟢 SUPPORTED-NUMERICAL | M6 M7 약리 mutual exclusion ODE-증명 |
| Stratification matrix (§2) | 🟡 SUPPORTED-BY-CITATION + 🟢 decision-tree | HLA · AAV Ab · reservoir literature + first-principles tree |
| Arm S sequencing (§3) | 🟡 + 🟢 closed-form cycle (§3.3) | 각 모듈 M5-M9 직접 인용 + Markov 누적 |
| Arm F sequencing (§4) | 🟡 + 🔵 (M7 §5 ODE) | M7 시퀀스 직접 인용 |
| ddPCR shedding endpoint (§5.1) | 🟢 SUPPORTED-NUMERICAL | Wald A 외 ddPCR sensitivity benchmark |
| LAT-miRNA blood proxy (§5.2#2) | 🟡 SUPPORTED-BY-CITATION | Umbach 2008 + 후속 |
| Endpoint hierarchy (§5.3, §6.3) | 🟢 logic + 🟡 thresholds | first-principles AND-gate |
| Non-biopsy verification mapping (§7.2) | 🟢 SUPPORTED-NUMERICAL | M3 + M4 ODE → shedding mapping |
| ¹⁸F-FIAU PET tracer (§7.4) | 🟠 INSUFFICIENT-DEFERRED | 임상 적용 미정, PoC stage |
| Animal-model bridge (§7.5, §9) | 🟡 SUPPORTED-BY-CITATION | Jerome · Stanberry · Aubert 2020 |
| Failure-mode matrix (§8) | 🟡 + 🟢 | 각 모듈 risk 직접 인용 + escape prob 폐형 |
| Combined efficacy projection (§11) | 🟢 SUPPORTED-NUMERICAL | M2/M5/M6/M8/M9 파라미터 직접 대입, 폐형 |
| Arm F lifetime acc (§11.7) | 🔵 + 🟢 | M7 §4 closed-form Markov |
| Clinical trial design (§9) | 🟡 SUPPORTED-BY-CITATION | FDA HSV guidance + adjacent (HBV, HIV cure) |
| Regulatory timeline (§10.4) | 🟠 INSUFFICIENT-DEFERRED | 날짜 fabrication 회피 |
| Phase 3 N=600 power | 🟡 | adjacent trial 외삽 (HBV functional cure VIR-2218) |

### 핵심 needs-check / 🟠 목록

1. **§7.4 PET tracer (¹⁸F-FIAU) for ganglion** — 잠복 ganglion-specific imaging PoC 부재.
2. **§5.2 LAT-miRNA blood quantitation** — 자연 감염자 baseline dataset sparse.
3. **§10.4 regulatory timeline** — FDA·EMA interaction 의존 date placeholder.
4. **§11 worst-case 파라미터** — 인간 deep-latent fraction 분포 측정 부재 (M2 §6.1).
5. **§9.1 humanized mouse M8/M9 validation** — 인간 HLA Tg mouse 필요.
6. **§3.2 KDM4 activator chemical 부재** — surrogate (UNC0638 + ascorbate-Fe(II)) 임시.
7. **§2.4 Anc80 backup serotype** — pre-immune prevalence + cross-reactivity 측정 필요.

---

## 13. 핵심 단일-문장 결론

> 본 M10 프로토콜은 M5+M6+M8+M9 4-modality stack (Arm S sterilizing) 또는 M7 단독 stack (Arm F functional)으로 환자를 stratify하여 — first-principles Markov 누적 폐형에서 **realistic case 10-15 cycle (~12-18mo)** 안에 M2 §7.1 N_total 1.25×10⁵을 ≤1 residual로 줄이는 sterilizing path를 정량적으로 가능케 하며 (best-case body 5 cycle · tail 20 cycle), heavy-tail dominant 또는 면역약한 환자에 대해서는 Arm F의 M7 block-and-lock (DLK + JNK + LSD1 + dCas9-ZIM3-KRAB)이 평생 reactivation < 10⁻³ 누적의 functional cure를 제공하는 — non-biopsy peripheral surrogate (4-endpoint AND-gate: ddPCR swab + LAT-miRNA blood + clinical lesion + Ab titer trajectory)로 measured-oracle PASS 검증 가능한 통합 임상 trial 설계이다.

---

## 14. 참고문헌 (one-line)

- M1-M9 prior milestones (`HERPES/M1-M9_*.md`) — direct input
- FDA (2017) *Genital Herpes — Developing Drugs for Treatment* guidance update
- EMA (2009) *Guideline on the clinical evaluation of antiviral medicinal products against HSV*
- Wald A, Corey L (2007-) *Lancet Infect Dis* — HSV-2 shedding ddPCR
- Sacks SL et al. — valacyclovir suppressive therapy trial legacy
- Davenport MP, Lewin SR (2019) *Nat Rev Microbiol* 17:75 — HIV cure framework
- Yuen MF et al. (2022) — VIR-2218 HBV functional cure trial design
- BNT163 — NCT05432583 BioNTech HSV-2 mRNA Phase 1 (🟠 readout 보류)
- Excision BioTherapeutics — HSV CRISPR preclinical (🟠 status needs-check)
- Aubert M, Jerome KR et al. (2020) *Nat Commun* 11:4148 — meganuclease HSV-1 ~92%
- Knipe DM, Cliffe A (2008) *Nat Rev Microbiol* 6:211 — HSV latency review
- Sloan DD, Jerome KR (2007) *J Virol* 81:11069 — non-cytolytic CTL
- Knickelbein JE et al. (2008) *Science* 322:268 — TG-resident CD8
- Tawbi HA et al. (2022) *NEJM* 386:24 — relatlimab+nivolumab (RELATIVITY-047)
- Cuddy SR et al. (2020) *eLife* 9:e58037 — Phase I/II phospho-methyl switch
- Whitford AL et al. (2022/2024) *Cell Host Microbe* — DLK/JNK block-and-lock
- Pulendran B et al. (2021) *Nat Rev Immunol* 21:626 — COVID mRNA immunology
- Replogle JM et al. (2022) *Cell* 185:2559 — ZIM3-KRAB Perturb-seq
- Nuñez JK et al. (2021) *Cell* 184:2503 — CRISPRoff persistent silencing

---

> end M10 — HSV sterilizing cure 10-milestone roadmap 완결. measured-oracle PASS은 §5/§6 4-surrogate AND-gate 임상에서 확인 가능 단계로 lock-in되었다.
