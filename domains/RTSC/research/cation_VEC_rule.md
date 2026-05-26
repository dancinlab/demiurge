# RTSC · X₂MH₆ cation-chemistry 제1원리 규칙 + 확장 매트릭스 + DFT deck readiness

> 🔬 **목적**: `ternary_ambient_candidates.md`가 발굴한 ambient-pressure 동역학-안정 후보
> **Mg₂IrH₆ (예측 160K)** · **Li₂CuH₆ (예측 86K)** — 둘 다 X₂MH₆ octahedral 패밀리.
> 이 패밀리의 "안정성 + Tc"를 지배하는 cation 화학 규칙을 **제1원리로 정량화**하고,
> 규칙으로 다른 X₂MH₆ 조합을 enumerate하여 ambient-stable·high-Tc 후보를 확장한다.
> 동시에 두 우선 후보의 **QE DFT deck을 준비**(실행 X — ubu-1은 h3po 점유 중)하여
> 다음 /cycle 라운드가 즉시 dispatch할 수 있게 stage한다.

---

## ⚠️ HONESTY 프로토콜 (g63 · d6)

| 라벨 | 의미 |
|------|------|
| 🟢 **MEASURED** | DAC 실험에서 실측된 Tc |
| 🟡 **PREDICTED** | DFT/Eliashberg/규칙으로 **계산·예측만** — `NOT measured` |
| 🔢 **RULE-PREDICTED** | 본 문서의 **VEC 규칙으로 enumerate한 후보** — DFT조차 안 돈, 규칙 기반 순위만. 실측·실DFT 둘 다 아님 |

> 본 문서 §3의 확장 매트릭스 후보는 전부 🔢 **RULE-PREDICTED**다.
> Mg₂IrH₆·Li₂CuH₆ 두 개만 외부 DFT 예측(🟡)이 존재하며, 나머지는 본 규칙의 산물이다.
> overclaim 금지 — "VEC가 맞으면 초전도체"가 아니라 "VEC는 **필요조건**(충분조건 아님)"이다.

---

## 1. X₂MH₆ 구조·전자 모델 (Fm-3m / K₂PtCl₆ prototype)

```
   Fm-3m (No.225, K2PtCl6 안티플루오라이트-유도형)        VEC = 2·v(X) + v(M) + 6·v(H)
   ┌─────────────────────────────┐                       v(H)=1  →  VEC = 2·v(X) + v(M) + 6
   │   X        X        X        │   M (전이금속) : 4a (0,0,0)
   │      ╲    │   ╱            │   X (alkali/AE): 8c (¼,¼,¼)
   │       [ M—H6 ]  팔면체        │   H            : 24e (x,0,0), x≈0.24
   │      ╱    │   ╲            │
   │   X        X        X        │   1 primitive cell = 1 M + 2 X + 6 H = 9 atoms
   └─────────────────────────────┘   (※ 이전 문서의 "7-atom"은 오기; 실제 9-atom — live dyn1 확인)
```

