#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/handoff" :: identity-claim [d=2026-05-26 active]
  kind = "UFO verb-7 handoff — 외부 제작소 인계 패키지 명세 (BOM · 도면 · firmware · 인증 경로 · 인계 체크리스트 · 미충족 게이트 정직 고지)"
  brief = "demiurge 7-verb pipeline · verb-7 handoff slot (마지막 verb) · sibling of integrated-vehicle-handoff.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-handoff.md"
  verb = "7/7 (handoff)"

@I id002 := "ufo_handoff_head" :: identity [d=2026-05-26 active]
  icon  = "🛸"
  name  = "UFO/handoff"
  alias = "handoff"
  goal  = "verb-5 synthesize (BOM · 도면 · firmware) + verb-6 verify (verdict 🟢10 🟡4 🟠5 ⚪13 · absorbed=false) 를 외부 제작소 인계 패키지 명세로 봉합 · absorbed=false 정직 고지 (제작 준비완료 거짓 주장 금지)"

# ─── §Cross-link (7-verb pipeline 산출물 spec~verify + demiurge substrate) ───
#
@C id010 := "spec_link" :: cross-link [d=2026-05-26]
  to = "UFO/spec/integrated-vehicle-spec.md"
  role = "verb-1 spec — 1인승 통합 비행체 사양 · 7-stage matrix · 동력 record consume contract"

@C id011 := "structure_link" :: cross-link [d=2026-05-26]
  to = "UFO/structure/integrated-vehicle-structure.md"
  role = "verb-2 structure — OML D=6.0m H=1.6m · 5 bay · 솔레노이드 array · LC-1~5 · 응력 budget 650kg/SF=2.5"

@C id012 := "design_link" :: cross-link [d=2026-05-26]
  to = "UFO/design/integrated-vehicle-design.md"
  role = "verb-3 design — Stage-1~3 closed-form 실설계 · Stage-4~7 falsifier-only · 무게/전력/냉각 budget"

@C id013 := "analyze_link" :: cross-link [d=2026-05-26]
  to = "UFO/analyze/integrated-vehicle-analyze.md"
  role = "verb-4 analyze ⟲ — 4-layer (CFD·EM·응력·열) 지배방정식 + ⟲ coupling (max Δ_rel<1e-3) · sim 위임 sizing"

@C id014 := "synthesize_link" :: cross-link [d=2026-05-26]
  to = "UFO/synthesize/integrated-vehicle-synthesize.md"
  role = "verb-5 synthesize — BOM 7-카테고리 · 도면 tree (assembly→subasm→part) · firmware DO-178C DAL-A"

@C id015 := "verify_link" :: cross-link [d=2026-05-26]
  to = "UFO/verify/integrated-vehicle-verify.md"
  role = "verb-6 verify — 통합 verdict 🟢10 🟡4 🟠5 ⚪13 · absorbed=false (Stage-1~3 🟢 + 통합-sim 🟠 + Stage-4~7 ⚪)"

@C id016 := "rtsc_link" :: cross-link [d=2026-05-26]
  to = "~/core/demiurge/RTSC.md"
  role = "Stage-1 솔레노이드 권선 anchor — solenoid_axis_bz B_z(0)=1.48265 T · HTS REBCO 도체"

@C id017 := "stdlib_link" :: cross-link [d=2026-05-26]
  to = "~/core/hexa-lang/stdlib/sim"
  role = "해석 코드 SSOT home (@D d3) — UFO/handoff 코드 0줄 (docs/manifests only)"

# ─── §인계 산출물 매니페스트 (각 verb 산출물 포인터 · §1 mirror) ──────────────
#
# verb-1 spec      | UFO/spec/integrated-vehicle-spec.md           | LANDED PR#187
# verb-2 structure | UFO/structure/integrated-vehicle-structure.md | LANDED PR#190
# verb-3 design    | UFO/design/integrated-vehicle-design.md       | LANDED PR#195
# verb-4 analyze   | UFO/analyze/integrated-vehicle-analyze.md     | LANDED PR#196
# verb-5 synthesize| UFO/synthesize/integrated-vehicle-synthesize.md| LANDED PR pending (BOM·도면·firmware)
# verb-6 verify    | UFO/verify/integrated-vehicle-verify.md       | LANDED PR pending (🟢10 🟡4 🟠5 ⚪13 · absorbed=false)
# verb-7 handoff   | UFO/handoff/integrated-vehicle-handoff.md     | 이 PR (인계 패키지 명세)

