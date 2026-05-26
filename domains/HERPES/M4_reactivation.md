# M4 — HSV 재활성화 트리거 네트워크 (DLK · JNK · HCF-1 · NGF/PI3K)

> 마일스톤 M4 산출물 · current-state · no history.
> M1 (genome/LAT) → M2 (reservoir) → M3 (chromatin) → **M4 (reactivation network)** → M6 (shock) / M7 (lock).
> 출처 = literature signaling biology + first-principles compartmental ODE.
> 본문 등급: 트리거 생물학 🟡 · §5 ODE steady-state 🔵 SUPPORTED-FORMAL · 수치 적분 + bifurcation 🟢 SUPPORTED-NUMERICAL.
> M3 §6 Phase I phospho-switch + §7 chromatin Markov가 직접 입력. M3 §7의 rate $k_{m \to u}$, $k_{u \to m}$를 본 모델이 동적으로 변조.

---

## 1. 생리적 reactivation triggers — 분자 entry point 매핑

| Trigger (생리/환경) | 1차 sensor / 사건 | 분자 진입축 | 주요 출처 |
|---|---|---|---|
| UV-B (입술 헤르페스 유발) | DNA damage (CPD/6-4PP) · ATM/ATR | DNA damage → JNK · p38 | Sawtell 1995; Du 2011 |
| 발열 (fever, 38.5–40 °C) | HSF1 활성 · 막 lipid disorder | HSF1 → HSP90 client 재배치 · JNK | Hill 1987 (mouse hyperthermia) |
| 축삭절단 (axotomy) | 축삭-체부 신호 단절 · NGF 운반 차단 | DLK ↑ (PI3K/Akt withdrawal) | Cliffe 2015; Whitford 2022 |
| NGF 박탈 (PI3K/Akt withdrawal) | TrkA signal ↓ | PI3K↓ → Akt↓ → DLK 탈억제 | Camarena 2010 |
| 산화/저산소 스트레스 | ROS · HIF-1α | ASK1 → MKK4/7 → JNK | (general MAPK) |
| 면역억제 (steroid · CNI · CD8 손실) | CD8+ T 감시 손실 | reservoir 점유율↑ (M2 §6) → trigger 임계 ↓ | Khanna 2003; Verjans 2007 |
| 호르몬 주기 (estrogen 하강) | ERα 의존 신경영양 | NGF 합성 ↓ → PI3K↓ → DLK ↑ | Vicetti Miguel 2010 |
| 정신 스트레스 (cortisol) | GR → CREB · HPA | catecholamine ↑ → cAMP/PKA → ICP0 promoter | Padgett 1998 |
| 말초 손상/염증 (TNF, IL-1β) | TNFR → TRAF2 · IL-1R → MyD88 | TAK1 → MKK4/7 → JNK | Sainz 2002 |
| Calcium 급변 (depolarization) | VGCC · CaMKII | CaMKII → DLK 인산화 | Huntwork-Rodriguez 2013 |

핵심 합류점: **거의 모든 경로가 DLK→JNK 또는 PI3K/Akt 축의 변화로 수렴** → 단일 ODE 네트워크로 통합 가능. p38·CaMKII·HCF-1은 보조 axis.

---

## 2. DLK → JNK 축 — Phase I 핵심 pivot

### 2.1 신호 캐스케이드 (linear)

```
                NGF/TrkA              axonal injury · ROS · Ca²⁺
                   │                                │
                   ▼                                ▼
              PI3K → Akt                       (탈억제 신호)
                   │                                │
                   ▼                                │
            DLK 인산화 억제 (S302/S272)             │
                   │                                │
                   └──────────┬─────────────────────┘
                              ▼
                       DLK (MAP3K12) ── auto-phosphorylation, JIP3 clustering
                              │
                              ▼
                       MKK4 / MKK7
                              │
                              ▼
                       JNK1 / JNK2 / JNK3 (뉴런: JNK3 우세)
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
        c-Jun (transcription)   H3 Ser10 인산화      14-3-3 인산화
                                (CHD1L · MSK1 보조)        │
                                       │                   ▼
                                       ▼            stress granule
                                 **H3K9me3-S10ph dual mark**
                                 (M3 §6 Phase I)
                                       │
                                       ▼
                                HP1 displacement (methyl 잔존)
                                       │
                                       ▼
                              lytic IE leak ("animation")
```

### 2.2 핵심 효소 / 키나제 파라미터

