# κ-72 horizon framing research — Round 11 design under honest partial-closure precedent

> **status**: scaffold-open · 2026-05-22 (post-κ-71 R10 HONEST 3/4 +
> G41 `[~]` PARTIAL closure · `c82fe0e` PLAN entry · `2ac28b4` G42
> closure commit). Code 0.
>
> ARCH.md §11.6 G41 stays `[~]` PARTIAL on honest gap (D121 ·
> mean_rel_err=0.0708 over [4,25] m/s 43-bin grid > D120 ≤0.05 PASS).
> 5 of 6 components LANDED · `absorbed=true` flip DEFERRED · R4
> invariant respected. **κ-71 R10 is the first round to land as
> honest 3/4 + PARTIAL** — this note examines what κ-72 should be
> given that precedent. **κ-72 has two natural framings · this note
> compares them honestly + a hybrid · ranking advisory only · pick
> belongs to next session's G44.**

## Why this note exists (precedent shift)

κ-68/69/70 each closed 4/4 (or 5/5 for κ-68 with G30 included). κ-71
deliberately did NOT — D120's PASS criterion was stricter
(PREDICTION-shape vs κ-69/70 numeric-equivalence shape · honesty-floor
re-elevation) and the IEC cubic-interp kernel did not fit the Vestas
V90 empirical curve closely enough. **The honest landing was 3/4 + G41
PARTIAL · not a fake 4/4 with `absorbed=true` over a 41% gap.** That
choice is the precedent.

κ-72 inherits two open obligations from that precedent:

1. **G41 deferred flip** — D121 lists three resumption paths · (i)
   kernel refinement (multi-segment quadratic / sigmoidal-on-rated)
   is principled · (ii) oracle-criterion new D-block is permissible
   but needs its own decision · (iii) different turbine class is
   anti-pattern.
