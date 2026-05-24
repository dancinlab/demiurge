# M18 — 외부 배포 runbook (deploy 골격)

> CLI+COCKPIT M18. 외부 사용자에게 **app(.app) + CLI(바이너리)** 를 배포하는 절차.
> ⚠ 이 프로젝트는 hexa-native 가드로 새 `.sh` 작성이 막혀 실행 스크립트는 후속
> (`release.hexa` 또는 Swift `demiurge release` 서브커맨드). 본 문서는 **명령이 그대로
> 실행 가능한 runbook 골격** — 테스트(자체서명)는 지금, 배포(Developer ID)는 cert 확보 후.

## 서명 2-경로

```
            ┌─ TESTING (지금) ──────────┐   ┌─ DISTRIBUTION (이후) ─────────┐
build·bundle│  ad-hoc self-sign         │   │  Developer ID sign + notarize  │
   →────────┤  codesign -s -            │   │  (Apple Developer 계정 필요)    │
            │  cert 불필요·로컬 동작     │   │  Gatekeeper 통과·배포 가능      │
            └───────────────────────────┘   └────────────────────────────────┘
```

| 축 | 테스트(자체서명) | 배포(Developer ID) |
|---|---|---|
| 서명 | `codesign -s -` (ad-hoc) | `codesign -s "$DEVELOPER_ID" --options runtime --timestamp` |
| 공증 | 없음 | `xcrun notarytool submit … --wait` + `xcrun stapler staple` |
| 자격 | 불필요 | Apple Developer 계정 + App-specific password |
| Gatekeeper | 타 머신서 우클릭→열기 경고 | 통과 |
| 시점 | **지금 가능** | cert 확보 후 |

## 단계 (cockpit/ 기준)

```
0. hexa 의존성 preflight   command -v hexa  (없으면 경고 — verify/atlas는 hx install 필요 · M16)
1. release build           swift build -c release --product CockpitApp
                           swift build -c release --product DemiurgeCLI
2. .app 번들 조립           dist/demiurge.app/Contents/{MacOS,Resources} + Info.plist
                           (아이콘: generate-icon.swift → sips → iconutil · install.sh와 동일)
                           ⚠ 배포 .app은 install.sh의 LSEnvironment DEMIURGE_REPO 미포함
                              (외부 사용자는 자기 state를 찾음 · 이 checkout 아님)
3. CLI 조립                 dist/bin/demiurge ← .build/release/DemiurgeCLI
4. 서명                     테스트: codesign --deep --force -s - dist/demiurge.app
                                    codesign --force -s - dist/bin/demiurge
                           이후:  codesign --deep --force --options runtime --timestamp \
                                    -s "$DEVELOPER_ID" dist/demiurge.app   (+ notarytool)
5. zip                      ditto -c -k --keepParent dist/demiurge.app dist/demiurge-<ver>.app.zip
                           ditto -c -k dist/bin dist/demiurge-cli-<ver>.zip
검증                        codesign -dv --verbose=2 dist/demiurge.app
```

## 외부 사용자 설치 사전조건

| 항목 | 방법 |
|---|---|
| hexa stdlib 커널 | `hx install` (hx 의존성 · 번들 X · M16) — verify/atlas 계산에 필요 |
| demiurge app | `demiurge-<ver>.app.zip` 압축 해제 → `/Applications` |
| demiurge CLI | `demiurge-cli-<ver>.zip` → PATH에 `demiurge` |
| owner-infra | **불필요** (pool·내 호스트·dancinlab repo 의존 0 · @goal) |

## 실행 스크립트 형태 (후속 결정)

`.sh`는 hexa-native 가드로 차단됨. 두 후보:
- **`cockpit/scripts/release.hexa`** — 가드 권장 hexa-native. stdlib의 spawn 패턴(cellrun.hexa·sweep_oracle_parity.hexa가 `hexa build`+native spawn) 적용
- **`demiurge release` Swift 서브커맨드** — on-theme(배포도 2-surface op화) · `Process`로 swift build·codesign·ditto spawn · `OperationRegistry`에 release op 등재 가능

> 본 runbook의 명령은 그대로 복붙 실행 가능 (테스트 경로). 실행 스크립트화는 위 2후보 중 택일.
