@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/teleport" :: identity [active]
  kind     = "UFO Phase B HEXA-TELEPORT 축 흡수 manifest (quantum state teleportation protocol)"
  icon     = "🛸"
  alias    = "teleport"
  brief    = "Bell-pair 기반 양자 상태 전송 + entanglement swapping 사양 — 분산 센서 양자 동기화 + QKD 보안 통신 비행체 응용"
  parent   = "UFO"
  ssot     = "UFO/HEXA-TELEPORT.md + UFO/{teleport,hexa-teleport}/hexa-teleport.md (사양 reference) · hexa-lang/stdlib (양자회로/Bell-state 계산 SSOT)"
  siblings = "UFO/hover · UFO/sim · UFO/grav · UFO/cloak"

@D t1 := "흡수 = 사양 manifest 만" :: governance [required active]
  do   = "본 디렉터리는 양자 teleportation 프로토콜 사양 manifest reference 만 유지 — Bell-state · 측정 · 고전채널 · 보정 결정 라인 + cross-link"
  dont = "Bell-pair 생성 · BSM · unitary correction 양자회로 계산 코드 본 디렉터리 작성 (canonical home = hexa-lang/stdlib)"

@D t2 := "정보 ≤ c · 초광속 통신 금지 — honest fence" :: governance [required active]
  do   = "teleportation 은 고전 채널 (≤ c) 2-bit 전송이 필수 — entanglement 단독은 정보를 옮기지 못함 (⚪ no-FTL)"
  dont = "엔탱글먼트로 초광속 통신/즉시 상태 전송 주장 (no-communication theorem 위배) · 600 km 즉시 전송 가정"

@D t3 := "no-cloning — 원본은 전송 중 파괴" :: governance [required active]
  do   = "측정 (BSM) 이 송신측 원본 상태를 붕괴시킴 — 복제 아닌 이전 (Wootters-Zurek 1982 no-cloning 준수)"
  dont = "원본 보존 + 사본 생성 주장 (복제 = no-cloning 위배) · 정보 손실 없는 multi-clone 가정"

@D t4 := "비행체 응용 = 양자 동기화 + QKD" :: governance [required active]
  do   = "분산 센서 양자 상태 동기화 (entanglement distribution) + QKD (BB84/E91) 보안 키 분배 사양으로 한정"
  dont = "teleportation 으로 물질/에너지/사람 전송 가정 (양자 상태 = 정보만) · 측정-without-classical-channel 동작 가정"

@A absorb_hexa_teleport := "HEXA-TELEPORT axis absorbed into UFO/teleport" :: status [d=2026-05-25 active]
  source        = "UFO/HEXA-TELEPORT.md (692 LOC) + UFO/teleport/hexa-teleport.md (440 LOC) + UFO/hexa-teleport/hexa-teleport.md (443 LOC)"
  source_sha1   = "be4ac3d (HEXA-TELEPORT) · 6cb5159 (teleport dir) · b75b778 (hexa-teleport dir)"
  absorbed_date = "2026-05-25"
  scope         = "spec manifest only (양자회로/Bell-state 계산 = SSOT canonical home) · 초광속 통신은 ⚪ SPECULATION-FENCED (물리 한계)"
  cross_link    = "RTSC.md (SC 큐빗 cryo 인프라) · UFO/grav (분산 sensor 동기화) · UFO/sim (양자채널 디지털트윈) · UFO.md (parent domain)"

@C cross_link := "UFO/teleport cross-link map" :: link [active]
  hexa_teleport = "UFO/HEXA-TELEPORT.md — Phase B HEXA-TELEPORT 1차 reference (692 LOC)"
  grav          = "UFO/grav — 분산 GW/관성 sensor 양자 상태 동기화 수요처"
  sim           = "UFO/sim — 양자 채널/decoherence 디지털트윈 검증"
  rtsc          = "RTSC.md — SC 큐빗 (transmon) cryo 인프라 + 자기 차폐 spec 인수"
  ufo           = "UFO.md — Phase B 부수 5축 중 5/5 (HEXA-TELEPORT · 마지막)"
  stdlib        = "hexa-lang/stdlib — Bell-state / BSM / QKD 양자회로 구현 SSOT (코드 home, @D d3)"
