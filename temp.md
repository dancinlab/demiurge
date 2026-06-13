# RTSC reconcile — 재부팅 후 이어서 (2026-05-30)

## 왜 재부팅
발사 Agent가 `( nohup dft-run & )` double-fork로 **launchd(PPID=1) 좀비** 양산.
pkill로 죽여도 Agent가 재발사 → vast pod 4→29 폭증. 재부팅하면 launchd 좀비 전멸 → 양산 종결.

## 재부팅 직후 순서

### 1. 좀비 잔존 확인 (없어야 정상)
```
ps aux | grep dft-run | grep -v grep   # 0이어야
```

### 2. vast 정리 — 유지 4개만 남기고 전부 down
**유지(절대 보존):** `37868501`(ysbh6 el-ph) `38382692`(Li2MgH16 el-ph) `38495596`(H3S el-ph) `38546678`(LaBH8 vc-relax)

**down 방법 주의:** `for`루프·`$(command sub)`·`| grep` 은 pool-route 거치며 깨져서 실제 안 죽음.
→ **세미콜론 직접 나열만 작동.** 단일 `hexa cloud down <id>`는 확실히 됨.
```
hexa cloud list | grep '^  vast' | awk '{print $2}'   # 현재 목록 재확인
# 유지 4개 빼고 세미콜론으로 나열:
hexa cloud down <id1>; hexa cloud down <id2>; ...
```
(재부팅 전 down 대상 24개였음: 38551548 38551552 38551965 38551969 38552113 38552617 38552740 38552810 38552843 38552844 38552845 38552944 38552955 38552968 38553257 38553262 38553266 38553273 38554157 38554168 38554178 38554237 38554354 38554355 — 단 38551450 이미 down. **재부팅 후 list 재확인 필수**)

### 3. 안정 후 17 candidate 클린 재발사 (1 pod=1 candidate · 순차)
**규칙:** 절대 bin-pack 금지. dft-run은 **relative path만**(절대경로=sign gate 차단). `cd exports/rtsc/decks && hexa cloud dft-run <deck>`.
**순차 발사** (병렬 fork-storm 금지 — 이번 사고 원인). 한 번에 1~2개씩.

대상 17 (전부 vc-relax부터):
- BeH8군: LaBeH8(20G) ScBeH8(50) YBeH8(50)
- 단순수소화물: LaH10(250) YH6(166) YH9(250)
- Y2XH18 큰셀(--disk 80): Y2InH18 Y2CdH18 Ca2SnH18 (250G)
- perovskite/clathrate: BaAuH3(50) SrPtH3(50) YAuH3(50) KBeH8(100) MgBeH8(100) ScH9(150) CeH9(100G) LaY_H10(250)

## 미반영 작업 (재부팅과 무관, 마무리 필요)
- **deck 버그 수정 uncommitted**: ScH9·CeH9·LaY_H10·MgBeH8 등 9개 `.in` 파일의 절대경로 outdir → relative(`./out`) 수정됨. **커밋 필요.**
- **FORK_STORM_CAP 8→16** 변경됨: `~/.claude/plugins/cache/sidecar/pool-route/0.18.0/bin/_pool_route.hexa` — 원복 검토.
- **ledger(`RTSC_LEDGER.jsonl`) 26줄, 무결**. 재발사 17종 pod-id 미등록(다 down될 거라 무의미) — 재발사 후 새로 등록.

## 이미 끝난 것 (재작업 불필요)
- ledger 정정 완료: YSbH6→running, CaBeH8→🔴 CLOSED-negative(VERDICT.md 있음·재발사 금지), CaAuH3-SOC/novel-batch→crashed+down
- DOWN 완료: 38367660 38444699 38384813 38095989 38546666 38546668 (+ 38551450, 38554187)
- memory 저장: `feedback_no_binpack_one_pod_one_candidate` (1 pod=1 candidate)