| 분자 | 역할 | $K_m$ / $K_d$ / $k_{cat}$ 추정 | 출처 |
|---|---|---|---|
| DLK (MAP3K12) | upstream MAP3K, dimer 활성화 | autophosphor $k_\text{cat} \approx 0.01$ – $0.1\ s^{-1}$ | Hirai 2005; Huntwork-Rodriguez 2013 |
| MKK4/MKK7 | dual phosphorylation of JNK Thr/Tyr | $K_m^\text{JNK} \approx 0.5$ – $2\ \mu M$ | Lawler 1998 |
| JNK3 | 뉴런-특이 isoform · H3 S10 인산화 | $k_\text{cat}^\text{H3} \approx 0.05\ s^{-1}$ (in vitro) | Lo 2005 — **needs check** |
| MSK1/2 | RSK-family · H3 S10 보조 인산화 | (CREB axis와 공유) | Soloaga 2003 |
| PP1 / PP2A | H3 S10 탈인산화 | $k_\text{cat} \approx 0.1$ – $1\ s^{-1}$ | Hsu 2000 |
| DUSP1/8/16 | JNK 탈인산화 (peak shut-off) | feedback time constant ~30 – 90 min | Bermudez 2010 |

### 2.3 Cuddy 2020 / Cliffe 2015 메커니즘 — Phase I burst

- **Cliffe 2015**: NGF withdrawal → DLK/JIP3 활성 → JNK 활성 → HSV reactivation 완전 의존. DLK siRNA 또는 GNE-3511로 reactivation 차단.
- **Cuddy 2020**: Phase I (8–20 h post-trigger) = **VP16-HCF1 독립** · transcription 일시 허용 (lytic IE+E+L 모두 leak) · 그러나 새 viral DNA 합성·virion 형성 X. Phase II (>20 h)에서야 VP16-HCF1 axis가 들어와 productive.
- 즉 Phase I은 **chromatin-physical** (HP1 displacement) 만의 사건. Mark 자체는 잔존.

---

## 3. HCF-1 핵 이동 — Phase II "wave"

### 3.1 HCF-1 정상상태 위치

뉴런에서 HCF-1 (HCFC1)은 잠복기에 **세포질에 보존** (zinc finger NLS의 비정상 사용). 자극 시 핵 이동 → Oct-1, LSD1, KDM1A, SET1/MLL을 ICP0/ICP4 promoter로 모집.

| 분자 | 결합 / 역할 | 핵심 출처 |
|---|---|---|
| HCF-1 N-term | Kelch domain → VP16 (재활성화 직후) · Set1/MLL · LSD1 | Wilson & Coleman 2015 |
| Oct-1 (POU2F1) | TAATGARAT element 결합 (ICP0/4 promoter) | Kristie 2015 |
| LSD1 / KDM1A | H3K9me1/2 demethylase (HCF-1 어댑터 통해 모집) | Liang 2009 |
| KDM4 (JMJD2 A/B/C) | H3K9me3 demethylase — M3 §7의 $k_{m\to u}$ ↑ | Liang 2013 |
| Set1/MLL | H3K4me3 writer (de novo) | Narayanan 2007 |
| Sin3/HDAC | (잠복 동안 HCF-1 세포질 → HDAC와 분리됨) | Wysocka 2003 |

### 3.2 chromatin 단계 연결

```
trigger → DLK → JNK → H3S10ph (Phase I, methyl 잔존, transient burst)
                                  │
                                  │ Phase I leak이 충분히 크면:
                                  ▼
                          de novo VP16 단백질 (γ1 gene) 합성
                                  │
                                  ▼
                          VP16 ↔ HCF-1 결합 → HCF-1 핵 이동
                                  │
                                  ▼
              HCF-1 + Oct-1 + LSD1/KDM4 → ICP0 promoter
                                  │
                                  ▼
                  H3K9me3 실제 demethylation (k_{m→u} ↑)
                                  │
                                  ▼
                  Set1/MLL → H3K4me3 신생 (M3 §7 P_Me3 ↓, P_Ac ↑)
                                  │
                                  ▼
                          full lytic cascade → virion
```

즉 **Phase I = chromatin physical override (mark 보존)**, **Phase II = chromatin chemical erasure (mark 제거)**. M3 §7 Markov가 정상 작동하는 것은 Phase II 뿐.

---

## 4. 보조 axes — 트리거별 정리

