# companion/ — HEXA-FUSION 데이터-레코드 축

이 디렉터리는 `main.pdf`와 함께 살아가는 **verifiable data records** layer다. 페이퍼 본문의
모든 numeric claim · PR 출처 · 외부-도구 결함이 PDF 한 장으로 끝나지 않고, atom/companion entry로
역추적되도록 reproducibility를 외부화한다 (sidecar/paper v0.7.0+ companion 패턴 · commons @D g51).

## 파일

- **`verify-ledger.json`** — `hexa verify` 실행 결과의 append-only ledger. 본문 §Verify / §BLUE-MAX의
  모든 atom이 여기 한 entry와 매칭된다. 36개 entry: 🟢 SUPPORTED-NUMERICAL (gate a/b/c/d/e/f
  + F-funnel + reactivity) + 8개 🔵 SUPPORTED-FORMAL (BLUE-MAX integer atom) + 8개 🔴 FALSIFIED
  (negative control). schema: `{fn, args, expected, observed, delta_abs, tier, atom_class, pr, gate, note}`.
  `atom_class` ∈ `supported-formal` | `supported-numerical` | `falsified-controlled`.

- **`pr-roll.json`** — 이 페이퍼를 만든 머지된 PR roll. hexa-lang 12개 (#1012/1020/1027/1032/1042/
  1054/1075/1078/1084/1090/1095/1102) + demiurge 3개 (#176/178/179). 메타데이터(`merged_at` ·
  `files_changed` · `lines_added/deleted`)는 `gh pr view --json`으로 실측 — 조작 없음. schema:
  `{repo, number, title, merged_at, files_changed, lines_added, lines_deleted, gate, role}`.

- **`adapter-defect-catalog.json`** — wrap-and-fix 라운드에서 surface된 외부-솔버 어댑터 결함 3건.
  OpenMC transport-less stub (#1078 fix) · FreeGS divergent coil + stdout-corruption (#1075 fix) ·
  GetDP solve-less checker + far-field-truncation 오진단 (#1095 fix). 후속 페이퍼/구현이 같은
  함정을 반복하지 않도록. schema: `{id, file, origin_commit, symptom, root_cause, fix_pr, fix_summary,
  tier_after, honesty_note}`.

- **`session-journal.md`** — 하루의 작업 arc를 사람 읽기용 한글 narrative로 압축 (도메인 생성 →
  7-gate funnel land → (c)(f)(e) wrap-and-fix promote → BLUE-MAX → HEXA-PORT 자매 도메인 탄생 →
  페이퍼). 4개 war-story callout 포함: 4π 정밀도 함정 · FAR-FIELD 진단 역전 · cross-repo gh merge
  버그 · rate-limit-killed agent salvage.

## 페이퍼 본문이 companion/을 인용하는 방식

- §Verify / §Results: 각 verbatim verdict 블록은 `companion/verify-ledger.json`의 한 entry와
  1:1 대응 — reviewer는 `jq '.[] | select(.fn=="q_star_constant")'` 한 줄로 검증 가능.
- §Wrap-and-fix → §Adapter defect catalog: 3-row 표가 `adapter-defect-catalog.json`의 요약.
- §Reproducibility: 12+3 PR 목록이 `pr-roll.json`의 truthful 메타데이터로 뒷받침.

## 왜 companion인가

PDF만 ship하면 ① numeric claim의 raw output 분실, ② 어떤 PR가 어떤 claim을 만들었는지 추적 불가,
③ 같은 외부-도구 결함을 다음 사람이 또 만난다. companion = 이 셋의 SSOT를 페이퍼 옆에 외부화한 것.
모든 sim 레코드는 `absorbed=false` — 6개 non-wet-lab gate를 통과한 디자인은 *engineering feasibility의
witness*이지, 지어지거나 측정된 reactor가 아니다. (g) 점화는 영구 wet-lab 경계로 남는다.

## 채우기 규칙

- new entry → 해당 JSON 파일에 append (날짜순; 절대 rewrite 금지).
- `session-journal.md` → 매 작업 세션 끝에 한 헤더 추가.
- paper 본문에서 `companion/verify-ledger.json` 인용 → reviewer가 grep/jq 한 줄로 검증.
