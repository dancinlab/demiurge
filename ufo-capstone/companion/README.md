# companion/ — UFO capstone 데이터-레코드 축

이 디렉터리는 `main.pdf` 와 함께 살아가는 **verifiable data records** layer 다.
페이퍼 본문의 모든 numeric claim · stage→sibling 매핑 · PR 출처가 PDF 한 장으로
끝나지 않고, atom/companion entry 로 역추적되도록 reproducibility 를 외부화한다
(sidecar/paper companion 패턴 · commons @D g51).

## 파일

- **`verify-ledger.json`** — `hexa verify` 실행 결과 + falsifier 상태의 ledger.
  본문 §Full Pipeline / §split / appendix I 의 모든 atom 이 여기 한 entry 와 매칭된다.
  Stage-1~3 9개 🟢 SUPPORTED-NUMERICAL (`ioffe_loop_bz` · `triple_product` ·
  `pair_threshold_total` · `rel_kinetic_from_p`, 전부 |Δ|=0, atlas `663698a0` parent fold) +
  🔵 n=6 lattice integer identity (`sigma*tau=48` · `sigma*phi=24`) +
  ⚪ 13 Stage-4~7 falsifier (전부 OPEN, academically UNPROVEN).
  schema: `{fn, args, expected, observed, delta_abs, tier, atom_class, stage, source_domain, note}`.
  `atom_class` ∈ `supported-numerical` | `supported-formal` | `falsifier-open`.

- **`integration-map.json`** — stage → sibling-domain → reuse-atom 의존 그래프
  (Table 4-domain integration map 의 SSOT). 하위 3단 = sibling verified atom 소비 ·
  CERN candidate infra edge · Stage-4~7 = sibling 소비 0 (⚪ falsifier-only).
  공유 상수 `B*=sigma*tau=48` 는 **arithmetic-reuse OBSERVATION** 으로 명시
  (통합 물리 증명 아님). `absorbed=false` + reason.

- **`pr-roll.json`** — 이 capstone 을 만든 머지된 PR roll. spec(#187) · verify
  ladder(#201/#206/#212/#216) · 이 monograph PR + 참조 sibling(#220 CERN).
  schema: `{repo, number, title, merged_at, files_changed, lines_added, lines_deleted, phase, role}`.

- **`session-journal.md`** — 하루의 작업 arc 를 사람 읽기용 한글 narrative 로 압축
  (통합 thesis → 7-stage ladder + proven/UNPROVEN 벽 → 4-domain map → absorbed=false 판정).
  2개 war-story callout 포함: B*=48 공유 상수 정직 framing · 정직 벽 sharp 유지.

## 페이퍼 본문이 companion/ 을 인용하는 방식

- §Full Pipeline / appendix I: 각 verdict 블록은 `verify-ledger.json` 의 한 entry 와
  1:1 대응 — reviewer 는 `jq '.[] | select(.fn=="ioffe_loop_bz")'` 한 줄로 검증 가능.
- §4-Domain Integration Map: 표가 `integration-map.json` 의 stage 배열 요약.
- §Reproducibility / appendix K: PR 목록이 `pr-roll.json` 의 truthful 메타데이터로 뒷받침.

## 왜 companion 인가

PDF 만 ship 하면 ① numeric claim 의 raw output 분실, ② 어떤 stage 가 어떤 sibling atom 을
소비하는지 추적 불가, ③ proven/UNPROVEN 벽이 흐려진다. companion = 이 셋의 SSOT 를
페이퍼 옆에 외부화한 것. 모든 sim 레코드는 `absorbed=false` — 비-wet-lab 게이트를 통과한
설계는 *통합 feasibility 의 witness* 이지, 지어지거나 비행한 craft 가 아니다. Stage-4~7
(warp · wormhole · dim-jump · dim-use) 은 ⚪ academically UNPROVEN 으로 영구 분리 —
13 falsifier 전부 OPEN, 벽 sharp 유지.

## 채우기 규칙

- new entry → 해당 JSON 파일에 append (날짜순; 절대 rewrite 금지).
- `session-journal.md` → 매 작업 세션 끝에 한 헤더 추가.
- appendix fill batch → `% TODO (fill batch)` 마커가 가리키는 `UFO/...` source 를 fold,
  새 verbatim verdict 는 `verify-ledger.json` 한 entry 와 매칭.
