# TTR M1 — 표적 잉크 클래스 inventory (first-principles)

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = 화학 문헌 + 결합에너지/redox 표 + FDA/ECHA 공개 데이터 → 🟡 SUPPORTED-BY-CITATION (DFT/MD recompute 는 M5 마일스톤).
> 본 문서는 **분자 구조 inventory + cleavable-bond 후보 매트릭스** — MoA(M2) / 활성성분(M3) / MD-QM(M5) 의 입력.

scope:
- in-scope: 분자 구조 · 입자 크기 · 표면 화학 · 결합 vulnerability · 규제 status
- out-of-scope: 합성 루트(M7) · MD/QM 결과(M5) · ex-vivo 데이터(M8-9) · 활성성분 선택(M3)

---

## 0. 잉크 = 색소 입자 + 캐리어 — 진피 잔류는 색소 입자 자체

```
타투 잉크 (튜브 → bottle)
────────────────────────────────────────────────────────────────
┌─────────────────────────────────────────────────────────────┐
│  CARRIER (액상, 시술 후 며칠 안에 lymph/혈류로 빠짐)         │
│   글리세린 · 프로필렌글리콜 · 에탄올 · 위치하젤 · 정제수    │
│                                                             │
│   ┌───────────────┐    ┌──────────┐    ┌──────────────┐    │
│   │ 색소 입자     │    │ 색소     │    │ 색소         │    │
│   │ (10 nm-10 μm) │    │ 응집체   │    │ nanoparticle │    │
│   └───────────────┘    └──────────┘    └──────────────┘    │
│         ↑                                                   │
│   이것이 진피(dermis) macrophage 내부에 영구 잔류           │
│   → TTR 제거 표적                                           │
└─────────────────────────────────────────────────────────────┘
```

- 진피 침투 깊이: 약 1–2 mm (papillary + reticular dermis)
- 잔류 위치: dermal macrophage / fibroblast 내부 phagosome
- 입자가 너무 크면 macrophage 가 못 삼키고 EM (extracellular matrix) 에 박힘
- 색소 입자 표면(surface chemistry) 이 TTR 활성분자가 만나는 1차 인터페이스

→ **TTR 의 표적은 색소 분자/입자**. 캐리어는 자연 배출되므로 표적 아님.

---

## 1. Carbon-based black (탄소계 검정)

### 1.1 화학 inventory

| 잉크 명 | 주성분 | 화학식 / 구조 | 입자 크기 (1차) | 표면 작용기 |
|---|---|---|---|---|
| **Carbon Black (CI 77266 · PBk 7)** | 탄소 (sp² grpahitic + amorphous) | (C)_n · graphene-like 6원환 stack | 10–500 nm (1차) · 응집 50 nm–10 μm | -OH · -COOH · -C=O (oxidation 정도에 따라) |
| **India ink (먹)** | lamp black / bone char + shellac/gum | (C)_n + 단백질 잔재 (소 골탄) | 30–500 nm | -OH · -COOH · 단백질 -NH₂ 흔적 |
| **Soot (검댕 잉크)** | 불완전연소 탄소 + PAH 흔적 | (C)_n + 다환방향족 (벤조피렌 등 잔류 가능) | 20 nm–수 μm | PAH π · -OH · -COOH |
| **Graphitic (흑연계)** | 결정성 그래파이트 분쇄 | (C)_n 결정 6원환 ABAB stack | 100 nm–수 μm | 가장자리 -OH · 평면 비활성 |

### 1.2 first-principles 구조 — 왜 단단한가

탄소 검정의 안정성 = **sp² 6원환 공명** + **stack 간 π-π 스택**.

```
       C ═ C ─ C            BDE (sp² C-C aromatic) ≈ 518 kJ/mol
      ╱     ╲                BDE (sp² C=C aromatic) ≈ 614 kJ/mol
     C       C               BDE (sp³ C-C alkane)  ≈ 347 kJ/mol  ← 약함
      ╲     ╱
       C ═ C ─ C            평면 graphene-layer 안의 C-C 는
     │   │                  alkane C-C 보다 ~50% 더 강함.
     π-π stack (~3.35 Å)
```

