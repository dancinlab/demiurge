# Domain Audit — 2026-05-23

> Cross-domain breadth snapshot. 6개 topical domain (`.md` + `.log.md` 쌍) +
> 1개 cross-cutting absorption-classification doc. 각 도메인의 **current
> stage · last activity · next viable step · status · trigger** 를 한 표로.
> Living current-state snapshot — 매 audit마다 덮어쓰기 (g15 chronicle
> 금지).
>
> snapshot_date: 2026-05-23 KST · audit_scope: `~/core/demiurge/*.md` UPPERCASE
> pairs · method: spec head 30-50줄 + log tail 1-2 entry

---

## 7-domain status table

| domain | stage | last activity | next viable step | status | trigger / dependency |
|--------|-------|---------------|------------------|--------|----------------------|
| **RTSC** | §9.13 capstone 확립 — first-principles SC-evaluation 양축 (Nb ambient measurement-MATCH 9.9K vs 9.25K · H₃S 고-Tc 단조 ladder 0.48→0.85→1.3) · §9 cohort H₃X screen in-flight | 2026-05-22 §9.11.H/I + §9.12 + §9.13 (DFT 돌파 + capstone) · 진행 중 H₃Se(ubu-1) / H₃Te(ubu-2) / H₃Po(chained) 6×6×6 q-grid | (a) H₃Se/H₃Te/H₃Po DFT 결과 수집 → group-16 시리즈 prediction record · (b) 6×6×6 q 수렴 + SSCHA 비조화 보정 (H₃S 잔여) · (c) 적격물질 wet-lab handoff packet (§8.9 5-criteria gate) | **ACTIVE** | 11 vast.ai pod 완주 + ubu-1/2 DFT runs (각 ~10-60min · group-16 시리즈 자동 chain) |
| **MONDALOY** | §9.7 wet-lab handoff packet 완성 — c1 composition table + 2 protocol stubs (investment-cast + LPBF) + characterisation + reproducibility checklist · provisional=true | 2026-05-23 §9.7 wet-lab handoff prep · 2026-05-22 §9.6 forward funnel EXECUTED → 단일 c1 candidate (commits a8020aa / 2dc19d2) | (a) c2 fallback envelope EXECUTE (§9 역설계 alternative) · (b) §9.7 handoff packet → 외부 melter/AM operator inbox handoff (현실 wet-lab 연결) · (c) CALPHAD 1차 검증 sim (§3 pipeline `gate_type=simulation-only-prediction` record emit) | **IDLE** | 사용자 결정 — wet-lab 외부 연결 OR c2 fallback compute OR CALPHAD sim 우선순위 |
| **NUCLEAR** | §6.3 Phase 2 stabilization audit LANDED · 10/10 cell PASS (5 baseline × N6+N7 cohort) · Phase 3 microkernel candidates 식별 (NC1/2/3 Viola-Seaborg + Royer + consensus) | 2026-05-22 Phase 2 stabilization · §6.3 신설 · NC1-3 candidates flagged | (a) Phase 3 microkernel land — N7 `_viola_seaborg_log10_t` / `_royer_log10_t` / `_consensus` hexa-native port (RTSC §9.13 `eliashberg_moments` 패턴 mirror) · (b) Brown 1992 / SemFIS-2 3rd-formula honest-skip 해소 — Denisov-Khudenko 2009 verbatim 대체 · (c) N8/N9/N10 cohort spec 진입 (§4) | **IDLE** | Phase 3 cycle launch — RTSC DFT 부담 없을 때 (pool:ubu-1/2 free baseline @D d8) |
| **MP** | Phase 1 R1 cohort partial complete — 28-entry cache + schema + provenance migration. JARVIS-OPTIMADE landed as 3rd DFT corpus (PR #287 MERGED, 20/20 PASS post-JARVIS) · NOMAD honestly rejected | 2026-05-22 JARVIS land + 20-cell Phase 2 ext matrix 18/20→20/20 PASS (+ OptB88vdW caveat s5) | (a) Phase 2 P2.1 COD CIF parser thin adapter (key-free public-domain · ~hexa-lang/stdlib/material/cod_query.py) · (b) Phase 2 P2.2 AFLOW REST thin adapter (일부 endpoint key-free) · (c) Phase 3 P3.1-P3.6 QE+Wannier90+EPW DFT pipeline (pool:ubu-1) — *RTSC가 이미 일부 수행 중* · (d) future MaterialsCloud / OPTIMADE federation expansion | **ACTIVE** | Phase 2 expand 가능 즉시 (P2.1 COD = pure-pip pymatgen · external deps 없음) |
| **YOSYS** | §5 OPEN — Δ 10.07% @ router_d4 best 55,546 µm² (vs oracle 61,762.99 · 99.4× area · 89.0 pp Δ reduction) · §4 모듈 7개 전부 land-CLOSED · §5 gate 미달 (±5% 윈도우까지 3,208 µm² gap) | 2026-05-22 §8 snapshot 갱신 · T79c post-measurement mini OOM @ ~50GB compressed VM · ubu-2 substrate 5-layer unblock | (a) **mini측정 unblock**: `pass_clean_multidriver` profile (O(n²)→O(n) accumulation 후보 · `pass_cut_and_remap` 7691133b 패턴 mirror) · (b) **ubu-2 cross-build**: `hexa_cli_driver` Linux ELF cross-build (현재 arm64 Mach-O) · (c) ABC `fa_1` multi-output `.gate` split (yosys-abc 0.65 compat) · (d) read_verilog comb-always SSA for-body dyn-idx READ lowering · (e) §5 gate flip → `Yosys absorbed=true` | **ACTIVE** | mini OOM 진단 OR ubu-2 cross-build 완주 (양쪽 중 하나) |
| **ABSORPTION** | 5-domain classification stable (①STDLIB · ②DOMAIN_MAP · ③RECORD · ④WORKFLOW · ⑤HONESTY) · DomainCatalog 19 entries · G5 FalsifierEntry + G3 SiblingRepoSpawner LANDED | 2026-05-22 session-batch: JARVIS + HFBTHO/BSk + WKB α-decay + JET pulse + Sleep-EDF + CSH (Snider 2020) absorptions 분류 등록 · DomainCatalog 16→19 entries (prerequisites + facets) | (a) INDEX.demi parser (D83) + cockpit NewProjectSheet UI 갱신 (G1 phase B) · (b) "즉시 가능" 후보 — pure-pip macOS quick win 도구 추가 흡수 (목록 §즉시 가능) · (c) "substrate 업그레이드" 후보 (GOAL P-⑧ fast path) — 1점 → full stack 진행 | **ACTIVE** | UI cockpit 작업 (Swift · DemiurgeCLI build) OR 다음 도구 흡수 cycle |
| **MP (meta)** | — (도메인 6개 cover; 위 table에 포함) | | | | |

---

## 도메인 별 핵심 read-pointer (audit reproducibility용)

| domain | spec head | log tail | 핵심 §-pointer |
|--------|-----------|----------|---------------|
| RTSC | `RTSC.md:1-40` | `RTSC.log.md:60-84` | §8.9 (5-criteria gate · absorbed=true) · §9.13 (capstone) · §9.11-9.12 (DFT 돌파) |
| MONDALOY | `MONDALOY.md:1-40` | `MONDALOY.log.md:85-110` | §9.7 (wet-lab handoff packet · c1 composition) · §3 (CALPHAD/DFT pipeline) · §4 (d2 breakthrough) |
| NUCLEAR | `NUCLEAR.md:1-40` | `NUCLEAR.log.md` (2 entries only) | §6.3 (Phase progress · 10/10 PASS) · §4 (N6-N10 cohort spec) · §5 (external library survey) |
| MP | `MP.md:1-40` | `MP.log.md` (3 entries only) | §2 Phase 1-5 roadmap · §3 API-key-dependent enhancement · ⚡ session-update (JARVIS land) |
| YOSYS | `YOSYS.md:1-40` | `YOSYS.log.md:90-121` | §5 (measurement gate OPEN) · §8 (current snapshot · best 55,546 µm² @ Δ10.07%) · §8 Outstanding work (4 items to flip §5) |
| ABSORPTION | `ABSORPTION.md:1-40` | `ABSORPTION.log.md:88-111` | §①-⑤ classification · §즉시 가능 (pure-pip macOS quick win) · DomainCatalog (19 entries) |

---

## 다음 cycle 추천

### 가장 큰 가치 — **NUCLEAR Phase 3 microkernel land**
- 이미 Phase 2 audit 통과 (10/10 PASS) · NC1/NC2/NC3 candidates 명확히
  식별. RTSC §9.13 `eliashberg_moments` PR #299 패턴이 직접 mirror 가능
  (substrate → hexa-native microkernel 한 layer 들기).
- d8 compute 사이즈 small (no DFT — 단순 phenomenological formula
  port) → pool:ubu-1/2 free baseline · RTSC 11-pod 부담과 직각.
- 산출: NUCLEAR sim.hexa v0.1.0 → v0.2.0 (3 microkernel +parity).

### 가장 빠른 산출 — **MP Phase 2 P2.1 COD CIF parser**
- 외부 deps 없음 (pure pymatgen · public-domain CIF). key-free 종착점.
- ~50-100 LOC thin adapter (`mp_query.py` 패턴 mirror).
- 산출: `hexa-lang/stdlib/material/cod_query.py` + cache schema 확장.

### IDLE 도메인 중 가장 진행 준비된 곳 — **MONDALOY c2 fallback OR CALPHAD sim**
- §9.7 wet-lab packet 완성으로 "compute 영역에서 가장 가까운 추가 마일"
  은 §9 역설계 c2 fallback envelope (c1과 직각인 alternative
  composition family) OR §3 CALPHAD 1차 simulation record emit.
- d2 breakthrough — c1 단독 candidate가 wet-lab에 막혀도 c2/c3 fallback
  envelope 가 sim-side에서 미리 준비되면 wet-lab dependency 단절을 회피.

### YOSYS — **substrate-side cycle (분리)**
- mini OOM 진단 OR ubu-2 cross-build 가 §5 gate 의 측정-호스트 의존성
  자체를 해소. 측정 reproducibility 회복 cycle은 NUCLEAR Phase 3와
  병렬 가능 (pool 사용량 직각).

### ARCHIVED 도메인 — 없음
- 6 topical 도메인 모두 IDLE 또는 ACTIVE. wet-lab-bound 도 없음 (MONDALOY
  §9.7 packet은 compute-side complete 이고 추가 작업이 남아있음 — wet-lab
  boundary는 *handoff line*이지 도메인 정지 상태가 아님).
- ABSORPTION 은 cross-cutting meta-doc — 도메인-add cycle마다 entry
  자라남, 정지 안 함.

---

## 메타

- **6 topical .md 도메인** (RTSC · MONDALOY · NUCLEAR · MP · YOSYS · ABSORPTION).
  CHARTER cohort 의 cern · antimatter · space · energy · brain 은 demiurge
  *root-level UPPERCASE.md* 미보유 (hexa-* sibling repo 측에서 spec
  유지 · demiurge는 typed-interface consumer 위치, CHARTER §Mission).
- **3 ACTIVE + 3 IDLE** 균형. 동시 cycle 권장 cap 2-3 (per memory
  `feedback_parallel_agent_cap.md`) — NUCLEAR Phase 3 + MP P2.1 + (YOSYS
  substrate or MONDALOY c2) 의 3-track 병렬이 한계.
- **wet-lab-bound** 정직 마킹: MONDALOY §9.7 c1 composition packet 은 외부
  melter/AM operator 손에 들어가야 absorbed=true 가능 (d1 frontier).
  RTSC §8.9 5-criteria gate 도 동일. NUCLEAR §3/§7 R4 invariant 도 동일
  ("simulation PASS = wet-lab priority hint, NEVER discovery claim").
- **g15**: 본 파일은 current-state snapshot — 매 audit cycle마다 overwrite.
  변경 chronicle은 git history가 보유.