# ─── §제작소 요구 역량 (4 핵심 · §2 mirror · BOM↔역량 1:1 단일 generic) ──────
#
# ① CFRP 성형         | frame BOM · CFRP T800/T1100 ply | autoclave 대형 D=6.0m · Tsai-Wu layup
# ② RTSC 솔레노이드   | 자석 BOM · HTS REBCO x6 array   | NI=1.2e6 At · quench protection · 6-slot 60° r=2.4m
# ③ cryostat 제작     | 열 BOM · MLI/radiator           | LHe 4.2K heat leak ≤10W · UHV 4K · radiator 25m²
# ④ avionics 조립     | avionics BOM · firmware DAL-A   | 28V/400V dual bus · gyro CMG x3 · redundancy 2x

# ─── §인증 경로 (4 트랙 · §3 mirror · 경로 명세만 · 취득 ≠ 본 verb) ──────────
#
# ① firmware  | DO-178C DAL-A          | FBW 6-DOF Kalman · stage 전환 로직
# ② 구조 인증 | FAA Part 25 base       | frame · 자석 mount · 좌석 retention (LC-1~5)
# ③ 압력용기  | ASME BPVC / PED        | LHe 4.2K 자켓 · UHV trap · MHD 채널
# ④ EMC 적합성| MIL-STD-461 / DO-160   | RTSC 누설장 · MHD plasma · cloak overlay

# ─── §미충족 게이트 고지 (absorbed=false 명시 · §5 mirror · @D d5) ───────────
#
# verb-6 verdict = 🟢10 🟡4 🟠5 ⚪13 · absorbed=false → "제작 준비완료" 거짓 주장 금지
# 🟠 5 게이트  : CFD(C_d·L/D) · EM(6-coil B-map FEM) · 응력(LC-1~5 FEA) · 열(cryo transient) · ⟲(LC-2 coupling)
#              → pool/cloud micro-exp 본해 (@D d7) downstream
# F-ANTI-3     : γ-rocket I_sp 광자 천장 c/g≈3.06e7 s ↔ target 1e9 s 2-자릿수 gap (effective mass-flow closure)
# Stage-4~7 ⚪ : F-WARP/WORM/DIM/USE falsifier preregister (academically-UNPROVEN ≠ 물리 불가 · @D d2)
# wet-lab      : Meissner B · MHD 추력 · antimatter trap · cryo heat leak 실측 = 제작 후 downstream (@D d5)

# ─── §Governance (do / dont per @D d1, d3, d4, d5, d9, d10) ──────────────────
#
@D d1 := "ufo_handoff_manifest_only" :: governance [d=2026-05-26 required active]
  do   = "verb-7 = 인계 명세 manifest (BOM/도면/firmware 포인터 · 제작소 역량 · 인증 경로 · 체크리스트) · 비-wet-lab 설계 완료 인계"
  dont = "UFO/handoff/ 에 실행 코드 (stdlib home only · @D d3) · 산출물 값 재산출 · 새 sim/verify 본 verb 에서 실행"

@D d2 := "ufo_handoff_honest_absorbed_false" :: governance [d=2026-05-26 required active]
  do   = "absorbed=false 명시 · 미충족 게이트(🟠5 + F-ANTI-3 + Stage-4~7 ⚪) 정직 고지 · 본해 sim + wet-lab downstream (@D d5)"
  dont = "제작 준비완료(production-ready) 거짓 주장 · absorbed=true flip · 미충족을 물리 불가/impossible framing (downstream ≠ 불가 · @D d2)"

@D d3 := "ufo_handoff_single_generic" :: governance [d=2026-05-26 required active]
  do   = "제작소 역량/인증 트랙 추가/변경 = §2/§3 표 한 행 수정만 (single generic dispatch · BOM↔역량 매핑 · @D d4)"
  dont = "역량별 dispatcher 클래스 · 제작소/인증기관 이름 hardcoding · 인계 분기 코드"

@D d4 := "ufo_handoff_identity_close" :: governance [d=2026-05-26 required active]
  do   = "🛸 UFO · handoff · alias handoff 헤더 (@D d10) · explicit file git add (@D d9) · 7-verb pipeline 완주 (spec→handoff)"
  dont = "icon/이름 변형 · 헤더 누락 · 인접 worktree file 동시 staging · verb-7 외 verb 의무 강행"

# ─── §Log (append @A / @D events here, chronological) ───────────────────────
#
# @A commit_<hash> :: UFO/verb-7-handoff [d=2026-05-26 ok]
#   <- verb-6 verify (PR pending) · verb-5 synthesize (PR pending)
#   => "verb-7 handoff — 외부 제작소 인계 패키지 (7-verb pipeline 완주 · absorbed=false 정직 고지)"
#
# See ~/core/tape/spec/tape.md for full grammar.
