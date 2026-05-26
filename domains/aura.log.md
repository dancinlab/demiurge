# AURA — step log

> Append-only progression log for the AURA (post-aural wearable BCI) domain.
> Snapshot SSOT: [aura.md](aura.md) · verb-cell manifest: [aura.demi](aura.demi)

## 2026-05-26 — domain ingest from sibling repo

- 🎧 AURA 도메인 demiurge 본체로 이관 (sibling repo `hexa-aura` 봉인 결정).
- 이전 위치: `github.com/dancinlab/hexa-aura` + 로컬 `~/core/hexa-aura/` (4.5 MB, 마지막 커밋 master @origin sync).
- 신규 위치:
  - 도메인 스냅샷: `demiurge/domains/aura.md` (대문자 헤더 prepend, legacy public-surface tool map 보존)
  - step log: `demiurge/domains/aura.log.md` (이 파일)
  - archive snapshot: `demiurge/domains/AURA/` — docs + .tape + papers + state(708 KB), 코드 없음 (@D d3 준수)
- GitHub 처리: `dancinlab/hexa-aura` → `dancinlab/archive-aura` rename + visibility=private
- 로컬 폴더: `~/core/hexa-aura/` 삭제
- DOMAINS.tape: `@domain AURA := "domains/aura.md"` 등록 (NAME 대문자 · 경로 소문자 = case-insensitive FS 충돌 회피)
- 구현 SSOT는 그대로: `~/core/hexa-lang/stdlib/aura/{specify,structure,design,analyze,synthesize,verify,handoff}.py` + `aura_mne.py` + `sleep_edf_measured_oracle.py` + `_dft_alpha_band_batch.hexa`
- G33 absorbed=true 상태 보존 (Sleep-EDF spectral parity mean_rel_err 8.4e-07 · D117 2nd cell first-flip · R8 4/4 CLOSURE) — `aura.demi` cellrun manifest 무변경.