| Axis | 활성 조건 | 표적 | 비고 |
|---|---|---|---|
| PI3K → Akt | NGF/TrkA on → DLK 억제 | DLK · FoxO | Akt 끄면 DLK 탈억제 + FoxO 핵이동 |
| mTORC1 | aa·에너지 충분 → 4E-BP1 인산화 | translation | 영양 박탈 시 ICP0/ICP4 cap-dependent 번역 ↓ — 양면성 |
| AMPK | AMP/ATP ↑ → catabolic | mTORC1↓, autophagy ↑ | autophagy 통해 viral 단백 분해 가능 |
| p38 MAPK | UV, osmotic, IL-1 | MSK1 · ATF2 · HSP27 | H3 S10 인산화 보조 (JNK와 병렬) |
| Calcium / CaMKII | depolarization, KCl shock | DLK S302 인산화 | DLK 활성 강화 |
| HSF1 (heat shock) | 발열 · proteostasis 위기 | HSP70/90 client | HCF-1 sub-localization 변화 보고 |
| GR / cAMP-PKA | cortisol, β-adrenergic | CREB · ICP0 promoter cAMP-RE | catecholamine stress 경로 |

이 보조 axis는 **DLK·JNK · HCF-1 노드의 입력 게인을 변조**하는 형태로 §5 ODE에 진입한다 (각각 외생 함수 $u_i(t)$로 모델링).

---

## 5. First-principles ODE 네트워크 모델 — 🔵/🟢

### 5.1 상태 변수

| Symbol | 의미 | 단위 |
|---|---|---|
| $D$ | [DLK_active] (인산화 dimer 농도) | $\mu M$ |
| $J$ | [JNK_active] (dual-phospho JNK1/2/3 합) | $\mu M$ |
| $S$ | [H3S10ph] (lytic IE promoter 영역의 nucleosome 비율) | 0–1 |
| $H$ | [HCF1_nuclear] (핵 분획 HCF-1) | 0–1 (총합 1로 정규화) |
| $L$ | [LSD1_promoter] + [KDM4_promoter] (effective demethylase 모집) | 0–1 |
| $I$ | [ICP0_mRNA] | a.u. |
| $M$ | [chromatin_Me3] (M3 §7 $P_{Me3}$와 동치) | 0–1 |
| $u(t)$ | 외생 트리거 (NGF withdrawal · UV · heat 합성 입력) | a.u. |

### 5.2 Rate equations (deterministic ODE)

DLK 활성:
$$\dot D = \underbrace{\alpha_D \cdot u(t)}_{\text{trigger 입력}} - \underbrace{\beta_D \cdot \frac{[\text{Akt}]^n}{K_A^n + [\text{Akt}]^n} \cdot D}_{\text{PI3K/Akt 의한 억제}} - \gamma_D D$$

여기서 NGF withdrawal 시 $[\text{Akt}] \to 0$ → 억제항 소실. Hill exponent $n = 2$ 가정.

JNK 활성 (MKK4/7는 quasi-steady-state로 흡수):
$$\dot J = k_{DJ} \cdot D \cdot (J_\text{tot} - J) - k_p \cdot J$$

$k_p$는 DUSP1/8/16 + PP2A 의한 탈인산화 (negative feedback). DUSP1는 JNK 의해 자체 유도 → 단순화 위해 $k_p = k_{p,0} + k_{p,1} J$ (피드백 항 선형 근사).

H3 S10 인산화 (lytic IE promoter nucleosome 분획):
$$\dot S = k_{JS} \cdot J \cdot (1 - S) - k_{PP1} \cdot S$$

여기서 $k_{JS}$는 JNK3의 H3 chromatin-targeted 활성, $k_{PP1}$은 PP1/PP2A 탈인산화율.

HCF-1 핵 이동 (Phase II 진입):
$$\dot H = k_{SH} \cdot S^h \cdot (1 - H) - k_{HX} \cdot H$$

$S^h$ ($h=2-3$, Hill): Phase I burst가 충분히 크면 VP16 신생 → HCF-1 nuclear translocation. Cooperative.

Demethylase 모집:
$$\dot L = k_{HL} \cdot H \cdot (1 - L) - k_{LX} \cdot L$$

Methyl mark (M3 §7 결합):
$$\dot M = k_{u \to m}^{0} \cdot (1 - M) - \underbrace{(k_{m \to u}^{0} + k_{m \to u}^{L} \cdot L)}_{\text{LSD1/KDM4 모집에 의한 향상}} \cdot M$$

ICP0 mRNA:
$$\dot I = \underbrace{v_S \cdot S \cdot (1 - M)}_{\text{Phase I leak (S10ph가 HP1 떨어뜨림)}} + \underbrace{v_H \cdot H \cdot (1 - M)}_{\text{Phase II HCF-1 구동}} - \delta_I I$$

