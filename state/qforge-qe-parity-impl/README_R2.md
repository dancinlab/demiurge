# QFORGE=QE parity — Lane "qe-parity-impl" R2 — metallic Fermi-surface sampling

Lane R2 (perpetual·fire-on-arrival). R1(README.md)이 노출한 진짜 벽 — `qforge_run.hexa`
el-ph 샘플 스트림이 단일-Γ on-shell(`eps_k=eps_kq=eps_occ[nn]`, `e_fermi=HOMO`)이라 금속
Fermi-surface 교차 샘플이 없어 matched-σ서 λ 붕괴 — 을 named 레버 1개로 돌파 시도(d2·d6·d_novel_only).

## R2 구현 = metallic FS 샘플링 (NOVEL · 차폐 9-path와 별개 축)

세 조각을 데이터 흐름 순서로 박제(코드=english):

### ① 진짜 금속 Fermi level (HOMO → bisected E_F)
- `pw_frontend.hexa _qpw_emit_deck`: SCF가 이미 `nbands=nocc+4`(점유+전도)를 푼다. 그 전체
  스펙트럼을 deck에 stage하고, **`qforge_fermi_level(eps_bra, 2·nocc, σ, spin_deg=2)`**로
  Σ f(ε−E_F)=nelec를 만족하는 **진짜 bisected 금속 E_F**를 계산 — HOMO `eps_occ[nocc-1]` 폐기.
  (HOMO 고정이 R1 벽: 모든 δ를 단일 점유밴드에 묶음.)
- `QforgeDeck`에 `nbra: int` + `eps_bra: [float]` 필드 추가(d4 data). `_qpwd_deck_with_band`의
  HOMO 재유도(`eps_occ[nocc-1]`)도 bisected E_F 보존으로 교체.

### ② 전도밴드를 포함한 BRA manifold (FS straddle)
- `qforge_run.hexa`: davidson을 `nbra=max(deck.nbra,nocc)` 밴드로 풀어 점유 KET(ψ_n) +
  **전체 BRA(ψ_m, 전도밴드 포함)** 둘 다 unpack. (nbra≤nocc면 레거시 점유-only로 fallback.)

### ③ 실 (m,n) band-pair FS double-δ 샘플
- el-ph 샘플 스트림을 단일-Γ 대각(`g_nn`)에서 **전 (m,n) band-pair**로 교체:
  `qforge_elph_g2(h, bra, occ, ...)` → `g[m*nocc+n]=⟨ψ_m|ΔV|ψ_n⟩`(inter-band) 사용.
  샘플당 `eps_k=ε_m`(scattered-into ε_{k+q}) · `eps_kq=ε_n`(ket ε_k) deposit → tail의
  `δ(ε_m−E_F)·δ(ε_n−E_F)`가 **Fermi surface 위 band pair에서만** 발화(QE elphon.f90 구조).
- el-ph stage note에 FS-window(±5σ) Σ|g|² + pair count 진단 박제(self-improving 도구·매 런 노출).

검증: 세 selftest(qforge_run·pw_frontend·qforge_tc_p_sweep) 전부 **PASS**(composition≡pieces 보존,
synthetic deck nbra=0 레거시 fallback bit-안정). c2 selftest.

## ★ R2 핵심 발견 (정직·d6·c23): FS 샘플은 고쳐졌으나 λ는 여전히 붕괴 — **더 깊은 벽 노출**

R1 벽("FS 교차 샘플 부재")은 **고쳐짐**(아래 진단이 직접 증명). 그러나 matched-σ λ는 회복 안 됨.
붕괴의 진짜 위치가 R1이 본 것보다 한 단 더 앞(el-ph 정점)으로 드러남.

### 진단 (CaH6 npw_cap=200·nq=2·BARE·matched σ_el=0.005303 Ha = QE 0.015 Ry)
캡처: `/tmp/r2_prod_*.out` (worktree 실행, HEXA_LANG=worktree).