2. **5th-cell measured-oracle round** — κ-71 R10 4-record-type
   invariant audit is the strongest cross-cell evidence to date. Bio
   (#2 in κ-71 G39 research) and Chem (#3) remain unspent candidates ·
   first NEW DOMAIN cell signal still open.

κ-72 can resume (1), open (2), or sequence both. The three framings
below are the honest options.

## κ-71 R10 honest-partial inheritance — what carries into κ-72

| inherited fact | source | κ-72 impact |
|---|---|---|
| G41 5/6 LANDED + flip DEFERRED | D121 · ARCH §11.6 G41 `[~]` · PLAN `c82fe0e` | Open kernel-refinement track · OR oracle-criterion D-block |
| `power_curve_kernel.hexa` v0.1.0 MERGED (hexa-lang PR #308 · `2b4fc695`) | D121 · PLAN | Substrate floor for Energy/wind no longer ZERO · refinement is *additive* |
| `EnergyWindVerifyRecord` LANDED (cockpit) | D121 #2 | 4th record type already audited · 5th would be 5th-record-type audit |
| 4-record-type invariant audit CONFIRMED (0 helper code change) | D121 #4 · κ-72 strongest evidence | 5th instance would be redundant confirmation (4th already strongest) |
| PR #320 (hexa-lang producer) status pending CI re-stabilization | PLAN companion infra notes | Orthogonal to G41 governance · resolves on its own |
| Bio (#2 in κ-71 G39) + Chem (#3) candidates UNSPENT | `inbox/notes/2026-05-22-k71-horizon-candidate-research.md` | Direct carry — same 5-fold dimension as before |
| `pilot-bio_align_nw` 36/36 PASS @ rel_err=0 floor | κ-71 G39 research §Candidate-B | Bio option-b substrate floor still very strong |
| `pilot-chem_arrhenius` 6/6 self-test-only · Stage-0 | κ-71 G39 research §Candidate-C | Chem substrate floor weakness unchanged |
| `pilot-power_curve` exists now (PR #308 land) | NEW | Energy/wind no longer "substrate floor ZERO" — refinement is the next pull |

## Framing A — κ-72 = G41 resumption (kernel refinement / oracle relaxation)

**Thesis**: close the open round before opening another. κ-71 deserved
a 4th legitimate `absorbed=true` flip; the honest partial is correct
under R4 but leaves the cell open. κ-72 lands that flip via D121
Path (i) [principled · kernel refinement] OR Path (ii) [oracle-
criterion new D-block · permissible but anti-cherry-pick disclosure
required].

### G43..G46 proposed shape (Framing A)

| gate | scope | parent mirror | est |
|---|---|---|---|
| G43 | D121 PASS criterion re-evaluation track decision (Path (i) kernel refinement vs Path (ii) oracle-criterion D-block · pre-code decision gate · code 0 · new D-block D122 for the chosen track) | (no direct parent — first **resumption-track** decision · κ-68 G27 / κ-69 G32 / κ-70 G36 / κ-71 G40 are *new-cell pick* decisions · this is a *same-cell criterion-track* decision · different shape · honest first instance) | 0.3-0.5 session |
| G44 | substrate kernel refinement land (Path (i) · `power_curve_kernel.hexa` v0.1.0 → v0.2.0 · multi-segment quadratic OR sigmoidal-on-rated · hexa-lang PR mirror PR #308 pattern · cross-impl parity vs Python ref) **OR** oracle-criterion D-block (Path (ii) · operating-regime weight by energy yield · Weibull · etc. · code-only-if-producer-update-needed) | G31 substrate-land mirror (Path i) · κ-68 G27 D-block-only mirror (Path ii) | 1-2 session (Path i) · 0.3 session (Path ii) |
| G45 | G41 resumption — re-measure with refined kernel OR refined oracle · `absorbed=true` flip IF new mean_rel_err PASSes new threshold · D-block D123 (resumption result) · 4th cell flip LEGITIMATELY landed | κ-71 G41 mirror · same record type (`EnergyWindVerifyRecord` · already exists · NO new record) | 0.5-1 session |
| G46 | κ-72 R11 closure 박제 (4/4 LANDED if G45 PASS · or PARTIAL again if not · `project.tape @D d6` 4-carrier audit framing carry · "flip LANDED" replaces "flip DEFERRED") | κ-71 G42 closure mirror with success-replacement narrative | 0.3-0.5 session |

### Pros (A)

- **Closes the only open `[~]` in R10..R11** — earns the 4th legitimate flip honestly · R4 invariant + g3 fulfilled.
- **No new VerifyRecord cost** — `EnergyWindVerifyRecord` already lives · 5-fold lock-in already done in D120 · only the kernel OR oracle criterion changes.
- **Honest partial-closure precedent gets matching honest resumption** — κ-71's "deferred" was not "abandoned" · the design respected R4 by NOT pretending PASS · κ-72-A is what makes that respect visible (the deferred flip eventually lands).
- **Substrate floor no longer ZERO** — PR #308 MERGED gives κ-72-A a 1-step shorter critical-path than κ-71 had (substrate kernel exists · refinement is additive).
- **Smallest scope** — single cell · single record type · single PASS criterion (or its honest re-derivation).
- **Strongest signal for the design** — "even when the first flip didn't PASS, the system finished the round honestly."

### Cons (A)

- **Stays on a single cell** — no new domain coverage · no 5th record-type audit instance (4th already strongest evidence · 5th is redundant confirmation per κ-71 research note).
- **Path (i) kernel refinement** introduces a 2nd kernel form (multi-segment quadratic / sigmoidal-on-rated) alongside IEC cubic-interp — substrate becomes "which curve form does the kernel implement?" decision. Honest disclosure cost.
- **Path (ii) oracle relaxation** carries cherry-pick risk — D121 explicitly notes "this is a redefinition of PASS criterion and requires its own D-block — NOT done unilaterally here." Any G43 Path (ii) D-block must disclose the redefinition honestly.
- **Doesn't add 5th record-type to G30 invariant audit** — generalization evidence ceiling unchanged from κ-71 (4-record audit already confirmed by construction).
- **Subjective**: κ-72 = κ-71 cleanup may feel like backtracking rather than forward motion · the *value* is exactly the absence of that feeling-bias in the design (honest > visible-progress).

## Framing B — κ-72 = 5th cell (new domain · Bio / Chem / Matter / Component)

**Thesis**: the per-cell measured-oracle round is the load-bearing
research vehicle · κ-72 opens a new cell. Bio (#2 in κ-71 G39
research) and Chem (#3) are unspent · κ-72 picks one. G41 stays
DEFERRED indefinitely with D121 as the honest record (DEFERRED is not
a bug — it's how the design preserves R4 against marginal data).

### G43..G46 proposed shape (Framing B)

| gate | scope | parent mirror | est |
|---|---|---|---|
| G43 | 5th cell candidate research 박제 (κ-71 G39 successor · Bio/ECG #1 + Chem/Arrhenius #2 + new finalist #3 [Matter/component]) · 5-fold lock-in articulation · ranking advisory only | κ-71 G39 mirror | 0.3 session |
| G44 | 5th cell pick + measured-oracle 5-fold lock-in decision (D122 자연 순서 · κ-68 G27 / κ-69 G32 / κ-70 G36 / κ-71 G40 동형) | κ-71 G40 mirror | 0.3-0.5 session |
| G45 | 5th cell 첫 `absorbed=true` legitimate flip (D123 · 5-record-type invariant audit · κ-71 G41 mirror but WITH the PARTIAL risk explicitly acknowledged in scope) | κ-71 G41 mirror · honestly note PARTIAL risk in scope | 1-3 session |
| G46 | κ-72 R11 closure 박제 (4/4 LANDED OR honest PARTIAL again · κ-71 G42 mirror) | κ-71 G42 closure mirror | 0.3-0.5 session |

### Pros (B)

- **5th record-type instance** — further generalization evidence (4-record audit is strongest · 5th is redundant confirmation · still positive marginal signal).
- **New domain coverage** — Bio (first NEW DOMAIN cell ever · 4-domain progression) OR Chem (NEW DOMAIN · Stage-0 → Stage-2 promotion vehicle).
- **Direct successor pattern** — κ-68 → κ-69 → κ-70 → κ-71 → κ-72 each opened a new cell · maximum continuity.
- **Bio option-b shape** — discrete-integer rel_err=0 = new 4th PASS shape (alongside D110 prediction · D117/D119 numeric-equivalence · D121 prediction-w-gap). Honest shape diversity.

### Cons (B)

- **Leaves G41 open indefinitely** — D121 is the honest record but the system carries an open `[~]` round-marker forever · gh-stack mental load.
- **Structural-floor cost** — Bio needs new `BioVerifyRecord` (~120 line schema) OR uses `pilot-bio_align_nw` 36/36 substrate. Chem needs new `ChemVerifyRecord` (~120 line) AND has Stage-0 substrate floor weakness. Both heavier than κ-71 was (κ-71 had 1 new record + 1 new kernel · κ-72-B has 1 new record + bridge stack + possibly new kernel).
- **Doesn't earn the deferred 4th flip** — κ-71's "honest partial" stays partial.
- **κ-72 G45 inherits κ-71's PARTIAL risk** — once one round lands PARTIAL, the same can happen again · explicit PARTIAL-risk disclosure required in G45 scope.
- **5th audit instance marginal value is low** — 4-record audit is already the strongest evidence cycle · 5th adds redundant confirmation only.

## Framing C — hybrid (κ-72 = Framing A · κ-73 = Framing B · sequence)

**Thesis**: do both, in order. κ-72 closes G41 (Framing A · D122/D123 ·
4 G-item · 4/4 LANDED if flip PASSes) · κ-73 opens 5th cell (Framing
B · D124+ · 4 G-item).

### G43..G46 proposed shape (Framing C)

Identical to Framing A's G43..G46 shape for κ-72. κ-73 R12 = Framing
B applied (G47..G50). Note that κ-72's G46 closure must include "next
horizon (κ-73+)" placeholder that names the 5th-cell candidate
cluster — this is the standard horizon-handoff mechanism (κ-68 →
κ-69 → κ-70 → κ-71 → κ-72 closure entries each named the next).

### Pros (C)

- **Strict ordering** — close open round first, then open new one. R4-respecting design also respects "no orphan partial rounds."
- **κ-72 critical-path matches Framing A** — smallest scope · fastest to 4/4.
- **κ-73 starts from a clean 4/4 baseline** — easier to estimate and scope.
- **Captures both Framing A and Framing B value over 2 rounds** — no false choice.

### Cons (C)

- **Pushes the 5th-cell new-domain signal one round further** — Bio/Chem candidate research carry stretches κ-68→κ-69→κ-70→κ-71→κ-72→κ-73 (Bio is now 4-round carry from κ-69 G32).
- **Identical to Framing A for κ-72 narrowly** — Framing C is "Framing A this round + commit to Framing B next round." If next session changes its mind on κ-73, Framing C reduces to Framing A.
- **κ-73 may itself land PARTIAL** — the precedent now is "honest PARTIAL is OK" · κ-73 could repeat the pattern.

## Comparison table

| factor | Framing A (G41 resume) | Framing B (5th cell) | Framing C (hybrid · A then B) |
|---|---|---|---|
| closes G41 [~] | **yes (this round)** | no (indefinite) | **yes (this round)** |
| 5th record-type audit | no | **yes** | yes (κ-73) |
| new domain coverage | no | **yes (Bio or Chem)** | yes (κ-73) |
| code/schema cost | low (refinement OR D-block) | high (new record + bridge) | low this round · high next round |
| substrate floor | floor exists (PR #308 land · refine) | Bio: 36/36 strong · Chem: Stage-0 weak · Matter: TBD | floor exists this round |
| precedent affirmed | "honest partial gets honest resumption" | "DEFERRED is final unless explicitly resumed" | both |
| critical-path | shortest | longest (κ-71 was the heaviest yet · 5th cell can be heavier still if NEW DOMAIN) | shortest this round · medium total |
| PARTIAL risk | low (refinement is principled · PASS in single-cell control loop) | medium-high (κ-71 G41 risk repeat · new substrate + new record + new oracle) | low this round · medium next |
| "no abandonment" honest signal | **strongest** | weakest | strongest |
| 4-domain progression continuity | broken (κ-72 = κ-71 cleanup) | preserved (4 → 5) | broken this round · resumed κ-73 |
| 1-commit landability | yes (G43-G46 all small) | no (G45 needs sub-cycles) | yes for κ-72 · κ-73 sub-cycles separate |

## Recommended framing (advisory · pick belongs to G44 in next session)

**RANK proposal**: Framing **A** for κ-72 · with documented Framing C
as the "if G45 PASSes 4/4 then κ-73 should follow Framing B" follow-on.

### Why Framing A is recommended

1. **Honest precedent affirmation** — κ-71's PARTIAL was the design
   working correctly under R4. κ-72-A is what makes that work
   *visibly land* (the deferred flip eventually arrives via the
   principled resumption path). Choosing Framing B would say "PARTIAL
   = abandon" by neglect, which is not what the design intends.
2. **Lowest cost this round** — no new record type · no new bridge ·
   only kernel refinement OR D-block-only oracle relaxation. The
   substrate floor exists now (PR #308). κ-72-A is the *easiest*
   round of κ-68..κ-72 by structural weight.
3. **PARTIAL risk lowest** — refinement is principled · the failure
   mode is "refined kernel still doesn't PASS" → another PARTIAL · but
   the data flow is clean (single kernel · single oracle · single
   metric).
4. **5th-cell value is preserved as κ-73** — Framing C documents that
   the 5th-cell new-domain signal is *deferred · not lost* · symmetric
   to how κ-71's flip is deferred-not-lost.
5. **Closes a measurable open `[~]`** — gh-stack mental load reduced.

### What would flip Framing B to the recommendation

- If the user's explicit goal is "earn first NEW DOMAIN cell signal in
  κ-72" (4-domain → 5-domain progression in the next round) → B.
- If the user judges that G41's DEFERRED is fine as the canonical
  record (D121 carries the honest narrative · no resumption needed) →
  B with G41 staying `[~]` indefinitely.
- If kernel refinement (Path i) is judged out-of-scope for demiurge
  (kernel refinement is a hexa-lang/stdlib axis · not a per-cell
  measured-oracle axis) → B (this is a legitimate scope argument · the
  refined kernel is `stdlib/kernels/wind/power_curve_kernel.hexa` v0.2.0
  which is hexa-lang substrate work · could be lifted out of demiurge
  G-rounds entirely).

### What would flip Framing C to the recommendation

- If next session has clear bandwidth for 2 rounds (κ-72 + κ-73) and
  wants to lock in the 5th-cell sequence ahead of time → C.
- If "closure-first then expansion" is the desired explicit policy
  (analogous to "test-first then code") → C.

## 5-fold lock-in proposal (if Framing A finalizes)

For G43 decision in next session · advisory only · D-block (D122) will
make this binding.

| dimension | Framing A G43 default proposal |
|---|---|
| **track** | Path (i) kernel refinement · multi-segment quadratic OR sigmoidal-on-rated · principled · D121 explicitly names this as the principled path |
| **substrate land** | hexa-lang `stdlib/kernels/wind/power_curve_kernel.hexa` v0.1.0 → v0.2.0 · add a second curve form (default: piecewise-quadratic with rated transition smoothing OR sigmoidal-on-rated) · IEC cubic-interp stays as `cubic_interp` API · new `manufacturer_fit` API added · cross-impl parity vs Python ref on each |
| **oracle reuse** | reuse Vestas V90-2.0MW manufacturer-published power curve (D121 oracle · already fetched · honest re-measurement on same dataset) |
| **hexa-native scope** | `manufacturer_fit` kernel API · same `power_curve_kernel.hexa` namespace · v0.2.0 SemVer MINOR (additive · cubic_interp preserved) |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over `wind_speed ∈ [4,25] m/s` (D120 PASS criterion **unchanged** · so the flip is honest re-measurement on a refined kernel · NOT a redefinition of PASS) |

### Honest disclosure (must accompany G43 D122)

- Layer 1 — **what changed**: kernel form (not oracle · not threshold · not dataset).
- Layer 2 — **why the cubic-interp didn't PASS**: IEC reference curve is a simplified analytical reference (P ∝ v³ between cut-in and rated) · manufacturer curves include drivetrain efficiency curve + rated-transition smoothing that cubic-interp does not model · this is *expected* not a bug.
- Layer 3 — **why the refinement is principled not cherry-picked**: D121 Path (i) explicitly named this · 2nd-curve-form is additive (cubic_interp preserved as v0.1.0 API) · IEC reference remains as the reference · refinement is the *manufacturer-fit* API alongside.
- Layer 4 — **what does NOT change**: D120 PASS criterion (0.05 over [4,25]) · oracle (Vestas V90-2.0MW) · record type (`EnergyWindVerifyRecord`) · R4 invariant predicate.

### 5-fold lock-in proposal (alternative · Framing B finalizes)

For G44 decision in next session · advisory only · default = Bio per
κ-71 G39 #2 rank.

| dimension | Framing B G44 default proposal (Bio · #2 in κ-71 G39 research) |
|---|---|
| **cell** | new `BioVerifyRecord.swift` (cockpit · ~120 line · `EnergyVerifyRecord` 1:1 mirror · 5th record-type carrier · `hexaNativeParity` + `measuredOracle` 둘 다 from-start) + `domains/bio.md` (D81 신규 도메인 · sibling `~/core/hexa-bio/` docs-only D116) |
| **external oracle** | PhysioNet MIT-BIH Arrhythmia Database (48 ECG record · 360 Hz · CC-BY anonymous wget · Aura Sleep-EDF 동형 floor) — R-peak interval prediction. OR Durbin §2.3 sequence-alignment fixture (option b · `pilot-bio_align_nw` 36/36 reuse · discrete-integer exact-match shape) |
| **bridge stack** | (option a · ECG) `stdlib/bio/mitbih_fetcher.py` + `stdlib/bio/qrs_detector_measured_oracle.py` · Aura sleep_edf 1:1 mirror · `pilot-dft_naive` 17/17 partial floor · (option b · NW) reuse `pilot-bio_align_nw` substrate · 신설 0 |
| **hexa-native scope** | (option a) new `stdlib/kernels/signal_proc/qrs_detector.hexa` (Pan-Tompkins 1985 · ~3 session) · (option b) `pilot-bio_align_nw` reuse (substrate floor zero · 신설 0) |
| **PASS criterion** | (option a) `mean_rel_err ≤ 0.05` on R-peak interval (RR-interval ms) over N=100 QRS events from `mitbih_100` · (option b) `rel_err = 0` exact (integer DP score match · 새 4th PASS shape · D110/D117/D119/D121 의 floating-point spectrum 에 discrete-integer 추가) |

Caveat: κ-72-B 5-fold defaults inherit κ-71 G39 research §Candidate-B
proposals · evolved only by "Bio is now 4-round carry from κ-69" and
"`pilot-bio_align_nw` floor still 36/36 PASS."

## Open questions for next session's G43/G44 decision

1. **Which framing**? A · B · C? Framing A is recommended · B and C
   are honest alternatives. The decision belongs to G44 (or G43 if
   Framing A) — not to this note.

2. **(if A) Path (i) kernel refinement vs Path (ii) oracle relaxation**?
   Recommended default = Path (i) per D121 explicit "principled path."

3. **(if A · Path i) curve form**: multi-segment quadratic vs
   sigmoidal-on-rated vs piecewise-cubic with rated smoothing? D122
   should explore one form first · others can be added in subsequent
   versions.

4. **(if A) what to do if G45 still PARTIAL**? Recommended:
   honest 3/4 + G45 [~] PARTIAL CLOSURE (κ-71 pattern repeat · this
   would establish that PARTIAL is *not unique to κ-71* · which is
   honest signal in itself).

5. **(if B or C) Bio vs Chem vs Matter**? Recommended default per
   κ-71 G39 research = Bio (option b NW for substrate floor zero ·
   OR option a ECG for prediction-shape signal).

6. **(if C) explicit κ-73 commit**? Recommended: ARCH §11.8 scaffold
   in κ-72 closure entry (κ-71 G42 → §11.7 mirror) names κ-73 cell
   candidate cluster without picking.

7. **D-number**: D121 is max · next D122. κ-72 G43 scaffold itself
   does NOT need D-block (per κ-69/70/71 scaffolds · D-block lands at
   G44-equivalent · so Framing A's G43 carries D122 [resumption-track
   decision] · Framing B's G44 carries D122 [5th cell pick] · Framing
   C's G43 = Framing A's G43 = D122 [resumption-track] then κ-73's
   G47 = D124 [5th cell pick]).

## Cross-references

- ARCH.md §11.7 Round 11 G43..G46 (본 horizon-scaffold · sibling commit) · §11.6 Round 10 G39..G42 (κ-71 R10 · G39 `[ ]` / G40 `[x]` D120 / G41 `[~]` D121 PARTIAL / G42 `[x]`) · §11.5 Round 9 G35..G38 (κ-70 R9 4/4 CLOSURE · template for "next horizon (κ-72+)" line) · §11.4 (Round 7/8 grandparent templates)
- design.md D109/D110 (κ-68 G27/G29 · prediction-shape) · D115/D117 (κ-69 G32/G33 · numeric-equivalence) · D118/D119 (κ-70 G36/G37 · numeric-equivalence) · D120 (κ-71 G40 cell-pick · 5-fold lock-in · PASS criterion baked-in) · **D121** (κ-71 G41 PARTIAL · the precedent this note builds on · resumption paths (i)/(ii)/(iii) baked-in) · D106 (illustrative-physics gate · Fusion mc_transport carve-out · permanent) · D103 (dimension-separation) · D86 (no hardcoded data) · D80 (endpoint rule)
- `inbox/notes/2026-05-22-k71-horizon-candidate-research.md` (κ-71 G39 candidate-research · 본 note 의 candidate carry source · Bio/Chem 5-fold lock-in proposal · ranking advisory) · `inbox/notes/2026-05-22-k71-g41-substrate-LANDED.md` (κ-71 G41 substrate sub-phase · superseded into D121)
- PLAN.md κ-71 R10 G40/G41/G42 closure entry (2026-05-22 · `c82fe0e` · `## 진행 로그`) — "next horizon (κ-72+)" obligation that κ-72 fulfills
- `cockpit/Sources/DemiurgeCore/Models/EnergyWindVerifyRecord.swift` (κ-71 G41 schema · κ-72-A reuses · κ-72-B does not touch) · `cockpit/Sources/DemiurgeCore/Models/MeasuredOracleRef.swift` (G28 schema · κ-72 G45 instantiates if Framing A · OR new instantiation if Framing B)
- `cockpit/Tests/DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` (4-record-type audit · κ-72-A: 4-record reused · κ-72-B: 5-record extension)
- `domains/PILOTS.demi` (`pilot-power_curve` exists now post-PR-308 · κ-72-A substrate floor non-zero · `pilot-bio_align_nw` 36/36 · `pilot-chem_arrhenius` 6/6 self-test)
- hexa-lang PR #308 (`power_curve_kernel.hexa` v0.1.0 MERGED · `2b4fc695`) · PR #320 (producer · still OPEN pending hexa-lang bootstrap CI re-stabilization · orthogonal to κ-72 design)
- proposals/rfc_013_hexa_native_parity_connection.md §6.11 (LANDED · κ-72 = same-invariant fifth-instance generalization audit if Framing B · OR 4-record-audit-stable + flip-resumed if Framing A · RFC status 미flip)

## g3 honest invariants

- 본 note 는 **decision 가이드 only** · 어떤 framing 도 pick 안 함 · Framing A 추천 (advisory) · 결정은 next session 의 G43 (Framing A) 또는 G44 (Framing B/C).
- D-block 미생성 (κ-71 G39 scaffold opening 도 D-block 없이 land · κ-68/κ-69/κ-70 scaffold 도 동일 · D-block 은 G43/G44 시점 land = D122 자연 순서 · `grep -nE '^### Decision' design.md | tail -1` = D121 확인).
- 어떤 cell 의 `absorbed=true` 도 flip 안 함 · κ-71 G41 의 `[~]` PARTIAL 상태 유지 (κ-72-A G45 시점까지 deferred · κ-72-B 채택 시 indefinite).
- κ-72 R11 의 모든 framing 은 PARTIAL 가능성을 명시 인정한다 — κ-71 R10 precedent 가 "honest PARTIAL is OK" 를 설정 · κ-72 가 PARTIAL 로 land 해도 design 실패 아님 · R4 invariant 가 작동하는 증거.
- κ-71 G39 research note 의 Candidate B (Bio) + C (Chem) 는 κ-72 carry — Framing B/C 채택 시 그 노트의 5-fold lock-in 본문이 직접 evolved source.
- D106 illustrative-physics gate 적용 cell (Fusion `mc_transport` · Ufo Stage-4..7 propulsion · `FusionVerifyRecord` 영구-잠김) 은 본 round 의 `absorbed` flip 후보에서 **명시 제외**.
- D95 computed projection 만으로 만족하는 cell 은 **measurement-parity 아님** — κ-72 의 점이 아님.
- ChipAnalyze (chip §B substrate-axis · §12.1 active in `~/core/hexa-lang` · 다른 agent · cross-axis 충돌 회피) 는 본 round 의 scope 외 ([[feedback-parallel-agent-cap]] — 본 cycle 은 Track A + Track B 와 병행 = 3 total).
- D106 illustrative cell 는 candidate 에서 제외 · Framing B/C 의 5th-cell candidate cluster 도 non-illustrative only.
- "impossibility framing" 회피 ([[feedback-no-impossibility-framing]]) — Framing B 의 PARTIAL risk 은 "확률적 가능성" 으로 disclose · "불가능" 으로 framing 금지.
- D-number stale rule respected ([[feedback-d-number-stale-in-handoff]]) — D121 max 확인 · D122 가 G43/G44 의 자연 다음.