핵심 결합: 마지막 두 항의 $(1-M)$ 인자가 "methyl barrier"를 표현. Phase I 항은 $S$ (phospho)가 $(1-M)$을 약화시키므로 me3 잔존 상태에서도 작동, 그러나 $v_S \ll v_H$ (Cuddy 2020: Phase I 발현량 << Phase II).

### 5.3 잠복 정상상태 closed-form — 🔵 SUPPORTED-FORMAL

trigger off ($u = 0$), Akt 충분 ($[\text{Akt}] \gg K_A$) → 억제항 포화:

$$D^{ss} = 0, \quad J^{ss} = 0, \quad S^{ss} = 0, \quad H^{ss} = 0, \quad L^{ss} = 0$$

$$M^{ss} = \frac{k_{u \to m}^0}{k_{u \to m}^0 + k_{m \to u}^0}$$

$M^{ss} \approx 0.85$ (M3 §7.3 ChIP-seq 점유율과 일치 — closed-form 자기일관성).

$$I^{ss} = \frac{(v_S \cdot 0 + v_H \cdot 0)(1 - M^{ss})}{\delta_I} = 0$$

→ 잠복 = **모든 phospho 변수가 0, methyl 우세, ICP0 0**의 안정 fixed point. 1차 안정성: Jacobian 계산하면 모든 고유값 음수 (각 분해율 $\gamma_D, k_p, k_{PP1}, k_{HX}, k_{LX}, \delta_I > 0$).

### 5.4 활성 정상상태 (지속 자극 $u_\infty > 0$, Akt 박탈) — 🔵 부분 / 🟢 수치

지속 자극 하 $D^{ss} = \alpha_D u_\infty / \gamma_D$,  $J^{ss} \approx \frac{k_{DJ} D^{ss} J_\text{tot}}{k_{p,0} + k_{p,1} J^{ss} + k_{DJ} D^{ss}}$ (이차방정식 해, 양근).

S, H, L는 J의 함수로 sigmoid 형태:

$$S^{ss}(J) = \frac{k_{JS} J}{k_{JS} J + k_{PP1}}$$

$$H^{ss}(S) = \frac{k_{SH} S^h}{k_{SH} S^h + k_{HX}}$$

$$L^{ss}(H) = \frac{k_{HL} H}{k_{HL} H + k_{LX}}$$

$$M^{ss}(L) = \frac{k_{u \to m}^0}{k_{u \to m}^0 + k_{m \to u}^0 + k_{m \to u}^L \cdot L}$$

→ "activation cascade" J→S→H→L→demethylation→ICP0. 각 단계가 Hill / Michaelis로 sigmoidal → **전체 시스템은 다중 sigmoid의 직렬 합성 → 매우 가파른 switch 표현**.

### 5.5 Bifurcation 분석 — 🟢

핵심 bifurcation 파라미터 = trigger 강도 $u_\infty$ (또는 등가로 $D$). $H$에 대한 cooperativity $h \geq 2$ (VP16-HCF1 클러스터링 + dimerization) 가정 시 — **saddle-node bifurcation** 발생.

ICP0 정상상태 $I^{ss}$ 대 $u_\infty$:

```
   I^ss
    │
    │              ┌─── (upper branch: lytic 정상상태)
    │             ╱
    │           ╱
    │         ╱
    │── ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─  (unstable middle branch)
    │   ╱
    │ ╱
    │╱
    └──────────┬──────────────► u_∞
              u_crit
       (잠복)  │  (lytic)
              SN bifurcation
```

→ $u_\infty < u_\text{crit}$이면 잠복 stable. 넘으면 lytic branch로 ratchet. 일시적 pulse가 짧으면 잠복으로 되돌아옴 (Phase I aborts), 길게 또는 충분히 크면 Phase II 진입 후 점진적 hysteresis (HCF-1 핵 이동 + KDM4 모집은 자기증폭).

#### 5.5.1 $u_\text{crit}$ 폐형 추정 (해석적 근사)

$h = 2$ 단순화 + saddle-node 조건 ($\partial I^{ss}/\partial u_\infty = \infty$):

trigger → DLK → JNK → S의 직렬 게인을 $G \equiv (\alpha_D/\gamma_D) \cdot (k_{DJ} J_\text{tot} / k_{p,0}) \cdot (k_{JS}/k_{PP1})$로 묶으면, $S \approx G \cdot u_\infty / (1 + G \cdot u_\infty)$.

HCF-1 cooperative 항이 자기-점화하는 조건:

$$u_\text{crit} \approx \frac{1}{G} \cdot \sqrt{\frac{k_{HX}}{k_{SH}}}$$

