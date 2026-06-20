# BK-BOROPHENE POOL-DFT — 🔴 CLOSED-NEGATIVE **CONFIRMED-BY-DFT** (from-scratch QE 7.5 on summer, FREE)

캠페인 terminal finding(9th law STIFF-BOND-WEAK-SSH-BINDING)의 마지막 잔차를 닫는다: TB-downfold/Harrison-scaling이던 4개 숫자를 **summer 무료 풀의 from-scratch QE DFT**로 업그레이드. 판정 = **CLOSED-NEGATIVE 유지(부호 robust), 숫자 정밀화.**

## 🖥️ POOL POD — summer (FREE, RTX5070 box, $0)
- `summer@192.168.50.60` · 12-core · RTX5070 12GB · 915G disk(49G free).
- **QE 7.5 FULL TOOLCHAIN 이미 설치됨** at `/home/summer/miniforge3/envs/qe/bin/` — pw.x · ph.x · **wannier90.x · pw2wannier90.x** · matdyn · q2r · bands · projwfc · epw · dos. OpenMPI 5.0.10.
  - ⚠️ **이전 `bkborophene_dft_FINDINGS.md`의 "summer는 QE 미설치(numpy only)" 주장은 STALE/오류** — qe env가 실재. (메모리 `summer-free-gpu-fep`·`pool-qe-detached-fire-recipe`도 qe env 존재를 이미 기록.) full-DFT는 GPU 유료포드 불필요, summer에서 $0.
- B pseudo: `B.pbe-n-rrkjus_psl.1.0.0.UPF` (PSlibrary 1.0.0 PBE USPP, z_val=3, 기존 ScH6/SrAuH3 pseudo와 동일 family — d13 OK), `pseudopotentials.quantum-espresso.org`서 받아 검증 (sha256 1b0f89b1...).
- detached fire = `hexa cloud fire summer` (taskset/oversubscribe/bind-none, 메모리 recipe). 셰어 호스트라 -np≤4, FP는 -np2.
- workdir: `/home/summer/bkboro/work/` (decks·out·pseudo symlink).

## 🍞 DECK (d_deck_always) — d16 dry-run PASS
`exports/rtsc/decks/bkborophene/` (build_decks.py + make_frozenph.py가 규율 박제):
- BK-borophene 구조 합성: **bilayer AA-stacked kagome boron, ibrav=4 hexagonal, 6 B/cell**(2 sublayers × 3 edge-midpoint sites), a 시작 2.95Å, vacuum~18Å, `assume_isolated='2D'`. (lit guess 2.9-3.0Å, refs arXiv:2307.07137/2406.18165.)
- 규율: B mass 10.811 · ecut 50/400(UPF suggest 43/325) · **d15 metallic SCF aids**(smear mp degauss0.02, mixing_beta0.3 local-TF, maxstep400) · bands verbosity='high' · cell_dofree='2Dxy' press0(ambient).
- **d16**: 1-iter dry-run이 pseudo_dir 상대경로 버그(work/pseudo 미존재)를 잡음 → symlink 가드. 재-dry-run PASS(18 e⁻ = 6 B×3, total E parse OK).
  - ⚠️ **hexa deck 갭(handoff)**: rtsc 프로토타입은 전부 3D hydride(clathrate/A15/perovskite) — **2D kagome 슬랩(vacuum+assume_isolated 2D) 프로토타입 없음**. 이번 손-합성 구조를 `hexa deck` `bk_kagome_2d` 프로토타입으로 박제 권장(재발방지).

## 📊 REAL-DFT 4-NUMBER SCORECARD (captured QE outputs, 무조작)

