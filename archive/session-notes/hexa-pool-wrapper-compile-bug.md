---
title: pool wrapper hexa compile 실패 — ubu-1/2 routing 차단
target_repo: hexa-lang
target_kind: stdlib-patch (pool dispatcher .hexa)
status: open
source: demiurge/DAPTPGX V3 sim 실행 중 발견
created: 2026-05-24
related: [[demiurge-assets-simulation-mandatory]]
---

# 증상

```bash
$ pool on ubu-1 "python3 --version"
2 warnings and 6 errors generated.
error: clang compile failed — binary not produced:
  /Users/ghost/.hexa-cache/hexa_run.661f21fa457a6af7_0.1.0-dispatch.tmp.<random>.tmp.<pid>
__HEXA_BRC__=1
```

`SIDECAR_NO_POOL_ROUTE=1` 환경변수 적용해도 동일. pool 명령 자체가 `hexa run pool.hexa` 시퀀스 통해 dispatch되는데 .hexa 컴파일에서 실패.

# 우회 방안 (workaround)

direct ssh로 우회 가능 (mini · ubu-1/2 모두 ssh 접근 가능):

```bash
scp <file> ubu-1:/tmp/
ssh ubu-1 '<cmd>'
```

하지만 이는 `g8` (canonical subcommand form per commons) 위반이며, 또한 d8 ("Vast trouble → hexa-lang inbox") 정신상 패치 필요.

# DAPTPGX 영향

- V3 hexa sim asset `/Users/ghost/core/demiurge/DAPTPGX/sims/v3_recompute.hexa` 실행
- 의도: `pool on ubu-1 'hexa run /tmp/v3_recompute.hexa'`
- 실제: pool 자체 실패 → direct ssh로 fallback → mini host에서 정상 실행
- 추가: ubu-1 host는 `/home/aiden/.local/bin/hexa.real` 누락 (별도 issue)

# handoff request

1. `pool` dispatcher .hexa source 위치 grep, clang compile error log 분석
2. recent 의존 변경 (sidecar marketplace pull?) 확인 — 0.1.0-dispatch 버전 문제 가능
3. fix 후 `hexa-lang` stdlib (또는 pool 패키지) 패치, `hexa cc` 재컴파일
4. demiurge cross-domain (DAPTPGX · HERPES · RTSC 등) 모두 동일 증상 영향 → 우선순위 ↑

# 검증 등급

| 항목 | 등급 | 근거 |
|---|---|---|
| 증상 재현 | 🟢 SUPPORTED-NUMERICAL | stdout VERBATIM (위) |
| 근본 원인 | 🟠 DEFERRED | pool source 코드 grep 필요 |
| workaround | 🟢 (ssh direct 정상 동작 확인) | DAPTPGX V3 실행 성공 |