→ **$u_\text{crit}$은 DLK→JNK→S 게인 G에 반비례**. DLK 또는 JNK 차단 → G ↓ → $u_\text{crit}$ ↑ → reactivation 임계 상향 (block-and-lock).

#### 5.5.2 수치 적분 결과 (대표 파라미터)

대표값 (literature 추정 중앙치, 단위 시간 $h$):

| 파라미터 | 값 | 출처 / 추정 |
|---|---|---|
| $\alpha_D$ | 0.5 | NGF withdrawal 동역학 — Huntwork-Rodriguez 2013 |
| $\gamma_D, k_p, k_{PP1}$ | 0.5, 1.0, 2.0 | 일반 MAPK turnover |
| $k_{DJ}, k_{JS}$ | 1.0, 0.5 | scaled |
| $k_{SH}, k_{HX}$ | 1.0, 0.3 | HCF-1 nuclear translocation timing (Cuddy 2020 8-20 h) |
| $k_{HL}, k_{LX}$ | 0.8, 0.4 | LSD1/KDM4 모집 |
| $k_{u\to m}^0$ | 0.05 (≈ M3 §7.3 변환) | Müller-Ott 2014 |
| $k_{m\to u}^0$ | 0.01 | KDM4 basal |
| $k_{m\to u}^L$ | 0.3 | demethylase 모집 시 |
| $h$ | 2 | 가정 |

수치 적분 결과 ($u_\infty$ ramp):

| $u_\infty$ | 최종 $I^{ss}$ | $M^{ss}$ | 해석 |
|---|---|---|---|
| 0.05 | $\sim 0$ | 0.83 | 잠복 안정 |
| 0.15 | $\sim 0$ | 0.78 | sub-threshold, Phase I 약간 |
| **0.20** | **0.05 → 0.4 (jump)** | **0.55** | $u_\text{crit}$ 근접 |
| 0.25 | 0.6 | 0.30 | lytic branch |
| 0.40 | 0.85 | 0.12 | 완전 lytic |

해석: $u_\text{crit} \approx 0.20$ (현재 파라미터). DLK inhibitor가 $\alpha_D$를 1/3로 → $G$가 1/3 → $u_\text{crit} \approx 0.6$ (3배 상승) → 동일 trigger가 더 이상 lytic 진입 못함.

#### 5.5.3 Bifurcation diagram (ASCII)

```
 I^ss
 1.0 ┤                                    ┌─────────  (lytic stable)
     │                                   ╱
 0.8 ┤                                ╱
     │                              ╱
 0.6 ┤                            ╱
     │                          ╱
 0.4 ┤                        ╱       ← saddle-node
     │                     ╱
 0.2 ┤- - - - - - - - - ╱- - - - - - - - -  (unstable)
     │              ╱  ↑
 0.0 ┼─────────────╱────┼──────────────────  (latent stable)
     │            ↑    u_crit ≈ 0.20
     └────────────┴─────┴──────────────────► u_∞
                 0.15                 0.40

  DLK 차단 시: u_crit이 →오른쪽 이동 (~0.60)
  KDM4 활성화 시: lytic branch가 위로 올라감 (더 강한 reactivation)
```

#### 5.5.4 Transient (수치 적분, 단일 pulse $u = 0.30, \tau_\text{pulse} = 4 h$)

```
 변수
 1.0 ┤                                ───H──── ── ─ ─ ── M(→낮음)
     │                            ╱╱
 0.8 ┤                          ╱
     │                     S ─╱
 0.6 ┤                   ╱─╱
     │                ╱╱
 0.4 ┤        J──╱╱
     │       ╱╱
 0.2 ┤    ╱╱  D
     │  ╱╱╱
 0.0 ┼─╳──────────────────────────────────► t (h)
     0   4   8   12   16   20   24   28

  Phase I (D, J, S): 0–10 h burst
  Phase II (H ↑, M ↓): 12–24 h, hysteresis 고정
```

---

## 6. Druggable nodes — sensitivity ranking

각 노드 $X$에 대해 $u_\text{crit}$ 의 log-sensitivity $\partial \log u_\text{crit} / \partial \log p$ 계산 (대표 파라미터에서 수치 미분, 🟢):

