# M18 — 외부 배포 runbook (deploy 골격)

> CLI+COCKPIT M18. 외부 사용자에게 **app(.app) + CLI(바이너리)** 를 배포하는 절차.
> 실행 스크립트 = `cockpit/scripts/release.hexa` (hexa-native · `.sh`는 가드 차단). 본 문서는
> 그 runbook 근거 — 테스트(자체서명)는 지금 동작, 배포(Developer ID)는 cert 확보 후.

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

## 실행 스크립트 — `cockpit/scripts/release.hexa`

hexa-native (`.sh`는 가드 차단). `hexa run cockpit/scripts/release.hexa [version]`:

| `DEVELOPER_ID` | 경로 | 시점 |
|---|---|---|
| unset | ad-hoc 자체서명 (`codesign -s -`) | 테스트, 지금 동작 |
| set | Developer ID 서명 + notarytool TODO 출력 | cert 확보 후 |

ad-hoc 경로 검증됨: `demiurge-<ver>.app.zip` + `demiurge-cli-<ver>.zip` 생성, `Signature=adhoc`,
배포 `.app`에 `DEMIURGE_REPO` 미주입 (install.sh와의 핵심 차이).

> 대안: `demiurge release` Swift 서브커맨드(배포도 2-surface op화) — 현재는 release.hexa로 충분.
