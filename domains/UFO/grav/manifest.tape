@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/grav" :: identity [active]
  kind     = "UFO Phase B HEXA-GRAV 축 흡수 manifest (gravity-wave + quantum-gravity-sensor)"
  icon     = "🛸"
  alias    = "grav"
  brief    = "GW 검출/통신 (LIGO 미니어처) + atom-IF/SQUID 관성 보강 sensor 비행체 통합 사양"
  parent   = "UFO"
  ssot     = "UFO/HEXA-GRAV.md + UFO/{hexa-grav,gravity-wave-canon,quantum-gravity-sensor-canon}/ (사양 reference) · hexa-lang/stdlib (계산 SSOT)"
  siblings = "UFO/hover · UFO/sim · UFO/cloak · UFO/teleport"

@D g1 := "흡수 = 사양 manifest 만" :: governance [required active]
  do   = "본 디렉터리는 GW + QGS 사양 manifest reference 만 유지 — 검출/통신/IMU+ 결정 라인 + cross-link"
  dont = "GW arm finesse · atom-IF Mach-Zehnder · SQUID DC 계산 코드 본 디렉터리 작성 (canonical home = hexa-lang/stdlib 또는 UFO/hexa-grav)"

@D g2 := "EM/관성 separation 필수" :: governance [required active]
  do   = "RTSC 자장 (1-48 T) 과 GW arm/atom-IF 사이 mu-metal × 5 layers + 거리 σ-φ=10 m + active null"
  dont = "RTSC 솔레노이드 자장이 atom-IF/SQUID floor 잠식 가정 (cross-talk 0 절대 요건)"

@D g3 := "비행체 미니어처 = 광등가 길이" :: governance [required active]
  do   = "GW arm 물리 1-10 m + SC 미러 finesse F=σ·τ=48 → 광등가 42 km · h ~ 10⁻²³ target"
  dont = "LIGO 지상 4 km arm 비행체 그대로 탑재 가정 (질량/공간 σ·τ=48× 초과)"

@D g4 := "falsifier preregister — 감도 미달 시 즉시 폐기" :: governance [required active]
  do   = "GW h > 10⁻²² OR atom-IF Δg > 10⁻¹⁰ g OR SQUID > 10 fT/√Hz @ 1 Hz → 사양 폐기 + breakthrough path 2-3 surface"
  dont = "감도 부족을 wet-lab 사후로 미루어 absorbed=true (@D d5 위배) · `partial` 잔여 (@D d1 위배)"

@A absorb_hexa_grav := "HEXA-GRAV axis absorbed into UFO/grav" :: status [d=2026-05-25 active]
  source        = "UFO/HEXA-GRAV.md (653 LOC) + UFO/hexa-grav/hexa-grav.md (656 LOC) + UFO/gravity-wave-canon/gravity-wave.md (855 LOC) + UFO/quantum-gravity-sensor-canon/quantum-gravity-sensor.md (861 LOC)"
  source_sha1   = "2d9c00d (HEXA-GRAV) · a1843b8 (hexa-grav) · 78e0244 (gravity-wave) · a99655a (QGS)"
  absorbed_date = "2026-05-25"
  scope         = "spec manifest only (계산 코드 = SSOT canonical home)"
  cross_link    = "RTSC.md (자석 cross-talk) · FUSION.md (Stage-2 진동) · ANTIMATTER.md (Stage-3 EMI) · UFO.md (parent domain)"

@C cross_link := "UFO/grav cross-link map" :: link [active]
  rtsc      = "RTSC.md — 자장 cross-talk source · mu-metal 차폐 spec 인수"
  fusion    = "FUSION.md — Stage-2 cruise MHD 진동 source"
  antimatter = "ANTIMATTER.md — Stage-3 γ-rocket EMI + Pb 차폐 spec"
  ufo       = "UFO.md — Phase B 부수 5축 중 3/5 (HEXA-GRAV)"
  stdlib    = "hexa-lang/stdlib — sensor / interferometer / SQUID 구현 SSOT (코드 home, @D d3)"