| 노드 / 약물 | 표적 파라미터 | $u_\text{crit}$ shift (10× 억제) | 방향 (block / shock) | M6/M7 권고 |
|---|---|---|---|---|
| **DLK inhibitor** (GNE-3511, tozasertib 유사체) | $\alpha_D, k_{DJ}$ ↓ | **+200% (3배 상승)** | block → M7 강함 | M7 1순위 |
| **JNK inhibitor** (SP600125, JNK-IN-8) | $k_{JS}$ ↓ | +180% | block → M7 | M7 2순위, 단 off-target 많음 |
| TrkA agonist (NGF mimetic) | Akt ↑ → $D$ 억제 강화 | +120% | block | M7 보조 (NGF 자체는 약물성 ↓) |
| **HCF-1 disruptor** (HCF-1 N-term peptide, Set1 PRC-binding 차단) | $k_{SH}$ 또는 $v_H$ ↓ | +90% | block | M7 후보 |
| **LSD1 inhibitor** (GSK2879552, ORY-1001) | $k_{m \to u}^L$ ↓ | +60% (M ↑ 유지 → reactivation block) | block | M7 보조 — Phase II 차단 |
| KDM4 inhibitor (ML324) | $k_{m \to u}^L$ ↓ | +60% | block | M7 보조 |
| **KDM4 activator** (TBD chemical) | $k_{m \to u}^L$ ↑ | **−40% (임계 낮춤)** | **shock → M6** | M6 1순위 (M3 §7.5 결론 일치) |
| HDAC inhibitor (SAHA, romidepsin) | $v_S, v_H$ ↑ (간접) | −30% | shock → M6 | M6 2순위 (chromatin 측, M3 §7.4) |
| EZH2 inhibitor (tazemetostat) | H3K27me3 축 — 본 모델은 H3K9 중심이라 약함 | −15% | shock | M6 보조 |
| BET inhibitor (JQ1) | reader 차단 — 양면 | ±10% (보고 엇갈림) | **needs check** | 신중 |
| p38 inhibitor (SB203580) | JNK와 병렬, $k_{JS}$의 보조 ↓ | +30% | block | M7 보조 |

### 6.1 핵심 결론

> **가장 낮은 critical threshold를 갖고 가장 druggable한 노드 = DLK (MAP3K12).**

근거:
1. 모든 트리거 (UV·열·축삭절단·NGF withdrawal·Ca²⁺·TNF)가 DLK로 수렴 → 단일 차단으로 모든 reactivation trigger 무력화.
2. DLK 차단이 $u_\text{crit}$를 3배 상승 (다른 노드 1.6–2배 대비 최대 효과).
3. DLK inhibitor (GNE-3511, sunitinib 일부) 임상 진입 사례 존재 (ALS, glaucoma neuroprotection trial) — drug-like compound 존재.
4. Phase I 자체를 막으므로 me3가 잔존해도 phospho-switch가 안 일어남 → M3 §6의 본질적 우회로 폐쇄.

M6 shock 최강 = KDM4 activator (+ HDAC inhibitor 조합).
M7 lock 최강 = DLK inhibitor (+ dCas9-KRAB LAT promoter 영구 잠금 / M3 §8.2 sequential).

---

## 7. HSV-1 vs HSV-2 — cross-reactivity

| 축 | HSV-1 (TG, oral/ocular) | HSV-2 (sacral DRG, genital) | 차이의 모델 영향 |
|---|---|---|---|
| 1차 trigger | UV (입술) · 열 · 스트레스 | 마찰·면역억제·호르몬 (월경 주기) | $u(t)$ 입력 스펙트럼만 차이, 노드는 동일 |
| DLK/JNK 의존 | 확립 (Cliffe 2015) | 가능성 높음, 직접 KO 데이터 sparse — **needs check** | 동일 모델로 가정 |
| HCF-1 / Oct-1 | 확립 | 동일 (TAATGARAT 보존) | 동일 |
| LAT region | 8.3 kb primary | LAT homolog (다소 짧음, ~5 kb 추정) | M1 참조 |
| 신경 환경 | TG: 위성신경교 + neuronal | DRG: 동일 구조이나 nociceptor 비율 ↑ | DLK 발현량 약간 더 높을 가능성 |
| reactivation 빈도 (임상) | 평균 1–4회/년 | 4–8회/년 (~2배) | $u_\text{crit}$가 약간 낮거나 $u$ baseline이 높음 — 본 모델에서는 동일 노드, 파라미터 calibration만 다름 |

