# CLI+COCKPIT — log

Append-only history sister of `CLI+COCKPIT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T15:00:00Z — M17 compute-backend ✅ (호스트 하드코딩 0) · audit 0❌ 달성

- [x] **M17 ✅ commit 72fb19e** — `ComputeBackend`+`BackendResolver`+`demiurge backend list/current` · local 기본 + `DEMIURGE_BACKEND` 사용자 remote
- [x] **호스트 하드코딩 0 (@goal)** — 내 ubu/mini를 demiurge 코드에 안 박음. owner pool은 런타임에 owner 자신의 `~/.pool/pool.json`에서 읽고 DEMIURGE_OWNER 일 때만 노출
- [x] **실증** — 외부 `backend list`=local만(pool 숨김) · `--owner`=pool.json 4 호스트(mini·ubu-1·ubu-2·pi5-akida) · `DEMIURGE_BACKEND=ssh:myhost`→remote:myhost
- [x] **audit 0❌ 달성** — product 9✅·3🔶·0❌ — 모든 blocked op 해소. single op 전부 2-surface reachable
- [x] M0_operate.md §3 compute-backend row + audit-count 갱신 · M17 milestone [x]
- [ ] ⏳ 남은 🔶 3개 = M15 7-verb 합성 실행 (verb-nav·analyze-loop·synthesize-run) — single op은 다 되고, 구성 stack을 topo 순서로 합성 실행하는 부분만 잔여
- [ ] ⏳ P3 cockpit GUI mirror (OperationRegistry·DomainComposer·BackendResolver) · M18 배포 · M19 plain격리 · M20 owner-mode · M21 audit flip

🔑 핵심: M17로 **audit ❌ 0** 달성 — verify·atlas·backend 모든 single 운영 op가 외부 2-surface에서 reachable (owner-infra 의존 0). compute-backend가 내 호스트를 코드에 안 박고 owner 설정파일에서 읽어 "외부 제품" 경계 준수. 외부 완전운영까지 남은 건 M15 7-verb 합성 실행(3🔶)뿐.

## 2026-05-25T14:40:00Z — M16 ✅ 완료 (atlas-lookup 추가 · read-only owner-gated)

- [x] **atlas-lookup ✅ commit 786bd18** — `demiurge atlas lookup/stats/hash/dump`→`hexa atlas` VERBATIM (HexaBridge 재사용) · write(register/append-witness/pr)=owner op 사장실 M20 거부
- [x] **M16 완료** — verify(ca81e73) + atlas-lookup(786bd18) 둘 다 hexa stdlib hx-dependency 호출 · external read-only · 빌드 green
- [x] **실증** — `atlas hash` → hexa 16082 nodes + hash VERBATIM (exit 0) · `atlas register foo` → owner 거부 (exit 2)
- [x] **audit ❌ 3→1** — product 8✅·3🔶·1❌ (남은 ❌ = compute-backend M17 · 🔶 = verb-nav·analyze-loop·synthesize-run M15 합성 실행)
- [x] M0_operate.md §3 atlas-lookup row + audit-count 갱신 · M16 milestone [x]
- [ ] ⏳ M17 compute-backend (내 호스트 하드코딩 제거 · 로컬 기본 + 사용자 remote) → 마지막 ❌ · M15 7-verb 합성 실행 · P3 cockpit GUI

🔑 핵심: M16 완결 — verify·atlas 둘 다 `HexaBridge` 단일 통로로 hexa SSOT 호출(VERBATIM). external=read-only, write=owner 사장실 격리. audit가 8/12 ✅ — 외부 운영 완결까지 ❌ 1개(compute-backend) + 🔶 3개(M15 합성)만 남음.

## 2026-05-25T14:20:00Z — M16 verify를 hexa stdlib 커널로 (hx 의존성 호출 · verdict VERBATIM)

- [x] **M16 verify ✅ commit ca81e73** — `HexaBridge.swift`(hexa leaf-call 단일 spawn 지점) + `demiurge verify --expr/--fence/rubric`→`hexa verify` VERBATIM (@D g5) · 빌드 green
- [x] **실증** — `verify --expr sigma 6 12` → 🔵 SUPPORTED-FORMAL · `verify --expr ivw 3 1` → 🟠 INSUFFICIENT (둘 다 hexa 원문 그대로 · demiurge re-judge 안 함)
- [x] 경계 준수 — demiurge는 dispatch만 소유, verdict 계산은 hexa stdlib SSOT(hx 의존성). hexa 부재 시 honest ran=false (g3, 조작 verdict 금지)
- [x] OperationRegistry verify reach ❌→✅ → **audit 7✅·3🔶·2❌** (verify 통과 · 잔여 atlas-lookup·compute-backend)
- [x] M0_operate.md §3 verify row + audit-count 갱신
- [ ] ⏳ atlas-lookup (M16 · HexaBridge 재사용 `hexa atlas lookup`) · compute-backend (M17) · M15 7-verb 합성 실행 (M16 ✅로 verify 단계 unblock)

🔑 핵심: 첫 stdlib 커널 호출(M16). demiurge=dispatch 소유 / hexa=verdict SSOT 가리킴 경계가 코드로 실증. `HexaBridge`가 이후 모든 hexa leaf-call(atlas 등)의 단일 통로. audit ❌ 3→2.

## 2026-05-25T14:00:00Z — 도메인 전수조사 + M15 composition resolver (선행=구성도메인) + compose CLI

- [x] **demiurge 도메인 전수조사** — 21 등록 (INDEX.demi 20 + clinical) · canvasMode 4종(chip·component·matter + cohort 17) · clusters 멀티태그 9종 · prerequisites DAG
- [x] **도메인 모델 2축 확정** — 가로 clusters(성격 결합) × 세로 prerequisites(구성) · `DomainGraph.transitiveClosure`+`topologicalSort` 기존재 (NewProject wizard가 이미 호출)
- [x] **M15 resolver ✅ commit 818fbfe** — `DomainComposition.swift`(`DomainComposer.resolve`: stack topo + clusterUnion + kind atomic/composite/meta + crossesDiscipline) + `demiurge compose <domain>` CLI · 빌드 green
- [x] **사용자 3-케이스 실증** — bio=composite(matter→chem→bio·구성3) · aura=결합(tech+bio 7-cluster·구성8) · ufo=meta(구성10 apex) · chip=atomic
- [x] M0_operate.md §8 도메인 합성 실행 규칙 추가 (kind 표 + 합성 규칙 · @D d4 단일 경로)
- [ ] ⏳ M15 잔여 — 7-verb가 구성 stack을 topo 순서로 cluster-aware 합성 실행 (M16 verify hx-call + M17 backend dep) · cockpit NewProject가 resolve 결과 노출(P3 GUI)

🔑 핵심: 선행도메인 = 구성도메인. resolve가 closure+topo+clusterUnion+kind 산출 → "메타(ufo)·결합(aura tech+bio)·단일맞춤(cluster)"이 단일 generic 경로(d4)로 표현. `demiurge compose`로 CLI 노출. 다음은 7-verb 합성 실행(M16/M17 dep).

## 2026-05-25T13:30:00Z — @goal 외부-제품 재정의 + M14 (operation manifest) 착지 + M0 운영 manifest

- [x] **@goal 재정의** — "외부 사용자가 app(Swift macOS) + CLI 2개만으로 7-verb 완전 운영, owner-infra 의존 0" (4-제약: surface 2개 · SSOT=stdlib 커널만 · 작동부=demiurge 소유 · 대상=외부+hexa hx 의존성)
- [x] **3-층 소유 경계** — 작동부(demiurge) / 진열대(external) / 사장실(owner env-gated) + stdlib 커널(hexa SSOT 가리킴)
- [x] **M14 ✅ commit 0ec8dc4** — `OperationRegistry.swift`(17-op census · external/owner tier · target swift/hexa/substrate · @D d4) + `demiurge operate list/audit` CLI + `OperabilityAudit`(M21 gate skeleton) · 빌드 green · audit=6✅/3🔶/3❌
- [x] **P1 산출 `CLI+COCKPIT/M0_operate.md`** — 17-op 전수표 + generic dispatcher(d4) + 배포(hexa hx-dep) + plain/expert 격리 + audit 정의
- [x] M15-M21 등재 — 진열대(M15-19·21) + 사장실(M20, 기존 M10-12 흡수)
- [x] memory `project-demiurge-pointer-hexa-lang-ssot` 정정 — 작동부 carve-out (cockpit/CLI Swift = demiurge 소유 · SSOT=stdlib 커널만)
- [x] ⚠ **동시 세션 wipe 사건** — 다른 세션이 CLI+COCKPIT.md/.log.md 라이브 편집(commit 556515c·6549eea)으로 본 문서 편집 2회 wipe → 코드는 d9 격리 커밋(0ec8dc4)으로 즉시 보호, 문서는 stable window에 재적용
- [ ] ⏳ P3/M15 — cockpit GUI가 OperationRegistry mirror (D50) + `OperationDispatch.run` per-target 실행 wiring · op별 stacked PR (@D g4)
- [ ] ⏳ M16 verify hx-call · M17 backend 추상화 · M18 배포 · M19 plain격리 · M20 owner-mode · M21 audit

🔑 핵심: M0 운영 매핑표가 `demiurge operate`로 실행 가능한 surface가 됨 — "완전 운영" 토대(M14) 착지. 동시 세션 충돌은 d9 `git commit -o` 격리로 코드 보호 (memory recurring-wipe 패턴 demiurge 재발).

## 2026-05-25T07:50:00Z — CARDIO+ 메타도메인 세션 교훈 → CLI/cockpit 개선 milestone M8-M13 등재

- [x] **M8-M13 개선 milestone 등재** (milestone-level only · 구현 후속) — CARDIO+ 메타도메인(X1-X13 + DOCTOR H1-H10 + 인프라 핸드오프 3건) 세션서 induce
  - M8 verify host-health 라우팅 (mini ✅/ubu broken) · M9 macOS-only pool-route 예외 · M10 commit-isolation(d9) 강제 · M11 agent fan-out cap 2-3 · M12 upstream INBOX reflex(g60) 패널 · M13 folder-nested domain (✅ 0.8.x 해소)
- [x] **CARDIO+ 검증사례 섹션 추가** — NOREFLOW 사례와 병렬 · 6 교훈 표(증거→surface→milestone→status) + generic caveats 4개
- [x] generic caveats: honest tier 천장(🟢 vs 🔵) · numerical→causal over-read 경계(X13 red-team) · d6 no-forcing 실증(ICER v7) · `+` 메타도메인 roll-up surface 필요
- [ ] ⏳ M8-M12 구현 (코드/시스템) — 별도 cycle (본 등재는 마일스톤 기준 · 사용자 "matleb 기준만" 지시)

🔑 핵심: CARDIO+ 세션의 실측 마찰(verify 호스트·pool-route·commit 격리·agent cap·INBOX 반사·domain nest)을 CLI+COCKPIT 7-verb surface 개선 milestone으로 전환 — cockpit이 이 교훈들을 embody하면 다음 메타도메인 작업서 재마찰 0.
⚠ status: M13만 해소(domain 0.8.x) · M8-M12는 open (구현 cycle 대기) · M8/M9/M12는 upstream(hexa-lang/sidecar) 부분 진행.

## 2026-05-25T02:30:00Z — DAPTPGX cycle 5 CLI 실증 + 3 spec docs induce (4th reproduction)

- [x] DAPTPGX V1-V4 verify-phase 완료 (M1-M11 + V1-V4 = 14/14)
- [x] `hexa verify rubric` · `hexa verify --expr phi 100 40` 🔵 · `hexa verify --fence` ⚪ × 4 — M6 surface dispatch 4 path 모두 verbatim 캡처
- [x] `hexa atlas stats` 16066 nodes 재확인 (NOREFLOW + ISR + LPA와 ATLAS_HASH 동일 = atlas read-only stable)
- [x] V3 sim — `ssh mini 'hexa run /tmp/v3_recompute.hexa'` 32줄 stdout (HW · phenotype · PM×HBR · ICER · Markov · budget)
- [x] V3 = 🟢 SUPPORTED-NUMERICAL × 2 (HW 0.6279 vs cited 0.60 within 5pp · PM per100 15.21 vs cited 14-15 exact)
- [x] V3 sign mismatch 정직 보고 (ICER -3,221 M/QALY vs cited +34) — d6 framing 준수, 🔴 FALSIFIED 거부, 🟠 reconciliation pending
- [x] V2 promoter 0-proposal bug 만남 → 4 shard staged `/tmp/daptpgx-staging/` + 2 inbox patches
- [x] `cp inbox/patches/{stdlib-bio-stats,atlas-pgx-kind}.md ~/core/hexa-lang/inbox/patches/daptpgx-*-2026-05-25.md` ✅ — demiurge cli upstream handoff (M7 surface)
- [x] V4 final ledger — 30 claim 분포 (현 🔵 0 + 🟢 5 → V2-bis 후 🔵 4 + 🟢 12 escalation 예상)
- [x] **3 spec docs induce 완료** — `CLI+COCKPIT/M5_synthesize.md` · `M6_verify.md` · `M7_handoff.md` (cross-domain learning을 surface spec으로 결정화)
- [x] CLI+COCKPIT.md DAPTPGX evidence section 추가 (NOREFLOW · ISR · LPA 표 패턴 4번째 확장)
- [x] cross-domain wall 4th confirmation — pool wrapper 컴파일 bug (ssh fallback 일관) + biostat kernel 부재 (PR #665 merge 시 일제 unblock)

## 2026-05-25T02:00:00Z — LPA cycle 4 CLI 실증 (3rd reproduction)

- [x] `hexa --version` = 0.1.0-dispatch 작동 — NOREFLOW + ISR과 동일 환경
- [x] `hexa verify --expr sigma 6 12` → 🔵 SUPPORTED-FORMAL (number-theory sanity 재확인)
- [x] `hexa verify --expr ivw 3 1` → 🟠 INSUFFICIENT (biostat kernel 부재)
- [x] `hexa atlas stats` = 16,066 nodes · F=1,313 · ATLAS_HASH `6fae9277...` (NOREFLOW + ISR과 hash 동일)
- [x] `pool list` 실행 → compile error 재현 (V3a · V3c agent 보고와 일치)
- [x] LPA V3a/V3c agent 우회 = ssh direct (ubu-1 0.58s · ubu-2 0.054s) — 3rd cross-domain reproduction
- [x] LPA V2 agent → hexa-lang **PR #665 OPEN** (`inbox/notes/2026-05-24-lpa-ivw-mr-formula.md`) — biostat 5 fn 요청
- [x] CLI+COCKPIT.md LPA evidence section 추가 (NOREFLOW + ISR 표 패턴 확장)
- [x] cross-domain wall 누적 통계 — 17+ identity × 4 도메인 (LPA + ISR + DAPTPGX + HERPES) 동시 unblock 대기
- [ ] V2 atlas push agent 완료 대기 (in-flight)
- [ ] V3b · V4 · M8 cycle 완료 후 LPA tier ledger CLI+COCKPIT 최종 흡수

🔑 핵심 통찰 (LPA cycle 4 CLI evidence):
- **M5 ssh direct fallback 패턴 = 3-도메인 일관** (ISR · NOREFLOW · LPA) → 권장 표준화 후보
- **M6 biostat wall = 4-도메인 confirmed** (이전 ISR 2건 → 누적 4) → PR #665 merge 가치 강화
- **TTR domain 🔵 22건** = 이번 cycle 최고 사례 (hexa-bio 외부 도메인 적용성 입증)

## 2026-05-25T01:10:00Z — NOREFLOW CLI 실증 (hexa + demiurge dual)

- [x] `hexa verify --fence` ⚪ SPECULATION-FENCED verdict verbatim 확보 (NOREFLOW M2 metaphor 1건)
- [x] `demiurge cli list-domains` → 20 도메인 출력 (NOREFLOW · DAPTPGX · ISR · LPA · TTR · HERPES 미등록 = `bio` 산하 sub-domain 또는 신규 `cardio` 후보)
- [x] `demiurge cli action verify bio` → 7-verb dispatch 작동 ✓ · anima bridge record · GATE_OPEN · absorbed=false (d5 거버넌스 준수)
- [x] `demiurge cli list-decisions` → 0 (design.md SSOT D-number 미사용)
- [x] CLI+COCKPIT.md M6 surface 에 3 verbatim 부착 + upstream 후보 3건 명시
- [ ] cherry-pick(395ad4b) 진행 중 → commit 보류 (다른 세션 LPA conflict 해결 대기)
- [ ] upstream 후보: `cardio` 도메인 등록 + `list-claims` 명령 + `action verify --tier-report` flag

🔑 hexa verify · demiurge cli action verify · demiurge cli list-domains 3 surface 모두 작동 ✓ — M6 verify surface 실증 완료
🔑 NOREFLOW · ISR · DAPTPGX · LPA가 `$DOM:` 미등록 = demiurge cli upstream 기여 후보 (cardio 도메인 신규)

## 2026-05-25T03:30:00Z — ISR cycle 5 verify-phase contribution (CLI 직접 사용)

- [x] `hexa --help` 정찰 — top-level 80+ verbs
- [x] `hexa verify rubric` verbatim — 7-tier 색상 (🔵🟢🟡🟠🟠🔴⚪) 확인
- [x] `hexa verify --expr hill 3 5` → 🟠 INSUFFICIENT (bio kernel 부재 재현)
- [x] `hexa atlas stats` → 16066 nodes · hash `6fae9277...` · F 1313 · L 531 · P 455 · C 5763
- [x] `hexa atlas --help` — read 8 verbs + write (append-witness · register --from-verify --auto-pr · pr --staging)
- [x] inbox patch 2건 file → hexa-lang/inbox/patches/ (bio-verify-kernel-extension + pool-cli-compile-errors)
- [x] CLI+COCKPIT.md M5/M6 surface 에 ISR + NOREFLOW cross-domain wall evidence 통합 (Cross-domain wall analysis ASCII)
- [x] M6 verify wall = leverage point — 단일 PR ≥50-90 🔵 unlock 가능 확인

🔑 핵심: M6 (verify surface) wall은 single hexa-lang PR로 6 도메인 동시 unlock — bio kernel ~400-600 LOC + float-arg parser. M5 (synthesize) `hexa cloud run` 작동 ✓, `pool list` 직접 호출만 wall.
🌱 다음 라운드: hexa-lang impl PR fan-out (bio kernel + pool.hexa fix) 또는 V4 ledger 진행.

## 2026-05-25T00:55:00Z — NOREFLOW cross-domain 검증 사례 추가

- [x] NOREFLOW 12 base + V1-V4 verify schema를 본 M1-M7 surface에 매핑하는 표 추가
- [x] generic learning 7 row + cross-domain caveat 4건 (인덱스 leak · 🔵 atlas dep · ⚪ fence honest · pool CLI 회귀)
- [ ] 본 도메인 M1-M7 milestone scaffold 자체는 아직 작성 안 됨 (NOREFLOW가 surface 사용 사례로 induce만)
- [ ] hexa verify CLI 시연 — M6 verify surface 실증 (다음 entry)