- 방향족 6원환 안 C-C: BDE ≈ 500–600 kJ/mol → 산화 cleavage 어려움
- π-π stack 결합: ~5 kJ/mol/atom 의 약한 분산력 → **vdW 박리(exfoliation) 가능**하나 *분자* 가 아니라 *입자* 단위
- 표면 -COOH, -OH: 산화 정도에 따라 → **chelation/ROS attack 가능**한 유일한 핸들

### 1.3 cleavage vulnerability — first-principles

| 공격 화학 | 표적 결합 | 1차 원리 | 예상 결과 |
|---|---|---|---|
| Strong oxidation (•OH, H₂O₂/Fe²⁺ Fenton) | 표면 -COOH/-OH → 추가 산화 → CO₂ | E°(•OH/H₂O) = +2.80 V vs SHE > graphene 가장자리 산화 전위(~+1.6 V) | 표면 부식, 입자 크기 점진적 감소 (~수 nm/cycle) — 평면 graphene 코어는 거의 무손상 |
| Enzymatic (peroxidase + H₂O₂) | 표면 활성탄 가장자리 | MPO/LPO 가 활성 -COOH 영역에서 •OH 생성 (생리학적 친화) | 표면 한정, 코어 잔류 |
| Photo-cleavage (UV 532 nm Q-switched) | π-π stack + 표면 결함 | 광흡수(black body 흡수율 ~1.0) → 열팽창 → photoacoustic 파쇄 | **현 시술 표준** (Q-switched laser) — 파쇄만, 분자 변환 X · macrophage 가 재흡수 |
| Chelation | 해당없음 (금속이 없음) | — | N/A |

### 1.4 FDA / 규제 status

- US FDA: 타투 잉크를 **pre-market 승인하지 않음** (cosmetic 카테고리, 21 CFR 700.35 일반 안전 조항만)
- EU REACH/ECHA: 2022-01부터 Annex XVII 76 항목에 따라 다수 안료 제한
- Carbon black 자체: IARC Group 2B (possibly carcinogenic to humans) — 흡입 경로 한정, 진피 주입은 별도 평가 부재
- → 시판 검정 잉크의 lot 변동성 큼 (PAH 함량, 표면 산화도, 입자 크기 분포)

---

## 2. Organic color pigments (유기 안료)

### 2.1 화학 inventory (대표 클래스 5종)

| 클래스 | 대표 안료 (CI / PR/PY/PB/PV) | 발색단 구조 | 대표 색 | 분자량 (g/mol) |
|---|---|---|---|---|
| **Azo (모노/디스아조)** | PR 22 · PR 170 · PY 14 · PO 13 | Ar-**N=N**-Ar' | 빨강 · 노랑 · 주황 | 350–700 |
| **Phthalocyanine** | PB 15 (Cu-Pc) · PG 7 (Cu-Pc-Cl₁₅) | 16원 macrocycle + 중심 금속(Cu/Co/Fe) | 청록 · 녹색 | 576 (Cu-Pc) · ~1127 (Cu-Pc-Cl₁₅) |
| **Quinacridone** | PR 122 · PV 19 | 5환 fused N-H amide quinone | 마젠타 · 보라 | 312.32 |
| **Dioxazine** | PV 23 | 6환 dioxazine fused | 보라 | 588.5 |
| **Isoindolinone** | PY 110 · PY 139 | bis-isoindolinone (Cl-치환) | 노랑 · 주황 | 642 (PY 110) |

### 2.2 first-principles 구조 — 왜 색이 나는가 · 왜 살아남는가

각 클래스의 **발색단** (chromophore) 과 **취약 결합**:

#### 2.2.1 Azo — N=N 결합이 약점

```
       Ar ─ N ═ N ─ Ar'         BDE (N=N) ≈ 167 kJ/mol  ← 매우 약함!
            ↑
        cleavage site
        ↓ reductive cleavage
       Ar-NH₂  +  H₂N-Ar'        (방향족 아민 — 발색 X, 그러나 일부 carcinogenic)
```