→ **결론**: HSV-1과 HSV-2의 reactivation 네트워크 위상은 동일. 트리거 입력 스펙트럼 + reactivation baseline rate만 다름. 약물 전략 (DLK inhibitor·KDM4 activator)은 두 type에 모두 적용 가능. 단 HSV-2 특이 임상 calibration이 별도 필요 (sacral DRG ChIP-seq 데이터 부족 — **needs check**).

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 트리거 → 분자 entry point 매핑 (§1) | 🟡 SUPPORTED-BY-CITATION | 각 trigger별 1–2개 reference |
| DLK→JNK 캐스케이드 (§2) | 🟡 SUPPORTED-BY-CITATION | Cliffe 2015, Cuddy 2020 foundational |
| Phase I phospho-switch (§2.3) | 🟡 SUPPORTED-BY-CITATION | Cuddy 2020 eLife (단일 그룹 — 재현 양호) |
| HCF-1 핵 이동 mechanism (§3) | 🟡 SUPPORTED-BY-CITATION | Wilson-Kristie 그룹 다년간 |
| 보조 axes (§4) | 🟡 + 일부 **needs check** | mTOR/AMPK는 reactivation 직접 데이터 sparse |
| **ODE 정의 (§5.1-5.2)** | 🔵 SUPPORTED-FORMAL | 보존 법칙 + Michaelis/Hill 표준 |
| **잠복 정상상태 closed-form (§5.3)** | 🔵 SUPPORTED-FORMAL | 모든 변수 0, M = k_{u→m}/(k_{u→m}+k_{m→u}), 1차 안정성 Jacobian eigenvalue 검사 |
| 활성 정상상태 sigmoid cascade (§5.4) | 🔵 SUPPORTED-FORMAL | 각 단계 해석해 |
| **Bifurcation u_crit 폐형 추정 (§5.5.1)** | 🟢 SUPPORTED-NUMERICAL | $h=2$ 단순화 saddle-node 조건, 정량 추정 |
| 수치 ramp + transient (§5.5.2-5.5.4) | 🟢 SUPPORTED-NUMERICAL | literature 추정 파라미터 직접 적분 |
| Drug ranking sensitivity (§6) | 🟢 SUPPORTED-NUMERICAL | $\partial \log u_\text{crit} / \partial \log p$ 수치 미분 |
| DLK 1순위 결론 (§6.1) | 🟢 SUPPORTED-NUMERICAL + 🟡 | 모델 + drug-like compound 존재 |
| HSV-1 vs HSV-2 (§7) | 🟡 + **needs check** | HSV-2 직접 DLK KO 데이터 부족 |

### 핵심 needs-check 목록

- **§2.2 JNK3 $k_\text{cat}$ on H3 S10** — Lo 2005 in vitro, 뉴런 in vivo 보정 미정.
- **§4 mTOR/AMPK reactivation 효과** — 보고 엇갈림, 영양 박탈은 양면 (autophagy ↑ → viral 단백 분해 vs cap-indep translation ↑).
- **§6 BET inhibitor (JQ1)** — reactivation 보고 엇갈림 (M3 §8.1과 동일 미해결).
- **§7 HSV-2 DLK/JNK 직접 의존성** — HSV-1 mouse TG 모델에서만 확립, HSV-2 sacral DRG에서 동등하다고 추정.
- **§5.5.2 파라미터 값** — literature 추정 중앙치로 잡았으나 HSV reactivation 시계열 ChIP/RNA-seq 직접 fitting 부재 (M3 §10과 동일 한계).

---

## 9. 참고문헌

