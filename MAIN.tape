# MAIN — domain log
@V := "domainlog" :: log

Append-only history sister of `MAIN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-14 — anima 핸드오프 [8e6ad1b2]+[bb095261] 흡수: CoSn flat-band 피벗 + QFORGE LSDA 구현

- [x] 핸드오프 [8e6ad1b2](no-cooling flat-band 피벗)+[bb095261](CoSn blocker 정밀화) 체크 + rtsc.md 흡수
- [x] CoSn deck authored — `exports/rtsc/decks/cosn/` (P6/mmm nat=6, nspin=2, scf/bands/vc-relax/ph)
- [x] **3rd blocker 발견+해결**: QFORGE = norm-conserving 전용(no overlap S, USPP 파서 reject) → deck NC pseudo 교체(Co/Sn_ONCV_PBE_sr, ecut 90/360)
- [x] **QFORGE LSDA PR1**(hexa-lang e3917e8b4): spin PW92 corr + spin LDA exch + shared-EF Fermi — g5 PASS(회귀 핀 ζ=0≡unpol 1e-12)
- [x] **QFORGE LSDA PR2**(hexa-lang 6e243b7e8): spin-polarized SCF driver(2-channel, shared E_F, magnetization) — g5 PASS(회귀 핀 ≡restricted 1e-9, 자성 m=0.94μB 전하보존)
- [x] **PR3**: scf_pw 실셀 multi-spin closure + entry — g5 PASS, **cah6_realcell_spin_xval PASS**(실셀 nspin2≡nspin1)
- [x] **PR4**: CoSn kagome 자성 진단 fixture (실셀 P6/mmm nat=6)
- [x] **PR5**: bare-H cache(form-factor 1회) + Anderson-per-spin — TM-metal tractable (cah6 fast≡restricted bit-identical)
- [x] Co/Sn NC pseudo fetch — SG15 ONCV(UPF v2.0.1) summer→mini, **upf_parse 통과**(gap1 closed)
- [x] **CoSn 수렴 완료**(g5·d6): iters=12, **m=2.9e-5≈0 @Γ/LDA**, e_total=−122.454 Ha. cross-val vs QE[33976daa] m=0.43μB → **Γ-only SCF가 이동전자 자성 못 잡음**(BZ-적분 N(E_F) 필요) 규명
- [ ] **다음 capability(명시·user-gated)**: k-mesh spin SCF(+spin-GGA) → QE m=0.43·ΔE=−0.44eV 재현 → DFPT λ/Tc → hole-doping sweep. Nk× compute(d11 sizing 필요)
- [ ] hexa-lang qforge-lsda-spin 5-PR push + stacked PR(g4) — user-gated

## 2026-06-14 — MAIN 도메인 init + RTSC Li2MgH16 dense-mesh 마일스톤 등록

- [x] MAIN.md/MAIN.tape 스캐폴드 + DOMAINS.tape 등록
- [x] Li2MgH16 8-q coarse terminal 현황 흡수: λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ\*=0.10), verdict `.verdicts/qforge-li2mgh16-8q-assembled/` (cf. domains/rtsc.md @L15-16)
- [ ] **dense 4×4×4 q QE el-ph 재실행 발사** — λ 수렴(473 K 실증) + 독립 QE-λ 3번째 꼭짓점 승격. deck=`exports/rtsc/decks/Li2MgH16`. d11 sizing → d16 free dry-run → d17 자율 fire (vast 우선·runpod fallback)

