# companion/ — CERN 모노그래프 데이터-레코드 축

이 디렉터리는 `main.pdf`와 함께 살아가는 **verifiable data records** layer다. 페이퍼 본문의
모든 numeric claim · PR 출처 · 정직-scope 경계가 PDF 한 장으로 끝나지 않고, atom/companion
entry로 역추적되도록 reproducibility를 외부화한다 (sidecar/paper companion 패턴 · commons @D g51).

> 이 패스는 SCAFFOLD+BODY. companion 파일들은 **SKELETON** — 실측 수치(observed/expected/
> delta_abs · gh-measured PR metadata)는 `null` placeholder로 두고 fill 배치에서 채운다.

## 파일

- **`verify-ledger.json`** — `hexa verify` 실행 결과의 append-only ledger. 본문 §Bethe-Bloch /
  §Plasma / §FODO 의 모든 atom이 여기 한 entry와 매칭된다. SKELETON 9 entry:
  Bethe-Bloch PDG 4점 (🟢) · plasma-wakefield 2 atom (wakefield_e0_gv_m · wakefield_lambda_um,
  PR #1007) · 1-D linear PIC parity (Δ=3.56%, PR #1088) · FODO twiss parity (absorbed=true
  ALGORITHM closure) · LHE round-trip (absorbed=false GATE_OPEN 영구). schema:
  `{fn, args, expected, observed, delta_abs, tier, atom_class, pr, stage, note}`.

- **`pr-roll.json`** — 이 도메인/페이퍼를 만든 머지된 PR roll. hexa-lang #1007 (cold-linear) ·
  #1088 (1-D linear PIC parity) + demiurge 모노그래프 PR. 메타데이터(`merged_at` ·
  `files_changed` · `lines_added/deleted`)는 `gh pr view --json`으로 실측 (fill 배치). schema:
  `{repo, number, title, merged_at, files_changed, lines_added, lines_deleted, stage, role}`.

- **`session-journal.md`** — 하루의 작업 arc를 사람-읽기용 한글 narrative로 압축. 도메인의
  정직-scope 경계(closed vs GATE_OPEN vs downstream)를 명시.

## 페이퍼 본문이 companion/을 인용하는 방식

- §Bethe-Bloch / §Plasma / §FODO: 각 verdict이 `verify-ledger.json`의 한 entry와 1:1 대응 —
  reviewer는 `jq '.[] | select(.fn=="wakefield_e0_gv_m")'` 한 줄로 검증 가능.
- §Reproducibility: PR 목록이 `pr-roll.json`의 truthful 메타데이터로 뒷받침.
- §Limitations / appendix G: downstream 3-row(Geant4-MC Stage 4 · GPU blowout PIC ·
  measured-ring deck)가 정직-scope 경계의 SSOT.

## 왜 companion인가

PDF만 ship하면 ① numeric claim의 raw output 분실, ② 어떤 PR가 어떤 claim을 만들었는지 추적 불가,
③ 정직-scope 경계(무엇을 닫았고 무엇을 의도적으로 안 닫았는지)가 본문 산문에만 남는다. companion/은
이 셋을 기계-검증 가능한 데이터로 외부화한다 — CERN 도메인의 시그니처는 **scope 경계가 사과가 아니라
deliverable**이라는 점이고, 그 경계가 여기 데이터로 산다.