밴드 vs bisected E_F(=−1.02885 Ha):
```
band[0]=-10.1974 (occ)  ε−E_F=-9.17    |ε−E_F|/σ=1729   ← 깊은 점유, δ→0
band[3,4]=-1.99,-1.91   ε−E_F≈-0.9     |ε−E_F|/σ≈170    ← δ-억제
band[5,6,7]=-1.02885 (occ)  ε−E_F≈1e-12  |ε−E_F|/σ≈4e-10  ← E_F 위 (FS)
band[8,9,10]=-1.02885 (CON) ε−E_F≈3e-12  |ε−E_F|/σ≈7e-10  ← E_F 위 (FS)
band[11]=-0.564 (CON)   ε−E_F=0.46      |ε−E_F|/σ=88     ← δ-억제
```
→ **6개 밴드(5-10)가 정확히 E_F에 축퇴** → δ(ε−E_F)≈75(=1/σ√2π) **최대**. FS 샘플 발화 ✅.

el-ph stage 진단:
- 전체 Σ|g|² = 3.62836 (정상·R1과 일관, diag-slice Σ|g_nn|²=3.40273)
- **FS-window(±5σ) Σ|g|² = 1.50467e-47 over 36 pairs** ← E_F 밴드쌍의 el-ph 결합이 **사실상 0**
- → 3.6의 Σ|g|²는 **전부 깊은 밴드(E_F서 멀어 δ-억제)**서 옴. FS 위 밴드쌍은 |g|²≈0.

a2f 정상성 확인(독립 probe `/tmp/a2fprobe.hexa`): **밴드가 진짜 E_F 위면**(ε−E_F=0, g2=0.038)
한 FS pair만으로 **λ=5503** — a2f 어셈블러는 붕괴 안 함. 즉 붕괴는 어셈블러도 σ도 아니고
**FS 밴드쌍의 bare |g|²=1.5e-47** 그 자체.

### 결과 표 (npw_cap=200·nq=2·BARE)
| σ_el (Ha) | ⇔ QE degauss | FS-window Σ\|g\|² | QFORGE λ | 판정 |
|---|---|---|---|---|
| 0.005303 (matched 0.015 Ry) | 0.015 Ry | 1.50e-47 (36 pairs) | 1.0191e-42 | 🧱 붕괴 |
| 0.05 (legacy default) | 0.1414 Ry | 1.50e-47 (36 pairs) | 4.4643e-42 | 🧱 붕괴 |

(npw_cap=200은 truncated basis — R1처럼 결론 불가 영역. 아래 RESULTS = production 확정.)

### RESULTS — production (npw_cap=0·n=645·nq=4·BARE — R1의 4.137 baseline config) ★확정
캡처: `/tmp/r2_prod_s015.out`.

| σ_el (Ha) | ⇔ QE degauss | diag-slice Σ\|g_nn\|² | FS-window Σ\|g\|² | QFORGE λ | 판정 |
|---|---|---|---|---|---|
| 0.005303 (matched 0.015 Ry) | 0.015 Ry | **3.69548** | 1.00e-33 (12 pairs) | **1.30e-31** | 🧱 붕괴 |

- ★ **diag-slice Σ|g_nn|² = 3.69548 = R1 production Σ|g|²=3.69554 비트재현** → R2가 R1의 4.137
  baseline과 **동일 config**(n=645·nocc=8) 위에서 돈다 확정. el-ph 정점은 동일·정상.
- ★ FS sampling FIRES at full shell — **12개 FS 밴드쌍** 발견(E_F ±5σ). 그러나 그 12쌍의
  **bare Σ|g|² = 1.00e-33** ≈ 0. 전체 4.42의 Σ|g|²는 전부 깊은 δ-억제 밴드서 옴(R1과 동일 패턴).
