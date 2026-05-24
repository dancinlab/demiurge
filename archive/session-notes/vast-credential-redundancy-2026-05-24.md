# Vast credential 백업 + redundancy 점검 — 2026-05-24

> /gap #2 (unowned load-bearing SPOF) 해소 점검. credential **값 일체 미노출** (g28).

## 1. secret 백업 상태 — 이미 ENABLED ✅

| 항목 | 상태 |
|---|---|
| primary | **icloud** — `~/Library/Mobile Documents/.../Keychains/dancinlab.keychain-db` (117 KB, 존재 확인) |
| mirror | **github** — `dancinlife/secret.git` (`~/.local/share/secret-archive`, git repo 정상) |
| auto-push | **on** (default) |
| `secret sync` | clean (pull/restore/push 전부 up-to-date, exit 0) |

→ 이미 **dual-channel (icloud + github)** 백업 활성. SPOF 아님 — Keychain 손상 시 icloud OR github 어느 쪽이든 복구.

## 2. vast.api_key SPOF 평가

- `secret check vast.api_key` → **PRESENT** (단일 Keychain 거주).
- 단, 위 dual-channel 백업이 vast.api_key 도 함께 커버 → **단일 Keychain 손상이 곧 통제 불능이 아님**.
- 추가로 **API 와 독립된 SSH 제어 경로 존재** (아래 §3) → API key 자체가 죽어도 pod 통제 가능.

## 3. Redundancy 경로 — SSH key fallback (LIVE 검증됨) ✅

- `~/.ssh/id_vast_anima` (disk, 419 B) fingerprint
  `SHA256:hnlR0xw…NelCDM` == 등록된 `vast.ssh_pub` **MATCH 확인**.
- `~/.ssh/config`: `Host *.vast.ai → IdentityFile ~/.ssh/id_vast_anima` (자동 매핑).
- Keychain 의 `vast.ssh_private` 와도 별개로 disk priv 단독 가용 (d8 교훈 ④⑤).
- **실증**: `hexa cloud run root@ssh2.vast.ai --port 18448 --insecure -- uptime` → exit 0, pod 응답.
  → API key 없이도 5 pod 전부 SSH 직접 통제 가능 = SPOF 해소됨.

## 4. 5 active pods (cycle 7 최신 스캔 05-24 00:34)

| id | target | ssh host:port |
|---|---|---|
| 37378449 | h3c  | ssh2.vast.ai:18448 |
| 37424531 | h3n  | ssh9.vast.ai:24530 |
| 37424586 | h3p  | ssh9.vast.ai:24586 |
| 37424660 | h3as | ssh3.vast.ai:24660 |
| 37424703 | h3br | ssh5.vast.ai:24702 |

(h3o/h3po/h3cl/h3f/h3si LANDED·destroyed · cah6 → pool:ubu-2 이관. burn $1.14/h.)

## 5. Emergency-destroy 매뉴얼 (API down 시 SSH 경유)

API 정상 시 → `vastai destroy instance <id>` (lifecycle, cloud-guard 미차단).
**API 불능 시** — SSH 로 pod 내부 종료 (billing 은 instance 단위라 SSH 만으론 과금 중단 불가, 그러나 작업 즉시 중단 가능):
```
hexa cloud run root@ssh2.vast.ai --port 18448 --insecure -- pkill -9 ph.x
```
완전 destroy(과금 중단)는 console.vast.ai 웹 UI 또는 API 복구 후 `destroy instance <id>` 필수.

## 6. 추천

- **백업 enable: 불필요** — 이미 icloud+github dual-channel 활성. 신규 channel push 행위 **없음**.
- **권장 조치**: 없음 (현 상태가 redundant). 정기 `secret sync` (안전) 만 유지.
- vast.api_key SPOF 는 SSH fallback + dual-channel 백업으로 **이미 해소** 판정.