- N=N 결합에너지: **167 kJ/mol** (참고: C-C aromatic 518 kJ/mol)
- Reductive cleavage 가능: Na₂S₂O₄ (dithionite) · zinc + acid · azoreductase 효소
- E°(azo/hydrazo) ≈ -0.3 V vs SHE (생리학적 가능 영역)
- → **모든 잉크 분자 중 가장 cleavable**. 그러나 산물(방향족 아민)이 일부 IARC 발암성 → off-target safety 고려 필수 (M6 마일스톤)

#### 2.2.2 Phthalocyanine — macrocycle 은 안 깨짐

```
          N═══C─────C═══N                중심 금속(Cu/Co/Fe) 가
         ╱    │     │    ╲              4개 N 에 chelate 결합
        N     │     │     N             ↓
        │   ┌─┴─┐ ┌─┴─┐   │             demetallation 가능 (강산성 / 강 chelator)
        Cu  │   │ │   │  ─               그러나 macrocycle C-N/C-C 는 robust
        │   └─┬─┘ └─┬─┘   │              BDE (aromatic C-N) ≈ 305 kJ/mol
        N     │     │     N              BDE (C-C in 6원환) ≈ 518 kJ/mol
         ╲    │     │    ╱              → 발색단 그대로면 색 그대로
          N═══C─────C═══N
```

- 중심 금속 chelation 안정도: log K (Cu-Pc) ≈ 30+ (extremely stable)
- macrocycle 자체: 16π electron 방향족 시스템 — 산화/환원에 매우 강함
- 가능 공격: (1) demetallation (HCl/HF 강산 + 강 chelator) → metal-free Pc (여전히 청록색) (2) macrocycle ring-cleavage = strong oxidant + UV (•OH + 광촉매)
- → **가장 어려운 잉크 클래스**. 시술자들이 청록/녹색 타투 제거가 어렵다고 보고하는 1차 화학 이유.

#### 2.2.3 Quinacridone — H-bond 격자가 약점

```
       O                   O                quinacridone 단량체 자체는
       ║                   ║                BDE 큰 결합으로 구성되었으나
   ─ C ─ N ─ ··· H ─ N ─ C ─               결정 안에서는 N-H···O=C
       │           │                        intermolecular H-bond 네트워크가
       Ar          Ar                       입자 안정성의 1차 요인
                                            ─────────────
   N-H···O=C H-bond:                        H-bond 파괴 → 단량체 분리 →
   ≈ 20–30 kJ/mol per H-bond                개별 분자는 산화/효소에 노출
```

- 단위 분자 BDE 자체는 강함 (모두 aromatic C-C/C-N)
- 그러나 **결정 응집성** 이 H-bond 네트워크에 의존 → DMSO/극성 비양자성 용매 + ROS 가 입자 분해
- → **표면적 증가 → 추가 cleavage** 의 양다리 전략 가능 (chelation 없이 oxidation 으로 가능)

#### 2.2.4 Dioxazine — ring-N 산화 vulnerable

- 6환 dioxazine fused 시스템에 두 개의 ring oxygen + 두 개의 ring nitrogen
- C-O-C ether linkage: BDE ≈ 360 kJ/mol — aromatic 보다 약함
- **광산화** (UV + O₂) 로 ring-opening 보고됨 (textile fade 메커니즘과 동일)
- → photo-cleavage 응답성 중간

#### 2.2.5 Isoindolinone — Cl 치환 양이 안정성 좌우

- 노랑/주황: bis-isoindolinone 골격 + 다수 Cl
- C-Cl BDE ≈ 339 kJ/mol — 광유리 가능 (photo-dehalogenation)
- 그러나 Cl 가 많을수록 redox 환경에서 안정성 ↑
- → photo + ROS combo 일 때 cleavable

### 2.3 cleavage vulnerability matrix

| 클래스 | Oxidation (•OH) | Reductive cleavage | Enzymatic | Chelation | Photo (UV-visible) |
|---|---|---|---|---|---|
| Azo | ◐ 표면만 | ●●● **결합 끊김** (N=N → 두 아민) | ●●● (azoreductase) | ✗ | ◐ (UV 가능, λ>300nm 필요) |
| Phthalocyanine | ◐ ring-very-slow | ✗ | ✗ | ●● (demetallation, but Pc 골격 색 유지) | ◐ (광촉매 환경 필요) |
| Quinacridone | ●● (H-bond 깨면 입자 → 단량체) | ◐ | ◐ (laccase 보고) | ✗ | ◐ |
| Dioxazine | ●● (ring O 광산화) | ◐ | ◐ | ✗ | ●● (UV-A) |
| Isoindolinone | ●● (Cl 광유리 후 ROS) | ✗ | ◐ | ✗ | ●● (광유리) |

