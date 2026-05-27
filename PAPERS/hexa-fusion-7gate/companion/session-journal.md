# Session journal — HEXA-FUSION 7-gate funnel

페이퍼 작성/검증 세션의 시간순 narrative. 실험 데이터(원 atom output · PR 메타)는 sibling JSON
파일 (`verify-ledger.json` · `pr-roll.json` · `adapter-defect-catalog.json`)에 있고, 이 파일은 사람이
연달아 읽는 narrative — 무엇을 바꿨고, 무엇을 검증했고, 무엇을 열어 둔 채로 다음 라운드로 넘겼는지의 흐름.

## 2026-05-25 — FUSION 도메인 탄생 → BLUE-MAX → 페이퍼

### 09:25 — F1/F2 keystone 등록 (PR #1012)

FUSION 도메인을 새로 열고, Bosch-Hale ⟨σv⟩(T) 반응도와 Lawson 삼중곱 / 0-D 게인 Q를 stdlib/fusion/ 아래
hexa-native로 stamp. F1(Bosch-Hale) 9개 atom + F2(Lawson) 3개 atom 모두 `hexa verify` 🟢
SUPPORTED-NUMERICAL, |Δ|=0 at ε=10⁻⁹. e18-scaled discriminating-ε view (`sigma_v_dt_e18`)도 같이 등록 —
native ⟨σv⟩ 값이 10⁻¹⁶ cm³/s 단위라 absolute-ε gate가 의미가 있으려면 magnitude 정렬이 필요했음.

**war story 1: 4π 정밀도 함정.** Bosch-Hale Eq.(12)에서 θ는 *분수의 분모*로 들어가야 하는데, 첫
포팅은 곱셈 형태로 잘못 옮겨 적어서 *모든* 온도에서 reactivity가 정확히 ≈4× 낮게 나왔다. 4×라는
숫자가 너무 깔끔해서 "어디서 4π를 한 번 더 빼먹은 거 아닌가"로 한 시간을 헤맸으나, 진실은 그냥
"published form은 division, multiplication 아니다"의 문자 그대로의 typo. 이 함정은
`adapter-defect-catalog`에 올리지는 않았다 — 본인의 typo일 뿐 stdlib 결함이 아니라서.

### 10:51 — F-funnel composite ranker (PR #1020)

(a)×(b)만 곱해서 top-K 디자인 포인트를 JSON으로 뽑는 ranker. ITER-class와 compact-HTS-class 5개
포인트를 enumerate해서 정렬. 일부러 (c)/(d)/(e)/(f)는 **합치지 않았다** — sim coverage tier가
달라서 하나의 숫자로 blending하면 gate-by-gate 진단이 흐려진다. 이 결정은 §F-funnel 본문에서
명시적으로 못 박아 둔다.

### 11:09 / 11:10 / 11:26 — F4/F3/F5 첫 스탬프 (#1027/#1032/#1042)

이상 MHD β-한계와 cylindrical q* (Wesson), Grad-Shafranov wrap(아직 install-gated), HTS REBCO TF-coil
magnet 게이트(closed-form 1/R baseline)를 차례대로 land. 이 시점에서 funnel은 6/7 gate가 "최소 한
번씩은 코드를 통과"한 상태였지만, (c)/(f)/(e)는 *진짜로* 외부 솔버가 돈 게 아니라 wrap layer가 통과만
한 상태. 정직한 "honest-skip"이고, "absorbed=false"가 유지된다.

### 11:44 — p-¹¹B aneutronic 분기 (PR #1054)

D-T-beyond 연료축. Tentori-Belloni 2023 (Nevins-Swain 2000 framework 보존) 계수를 verbatim으로
inline, 600-노드 midpoint Maxwellian quadrature를 hexa-native로 구현. 13개 atom 모두 🟢 |Δ|=0.
한 가지 정직성 표시: `pb11_reactivity_moment`는 **reactivity shape**로만 등록 — 문헌의 keV-vs-MeV
S-factor 단위 모호성이 절대값 cm³/s 변환을 막아서, 그 부분은 ⚠ scope caveat으로 명시.

### 12:16 — wrap-and-fix #1: FreeGS 수렴 (PR #1075)

