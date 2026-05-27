# companion/ — ANTIMATTER FACTORY 데이터-레코드 축

이 디렉터리는 `main.pdf`와 함께 살아가는 **verifiable data records** layer다. 페이퍼 본문의
모든 numeric claim · PR 출처 · 외부-도구 결함이 PDF 한 장으로 끝나지 않고, atom/companion entry로
역추적되도록 reproducibility를 외부화한다 (sidecar/paper companion 패턴 · commons @D g51).

## 파일

- **`verify-ledger.json`** — `hexa verify` 실행 결과의 ledger. 본문 §Method / §Penning keystone /
  §BLUE-MAX의 모든 atom이 여기 한 entry와 매칭된다. 39개 entry: 20개 🟢 SUPPORTED-NUMERICAL
  (7공정 libm-class 재계산) + 11개 🔵 SUPPORTED-FORMAL (core 3 + BLUE-MAX 8 algebraic-root) +
  8개 🔴 FALSIFIED (결정론적 음성대조). schema: `{fn, args, expected, observed, delta_abs, tier,
  atom_class, pr, process, note}`. `atom_class` ∈ `supported-formal` | `supported-numerical` |
  `falsified-controlled`. positive atom = 23 (🔵 3 + 🟢 20).

- **`pr-roll.json`** — 이 페이퍼를 만든 머지된 PR roll. hexa-lang 5개 (#1014/1015/1018/1094/1107) +
  demiurge 9개 (#157~#169). 메타데이터(`merged_at` · `files_changed` · `lines_added/deleted`)는
  `gh pr view --json` 실측 — fill batch에서 채움(현재 TODO 마커). schema: `{repo, number, title,
  process, role, note}`.

- **`adapter-defect-catalog.json`** — **N/A (의도적 빈 목록)**. ANTIMATTER는 외부-솔버
  wrap-and-fix 라운드가 없었다 — 유일한 솔버-class 커널(⓺가둠 자석)은 RTSC toolchain을
  *상속*했기에 새 어댑터 wrap이 없었고 → 새 결함도 없다. 빈 목록은 gap이 아니라 정직
  (verify-once-reuse-twice). schema 보존(HEXA-FUSION mirror) + `status: N/A` + `reason`.

- **`session-journal.md`** — 도메인 탄생(공정=축) → 6공정 verify 닫기 → ⓺가둠 RTSC 상속 →
  BLUE-MAX 11/11 g69 PASS → absorbed=false 정직 → 본 모노그래프, 의 작업 arc를 한글 narrative로
  압축. war-story callout 3건(Penning invariance 잔차 0.0 · wrap-and-fix 불필요 이유 · worktree wipe).

## 페이퍼 본문이 companion/을 인용하는 방식

- §Method / §Penning keystone / §BLUE-MAX: 각 verbatim verdict 블록은 `verify-ledger.json`의
  한 entry와 1:1 대응 — reviewer는 `jq '.[] | select(.fn=="penning_invariance")'` 한 줄로 검증.
- §Reproducibility: PR 목록이 `pr-roll.json`의 메타데이터로 뒷받침.
- §Inheritance(⓺가둠) → `adapter-defect-catalog.json`의 N/A 사유가 상속 thesis를 뒷받침.

## 왜 absorbed=false인가

6개 non-wet-lab 공정(⓵~⓺)을 통과한 디자인은 *공장 engineering feasibility의 witness*이지,
생성·측정된 반수소 샘플이 아니다. CPT 측정(⓻)은 영구 measured-oracle 경계 — ALPHA 1S-2S
(≈2e-12) · BASE g-factor가 adjudicate해야 하며, 폐형해는 대체 불가. @D d5 정직성: measured
oracle은 downstream confirmation이며, absorbed flip은 별도 gate다.

## 채우기 규칙

- new entry → 해당 JSON 파일에 append (절대 rewrite 금지).
- `session-journal.md` → 매 작업 세션 끝에 한 헤더 추가.
- appendix FILL batch → `% TODO (fill batch)` 마커를 실내용으로 교체, companion entry 인용.