표기: `●●●` = primary attack vector, `●●` = secondary, `◐` = partial / surface only, `✗` = not viable

### 2.4 FDA / 규제 status (유기 안료)

- US FDA: 위와 동일 (pre-market 승인 X)
- EU REACH Annex XVII #76 (2022-01-04 발효): **Blue 15:3 (Cu-Pc)** 및 **Green 7 (Cu-Pc-Cl₁₅)** 의 EU 시장 제한 (2023-01-04 그레이스피리어드 종료)
- 다수 azo: 4-아미노바이페닐 · 벤지딘 등 carcinogenic amine 으로 환원분해 가능한 azo는 EU 직물 규제와 동일하게 제한 대상
- 시판 잉크는 batch 마다 안료 비율/잔류 용매 다름 — **off-label tattoo ink** 가 시장 상당 부분

---

## 3. Metal oxide pigments (금속 산화물)

### 3.1 화학 inventory

| 잉크 | 화학식 | 결정 구조 | 색 | 1차 입자 크기 |
|---|---|---|---|---|
| **Titanium White** (PW 6) | TiO₂ | rutile (P4₂/mnm) · anatase (I4₁/amd) | 백색 | 50–500 nm |
| **Iron Red** (PR 101) | Fe₂O₃ (hematite) | corundum (R-3c) | 빨강·갈색 | 50 nm–1 μm |
| **Iron Yellow** (PY 42) | α-FeOOH (goethite) | orthorhombic (Pbnm) | 노랑 | 100 nm–수 μm (acicular) |
| **Iron Black** (PBk 11) | Fe₃O₄ (magnetite) | cubic spinel (Fd-3m) | 검정 (가끔 보조 흑색) | 50–500 nm |
| **Chromium Oxide Green** (PG 17) | Cr₂O₃ | corundum (R-3c) | 진녹 | 100 nm–수 μm |
| **(legacy) Cadmium Red/Yellow** | CdS/CdSe | wurtzite | 빨강·노랑 | 100 nm–μm |

### 3.2 first-principles 구조 — 왜 깨지지 않는가

금속 산화물의 안정성 = **이온 격자 에너지 + 산화상태 안정성**.

| 산화물 | 격자에너지 (kJ/mol) | M-O BDE (avg, kJ/mol) | 표준 환원전위 E°(M^n+/M) (V vs SHE) |
|---|---|---|---|
| TiO₂ (rutile) | 12,150 | 662 | E°(Ti⁴⁺/Ti³⁺) = +0.00 V (acidic) |
| Fe₂O₃ | 14,309 | 409 | E°(Fe³⁺/Fe²⁺) = +0.77 V |
| FeOOH | 8,612 | ~390 | E°(Fe³⁺/Fe²⁺) = +0.77 V |
| Fe₃O₄ | 18,853 | ~395 | E°(Fe³⁺/Fe²⁺) = +0.77 V |
| Cr₂O₃ | 15,276 | ~493 | E°(Cr³⁺/Cr⁰) = -0.74 V — **매우 산화 안정** |

- 격자에너지 ~10–20 MJ/mol 영역 → 단순 산-염기로 못 풂
- TiO₂: 화학적 비활성, **광촉매** (band gap 3.0–3.2 eV, UV 흡수) — 빛 + 물 = •OH 생성기 (역설적: 자기파괴가 아니라 *주변* 파괴)
- Fe₂O₃/Fe₃O₄/FeOOH: **chelation 가능** — Fe³⁺ 는 강한 chelator (deferoxamine · EDTA · DTPA · DFO) 와 log K = 25–30
- Cr₂O₃: 가장 강건. Cr³⁺ chelation 도 어려움. **광·산·환원 모두 저항**.

### 3.3 cleavage vulnerability matrix