- ★ QFORGE λ = **1.30e-31** (vs QE matched 4.376) — production서도 붕괴 확정.
  R1의 matched-σ 붕괴(1e-30대)와 **같은 자릿수** → R2의 FS 샘플 추가가 붕괴를 못 고침을 production
  실측으로 박제. **붕괴 원인은 FS-샘플 부재(R1 가설)가 아니라 FS 위 bare |g|²≈0(R2 확정).**

## 판정 (정직·d6) — 진짜 벽이 한 단 더 깊은 곳으로 이동
- ✅ **R1 벽 해소·구현 박제**: 단일-Γ on-shell → 실 metallic FS 샘플(bisected E_F + nbra 전도밴드
  + (m,n) band-pair). 6밴드가 E_F에 축퇴해 FS double-δ가 **최대**로 발화함을 직접 측정으로 증명.
- 🧱 **새 벽(더 앞단·el-ph 정점) 노출**: Fermi-surface 밴드쌍의 **bare |g|² = 1.5e-47 ≈ 0**.
  λ 붕괴는 이제 broadening도 FS-샘플 부재도 아니고 **FS 위 bare el-ph 결합 자체가 소멸**.
  원인(파일:라인): `pw_frontend.hexa`의 ΔV 번들(`qforge_dvbare_psi_bundle`)이 **점유 KET ψ_n에만**
  rigid-ion bare 형상인자를 적용 — 단일-Γ q·축퇴 평탄밴드서 E_F 밴드쌍의 inter-band overlap≈0.
  이건 R1 차폐 closed-neg(9-path)과 또 다른 축이지만, **둘 다 bare-vertex의 한계**로 수렴.

## fire-on-arrival 다음 라운드 (R3) — named 레버 후보
- **(a) 다중-q FS 샘플**: 단일-Γ가 아닌 실 q-mesh(k×q)서 ε_{k+q}≠ε_k인 진짜 산란 — 축퇴 평탄밴드
  Γ-only가 inter-band |g|²를 죽이는지 검증. (현재 ncells=1 q-flat → q=Γ만.)
- **(b) 전도밴드 KET 확장**: ΔV 번들을 점유 KET뿐 아니라 E_F 근방 전도 KET까지 → FS 밴드쌍이
  실제 산란 진폭을 받도록.
- **(c) 차폐정점 교차**: 차폐 9-path(closed-neg)와의 교차 — bare서 FS |g|²=0이면 ε⁻¹ 차폐도 0×무한 →
  별 효과 없음을 정직 박제(차폐가 못 고치는 더 앞단 결함 확인).
- depletion test: (a)/(b)서 FS-window Σ|g|²가 O(0.01+)로 살아나 matched-σ λ(σ)가 QE 사다리와
  평행하면 ✅; 여전히 FS |g|²≈0이면 정직 🧱(레버 소진 시 lane 🧱 종결).

## PR (dancinlab/hexa-lang)
- R2 = R1(#3658, OPEN) 위에 stack. branch `feat-qforge-metallic-fs-sampling`.
- 코드 변경: `qforge_run.hexa`(nbra/eps_bra deck 필드 + nbra davidson + (m,n) FS 샘플 + FS-window
  진단) · `pw_frontend.hexa`(bisected E_F + eps_bra stage, 4 deck 생성자 + smearing import) ·
  3 selftest(nbra:0 레거시 fallback) · cah6_fullbz_xval fixture(R2-FS band 진단).
  explicit·no force·selftest PASS(c2).

## depletion test (fleet 프로토콜)
- R2 레버(metallic FS 샘플)는 **구현·검증 완료, 실측 완료** — FS 샘플은 발화하나 FS |g|²≈0 노출.
  이 레버서 더 짤 것 없음(붕괴 위치가 el-ph 정점으로 확정 이동).
- 다음 레버(R3 = 다중-q / 전도 KET)는 **새 코드 영역**(ΔV 번들·q-mesh 산란) — R2와 독립,
  fire-on-arrival 별개 라운드.