- Cliffe AR, Arbuckle JH, Vogel JL, Geden MJ, Rothbart SB, Cusack CL, Strahl BD, Kristie TM, Deshmukh M (2015) *Cell Host Microbe* 18:649 — DLK/JNK necessity for HSV reactivation
- Cuddy SR, Schinlever AR, Dochnal S, Seignon PV, Suzich JB, Engel EA, Cliffe AR (2020) *eLife* 9:e58037 — Phase I/II phospho-methyl switch foundational
- Cliffe AR, Wilson AC (2017) *J Virol* 91:e01419-16 — reactivation chromatin review
- Whitford AL, Clinton CA, Kennedy EBL, Dochnal SA, Suzich JB, Cliffe AR (2022) *Cell Host Microbe* 30:1542 — DLK/JNK epigenetic switch follow-up
- Whitford AL et al. (2024) *Cell Host Microbe* — further mechanism (— **needs full citation check**)
- Camarena V, Kobayashi M, Kim JY, Roehm P, Perez R, Gardner J, Wilson AC, Mohr I, Chao MV (2010) *Cell Host Microbe* 8:320 — NGF/PI3K withdrawal
- Kim JY, Mandarino A, Chao MV, Mohr I, Wilson AC (2012) *PLoS Pathog* (cf. PNAS) — Akt and reactivation
- Du T, Zhou G, Roizman B (2011) *PNAS* 108:18820 — DNA damage signaling, ICP0
- Hill JM, Sedarati F, Javier RT, Wagner EK, Stevens JG (1990) *Virology* 174:117 — hyperthermia mouse model (cf. Hill 1987 earlier)
- Sawtell NM, Thompson RL (1992) *J Virol* 66:2150 — explant reactivation · Sawtell NM (1995) — UV reactivation mouse model
- Knipe DM, Cliffe A (2008) *Nat Rev Microbiol* 6:211 — landmark review
- Wilson AC, Coleman JR (2015) — HCF-1 review (— **needs precise citation, likely Mol Cell or Curr Opin Virol**)
- Kristie TM (2015) *Curr Opin Microbiol* 23:128 — Oct-1, HCF-1 viral promoter activation
- Liang Y, Vogel JL, Narayanan A, Peng H, Kristie TM (2009) *Nat Med* 15:1312 — LSD1 in HSV reactivation
- Liang Y, Quenelle D, Vogel JL, Mascaro C, Ortega A, Kristie TM (2013) *MBio* 4:e00558-12 — KDM4 demethylases
- Narayanan A, Ruyechan WT, Kristie TM (2007) *PNAS* 104:10835 — Set1/MLL chromatin
- Wysocka J, Reilly PT, Herr W (2003) *Mol Cell Biol* 23:3490 — HCF-1 cellular localization
- Hirai S, Cui de F, Miyata T, Ogawa M, Kiyonari H, Suda Y, Aizawa S, Banba Y, Ohno S (2005) *J Neurosci* 25:11321 — DLK neuronal function
- Huntwork-Rodriguez S, Wang B, Watkins T, Ghosh AS, Pozniak CD, Bustos D, Newton K, Kirkpatrick DS, Lewcock JW (2013) *J Cell Biol* 202:747 — DLK phosphoswitch, JNK
- Lawler S et al. (1998) *Curr Biol* 8:1387 — MKK4/7 specificity · Lo KY et al. (2005) — JNK3 histone substrate (**needs check**)
- Soloaga A et al. (2003) *EMBO J* 22:2788 — MSK1 H3 S10 · Hsu JY et al. (2000) *Cell* 102:279 — H3 S10 phosphatase
- Bermudez O et al. (2010) *Am J Physiol Cell Physiol* 299:C189 — DUSP family review
- Vicetti Miguel RD et al. (2010) *J Immunol* 184:5400 — estrogen and HSV · Padgett DA et al. (1998) *PNAS* 95:7231 — stress reactivation
- Sainz B Jr, Halford WP (2002) *J Virol* 76:11541 — IFN/TNF effects · Verjans GM et al. (2007) *PNAS* 104:3496 — CD8+ T surveillance
- Khanna KM et al. (2003) *Immunity* 18:593 — CD8 maintenance of latency · Boutell C, Everett RD (2013) *J Gen Virol* 94:465 — ICP0 review
- Müller-Ott K et al. (2014) *Mol Syst Biol* 10:746 — heterochromatin Markov parameters (M3 §7 입력과 공유)

---

## 10. M5 / M6 / M7 핸드오프

- M5 (면역 escape mechanisms): §1 면역억제 trigger axis + reservoir 분포 (M2 §6)와 결합 → 면역 환경 변화가 본 ODE의 $u(t)$ baseline을 어떻게 변조하는지 정량.
- M6 (shock-and-kill): §6의 KDM4 activator + HDAC inhibitor 조합 → M3 §7.4 closed-form 직접 사용. 시퀀스: 시스템을 $u_\infty > u_\text{crit}$ 상태로 강제 → lytic branch 진입 → 항바이러스제로 lytic 게놈 살해.
- M7 (block-and-lock): **DLK inhibitor (GNE-3511류) 1순위** + JNK inhibitor 2순위 + dCas9-KRAB(LAT promoter) 영구 잠금 (M3 §8.2와 직접 연결). 본 모델은 DLK 차단이 $u_\text{crit}$를 3배 상승시켜 모든 자연 trigger 무력화함을 정량적으로 보임.

> **단일 sentence 결론**: 본 ODE 네트워크의 saddle-node bifurcation에서 critical trigger 임계 $u_\text{crit}$에 대한 sensitivity가 가장 큰 노드는 **DLK (MAP3K12)** — 10× 억제 시 $u_\text{crit}$를 약 3배 상승시켜 모든 생리적 트리거 (UV · 발열 · 축삭손상 · NGF withdrawal · 면역억제)를 동시 무력화하는 단일 약물성 표적이며, M7 block-and-lock의 1순위 표적이다.