| 산화물 | Oxidation (•OH) | Reductive dissolution | Chelation | Photo |
|---|---|---|---|---|
| TiO₂ | ✗ (이미 +4 max) | ◐ (Ti⁴⁺→Ti³⁺ very slow at pH 7) | ◐ (catechol-based 가능) | **자기촉매** — UV 받으면 •OH 생성기 |
| Fe₂O₃ | ✗ | ●● (Fe³⁺→Fe²⁺ → soluble) | ●●● (DFO / EDTA / siderophore) |◐ |
| FeOOH | ✗ | ●● (위와 동일) | ●●● (가장 chelation 친화적 — 표면 -OH) | ◐ |
| Fe₃O₄ | ◐ (Fe²⁺ component 산화 가능) | ●● | ●● | ◐ |
| Cr₂O₃ | ✗ | ✗ (Cr³⁺ very stable) | ◐ | ✗ |
| (Cd 류) | ✗ | ◐ | ●● (강 chelator + acid) — **toxic 부산물 주의** | ◐ |

### 3.4 FDA / 규제 status

- TiO₂: 화장품으로 광범위 승인 (sunscreen, 안료) · 단 **흡입 등급** EU CMR Cat 2 (2021)
- Fe 산화물: 화장품·식품 안전 안료 — 안전
- Cr₂O₃: PG 17 — REACH Annex XVII #76 으로 타투 잉크 사용 EU 금지 (2022)
- Cd 류: 사실상 모든 관할권에서 타투 사용 금지 (legacy)

---

## 4. Cross-class — 결합 vulnerability 통합 매트릭스

| 결합 / 표적 | 대표 클래스 | BDE / log K / E° | 1차 공격 화학 | TTR 활성성분 후보 (M3 입력) |
|---|---|---|---|---|
| **N=N (azo)** | Organic azo (PR 22, PY 14 …) | BDE 167 kJ/mol · E°(azo/hydrazo) ≈ -0.3 V | Reductive cleavage (효소 또는 화학) | azoreductase · dithionite analog · ascorbate-mediated reduction |
| **Fe³⁺ ion lattice** | Fe₂O₃ · FeOOH · Fe₃O₄ | log K(Fe³⁺-DFO) ≈ 30 · E°(Fe³⁺/Fe²⁺) = +0.77 V | Chelation + reductive dissolution | DFO · DTPA · siderophore mimetic · ascorbate (Fe³⁺→Fe²⁺) |
| **H-bond 격자 (QA crystal)** | Quinacridone (PR 122, PV 19) | ~25 kJ/mol per H-bond × n | 극성 비양자성 용매 + ROS | DMSO carrier + Fenton-class ROS |
| **표면 -COOH/-OH (carbon)** | Carbon black · India ink | aromatic C-edge ~+1.6 V | •OH · Fenton-class | Fenton (Fe²⁺ + H₂O₂) · peroxidase 효소 |
| **Cu²⁺ chelation (Pc)** | Cu-Phthalocyanine (PB 15, PG 7) | log K(Cu-Pc) ~30 | demetallation 어려움 — 광촉매가 더 현실적 | TiO₂ NP + UV (역설적) · porphyrin-based PDT |
| **C-Cl (Cl 치환 안료)** | Isoindolinone · Cu-Pc-Cl₁₅ | BDE 339 kJ/mol | photo-dehalogenation + ROS | UV-A + sensitizer |
| **ring O / ring N** | Dioxazine · isoindolinone | C-O ether ~360 kJ/mol | UV + O₂ ring opening | sensitizer-mediated UV |
| **방향족 6원환 (graphene core)** | 모든 carbon · 모든 organic aromatic core | C-C aromatic 518 · C=C 614 kJ/mol | first-principles ✗ 화학 단독 불가능 | (M3 out — 표면 처리 + 입자 분해로 우회) |

→ **녹색 행 = TTR 의 high-yield 표적**. 빨강 행 = 우회 전략 필요 (carrier 보조 또는 macrophage 재활성화로 입자 재흡수 후 분해).

---

## 5. 입자 크기 분포 · 표면 화학 — TTR 가 마주칠 실제 형태