여기서 처음으로 *외부 솔버를 free pool host에서 실제로 돌렸다*. 그 순간 wrap layer가 자동으로
integration test가 됐다. FreeGS 0.8.2 (numpy <2.0 pin)으로 처음 돌렸을 때 Picard가 "No O points
found"로 발산. 진단: 두 개 적층된 버그. (i) PR #1032의 hardcoded custom coil set이 기하학적으로
admissible equilibrium이 없는 상태. (ii) FreeGS의 early-Picard warning이 *stdout으로 찍혀서*
adapter의 JSON tail을 corrupt시키고 있었다.

**war story 2: cross-repo gh merge bug.** 이 fix를 처음 land하려 했을 때, demiurge 워크트리에서 hexa-lang
PR을 만들었더니 gh가 default repo를 demiurge로 잡고는 다른 워크트리의 main을 잠금. PR #1075 자체는
landed but the worktree-cleanup tail이 false-failed. memory에 적힌 "demiurge worktree PR landing"
패턴(gh pr view로 state 확인 후 manual cleanup)으로 복구.

### 12:31 — wrap-and-fix #2: OpenMC TBR (PR #1078)

FUSION 도메인 첫 적용된 wrap-and-fix가 진짜로 결함을 surface 시키는 패턴이라는 게 확인됐기 때문에
이번엔 일부러 expect-fail 모드로 OpenMC 어댑터를 돌려봤다. 결과: 어댑터가 transport-less
gate-classifier (OpenMC import + ENDF env 확인만 하고 `openmc.run`은 절대 부르지 않음). 자기-부트
strapped micromamba env 설치 → 5M-history 통과 → TBR = 1.3197 ± 0.0005, 그리고 transport block을
`.hexa` adapter에 embedded한 후속 run이 TBR = 1.3222 ± 0.0004. 작은 shift는 30-nuclide ENDF subset에서
Mn/V/Mo/Si trace를 drop한 것 — TBR-negligible로 문서화.

### 12:39 — solenoid_axis_bz closed-form anchor (PR #1084)

여기서 우리는 게이트 (e)의 향후 GetDP 브릿지를 위한 **load-bearing parity anchor**를 미리 등록했다.
Thick finite solenoid의 on-axis B_z(0)는 textbook integral로 (b+sqrt(b²+(h/2)²))/(a+sqrt(a²+(h/2)²))의
로그가 들어가는 식. Reference coil (NI=2×10⁶, a=0.50, b=0.70, h=1.20)에서 1.48265 T. 이게
브릿지 검증의 단단한 발판이 된다. atom: `solenoid_axis_bz(NI,a,b,h)`.

### 12:48 — HEXA-PORT P0.5: git-LFS infra (PR #1090)

자매 도메인 HEXA-PORT (자세한 건 별도 도메인 snapshot)의 P4b — ENDF/B-VIII 같은 ~GB 데이터-바운드
corpus를 위한 git-LFS 인프라를 미리 깔아둠. P4b 자체는 follow-up이고, 인프라만 land.

### 13:02 — wrap-and-fix #3: GetDP solenoid solve LANDED (PR #1095)

이번 세션의 가장 길고 험한 fix. GetDP의 axisymmetric A-φ FEM이 closed-form anchor와 1.4% 차이가
났고, 처음엔 `2π/VolAxiSqu` Jacobian / units 버그로 진단(이 진단을 5-6시간 추적함). **war story 3:
the FAR-FIELD diagnosis reversal.** 사실은 그게 아니었다. air-region 바깥 경계가 coil radius의
~5×밖에 안 돼서 flux가 누설되고 있었던 것. R_out/H_out을 ~10×로 밀어내자 잔차가 1.4% → <0.1%로
collapse. 같은 deck, 같은 Jacobian. 정직성: 이 false-positive 진단 자체를 `adapter-defect-catalog`에
명시적으로 적었다 — 다음 implementer를 같은 함정에서 구하려고.

최종: GetDP 3.5.0 (Linux pool) + 4.0.0 (Apple silicon) 두 플랫폼 cross-check, ~33k-node 메시에서
1.4817 T → anchor 대비 Δ = -0.064%. magnet_gate adapter는 이제 `field_path = "getdp"`로 flip되고,
ITER-class operating point에서 B_peak = 1.48168 T, HTS REBCO ceiling 20 T까지 마진 18.52 T @ 20 K.

