# UFO — log

Append-only history sister of `UFO.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T13:45:05Z — HEXA-HOVER 축 흡수 LANDED

- [x] source 식별 — `~/core/hexa-ufo/HEXA-HOVER.md` (706 LOC · SHA a5f60e2) + `~/core/hexa-ufo/HOVER.md` (733 LOC · SHA acd19cc)
- [x] `UFO/hover/README.md` 작성 — 7-section 한국어 본문 (TL;DR · source · Meissner closed-form · 자석/도체 사양 · Earnshaw 안정성 · 고도 범위 · cross-link)
- [x] `UFO/hover/manifest.tape` 작성 — @I `ufo/hover` (icon 🛸 · alias `hover`) + @D h1-h4 결정 라인 + @absorb status
- [x] 자석 substrate = `RTSC.md` 48T HTS REBCO 솔레노이드 cross-link (@D d4 단일 dispatch — RTSC 가 자석 SSOT)
- [x] 도체 1차 = HTS REBCO (77K LN₂) · 궁극 = RT-SC (RTSC.md §8.4 9-test PASS 시 승격)
- [x] Earnshaw 정리 → active stabilization 3-경로 hybrid (active coil 6-DOF PID μ=1ms · gyro n=6 60° · flux pinning)
- [x] 고도 범위 0~20km — 지면 안내 레일 (1-10T 국소) · 솔레노이드 grid · 지자기 + 탑재 자석 array
- [x] `UFO.md` Phase B HEXA-HOVER milestone → [x] 플립
- [x] @D d3 준수 — 흡수 = 사양 manifest 만 (계산 코드 = hexa-lang/stdlib 또는 hexa-ufo SSOT)
- [x] @D d10 준수 — icon 🛸 · name `UFO/hover` · alias `hover` 헤더

deferred:
- [ ] Stage-2 cruise 인계 인터페이스 정의 (고도 20km 천이 — hover → MHD)
- [ ] closed-form 부상력 verify 🟢 (`hexa verify --expr F_lev`) → atlas register
- [ ] flux pinning Type-II 정량 (pinning force vs Meissner force 비율)
- [ ] active coil 6-DOF PID 게인 sizing (m=90kg · μ=1ms · ζ=0.7)

