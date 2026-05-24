# pool exec 진단: gate_v3 abc_map [OK] 가짜 — input .blif 쪽 실제 버그

> **id**: `pool-gate_v3-abc-diagnosis` · **opened**: 2026-05-21 KST · **status**: honest finding · **track**: chip / rfc006 §5 substrate-axis
>
> RTSC 세션에서 사용자가 "혹시 /tmp/gate_v3 진행중세션이라면 pool cli 통해 자원활용해서 진행할것" 지시 → ubu-2 로 cross-platform 재현 시도 → **input-side 버그 확정** (플랫폼 무관).

## 사실

1. `/tmp/gate_v3` (arm64 Mach-O, hexa-lang 자생호스트 컴파일러 산출물) 가 16:49 시작, timeout 540s 로 17:00 경 종료.
2. Mac 출력 (`/tmp/gate_v3_long.txt`):
   - `[abc_map] exit=0` + `sh: line 1: 30987 Abort trap: 6 /opt/homebrew/bin/abc -c "..."`
   - 그러나 wrapper 는 `[OK] d4:abc_map — abc_map: ok` 로 마무리 (honest 위반).
3. `/tmp/_hexa_yosys_gate_d{4,6}_out.blif` 의 mtime 은 **16:42** — 17:00 종료된 현재 run 이 *아니라* 더 이전 run 의 잔존물. 현재 run 은 사실상 출력을 못 떨궜다.

## pool 재현 (ubu-2, Linux x86_64, yosys 0.33 + yosys-abc 번들)

전송: d4_in.blif (314 KB) · d6_in.blif (38 KB) · `sky130_fd_sc_hd__tt_025C_1v80.lib` (12.8 MB) → `summer@ubu-2:~/gate_v3_pool/`

실행 (Mac 와 동일 ABC 명령):
```
yosys-abc -c "read_lib <LIB> ; read_blif <IN.blif> ; strash ; map ; write_blif <OUT.blif> ; print_stats"
```

결과:

| 입력 | Linux 실패 모드 | 원인 |
|---|---|---|
| `d4_in.blif` | `yosys-abc: src/base/abc/abcFanio.c:92: void abc::Abc_ObjAddFanin(...): Assertion '!Abc_ObjIsNet(pObj) \|\| !Abc_ObjFaninNum(pObj)' failed.` | gate_v3 가 BLIF에 net node 에 fanin 추가 (= invariant 위반). ABC `strash` 단계에서 즉시 abort. |
| `d6_in.blif` | `Library "sky130_fd_sc_hd__tt_025C_1v80" ... 334 cells (94 skipped: 63 seq; 13 tri-state; 18 no func) ... Warning: Detected 9 multi-output gates (for example, "sky130_fd_sc_hd__fa_1"). Line 160: Mismatch in the fanins of gate "sky130_fd_sc_hd__fa_1". Reading network from file has failed.` | gate_v3 의 BLIF emitter 가 multi-output sky130 cells (예: `fa_1` = sum + cout) 의 fanin 직렬화를 잘못함. ABC `read_blif` 가 첫 fanin 미스매치에서 abort. |

→ **macOS arm64 와 Linux x86_64 에서 동일 실패** = 플랫폼 무관 = `gate_v3` 의 BLIF 라이터 버그.

## 두 가지 honest 결론

1. **`[OK] d4:abc_map — abc_map: ok` 는 가짜**: gate_v3 wrapper 가 ABC 의 abort (Mac: Abort trap 6 / Linux: assertion failure) 를 swallow + exit=0 으로 위장. wrapper 수정 필수 — abc 실패 시 `[FAIL]` 로 보고 + non-zero exit.
2. **고치는 곳은 gate_v3 BLIF emitter**: `~/core/hexa-lang/build/artifacts/gate_v3.c` (자생호스트 컴파일러 산출물) 의 RTLIL→BLIF 변환부. 두 버그:
   - (a) Net node 에 fanin 추가 (ABC 가 `read_blif` 시점에 invariant 검사로 잡음)
   - (b) Multi-output sky130 cells (`fa_1`, `ha_1` 등) 의 fanin 순서/계수 직렬화 불일치 (ABC가 첫 fanin 미스매치로 abort)

## 다음 행동 (chip 팀 영역; RTSC 세션 권한 밖)

- `gate_v3` wrapper 의 abc exit code propagate 픽스 (honest invariant)
- `gate_v3` BLIF emitter 의 두 버그 (multi-output cell + net-node fanin) 픽스
- 이후 다시 ubu-2 에서 재실행하면 같은 .blif 가 깨끗하게 매핑돼야 함 (pool 인프라는 이미 셋업됨: `~/gate_v3_pool/` 에 lib + input blif 잔존)

## pool 자원 평가

- ubu-1: 동시 rsync 4개로 포화 (HEXAD ckpt 업로드 중) — 본 진단에는 미사용
- ubu-2: yosys 0.33 + yosys-abc 번들 정상, load 0, 30G RAM — 본 진단 호스트
- 전송 시간: ~12.8 MB 페이로드 약 3-5s (LAN), abc 실행 < 1s × 2 케이스 → 진단 사이클 매우 가벼움
- 의미: pool 의 가치는 단순 parallelization 이 아니라 **cross-platform 재현으로 플랫폼 가설 즉시 부정** — Mac arm64 의 Abort trap 이 "macOS abc 빌드 이슈" 가 아님이 확정됨 (Linux 에서도 같은 곳에서 동일 abort).

## Cross-reference

- `~/core/demiurge/inbox/notes/rfc006-s5-area-oracle-parity-handoff.md` — rfc006 §5 area-oracle parity 트랙
- `~/core/demiurge/inbox/notes/k69-substrate-axis-yosys-stat-measurement-2026-05-21.md` — κ-69 substrate-axis 측정 트랙
- `~/core/hexa-lang/build/artifacts/gate_v3.c` — gate_v3 자생호스트 산출 C 소스
- pool: `~/.pool/pool.json` (mini · ubu-1 · ubu-2)
- ubu-2 worktree: `summer@ubu-2:~/gate_v3_pool/` (재실행 준비됨)