### 13:18 — BLUE-MAX 8개 integer atom (PR #1102)

ANTIMATTER 도메인이 먼저 등록한 BLUE-MAX 패턴 (commons @D g69)을 FUSION에도 적용. 모든 libm-class
atom마다 0-arg integer atom을 짝지어 등록 — formula에 박힌 진짜 integer factor / exponent를
SUPPORTED-FORMAL로 attest. 가장 중요한 entry: `q_star_constant = 5` — 이건 `2π/(μ₀·10⁶) = 5`
exact identity를 formally encode한 것이고, 이걸 등록한 후에 Wesson cylindrical safety factor를
literal `q* = 2π a² B / (μ₀ R I_p)` 대신 π-free `q* = 5 a² B / (R I_p)`로 쓸 수 있게 된다. literal
form은 engine constant-folding에서 |Δ| ≈ 5.8×10⁻⁶ middle-magnitude precision loss를 겪었는데,
π-free form은 transcendental이 constant fold를 살아남지 못해서 모든 input에서 |Δ|=0.

8개 SUPPORTED-FORMAL atom + 8개 matched negative control (모두 FALSIFIED로 검증) → BLUE-MAX 12 libm
coverage 닫힘.

### 13:21 — HEXA-PORT 자매 도메인 탄생

위의 wrap-and-fix 3개가 모두 *parity oracle*을 만들었기 때문에, 그것들을 받아서 native solver를
hexa-lang으로 reimplement하는 자매 프로젝트 HEXA-PORT가 자연스럽게 도출됐다. P1 (FreeGS),
P2 (GetDP), P4 (OpenMC; P4a engine / P4b data corpus / P4c first-principles cross-sections)로
분해. 이 페이퍼는 HEXA-PORT 자체의 작업은 다루지 않지만, parity oracle이 그쪽으로 forwarded되는
사실은 §Wider Architectural Context에 명시.

### 13:42 — paper 첫 land

위 12개 hexa-lang PR + 3개 demiurge pointer PR을 다 합쳐 10-page LaTeX 페이퍼로 land. (PR #176 era)

### 23:20 — 페이퍼 v2 재생성 (이 entry)

sidecar/paper v0.8.0 (PR #148/149/151)이 9-section spine + §Full Pipeline ANTIMATTER-style 표 +
companion/ dir + xelatex + 더 풍부한 lint를 가져왔다. v1을 새 spine 위에 다시 깔아서 v2로 재생성.
cover.png는 그대로 보존 (user-validated), references.bib 18개 entry 모두 carry-over, §Full Pipeline에
10-stage D-T fuel 추적 표 추가 (⓵펠릿 주입 → ⓾점화 Q>1; ⓵⓶⓷⓼⓾는 wet-lab/out-of-scope, ⓸⓹⓺⓻⓽는
🟢/🔵 sim-PASS), §Wrap-and-fix에 adapter defect catalog 표 명시.

**war story 4: rate-limit-killed agent salvage.** 이 세션 전체에서 병렬 agent 캡을 2-3개로 유지하지
못한 라운드(4+ 동시 fan-out)에서 한 번 rate-limit-kill을 맞았다. memory `Parallel agent cap 2-3`에
이미 적혀 있는 함정. 죽은 agent의 작업은 git stash 없이 사라졌지만, atomic-commit 패턴 덕에 main에
absorbed된 작업은 손실 없음. 이후 라운드는 cap 2를 엄수.

## 열린 채로 남긴 것 (deferred)

- ENDF/B-VIII corpus의 ~475 MB git-LFS ingest (PR #1090 인프라만 land · 데이터는 follow-up)
- (g) JET D-T measured-oracle 자체는 *영구* wet-lab — closed-form sim으로 닫지 않는다 (정직성)
- p-¹¹B의 reactivity 절대값 cm³/s (S-factor unit 모호성 해결 시 후속 atom 등록 가능)
- HEXA-PORT P4a (native MC engine) — 별도 도메인의 follow-up이라 이 페이퍼 scope 밖