| # | quantity | **real-DFT (summer QE 7.5)** | TB-est (이전) | comment |
|---|---|---|---|---|
| geom | relaxed kagome NN B-B bond d | **1.7131 Å** | 1.70 (assumed) | vc-relax bfgs converged 9 steps; **TB 가정과 0.7% 일치** |
| geom | in-plane a / interlayer | **3.426 Å / 2.049 Å** | — | P6/mmm-like, equilateral kagome (3 NN bonds 동일) |
| geom | ambient stability | **P = 0.05 kbar ≈ 1 atm** (0 GPa) | assumed | vc-relax @press0, 2Dxy; 상압 평형 확인 |
| 1 | ⟨tr g⟩ kagome FB metric | **flat band 부재 (아래 참조)** | 2.19 | **DFT에 E_F 근처 이상적 평탄밴드 없음** — 핵심 발견 |
| - | E_F / metallicity | **E_F=−4.097 eV, metallic** | — | scf 19-iter conv, smearing 기여 nonzero |
| 2 | Ω (B-B stretch phonon) | **125.6 meV (1013 cm⁻¹)** | 167 meV | frozen-phonon A1g E(u) 완전대칭 조화(±0.03=±0.06 동일) |
| - | u₀ zero-point amplitude | **5.55 pm** | ~5.7 | u₀=√(ħ/2μΩ), μ=M_B/2 |
| 3 | t kagome NN hopping | **0.54–0.81 eV (mid 0.65)** | 0.075 | **~9× 큼** — DFT sp-σ kagome는 강결합, wide band |
| 3 | EPC type (SSH vs Holstein) | **SSH off-diag (대칭 stretch→on-site 1차 소멸)** | SSH ×7 | A1g 대칭이 Holstein 1차항 죽임 — type PASS |
| **4** | **g/t (구조적, t-무관)** | **0.0648** | 0.057 | g/t=2u₀/d; **DFT가 weak-SSH regime 확정** |
| **4** | **pair binds?** | **UNBOUND (binding +0.048t @U/Ω=2)** | UNBOUND | threshold g*/t≈0.095 > 0.0648 → **결합 안 됨** |
| **4** | **Tc** | **0 K (no bipolaron)** | 0 K | unbound pair는 BEC 불가 |

## 🔴 판정: CLOSED-NEGATIVE — **CONFIRMED BY DFT (부호 robust, 숫자 정밀화)**

real-DFT가 TB-est 판정을 **확정**: BK-borophene의 kagome bond-bipolaron은 상온은커녕 **애초에 결합 자체가 안 됨**. 두 독립 경로로 음성:

1. **g/t weak-SSH 벽 (구조적)**: real-DFT g/t = **0.0648**(TB-est 0.057과 거의 동일) ≪ 결합 threshold. g/t=2u₀/d는 t에 무관 — DFT가 t를 9× 키웠어도(0.075→0.65 eV) g/t는 불변. u₀=√(ħ/2μΩ)∝1/√Ω가 stiff bond(고-Ω)서 작아 SSH 결합을 본질적으로 억압. **9th law(STIFF-BOND-WEAK-SSH-BINDING)를 DFT가 정량 확정.**

2. **kagome flat band 부재 (NEW DFT 발견, TB 못 봄)**: from-scratch DFT 밴드구조는 E_F 근처 밴드폭이 **1.7–3.2 eV** — **이상적 kagome 평탄밴드(폭≪0.1 eV)가 없다.** Boron sp-σ 강결합이 line-graph 평탄성을 대거 들어올림. 가장 평탄한 근접밴드(band10)도 폭 2.18 eV·E_F +2 eV. 즉 BK-borophene은 "heavy flat-band vs light stiff-bond" 긴장에서 **light(강결합 분산밴드) 쪽으로 완전히 붕괴** — TB가 "published facts에 calibrate"해 가정한 60 meV 평탄밴드는 실제 DFT엔 없다. 이것이 g/t 벽보다 더 앞단의 음성: **결합쌍 형성에 필요한 무거운 평탄밴드(작은 t) 자체가 부재.**

