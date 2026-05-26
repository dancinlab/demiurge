# Nb₃Al (A15) — non-hydride RTSC frontier Pilot #1

> **status**: **SPEC ONLY · DISPATCH DEFERRED to next round**
> **kind**: non-hydride RTSC family pilot deck (BETE-NET trustworthy frontier)
> **date**: 2026-05-27 KST · **domain**: RTSC · **governance**: d6 · d7 · d11 · d13 · d14 · d15 · d16 · d17 · g3 · g63 · R4

---

## 0. Why Nb₃Al (motivation 1-paragraph)

A15 family (Nb₃Sn · Nb₃Ge · V₃Ga · Nb₃Al) 는 1950s-70s industry-mature LTS — measured Tc 16-23K, BCS regime (λ~0.84, ω_log~230K, μ\*=0.13). **BETE-NET 의 A15 prediction rel_err ≈ 22% (Hydride 90%+ 대비 4-5× 향상)** → ML-trustworthy 영역. demiurge V3 numerical recompute ledger 의 hydride-편향(10/10) 을 *A15 anchor 1개 추가* 로 깨고, BETE-NET retro-comparison + Allen-Dynes Tc 재산정의 *cross-tool consistency baseline* 을 확보. RTSC absorbed=true 직결 아님 — N5/N6 hydride funnel 의 parallel verify lane.

## 1. Cell (Pm-3n, A15 prototype)

- space group #223 Pm-3n (cubic primitive)
- 8 atoms / primitive (= conventional cell · 6 Nb + 2 Al)
- Wyckoff: Al at 2a (0,0,0) · Nb at 6c (1/4, 0, 1/2) + permutations
- lattice param a_lit = 5.187 Å = 9.802 Bohr (Junod 1971 @ 4K measured)
- VEC = 6×5(Nb) + 2×3(Al) = 36 (= 4.5 e/atom)

## 2. Pseudopotentials (d13 check)

| element | UPF | source | staged? |
|---|---|---|---|
| Nb | Nb.pbe-spn-rrkjus_psl.1.0.0.UPF | pseudopotentials.quantum-espresso.org PSlibrary 1.0.0 | **TBD before dispatch** (likely already on ubu-1 ~/etc/pseudos — verify) |
| Al | Al.pbe-n-rrkjus_psl.1.0.0.UPF | pseudopotentials.quantum-espresso.org PSlibrary 1.0.0 | **TBD before dispatch** |

→ **d13 gate**: dispatch 직전 `ls ~/etc/pseudos/Nb*.UPF Al*.UPF` 로 확인, 부재 시 PSL 1.0.0 PBE rrkjus 표준 다운로드.

## 3. Flow

```
(0) d13 gate: pseudopotential check + stage to ubu-1:~/rtsc_nb3al/pseudo/
(1) vc-relax (relax.in) — settle celldm under cubic symmetry constraint (cell_dofree='ibrav')
(2) edit scf.in with relaxed celldm, then SCF (scf.in) — 8³ k Monkhorst-Pack
(3) ph.x (ph.in) electron_phonon='simple' 4³ q — IBZ 8 q-points (Pm-3n symmetry)
(4) harvest: σ-plateau + per-q λ + ω_log + Allen-Dynes Tc
(5) verify: hexa verify --expr allen_dynes_tc <λ> <ω_log> 0.13 --compute
            expected: Tc ≈ 18.0 ± 5 K → 🟢 ambient anchor lock
```

## 4. d7 sizing (pre-rent feasibility)

- 8-atom primitive · 80 Ry ecutwfc · 8³ k · 4³ q (IBZ ~8 q-points)
- ubu-1 -np 6 estimate: SCF ~4h · ph.x el-ph ~8 q × ~1.5h = ~12h · **total ~16h**
- **pool free OK (d7 small-cell)** — paid rent 불필요
- d11 pre-feasibility ✓

## 5. d16 dry-run plan

dispatch 직전 ubu-1 free 에서 1-iter SCF dry-run (`electron_maxstep=1`) → directive/basis syntax 검증 → 정상 시 full SCF 진행.

## 6. Falsifier (pre-register)

> **Nb₃Al @ ambient, vc-relax 통과 후 SCF + ph.x el-ph 4³ q full chain 의 σ-plateau (σ≥0.025 Ry) Allen-Dynes Tc(μ\*=0.13) 가 18.0 ± 5 K 범위 내면 🟢 ambient A15 anchor lock; 범위 밖이면 pseudopotential / k-mesh convergence / λ-recompute 검토. dynamically unstable (q 의 min_freq < −50 cm⁻¹) 면 🔴 — Pm-3n A15 prototype DFT 재현 실패 (literature 와 충돌 = pseudopotential 의심)**.

threshold:
- Tc lock window: 13 K ≤ Tc_AD(μ\*=0.13) ≤ 23 K
- dynamical stability: all q min_freq > −50 cm⁻¹ AND hard-imag count ≤ 1/q
- σ-plateau: |Tc(σ=0.025) − Tc(σ=0.030)| ≤ 1 K

## 7. Cross-reference

- `domains/RTSC/research/non_hydride_candidates_brainstorm_20260527.md` — pilot selection rationale
- `domains/RTSC/falsifiers/F-N6.md` — same-cycle N6 falsifier ledger (different scope — hydride ternary)
- `domains/RTSC/verify/V3_numerical_recompute.md` — land destination of Tc_AD lock
- `decks/mg2irh6/`, `decks/li2cuh6/` — same-pattern hydride deck templates (style anchor)
- `decks/mgb2_pure/` — sister non-hydride pilot #2

## 8. Honest scope

- 본 pilot 결과 (Tc ≈ 18K reproduction) 가 *RTSC 200K+ 목표를 직접 진전시키지 않음*. baseline cross-tool consistency 확보용 anchor.
- BETE-NET 22% rel_err 도 absolute Tc 의 ±4K 정도 — Tc 18K 에서는 충분 신뢰 가능, 그러나 high-Tc extrapolation 보장 아님.
- R4 absorbed=false 영구 (simulation tier, no measured oracle PASS).
