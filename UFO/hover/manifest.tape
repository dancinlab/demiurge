@V := "tape" :: spec [active]
  version = "1.0"

@I := "ufo/hover" :: identity [active]
  kind     = "UFO Stage-1 Meissner levitation absorb manifest (HEXA-HOVER axis)"
  icon     = "🛸"
  alias    = "hover"
  brief    = "RTSC 48T 솔레노이드 + 비행체 하부 HTS plate 의 Meissner 반자성 부상 (0~20km)"
  parent   = "UFO"
  ssot     = "~/core/hexa-ufo/HEXA-HOVER.md + ~/core/hexa-ufo/HOVER.md (사양 reference) · ~/core/hexa-lang/stdlib (계산 SSOT)"
  siblings = "UFO/grav · UFO/cloak · UFO/teleport · UFO/sim"

@D h1 := "흡수 = 사양 manifest 만" :: governance [required active]
  do   = "본 디렉터리는 사양 manifest reference 만 유지 — 자석/도체/안정성 결정 라인 + cross-link"
  dont = "levitation 계산 / 시뮬 코드 본 디렉터리에 두지 마라 (canonical home = hexa-lang/stdlib 또는 hexa-ufo)"

@D h2 := "자석 substrate = RTSC.md" :: governance [required active]
  do   = "B-field · ∇B · solenoid geometry 는 RTSC.md (device=솔레노이드 · conductor=HTS REBCO) consume"
  dont = "본 hover manifest 안에서 자석 spec 자체를 다시 정의 (중복 · @D d4 위배)"

@D h3 := "도체 1차 = HTS REBCO" :: governance [required active]
  do   = "1차 absorb = HTS REBCO (77K LN₂) · 궁극 목표 = RT-SC (RTSC §8.4 9-test PASS 시 자동 승격)"
  dont = "Cu 상전도 도체 가정 (|χ|≈10⁻⁵ 부상력 부족)"

@D h4 := "active stabilization 필수" :: governance [required active]
  do   = "active coil (6-DOF PID μ=1ms) + gyro (n=6 60° rotor) + flux pinning hybrid"
  dont = "정자기 만으로 자유공간 정지 부상 가정 (Earnshaw 정리 위배)"

@absorb := "HEXA-HOVER axis" :: status [active]
  source        = "~/core/hexa-ufo/HEXA-HOVER.md (706 LOC) + HOVER.md (733 LOC)"
  source_sha1   = "a5f60e2 (HEXA-HOVER) · acd19cc (HOVER)"
  absorbed_date = "2026-05-25"
  scope         = "spec manifest only (계산 코드 = SSOT canonical home)"
  cross_link    = "RTSC.md (자석) · FUSION.md (Stage-2 인계) · UFO.md (parent domain)"