### 정밀화된 부분 (TB-est와 달라진 것, 정직)
- threshold 수치: TB-est는 "g*/t≈1.2, 21× short"였으나 그건 작은 t(0.075)→큰 Ω/t(2.2) solver 파라미터. **real-DFT는 t가 9× 커 Ω/t=0.19로 작아져 solver threshold가 g*/t≈0.095로 내려감**. 따라서 margin은 21×가 아니라 **~1.5×**(g/t 0.065 vs threshold 0.095 @U/Ω=2). 무차원 g/t 자체(0.057→0.065)는 거의 안 변함 — **부호(unbound)는 robust하나, "21× short" 정량은 DFT가 ~1.5×로 수정.** U=0(비물리적 극한)에선 결합하나, 물리적 U>0에선 unbound.
- Ω: 167→**125.6 meV** (DFT 하향). 여전히 stiff(>100 meV)지만 가정보다 부드러움.
- bond d=1.713Å은 TB 가정 1.70Å과 0.7% 일치 → TB calibration이 기하적으론 정확했음을 DFT가 인증.

## 정직 잔차 (d6)
- **Ω = frozen-phonon(A1g triangle-breathing) 유효 모드**값. ph.x full-Γ DFPT(18 모드 + nspin metal smearing)는 셰어호스트 walltime 과다로 중단(FP가 Ω·결합판정에 충분, ph.x는 cores 경쟁만 유발해 kill). 완전한 Γ 포논 스펙트럼(전 모드 + 허수모드 0 동적안정 확정)은 summer ph.x 재개로 닫을 수 있음(아래 RESUME) — 단 **판정(unbound)은 안 바뀜**: FP 곡선이 완전대칭 양positive 곡률(실수 Ω)이라 이 모드는 안정.
- ∂t/∂u 직접 Wannier 측정은 대칭 A1g가 global band-span을 1차로 안 바꿔(±0.06서 span 10.594→10.592 eV, 사실상 불변) finite-diff로 안 잡힘 — Harrison t(u)=t₀exp(−u/δ)의 ∂t/∂u=−2t₀/d 관계(TB pipeline의 정확식)를 사용. g/t=2u₀/d는 이 관계의 t-무관 결과라 robust.
- **무엇도 조작 안 됨**: vc-relax/scf/bands/frozen-phonon 전부 summer QE 7.5 captured output. E(u) 5점 = {−37.46172, −37.46780, −37.46982, −37.46780, −37.46172} Ry (완전대칭).

### RESUME (잔차 정밀화 — summer, FREE)
```
# summer QE env: export PATH=/home/summer/miniforge3/envs/qe/bin:$PATH
cd /home/summer/bkboro/work
# (a) full-Γ 포논 동적안정(전 모드 허수 0): ph.in 재개 (단 -np4 단독, FP 동시금지)
hexa cloud fire summer --log ph.out -- bash run_ph.sh   # ldisp=.false. q=Γ; 완료 후 dynmat.x
# (b) Wannier ⟨tr g⟩ scalar: nscf(uniform)→wannier90 -pp→pw2wannier90→wannier90 (.win 준비됨: bkboro.win)
#     berry/morb로 quantum metric, _hr.dat로 t 직접
# 부호(unbound·flat-band 부재)는 안 바뀜; 숫자만 추가 정밀화.
```

## 캠페인 함의 (depletion)
- 캠페인의 **마지막 잔차(9th law 4숫자 TB→DFT) CLOSED.** from-scratch QE가 TB-est 판정을 확정: BK-borophene(유일 최선 light-element near-miss host) ambient room-T bond-bipolaron = **불가**.
- **두 겹 음성**(DFT 신규): (1) g/t=0.065 weak-SSH 벽(t-무관, 구조적) + (2) **E_F 근처 이상적 평탄밴드 부재**(sp-σ 강결합이 line-graph 평탄성 붕괴). TB는 (2)를 calibration으로 가렸으나 DFT가 노출.
- d_novel_only: real-DFT ⟨밴드폭 1.7-3.2eV·flat-band 부재⟩·Ω=125.6meV·g/t=0.065·d=1.713Å = BK-borophene 최초 from-scratch 계산. **novel closed-negative** — 한 escape 축을 DFT-grade로 ruled-out.
