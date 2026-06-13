# SRR — Split-Ring Resonator (갈라진 고리 공명기) progress board

@title: 💍 SRR — 갈라진 고리 공명기(μ<0 공명자)

@goal: Split-Ring Resonator(갈라진 고리 공명기) 메타셀 — Lorentz-type μ(ω) 공명 모델로 μ_eff < 0 (음의 투자율) 을 닫는 verify-native 토대. **CLOAK 메타도메인의 부품 2** — Q = σ·τ = 48 품질계수 + Pendry 1999 closed-form + numerical recompute 까지. absorbed=true ⇔ 全 non-wet-lab gate PASS (실측 VNA = downstream · @D d5)

## 0. TL;DR

```
   ╭───╮         μ(ω) = 1 + F·ω²/(ω₀² - ω² - iωΓ)     Lorentz form
   │ ┃ │  ◄──    ω₀ = 1/√(L·C)                        resonance freq
   ╰─┴─╯         Q = ω₀/Γ = σ·τ = 48                  quality factor
                                                       ↑
   갈라진 고리                                        n=6 lattice 상수
   = 자기 LC 회로 = 자기 공명자

@ ω = ω₀ 부근:  μ_eff(ω) < 0      (CLOAK 의 μ<0 공급원)
                ↓
   메타셀 격자에 깔면      ε(ω)<0 (RTSC Drude) + μ(ω)<0 (이 도메인) → n_eff = -√(εμ) < 0
                                                                       ↑
                                                                  Veselago 음굴절
```

## Milestones (progress)

### Phase A — Lorentz μ(ω) closed-form (Pendry 1999)

- [ ] ⓵ LC 공명 ω₀ = 1/√(L·C) — closed-form 항등식 (g_self_verify 후보)
- [ ] ⓶ Q-factor Q = σ·τ = 48 — derived from `sigma 6 12` · `tau 6 4` 🔵 anchor 직접 결과
- [ ] ⓷ 음투자율 분기 sign — Lorentz form 의 ω > ω₀ 영역에서 μ<0 → 🔵 부호 항등식
- [ ] ⓸ 격자 충진율 F (filling factor) — F = π r²/a² closed-form (Pendry 1999)
- [ ] ⓹ 손실 한계 — Γ ≪ ω₀ (high-Q) 조건 + Q=48 매칭

### Phase B — geometry · materials (cellrun stub)

- [ ] Hex-SRR 단위 셀 형상 (외경 r_o · 내경 r_i · gap g · linewidth w)
- [ ] 도체 소재 — Cu / Ag / Au · RT-SC 박막 호환성 (sopfr=5 nm 두께)
- [ ] 동작 대역 — RF / THz / IR / 가시광 별 스케일링 (λ/10 rule)
- [ ] 공정 호환 — EUV 48 nm pitch + ALD multilayer

### Phase C — 7-verb 파이프라인 (CLOAK 메타-합성과 공유)

- [ ] verb-1 specify — SRR 메타셀 목표 사양 (대역·Q·loss budget)
- [ ] verb-2 structure — Hex-SRR 형상 + n=6 격자 배치
- [ ] verb-3 design — Pendry closed-form 파라미터 표
- [ ] verb-4 analyze ⟲ — FDTD/HFSS S-parameter 추출 + ε(ω)·μ(ω) retrieval
- [ ] verb-5 synthesize — EUV mask + 측면 도체 패터닝 recipe
- [ ] verb-6 verify — V1-V4 tier ledger (Q=48 + ω₀ 닫힘)
- [ ] verb-7 handoff — VNA bench plan (Q · |S11|·|S21| · ε/μ retrieval)

### Phase D — absorbed 판정 (@D d5 · CLOAK 메타 invariant 와 lockstep)

- [ ] 全 non-wet-lab gate PASS → SRR absorbed=TRUE (VNA 실측 = downstream)

## verify (🔵/🟢 push · @D g5 · demiurge 자산 필수)

- [x] V1 claim inventory — Pendry 1999 + Smith 2000 + UFO/CLOAK.md H-CLK-1~12 의 SRR-관련 항목 추출 + tier triage (V2 ledger §0 에서 통합 수행)
- [x] V2 🟡 push — LC 공명 ω₀ + Q=σ·τ=48 + filling factor F + μ<0 sign branch tier triage **DONE 2026-05-28** — `exports/srr/verify/V2_pendry_closedform.md` · 🟡×4 (atlas `n6-bt-762 sigma_tau=48` + Pendry 1999 LC ω₀ + Pendry F=π·r²/a² + Smith 2000 λ/10) + ⚪×3 (LC closed-form recompute · F recompute · μ<0 sign 모두 honest fence — `lc_resonance/srr_filling_factor/lorentz_mu_re` hexa-native fn 부재 정직 명시). 직접 🔵 0 (HEX-N6 sibling 의 sigma·tau 🔵 anchor 의 integer composition 으로 σ·τ=48 derive · 별도 atom 신설 불필요 g69)
- [x] V3 🟢 push — `stdlib/srr/lc_resonance.hexa` (PR #1934 MERGED 2026-05-28, hexa-lang main) 7-falsifier self-test 7/7 PASS · `lc_resonance(L,C)=1/√(LC)` + `srr_filling_factor(r,a)=π·r²/a²` + `lorentz_mu_re(F,ω,ω₀,γ)` — 모두 closed-form Pendry 1999 + libm sqrt numerical, F7 μ<0 branch 실증 (μ_re(ω/ω₀=1.0001, F=0.5, γ/ω₀=1e-4) = -1999.26 < 0 = CLOAK demand witness)
- [ ] V4 final tier ledger — V1+V2+V3 통합

## 1. cross-domain (NEXUS.tape 후보)

| 선행 자산 | reuse 대상 | 형태 |
|---|---|---|
| n=6 lattice (HEX-N6) | σ·τ=48 Q-factor 매칭 | 격자 산술 직접 |
| RTSC | RT-SC 박막 도체 (sopfr=5 nm) | substrate stack 직계 |
| CLOAK (메타) | μ<0 공급원 | SRR = CLOAK 부품 2 |
| METAMATERIAL | acoustic/optical SRR 일반론 | 공명자 family |

## 참고 (cross-reference)

- `domains/cloak.md` — 메타-합성 carrier (SRR = 부품 2)
- `domains/rtsc.md` — RT-SC 박막 substrate
- `domains/hex-n6.md` — n=6 육각 격자 primitive
- Pendry, J. B. (1999) IEEE Trans. Microwave Theory Tech. 47, 2075 — original SRR
- Smith et al. (2000) PRL 84, 4184 — left-handed metamaterial
- @D d1 · d3 · d5 · d10 · d19
