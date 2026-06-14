# MAIN — domain log
@V := "domainlog" :: log

Append-only history sister of `MAIN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-14 — anima 핸드오프 [8e6ad1b2]+[bb095261] 흡수: CoSn flat-band 피벗 + QFORGE LSDA 구현

- [x] 핸드오프 [8e6ad1b2](no-cooling flat-band 피벗)+[bb095261](CoSn blocker 정밀화) 체크 + rtsc.md 흡수
- [x] CoSn deck authored — `exports/rtsc/decks/cosn/` (P6/mmm nat=6, nspin=2, scf/bands/vc-relax/ph)
- [x] **3rd blocker 발견+해결**: QFORGE = norm-conserving 전용(no overlap S, USPP 파서 reject) → deck NC pseudo 교체(Co/Sn_ONCV_PBE_sr, ecut 90/360)
- [x] **QFORGE LSDA PR1**(hexa-lang e3917e8b4): spin PW92 corr + spin LDA exch + shared-EF Fermi — g5 PASS(회귀 핀 ζ=0≡unpol 1e-12)
- [x] **QFORGE LSDA PR2**(hexa-lang 6e243b7e8): spin-polarized SCF driver(2-channel, shared E_F, magnetization) — g5 PASS(회귀 핀 ≡restricted 1e-9, 자성 m=0.94μB 전하보존)
- [ ] **PR3**: scf_pw 실셀 multi-spin closure(doubled PW_HAM·per-spin vscr) + CaH6 nspin2≡nspin1 회귀 fixture (production wiring, 대형)
- [ ] **PR4**: pw_frontend nspin UPF/control parse + orchestrator_pw nspin knob + CoSn entry point
- [ ] Co/Sn NC pseudo fetch(network-gated) → d11 sizing → d16 free validate → CoSn run(compute, user-gated $)
- [ ] hexa-lang PR1/PR2 push + stacked PR(g4) — user-gated

## 2026-06-14 — MAIN 도메인 init + RTSC Li2MgH16 dense-mesh 마일스톤 등록

- [x] MAIN.md/MAIN.tape 스캐폴드 + DOMAINS.tape 등록
- [x] Li2MgH16 8-q coarse terminal 현황 흡수: λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ\*=0.10), verdict `.verdicts/qforge-li2mgh16-8q-assembled/` (cf. domains/rtsc.md @L15-16)
- [ ] **dense 4×4×4 q QE el-ph 재실행 발사** — λ 수렴(473 K 실증) + 독립 QE-λ 3번째 꼭짓점 승격. deck=`exports/rtsc/decks/Li2MgH16`. d11 sizing → d16 free dry-run → d17 자율 fire (vast 우선·runpod fallback)

