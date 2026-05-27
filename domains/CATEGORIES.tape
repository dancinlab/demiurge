# CATEGORIES.tape — 5 category × 20 frontier domain index
# demiurge pointer manifest (d3) · drives GUI category tree + status badges
# Source: WEB_GUI_DESIGN.md Q16 + STDLIB_MATRIX.tape

@V := "categories" :: index
  version = "1.1"
  origin  = "2026-05-28 PR#0 stdlib-matrix-index · SYSTEM dropped per user"
  scope   = "20 runnable research domains · 5 categories · landing page untouched"

@C atom := "🔬 ATOM" :: category [active]
  icon    = "🔬"
  name    = "ATOM"
  alias   = "원자·입자·양자"
  members = [ "qubit", "antimatter", "fusion" ]

@C matter := "🧱 MATTER" :: category [active]
  icon    = "🧱"
  name    = "MATTER"
  alias   = "벌크·박막 물질"
  members = [ "perovskite", "graphene", "rtsc", "metamaterial", "aerogel", "spintronic", "memristor" ]

@C chip := "🪪 CHIP" :: category [active]
  icon    = "🪪"
  name    = "CHIP"
  alias   = "회로·광 디바이스"
  members = [ "neuromorphic", "photonic" ]

@C bio := "🧬 BIO" :: category [active]
  icon    = "🧬"
  name    = "BIO"
  alias   = "유전·단백·세포"
  members = [ "gene-edit", "rna-therapy", "organoid", "protein-fold" ]

@C chemistry := "⚗️ CHEMISTRY" :: category [active]
  icon    = "⚗️"
  name    = "CHEMISTRY"
  alias   = "반응·촉매·흡착"
  members = [ "electrocat", "photoredox", "co2-capture", "green-nh3" ]

@I rollup_categories := "membership-counts" :: index [active]
  atom_n      = 3
  matter_n    = 7
  chip_n      = 2
  bio_n       = 4
  chemistry_n = 4
  total       = 20
  note        = "20 runnable frontier · SYSTEM/META 별도 미포함 · 랜딩페이지는 별 인덱스"