```
잉크 입자 size 분포 (전형적 tattoo, 진피 잔류 후)
─────────────────────────────────────────────────────────
log size (nm)    10      100     1000    10000
                  │       │       │       │
nanoparticle ─────█████──────                   ← lymph node migration 가능
                                                   (~10-200 nm)
                       ──████████──             ← macrophage phagocytosis sweet spot
                                                   (~200-2000 nm)
                                ──██████        ← extracellular ECM 잔류
                                                   (>2 μm)
```

- macrophage phagocytosis 범위: ~200 nm – 5 μm — TTR 활성성분이 macrophage 내부 phagolysosome 에 도달해야 함 (M4 전달 마일스톤)
- 나노 입자 (<100 nm): 림프 노드 이동 → 전신 분포 → 안전성 평가 다른 축
- 1 μm 이상 ECM 잔류: macrophage 가 못 삼킨 입자 → ECM 손상 없이 분해해야 함 (M6 안전성)

표면 화학 (모든 클래스 공통):
- **carrier 단백질 코로나** 형성 (시술 직후): albumin, complement, IgG → TTR 활성분자가 만나는 1차 표면이 단백질일 수 있음
- 산화 정도 (carbon 특히), 결정면 (oxide), 잔류 합성용매 (organic) — lot variability 의 주요 축

---

## 6. 정직한 unknowns / scope caveats

1. **Lot variability**: 같은 CI 번호 (e.g. PR 122) 잉크라도 제조사 / 배치 별 입자 크기·표면 산화도 ±30% 변동 → TTR 효과 lot 별 다를 수 있음
2. **Off-label tattoo inks**: 시장의 큰 분획이 산업용 안료 (textile/automotive) 의 재포장 — 잉크 라벨이 실제 화학 조성을 보장하지 않음
3. **혼합 잉크**: 검정 잉크는 carbon + 소량 Cu-Pc (청색 보강) 가 흔함 → 단일 화학 가정 무효
4. **FDA pre-market gap**: 미국·한국 모두 타투 잉크는 pre-market 승인 없음 → "잉크 inventory" 가 실제 시장과 100% 일치한다고 보장 불가
5. **연구 데이터 부재**: 진피 *내부* 잉크 입자의 표면 화학을 *생체* 에서 직접 측정한 데이터가 적음 (대부분 commercial-stock 잉크 측정) — 시술 후 단백질 코로나 / 산화 상태 변화는 가정
6. **본 인벤토리의 BDE/E° 값**: 모두 **분자/이온 단독** 표준 조건 값. 결정 격자 안 / phagolysosome 산성 (pH 4-5) 환경에서는 effective 값이 다를 수 있음 — M5 (MD/QM) 에서 보정 필요
7. **Cleavage 산물 안전성**: azo cleavage 의 방향족 아민, Cr₂O₃ 의 Cr 잔류 등은 cleavage 가 끝이 아님 — M6 (off-target safety) 에서 별도 평가 필수
8. **Cu-Pc / Cr₂O₃ 의 wall**: first-principles 로 "거의 깨지지 않는" 입자가 실재 — TTR 한 튜브로 90% 제거 goal 에 대해 정직한 한계. M2 에서 우회 전략 (macrophage 재활성화 / 광촉매 보조) 필요.

---

## 7. 다음 마일스톤(M2) handoff

M2 (MoA short-list) 가 받을 입력:

- §4 의 **8개 표적 결합/이온 lattice** 카테고리
- §1.3 / §2.3 / §3.3 의 cleavage matrix → 화학경로 4종 (oxidation · reductive cleavage / enzymatic · chelation · photo) 별 hit count
- §5 의 입자 크기 → 전달 마일스톤 (M4) 디자인 제약
- §6 의 unknown — 활성성분 후보 평가 시 robustness 가 lot variability 견디는지 확인

TTR 의 한 튜브 90% 제거 goal 에 대해 **first-principles 추산**:
- Azo + Fe oxide + Quinacridone (∑ ≈ 시장 60-70%): 화학적 cleavable → 활성성분 design 가능
- Carbon black (시장 ~20-30%): 표면 산화 + macrophage 재활성화 hybrid 필요
- Cu-Pc + Cr₂O₃ + 미상 (시장 ~10-15%): wall — photo 보조 또는 staged-removal 전략

→ 본 inventory 가 M2 MoA 후보 short-list 의 정직한 출발점.
