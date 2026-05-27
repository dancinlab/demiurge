# PUBLIC_DOMAINS.tape — founder-curated free public domains
# Pointer manifest (d3) · drives /library page (guest readable · member forkable)
# Curator: dancinlab · License: MIT (per-entry overridable)

@V := "public-domains" :: index
  version  = "1.0"
  origin   = "2026-05-28 PR#0 stdlib-matrix-index"
  policy   = "guest=read · member=fork · founder=register/update"
  growth   = "continuous registration — new entries appended over time"

# ── completed entry ────────────────────────────────────────────────────────
@C qubit_v10 := "🧪 QUBIT v1.0" :: public_domain [active]
  curator       = "dancinlab"
  version       = "1.0"
  status        = "🟢 complete"
  composes      = [ "qubit" ]
  hero_verb     = "analyze"
  records_glob  = "exports/qubit/**"
  paper         = "PAPERS/qubit-coherence-2026/"
  license       = "MIT"
  fork_ok       = true
  guest_view_ok = true

# ── WIP entry (HBM composition example · 사용자 도출 응용) ──────────────────
@C hbm_v03 := "🧠 HBM v0.3" :: public_domain [active]
  curator       = "dancinlab"
  version       = "0.3"
  status        = "🟡 WIP"
  composes      = [ "chip", "memristor", "matter" ]
  hero_verb     = "design"
  preset_spec   = "stack=8-Hi · bw≥1024 GB/s · TDP≤15 W"
  license       = "MIT"
  fork_ok       = true
  guest_view_ok = true

# ── permission matrix ──────────────────────────────────────────────────────
@I permissions := "access-roles" :: index [active]
  guest_view    = true   # /library 갤러리 게스트 노출
  guest_fork    = false  # fork 시 회원가입 prompt
  member_fork   = true   # fork 후 자기 private 프로젝트로
  member_edit   = false  # public domain 자체는 read-only
  founder_write = true   # 신규 등록 + version bump

# ── rollup ─────────────────────────────────────────────────────────────────
@I rollup_public := "library-counts" :: index [active]
  complete_n = 1   # qubit
  wip_n      = 1   # hbm
  total_n    = 2
  note       = "continuous growth · founder appends new entries · entries become Public Domain Library cards in /library"
