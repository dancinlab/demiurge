# MP — Materials Project (key-free 직접 구현 substrate)

> Root-level domain expansion. RTSC.md §8.7 Tier 1 (computational synthesis)
> 의 입력 데이터 100% self-contained 화 로드맵. API-key 의존 제거가 1차
> 목표; key 가 있으면 더 빨라지지만 *필수는 아닌* 구조로 설계.
>
> opened: 2026-05-21 KST · status: **roadmap draft (Phase 1-5 + 선택 enhancement)**
> parent: RTSC.md (§8.5 handoff schema · §8.7 Tier 1)

## ⚡ Session update (2026-05-22)

- **JARVIS-OPTIMADE LANDED as 3rd DFT corpus** (hexa-lang PR #287 MERGED · cross_code_dft._poll_jarvis ~85 LOC). 4-source consensus 이제 mp_cache + AFLOW + OQMD + **JARVIS** (anonymous OPTIMADE REST · NIST US-government public domain).
- **20-cell Phase 2 ext matrix: 18/20 → 20/20 PASS** post-JARVIS land. YBa₂Cu₃O₇ + H₃S DEVIATION cells resolved (n=1 → n=3 multi-corpus consensus).
- **OptB88vdW caveat (s5)** added — JARVIS uses non-PBE functional family · same s2 systematic-error correlation as MP/AFLOW/OQMD. NOT conflate into "PBE consensus".
- **NOMAD honestly rejected** as 4th corpus (formation_energy not in `available_properties` index · ~150-200 LOC archive-level total-energy queries required · B-path 이탈). Future expansion candidates: MaterialsCloud · OPTIMADE federation.
- See `archive/session-notes/2026-05-22-rtsc-9-phase2-multicorpus-decision.md` + `2026-05-22-rtsc-9-phase2-jarvis-rerun.md` for full audit.

---

## 0. TL;DR

**Materials Project (MP)** = LBNL DFT 계산 물질 DB · ~150,000+ 구조 + band gap / formation energy / DOS / 일부 Debye temperature 등 predicted properties. 라이선스 **CC-BY-4.0** (attribution 만 유지하면 자유 사용 — 캐시 / mirror / 가공 가능).

API key 가 필요한 건 *실시간 REST 쿼리* 만; **bulk dump (S3 mirror / Globus)** 는 key 없이 다운로드 가능. 보완 source 도 충분:

- **COD** (Crystallography Open Database) — public domain · key-free · CIF format
- **AFLOW** REST — 일부 endpoint key-free · CC-BY-4.0
- **NIMS SuperCon** (실험 측정 SC Tc) — register-only · 사용자 수동 mirror 만 가능
- **arxiv supplementary materials** — public · free download

→ **MP_API_KEY 없이도 sim_adapter / sim.hexa / DFT pipeline 입력을 100% 채울 수 있음** (이 문서의 핵심 주장).

---

## 1. Current state (이 세션까지)

- [x] `mp_query.py` thin REST adapter (`~/core/hexa-lang/stdlib/material/mp_query.py`) — key-dependent path
- [x] Honest skip path (no key → `gate_type=api-key-missing`) — K cohort verified
- [x] Setup guide 노트 (`archive/session-notes/2026-05-21-mp-api-setup-needed.md`)
- [x] `sim_adapter.py` / `sim.hexa` 가 Nb 입력 받아 4-formula (BCS · McMillan · Allen-Dynes · WHH) Tc 예측 — params 는 현재 **hard-code**

→ 현재 상태의 한계: sim_adapter 의 입력 params (Θ_D · λ · μ* · ω_log · slope) 가 hard-code. MP 가 있어야 실제 candidate 의 params 를 가져옴. **MP 가 없으면 candidate 추가 불가** — 이걸 풀려는 게 본 로드맵.

---

## 2. Roadmap (체크박스)

### Phase 1 — Key-free MP 데이터 mirror

- [ ] **P1.1** — MP bulk-dump endpoint 조사 (https://next-gen.materialsproject.org/api → S3 / Globus mirror URL). 라이선스 CC-BY-4.0 확인 + attribution 포맷 결정.
- [ ] **P1.2** — 가벼운 sample dump 시도 (~100 entry, formula + band gap + DOS + spacegroup 만 골라서). 전체 dump (~수십 GB) 대신 SC 후보 family 만 (8 family × ~50 candidates = 400 entries).
- [ ] **P1.3** — 로컬 캐시 schema 정의 + 디렉토리 (`exports/material_cache/mp/<mp_id>.json` 또는 `<formula_slug>.json`).
- [ ] **P1.4** — `mp_query.py` 에 disk-cache fallback layer 추가: no-key + cache hit → 캐시 데이터 반환 + `gate_type="cached-mirror"`; cache miss → 기존 `api-key-missing` skip. *cache-warm 모드를 첫 시민으로*.
- [ ] **P1.5** — cache provenance: 각 캐시 파일에 `cached_at`, `mp_id`, `cc_by_attribution_text`, `source_dump_version` 박기.

### Phase 2 — 보완 source (key-free)

- [x] **P2.1** — **COD** (Crystallography Open Database) CIF parser thin adapter — `~/core/hexa-lang/stdlib/material/cod_query.py` (397 LOC, pure python · stdlib + pymatgen). LANDED 2026-05-23. `result?text=<comp>&format=csv` 으로 COD ID 인덱스 추출 → `/cod/<id>.cif` 다운로드 → `pymatgen.Structure.from_str(fmt="cif")` 으로 lattice/spacegroup/density 추출. record schema 는 MP cache 와 mirror (`domain=material` · `verb=query` · `absorbed=false` 영구 · `gate_type` ∈ {external-api, external-api-failed, install-gated} · `provenance` · `citations`). MgB2 live test 6 COD ID → 3 CIF parse PASS. public domain → 완전 자유 (no API key · no attribution 필수). install-gated path: pymatgen 미설치시 id-only row.
- [x] **P2.2** — **AFLOW** AFLUX REST thin adapter — `~/core/hexa-lang/stdlib/material/aflow_query.py` (350 LOC, pure python · stdlib urllib · no API key). LANDED 2026-05-23 (hexa-lang PR #402). AFLUX endpoint `https://aflow.org/API/aflux/?species(A,B),nspecies(N),<props>,$paging(1,n)` 는 무인증 key-free 확인. `$paging(P,N)` 2-arg 형은 JSON **list** 반환 (단일 arg `$paging(N)` 은 *page N* 의미라 `[]` 위험 — 2-arg `$paging(1,n)` 채택). record schema 는 MP cache / cod_query 와 mirror (`domain=material` · `verb=query` · `kind=aflow_lookup` · **`absorbed=false` 영구** · `gate_type` ∈ {external-api, external-api-failed} · provenance · citations). MgB2 live test → 10 rows (실 ΔH_f · spacegroup_relax · auid). license: `academic-cite-required` (aflow.org/license/ 가 build 시점 404 — cod public-domain / oqmd CC-BY-4.0 와 다름; s5 caveat 명시).
- [ ] **P2.3** — **NIMS SuperCon** CSV mirror check. register-only 이라 자동화 안 됨 → 안 되면 honest skip + setup-note (mp-api-setup-needed.md 패턴).
- [ ] **P2.4** — Source priority chain: measured > DFT-computed-cached > MP-cached > COD > AFLOW > literature-text > default-hard-code. record 의 provenance.source_chain 에 어디서 왔는지 기록.

### Phase 3 — DFT first-principles (Tier 0 self-host)

- [ ] **P3.1** — **Quantum ESPRESSO (QE)** 빌드 (ubu-1 / ubu-2 pool 호스트. open GPL · Linux 친화. CPU-only OK 시작점). pool 셋업 시간 ~1 시간.
- [ ] **P3.2** — **Wannier90** 빌드 (QE 와 같은 pool 호스트, QE 와 함께 컴파일).
- [ ] **P3.3** — **EPW** 빌드 (QE core module, QE 와 같은 빌드 트리). epw-code.org 참고.
- [ ] **P3.4** — Nb candidate end-to-end 실증 — `scf.in` → `nscf.in` → wannier 변환 → EPW α²F · λ · ω_log → Allen-Dynes Tc. Expected: Tc ≈ 9.25 K (실험값과 비교). 실험-계산 Δ 5% 이내면 PASS.
- [ ] **P3.5** — thin adapter `~/core/hexa-lang/stdlib/material/qe_epw_adapter.py` — pool subprocess + ssh + remote tarball ingest. `gate_type="dft-pool-computed"`.
- [ ] **P3.6** — 두번째 candidate (MgB₂) — full E2E DFT pipeline 재현 — Tc ≈ 39 K 비교.

### Phase 4 — sim_adapter input pipeline 통합

- [ ] **P4.1** — `sim.hexa` / `sim_adapter.py` 가 4-source 입력 받는 형태로 리팩 (current hard-code → MP-cache → COD → DFT-pool → user-CLI override).
- [ ] **P4.2** — 우선순위 chain 코드로 명시 (priority enum + selector). 동일 candidate 에 여러 source 가 있으면 가장 신뢰도 높은 source 채택, 나머지는 cross-check 용으로 기록.
- [ ] **P4.3** — 각 source 의 provenance 가 sim 결과 record 까지 일관 전파 (`provenance.source_chain: [mp_cache:mp-763, cod:1531234, dft_pool:nb_scf_2026-05-21]`).
- [ ] **P4.4** — Honest stance: source 가 다양해져도 **absorbed=false 영구** (RTSC.md §8.7 限界 그대로 — 예측 ≠ 측정).

### Phase 5 — 자체 H-formulation .pro 작성 (license-unclear 외부 의존 제거)

- [ ] **P5.1** — arxiv:1908.02176 H-formulation review 의 식을 직접 .pro 로 구현 — own license. 기존 `solenoid_axisym.pro` 작성 패턴 활용 (Form1P · BF_PerpendicularEdge · VolAxiSqu).
- [ ] **P5.2** — `~/core/hexa-lang/stdlib/rtsc/templates/h_formulation_own/{tape,pancake,cube}.pro` — 우리 own. life-hts/cube/cube.pro 는 참고만, 코드 베끼지 않음.
- [ ] **P5.3** — 자체 .pro 가 GetDP 4.0.0 + RhoPowerLaw 로 §4.2.1.d 의 cube 결과 (TimeStep 248 · 617s) 와 동일 결과 재현 검증.
- [ ] **P5.4** — `h_formulation_adapter.py` 에 `--use-own-template` 옵션 추가 — license-unclear 외부 의존 없이 HTS-grade 본해 가능.
- [ ] **P5.5** — D1 cohort 의 life-hts cache 는 *대조군* 으로만 유지 (reference cross-check) — primary path 는 own .pro 로 전환.

---

## 3. API-key-dependent (선택적 enhancement, *필수 아님*)

본 로드맵의 핵심은 Phase 1-5 가 **key-free** 인 것. 아래는 key 가 있으면 *더 편한* layer:

- [ ] (선택) `MP_API_KEY` 설정 → `mp_query.py` 실 hit (3 baseline query: MgB₂ · YBa₂Cu₃O₇ · Pb₁₀Cu(PO₄)₆O)
- [ ] (선택) `MP_API_KEY_NEW` + `mp-api` 신 클라이언트 → emmet-core 0.84 + pymatgen 2024.10+ 버전 align (K cohort 에서 발견된 ImportError 해결)
- [ ] (선택) 실시간 REST 쿼리로 Phase 1.2 의 sample dump 를 *bootstrap* (한 번 받아 캐시 채운 후 key 제거 가능)

→ **API key 가 있으면 Phase 1.2 (sample dump) 가 30분 단축**, 그 외 모든 Phase 는 key-free 로 진행. key 의존도는 *편의성* 이지 *blocker* 아님.

---

## 4. Honest g3 stance

- MP CC-BY-4.0 = 자유 사용 + attribution 의무. demiurge 가 캐시 / mirror 해도 라이선스 안전.
- 캐시는 *데이터 mirror* 이지 *demiurge SSOT* 가 아님 — provenance 에 MP 캐시 hit 명시 (P1.5).
- API-key 의존 자체는 honest violation 아님 (외부 서비스 사용은 정당); **그러나 key 없이도 동작하는 fallback chain** 이 robust path. 이 로드맵은 fallback chain 을 1차 시민으로 둠.
- Tier 1 sim 의 입력이 MP / COD / AFLOW / DFT-self / hard-code 어디서 왔든 — **absorbed=false 영구** (RTSC.md §8.7 限界 그대로 — 예측 ≠ 측정).
- 자체 H-formulation .pro (P5) 도 mathematical formulation 자체가 공개 논문 (arxiv:1908.02176 review) 이라 자유 구현 가능 — life-hts 의 license-unclear 문제는 그들의 .pro 콘텐츠일 뿐, 식은 공유 자산.

---

## 5. Cross-reference

- `RTSC.md` — parent (§8.5 handoff schema · §8.7 4-tier expansion path · §8.8 g3 stance)
- `~/core/hexa-lang/stdlib/material/mp_query.py` — 현재 key-dependent adapter
- `~/core/hexa-lang/stdlib/material/{sim.hexa, sim_adapter.py}` — Tier 1 sim
- `~/core/hexa-lang/stdlib/material/hexa_rtsc_crosslink.py` — hexa-rtsc cross-link
- `~/core/demiurge/archive/session-notes/2026-05-21-mp-api-setup-needed.md` — K cohort honest skip note
- pool: `~/.pool/pool.json` (mini · ubu-1 · ubu-2) — DFT 계산 인프라 (P3)
- 외부 ref URL: https://next-gen.materialsproject.org/api · https://crystallography.net · http://aflowlib.duke.edu · https://supercon.nims.go.jp · https://epw-code.org

---

---

Historical log entries are in [`./MP.log.md`](./MP.log.md).
