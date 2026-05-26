@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/cloak" :: identity [active]
  kind     = "UFO Phase B HEXA-CLOAK 축 흡수 manifest (transformation optics + metamaterial + radar/optical stealth)"
  icon     = "🛸"
  alias    = "cloak"
  brief    = "비행체 EM 가시성 차단 layer — ε-μ tensor metamaterial shell + RCS 감소 + IR 억제 사양"
  parent   = "UFO"
  ssot     = "UFO/HEXA-CLOAK.md + UFO/{CLOAK.md,cloak,cloak-canon,hexa-cloak}/ (사양 reference) · hexa-lang/stdlib (계산 SSOT)"
  siblings = "UFO/hover · UFO/sim · UFO/grav · UFO/teleport"

@D c1 := "흡수 = 사양 manifest 만" :: governance [required active]
  do   = "본 디렉터리는 transformation-optics + metamaterial + stealth 사양 reference 만 유지 — 결정 라인 + cross-link"
  dont = "ε-μ tensor / metamaterial FDTD / RCS 산출 코드 본 디렉터리 작성 (canonical home = hexa-lang/stdlib 또는 UFO/hexa-cloak)"

@D c2 := "이중 layer — transformation cloak + 공학 stealth 상보 적층" :: governance [required active]
  do   = "transformation-optics 완전 우회 (협대역) + radar/optical stealth (RCS/IR, 광대역) 두 layer 상보 적층"
  dont = "협대역 transformation cloak 만으로 전대역 가시성 차단 가정 (metamaterial dispersion 한계)"

@D c3 := "Stage 추진 EM 누설 vs cloak 양립성 필수" :: governance [required active]
  do   = "RTSC B(Meissner self-shield) · MHD/γ-rocket RF EMI(Faraday cage+band-stop) · IR plume(cryo+방사율) 누설 격리"
  dont = "능동 radar/통신 송신이 cloak band 침범 가정 (LPI waveform + GW 통신 대체 · stealth 천적은 능동 방출)"

@D c4 := "falsifier preregister — 차폐 미달 시 즉시 폐기" :: governance [required active]
  do   = "RCS > 10⁻⁵ m² OR 대역 < 2 octave OR IR 억제 < 5 dB → 사양 폐기 + breakthrough path 2-3 surface"
  dont = "차폐 부족을 wet-lab 사후로 미루어 absorbed=true (@D d5 위배) · `partial` 잔여 (@D d1 위배)"

@A absorb_hexa_cloak := "HEXA-CLOAK axis absorbed into UFO/cloak" :: status [d=2026-05-25 active]
  source        = "UFO/HEXA-CLOAK.md (678 LOC) + UFO/CLOAK.md (948 LOC) + UFO/cloak/hexa-cloak.md (471 LOC) + UFO/cloak-canon/cloak.md (698 LOC) + UFO/hexa-cloak/hexa-cloak.md (474 LOC)"
  source_sha1   = "7efd741 (HEXA-CLOAK) · 8d855b9 (CLOAK) · 3cdb0e6 (cloak/hexa-cloak) · 5076cce (cloak-canon) · ad9ba0e (hexa-cloak)"
  absorbed_date = "2026-05-25"
  scope         = "spec manifest only (계산 코드 = SSOT canonical home)"
  cross_link    = "RTSC.md (RT-SC 도체 ε<0 · Meissner self-shield) · FUSION.md (Stage-2 MHD EMI) · ANTIMATTER.md (Stage-3 γ-rocket EMI) · UFO.md (parent domain)"

@C cross_link := "UFO/cloak cross-link map" :: link [active]
  rtsc       = "RTSC.md — RT-SC 도체 사양 인수 (ε<0 공명 · Meissner self-shield)"
  fusion     = "FUSION.md — Stage-2 cruise MHD 방전 RF EMI source"
  antimatter = "ANTIMATTER.md — Stage-3 γ-rocket EMI + γ-shield source"
  structure  = "UFO/structure — frame OML radar/EM caveat · HEXA-CLOAK overlay 적층 슬롯"
  grav       = "UFO/grav — cryo 인프라 공유 (IR heat-sink) · GW 통신 (EM-free 송신 대체)"
  ufo        = "UFO.md — Phase B 부수 5축 중 4/5 (HEXA-CLOAK)"
  stdlib     = "hexa-lang/stdlib — transformation-optics / metamaterial FDTD / RCS 구현 SSOT (코드 home, @D d3)"