**MH₆ 팔면체 분자궤도 (octahedral ligand-field)**:
- H의 1s 6개 → 대칭화 결합조합(SALC): a₁g + eg + t₁u (6개 σ 궤도)
- M의 d(t₂g + eg) + s(a₁g) + p(t₁u)와 혼성 → 결합/비결합/**반결합(σ\*)** manifold
- 핵심: H₆-cage가 만드는 **σ\* 반결합 밴드**가 E_F 근처에 온다. 이 밴드의 **부분 충전**이 RTSC의 엔진.

---

## 2. PART A — 제1원리 cation 규칙 (queue #1)

### 2.1 규칙 ① — VEC 정수식 (닫힌 형태)

> **VEC = 2·v(X) + v(M) + 6**   (v(H)=1, H 6개 → +6 고정)

여기서 v(X)·v(M)은 족-원자가(group valence) 전자수.

| 후보 | v(X) | v(M) | VEC = 2·v(X)+v(M)+6 | n_σ\* = VEC−18 | 판정 |
|------|------|------|---------------------|----------------|------|
| **Mg₂IrH₆** | 2 (Mg) | 9 (Ir) | **19** | **1** | ✅ sweet spot |
| **Li₂CuH₆** | 1 (Li) | 11 (Cu) | **19** | **1** | ✅ sweet spot |
| Mg₂PtH₆ | 2 | 10 (Pt) | **20** | 2 | ✅ sweet spot |
| Na₂ZnH₆ | 1 (Na) | 12 (Zn) | **20** | 2 | ✅ sweet spot |
| Al₂MnH₆ | 3 (Al) | 7 (Mn) | **19** | 1 | ✅ sweet spot |

두 已知 후보(Mg₂IrH₆·Li₂CuH₆) 모두 VEC=19로 정확히 sweet spot에 떨어진다 → 규칙 자가 정합.

### 2.2 규칙 ② — WHY VEC 19-20? (σ\* 밴드 필링)

닫힌-형태 밴드충전 모델:

> **n_σ\* = VEC − 18**   (18e = 닫힌껍질: t₂g⁶ + eg⁴(결합) + a₁g² + 비결합 채움 = "octahedral 18-electron rule")

```
 VEC   n_σ*   상태
 17     -1    σ* 완전 빔 + 결합밴드도 미충전 → low N(E_F), 금속성 약함/불안정
 18      0    σ* 완전 빔 (18-electron 닫힌껍질) → band-insulator/반금속, N(E_F)↓ → Tc≈0
 19      1    ★ σ* 부분충전(¼) → E_F가 σ* DOS 피크 위 → N(E_F)↑, strong e-ph
 20      2    ★ σ* 부분충전(½) → 여전히 높은 N(E_F), 최적 λ
 21      3    σ* 과충전 → 반결합 점유 ↑ → M–H 결합 약화 → soft mode → 동역학 불안정
 22      4    σ* 심한 과충전 → 격자 붕괴/decompose
```

물리: σ\* 밴드는 **H–H/H–M 반결합**이라 가파른(steep) DOS를 갖는다. E_F를 이 밴드 **가장자리~중턱**에 놓으면
(=VEC 19-20) ⓐ N(E_F) 극대 → λ↑ ⓑ H가 끌고 다니는 고-ω 광학포논과 강결합 → ω_log↑.
Allen-Dynes의 Tc∝ω_log·exp(−1/λ) 양쪽이 동시에 산다. **18e 닫힘=Tc죽음, 21e 과충전=격자죽음**,
그 사이 **19-20 창**이 "전자 충분 × 격자 안정"의 교집합.

### 2.3 규칙 ③ — WHY Mg→Ca/Sr가 Tc를 죽이는가 (VEC 불변인데도)

핵심 통찰: **Ca₂IrH₆·Sr₂IrH₆도 VEC=19로 동일**하다(2·2+9+6=19). 그런데 Tc≈0.
→ **VEC만으로는 설명 불가**. cation의 **이온반경 + 전기음성도**가 2차축이다.

| cation X | 이온반경 r(X²⁺/⁺) Å | Pauling χ | 효과 |
|----------|---------------------|-----------|------|
| Li⁺ | 0.76 | 0.98 | 작음 → 격자 압축 → H 포논 단단함(stiff) |
| Mg²⁺ | 0.72 | 1.31 | ★ 작음+적당한 χ → MH₆ cage에 **화학적 압력** 공급(CaH₆류 "chemical precompression") |
| Ca²⁺ | 1.00 | 1.00 | 큼 → 격자 팽창 → H–H 거리↑ → σ\* 밴드폭↓·ω 연화 |
| Sr²⁺ | 1.18 | 0.95 | 더 큼 → 더 심한 팽창 → soft mode·DOS 분산 → Tc붕괴 |

**메커니즘 (3중)**:
1. **격자 팽창**: r(Ca/Sr) ≫ r(Mg) → 셀 a 증가 → MH₆ 팔면체가 풀리며 H–M 거리↑ → σ\* 밴드폭↓ → N(E_F) 분산·저하.
2. **포논 연화**: a↑ → H 신축 포논 ω↓ → ω_log↓ → Allen-Dynes Tc 직접 하락. (極端엔 soft mode → 동역학 불안정.)
3. **cation 상태 침입**: Ca/Sr의 비어있는 d-state가 낮게 내려와 E_F 근처 σ\* DOS에 섞임 → "수소-주도 결합"을 희석.

→ **설계 규칙**: VEC 19-20은 **필요**, 추가로 r(X) 작음(Mg·Li·Al 선호, Ca·Sr·K 회피) + 적당~높은 χ가 **충분조건 보강**.
"작고 전기음성도 있는 cation이 H₆ cage를 압축하면서 σ\* 밴드에 정확히 1-2 전자를 도핑" — 이것이 X₂MH₆ RTSC의 레시피.

### 2.4 닫힌-형태 검증 (hexa verify · g5 verbatim)

**(a) Allen-Dynes Tc 닫힌형태 재계산** — DFT가 산출할 (λ, ω_log)→Tc 경로가 hexa-native로 닫힘을 입증
(레퍼런스 파라미터: CaH₆ 8q 캠페인의 λ=1.135, ω_log=1254.2K, μ\*=0.10):

```
$ hexa verify --expr allen_dynes_tc 1.135 1254.2 0.10 104.59716390644087
verify --expr allen_dynes_tc(1.135,1254.2,0.1)=104.597
  calc   = 104.597  ≈ expected 104.597  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

→ 🟢 **SUPPORTED-NUMERICAL**. DFT가 (λ, ω_log)만 내놓으면 Tc는 atlas 닫힌형태로 즉시 검증된다.
즉 X₂MH₆ DFT의 출력→Tc 변환 단계는 이미 검증-닫힘 상태. (남은 미지수는 DFT가 줄 λ·ω_log 자체.)

**(b) VEC 규칙 + 격자-팽창 죽음 메커니즘** — 정수 산술(VEC=2v(X)+v(M)+6)은 atlas 전용 fn 부재로
닫힌형태 verify 경로 없음 → §2.1 표로 산술 자가검산 완료. 물리 메커니즘은 정직-펜스:

```
$ hexa verify --fence "X2MH6 octahedral hydride Tc peaks at VEC 19-20 because n_sigma*=VEC-18 electrons partially fill the H6-derived sigma* antibonding manifold, maximizing N(EF); Mg->Ca/Sr substitution preserves VEC=19 but expands the lattice (larger ionic radius), softening H phonons and intruding cation d-states, killing Tc"
verify --fence
  claim  = X2MH6 octahedral hydride Tc peaks at VEC 19-20 because n_sigma*=VEC-18 electrons partially fill the H6-derived sigma* antibonding manifold, maximizing N(EF); Mg->Ca/Sr substitution preserves VEC=19 but expands the lattice (larger ionic radius), softening H phonons and intruding cation d-states, killing Tc
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

→ ⚪ **SPECULATION-FENCED** (정직). 밴드충전 물리 모델은 **DFT N(E_F)·포논 계산으로만 닫힌다**
(다음 라운드 deck이 정확히 그 검증을 수행). 규칙은 "후보 선별 휴리스틱"이지 증명된 atom이 아님.

---

## 3. PART A — 후보 확장 매트릭스 (queue #1, step 2)

X ∈ {Li, Na, Mg, Al, Ca, Sr, K}, M ∈ {Mn, Fe, Co, Rh, Ir, Ni, Pd, Pt, Cu, Ag, Au, Zn}.
**랭킹 기준**: VEC 19-20(필수) → r(X) 작음(Mg·Li·Al ≫ Ca·Sr·K) → 9족(Co/Rh/Ir, λ강) 또는 11족(Cu/Ag/Au) M 선호.
모두 🔢 **RULE-PREDICTED · DFT 미실행 · NOT measured**.

### Tier-1 — VEC 19-20 ∩ 작은 cation (ambient high-Tc 1순위 후보)

| 후보 | VEC | n_σ\* | r(X) | 비고 (왜 유망) | 상태 |
|------|-----|-------|------|----------------|------|
| **Mg₂IrH₆** | 19 | 1 | Mg 작음 | ★ 已 외부예측 160K · Mg₂IrH₅ 실합성 플랫폼 | 🟡 PRED (DFT deck 준비완료, §5) |
| **Li₂CuH₆** | 19 | 1 | Li 최소 | ★ 已 외부예측 86K · Li 최소반경→stiff H | 🟡 PRED (DFT deck 준비완료, §5) |
| **Mg₂RhH₆** | 19 | 1 | Mg 작음 | Ir의 4d 동족(Rh) — λ 약간↓이나 동역학 안정 양호 | 🔢 RULE-PRED |
| **Mg₂CoH₆** | 19 | 1 | Mg 작음 | Ir/Rh의 3d 동족(Co) — 3d라 ω↑ 가능, 자성 위험 점검필요 | 🔢 RULE-PRED |
| **Al₂MnH₆** | 19 | 1 | Al 작음 | Al³⁺ 강압축 + Mn — 已 외부 "promising 안정성" 언급 | 🔢 RULE-PRED |
| **Mg₂PtH₆** | 20 | 2 | Mg 작음 | 已 외부예측 78K · 5d Pt SOC 점검 | 🔢/🟡 |
| **Mg₂PdH₆** | 20 | 2 | Mg 작음 | 已 외부예측 63K | 🔢/🟡 |
| **Mg₂NiH₆** | 20 | 2 | Mg 작음 | 3d Ni — Mg₂NiH₄ 실존(분해상)이라 합성성↑, but Ni 자성 점검 | 🔢 RULE-PRED |
| **Al₂FeH₆** | 20 | 2 | Al 작음 | Al 강압축 + Fe(자성 위험) | 🔢 RULE-PRED |
| **Na₂ZnH₆** | 20 | 2 | Na 중간 | 已 외부예측 53K · conventional | 🔢/🟡 |
| **Na₂CuH₆** | 19 | 1 | Na 중간 | Li₂CuH₆의 Na 동족 — r(Na)>r(Li)라 Tc는 Li판 대비 ↓ 예상 | 🔢 RULE-PRED |
| **K₂CuH₆** | 19 | 1 | K 큼 | VEC 맞으나 r(K) 큼 → §2.3 격자팽창死 위험 → 우선순위 낮음 | 🔢 RULE-PRED (경고) |

### Tier-2 — VEC 18 (닫힌껍질 경계, Tc 낮음 예상 — 대조군)

| 후보 | VEC | n_σ\* | 판정 |
|------|-----|-------|------|
| Mg₂FeH₆ | 18 | 0 | 18e 닫힘 → Tc≈0 예상. **실존 합성된 complex hydride**(Mg₂FeH₆ 알려짐)이나 비초전도 — 규칙의 음성 대조군으로 가치 |
| Li₂PdH₆ / Li₂PtH₆ / Na₂PdH₆ / Na₂PtH₆ | 18 | 0 | 18e 닫힘 → 규칙상 Tc 낮음 |

### Tier-3 — VEC ≥ 21 (과충전, 동역학 불안정 예상 — 회피)

| 후보 | VEC | n_σ\* | 판정 |
|------|-----|-------|------|
| Al₂CoH₆ | 21 | 3 | σ\* 과충전 → soft mode 위험 |
| Ca₂CuH₆ | 21 | 3 | 과충전 + 큰 cation 이중페널티 → 회피 |
| Al₂NiH₆ | 22 | 4 | 심한 과충전 → 격자 붕괴 예상 |

### Tier-X — VEC=19지만 cation 큼 (규칙 ③ 사형선고 — 명시적 제외)

| 후보 | VEC | r(X) | 판정 |
|------|-----|------|------|
| **Ca₂IrH₆** | 19 | Ca 큼(1.00Å) | VEC 정상이나 §2.3 격자팽창 → Tc≈0 (Mg→Ca death 규칙의 직접 사례) |
| **Sr₂IrH₆** | 19 | Sr 더 큼(1.18Å) | 더 심한 팽창 → Tc붕괴. 규칙 ③ 검증용 음성 대조군 |

> **확장 결론**: ambient·high-Tc 신규 1순위는 **Mg₂RhH₆ · Mg₂CoH₆ · Al₂MnH₆** (VEC=19 ∩ 작은 cation ∩ 9/7족 강-λ M).
> 다음 배치 후보로 **Mg₂NiH₆ · Mg₂PtH₆** (VEC=20). Ca₂IrH₆/Sr₂IrH₆/K₂CuH₆/VEC≥21군은 규칙으로 **사전 배제** → DFT 예산 절약.

---

## 4. PART B — DFT deck 준비 (queue #3, prep ONLY — 실행 X)

### 4.1 구조 (literature Wyckoff · Fm-3m K₂PtCl₆ prototype)

| | Mg₂IrH₆ | Li₂CuH₆ |
|---|---------|---------|
| 공간군 | Fm-3m (225) | Fm-3m (225) |
| ibrav | 2 (FCC primitive) | 2 (FCC primitive) |
| nat / ntyp | 9 / 3 | 9 / 3 |
| celldm(1) | **12.283 Bohr (6.50 Å)** — live dyn1 검증값 | **11.34 Bohr (6.00 Å) 추정** → **vc-relax 필수**(미지) |
| M @ 4a | Ir (0,0,0) | Cu (0,0,0) |
| X @ 8c | Mg (¼,¼,¼)×2 | Li (¼,¼,¼)×2 |
| H @ 24e | x≈0.237 (live dyn 확인) | x≈0.24 (추정→relax) |
| VEC | 19 | 19 |

### 4.2 방법 (d14 PBE 순수 · NOT hybrid)

- **xc**: PBE pure (UPF가 pbe-rrkjus PSlibrary → xpbe96/cpbe96 등가). hybrid 금지(d14).
- **ecutwfc/ecutrho**: 80 / 800 Ry (H 함유 hydride 표준; CaH₆ 캠페인 정합).
- **k-grid**: 16×16×16 (SCF; small-cell 금속 정밀 N(E_F)).
- **smearing**: mp / degauss 0.02 (금속).
- **q-grid (ph.x)**: **4×4×4** (13 irred q — d7 small-cell 적정. live Mg₂IrH₆ dyn0 = 4×4×4 확인).
- **electron_phonon = 'simple'** · el_ph_sigma 0.005 · el_ph_nsigma 10 (RTSC 캠페인 표준; reference_qe_dft_pool_setup 정합).

### 4.3 ⚠️ Pseudopotential 커버리지 (d13 — 라이브러리 grep 완료, 가정 X)

ubu-1 `find /home/aiden -iname "*.UPF"` 실측 결과:

| 원소 | 필요 UPF | ubu-1 상태 |
|------|----------|-----------|
| Mg | `Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF` | ✅ **존재** (`/home/aiden/rtsc_mg2irh6/pseudo/`) |
| Ir | `Ir.pbe-n-rrkjus_psl.0.2.3.UPF` | ✅ **존재** (동 dir; PSL 0.2.3 — Ir만 구버전) |
| H | `H.pbe-rrkjus_psl.1.0.0.UPF` | ✅ **존재** (campaign 전역) |
| **Li** | `Li.pbe-s-rrkjus_psl.1.0.0.UPF` | ❌ **부재** — staging 필요 |
| **Cu** | `Cu.pbe-dn-rrkjus_psl.1.0.0.UPF` | ❌ **부재** — staging 필요 |

> **Mg₂IrH₆**: 3원소 pseudo 전부 ✅ → **즉시 실행 가능**.
> **Li₂CuH₆**: H만 있고 **Li·Cu 부재** → 다음 라운드에 PSlibrary 1.0.0 PBE rrkjus 세트에서
> 2개 UPF를 `/home/aiden/rtsc_li2cuh6/pseudo/`로 stage해야 함. 파일명은 campaign PSL 1.0.0 컨벤션
> (`<El>.pbe-<config>-rrkjus_psl.1.0.0.UPF`) — 다운로드 시 정확 config 코드(Li=s, Cu=dn) 확인할 것.
> (Li은 1s 코어만이라 `-s`, Cu는 3d 반코어 포함 `-dn`이 PSL 표준.)

### 4.4 staged deck 파일 (로컬 — `~/etc/rtsc-results/`)

```
~/etc/rtsc-results/mg2irh6/      ← Mg₂IrH₆ (즉시-실행-가능)
  scf.in        PBE SCF, ibrav=2, celldm 12.283, 9-atom, 16^3 k
  ph.in         ph.x electron_phonon='simple', 4^3 q
  run.sh        conda 'qe' + mpirun -np 6 → SCF→ph.x, JOB DONE 가드
~/etc/rtsc-results/li2cuh6/      ← Li₂CuH₆ (pseudo 2종 stage 후 실행)
  vcrelax.in    vc-relax (a 미지 → 먼저 격자 settle)
  scf.in        relax 후 celldm 갱신하고 SCF
  ph.in         ph.x electron_phonon='simple', 4^3 q
  run.sh        vc-relax→SCF→ph.x 체인, JOB DONE 가드
```

---

## 5. Readiness 상태 (다음 /cycle 라운드 dispatch용)

| 후보 | deck | pseudo | 실행 readiness | dispatch 절차 |
|------|------|--------|----------------|----------------|
| **Mg₂IrH₆** | ✅ scf/ph/run.sh stage완료 | ✅ Mg·Ir·H 전부 ubu-1 존재 | 🟢 **READY — 즉시 실행 가능** | ① ubu-1 한가해지면(h3po 종료) `pool on ubu-1`로 `~/etc/rtsc-results/mg2irh6/{scf.in,ph.in,run.sh}` → `/home/aiden/rtsc_mg2irh6/`에 copy ② `bash run.sh`. ※ 기존 partial dyn1/dyn2 존재 → `recover=.true.`로 이어감 |
| **Li₂CuH₆** | ✅ vcrelax/scf/ph/run.sh stage완료 | ⚠️ Li·Cu UPF **부재** | 🟡 **NEAR-READY — pseudo 2종 stage 필요** | ① PSlibrary 1.0.0 PBE에서 `Li.pbe-s-rrkjus`·`Cu.pbe-dn-rrkjus` UPF 받아 `/home/aiden/rtsc_li2cuh6/pseudo/`(+H) 배치 ② deck copy ③ `bash run.sh` (vc-relax부터) |

### 5.1 ⚠️ ubu-1 점유 상태 (실측)

- 실행 중: **`ph.x -in ph_h3po.in`** (binary-closure agent의 h3po job, `-np 6`, conda `qe` env). 6코어 점유.
- Mg₂IrH₆: 과거 partial run 흔적(`mg2irh6.dyn1/dyn2` + `.elph`, 05-25 01:04~07:23) 존재하나 **현재 정지** (dyn3 빈 파일, mg2irh6 프로세스 없음 — h3po가 코어 선점). `recover=.true.`로 재개 가능.
- **이번 라운드 실행 금지 준수** (task 지시 + d7 컴퓨트 충돌 회피). deck staging만 완료.

### 5.2 dispatch 후 검증 경로 (이미 닫힘)

DFT가 `(λ_BZ, ω_log)` 산출 → §2.4(a) `hexa verify --expr allen_dynes_tc <λ> <ω_log> <μ*> <Tc>` → 🟢 SUPPORTED-NUMERICAL.
즉 결과 파싱→Tc 검증 단계는 verify-닫힘. under-converged 값 보고 금지(g63) — broad sweep(0.015~0.030) 수렴 확인 후 보고.

---

## 6. 핵심 provenance

- §1·§2 구조/MO: K₂PtCl₆ Fm-3m 결정학 표준 · octahedral 18-electron rule (Tolman/Mingos).
- Mg₂IrH₆ 160K · VEC 19-20 규칙: arXiv:2310.07562 (Dolui/Pickard, PRL 132.166001) · arXiv:2604.04151 · S2542529326000805 (2026 X₂MH₆ 전자/포논 분리 분석).
- Li₂CuH₆ 86K · X₂MH₆ ambient 스크리닝: S2542529324000506 (ScienceDirect).
- Na₂ZnH₆ 53K: S0022369725001532 (JSSC 2025).
- 이온반경(Shannon) · Pauling 전기음성도: 표준 표.
- Allen-Dynes Tc 닫힌형태: atlas `allen_dynes_tc` (RTSC V2), 본 문서 §2.4(a) 🟢 재계산.
- DFT 파라미터 컨벤션: reference_qe_dft_pool_setup (conda QE 7.5, electron_phonon='simple', -np 6) · CaH₆/h3cl 캠페인 deck.

---

### 부록 — VEC 규칙 한 줄 요약

> **X₂MH₆ ambient RTSC = [VEC=2·v(X)+v(M)+6 ∈ {19,20}] ∩ [작은·전기음성 cation(Mg/Li/Al)] ∩ [강-λ M(9족 Co/Rh/Ir·11족 Cu)]**
> VEC는 σ\* 밴드에 1-2전자를 채워 N(E_F)를 살리고(필요조건), 작은 cation은 H₆ cage를 압축해 ω_log를 살린다(충분조건 보강).
> Ca/Sr/K로 가면 VEC가 같아도 격자가 팽창해 ω·N(E_F) 둘 다 죽는다.
