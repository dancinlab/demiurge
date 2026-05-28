# RTSC — 40후보 vast.ai 발사 계획 (phased · 2026-05-29)

> 본 문서는 `domains/rtsc.candidates.md` 의 40 신규 후보(A01–A40)를 vast.ai 로 발사하기 위한
> **phased 발사 로드맵**이다. 핵심 관문은 deck 준비(구조) — substitution 은 anchor 구조 재활용으로
> 즉시, 신메커니즘은 구조예측(CSP) 선행. 참조 verdict: YH₁₀ Tc 227.5K@250GPa (#486 · atlas #1909).

## 0. 전략 — 압력 벽 직격

RTSC 중간평가 결론: **온도축은 근접(227/293K=77%), 압력축이 5자리수 본질 벽**. 검증 후보 전부
200–250 GPa. 따라서 발사 우선순위는 **압력을 낮추는 메커니즘**(Be-precompressor · quench)에 가중.

## 1. deck-readiness 3분류

### Wave 1 · 즉시 발사 (anchor substitution · ~22개)

구조 = 기존 prototype 의 원소 치환 → vc-relax 로 최적화. deck 즉시 생성 가능.

| 그룹 | 후보 | anchor 구조 |
|---|---|---|
| Be계 | A01 MgBeH8 · A02 KBeH8 · A03 NaBeH4 · A04 RbBeH8 · A05 Sr2/Ba2BeH7 · A06 BeB2Hx · A07 Be3Hx | AcBeH8 (fcc, #2411.19028) |
| Perovskite | A08 SrPtH3 · A09 SrPdH3 · A10 BaAuH3 · A11 CaAuH3 · A12 TiAuH3 · A13 ZrAuH3 · A14 LaAuH3 · A15 YAuH3 · A16 Ca/SrCuH3 | SrAuH3 (Pm-3m) |
| BCS | A25 Mg₁₋ₓCaₓB2 · A26 Mg₁₋ₓAlₓB2 | MgB2 (P6/mmm) · $0 pod 재사용 |

### Wave 2 · CSP 선행 (신구조 예측 필요 · ~14개)

prototype 없음 → vc-relax 다구조 스캔 또는 USPEX/CALYPSO 구조예측 선행.

A17–A20 pnictogen · A21–A24 twisted-bilayer · A28 topological · A29–A32 quasi-1D · A37–A40 wild-cards

### Wave 3 · 특수 공정 (metastable/strain · ~4개)

A33 LaH10@ambient quench · A34 YH10 strain thin-film · A35 CeH9 epitaxial · A36 H3S epitaxy

## 2. budget · pod 추정

| 축 | 값 | 근거 |
|---|---|---|
| 잡당 wall | ~50–150h | 5–10 atom · nq~8 · ph el-ph (preflight `cloud preflight --kind dft-phonon --atoms N --nq M` #1885) |
| pod 제약 | cores ≤64 · ≤8 jobs/pod | manifest design_constraints (throttle 안전) |
| pod 수 | 40 / 8 = 5 pod | LPT bin-packing |
| cost | ~$120 | vast $0.2/hr × ~120h × 5 pod · budget $750 의 16% |
| $0 재사용 | ssh9(128c, cabeh8 np8) ~120 core 여유 | Wave 1 일부 무비용 |

## 3. 발사 순서 (압력 벽 직격 우선)

| 차수 | 후보 | 비고 |
|---|---|---|
| 🥇 1차 (파일럿) | A01 MgBeH8 · A11 CaAuH3 · A25 Mg₁₋ₓCaₓB2 | ⭐ + 압력축 · deck/파이프라인 검증 · ~$10 |
| 🥈 2차 | Wave 1 잔여 substitution (~19개) | 5 pod bin-pack · ~$60 |
| 🥉 3차 | Wave 2 CSP (구조예측 agent 선행 후) | ~$40 |
| 🛸 4차 | Wave 3 metastable | ~$10 |

## 4. 운영 메모

- **발사 전 preflight**: `cloud preflight --kind dft-phonon --atoms N --nq M [--metallic]` walltime 사전점검 (#1885)
- **deck 표준**: vc-relax → scf → ph(el-ph simple). 압력은 후보별 명시 (absorbed=true 후보는 1atm 필수)
- **pseudo 확인** (d13): 원소 coverage. 5d/4f 원소(Pt·Au·La·Y·Ce)는 SOC 고려
- **env-loss 방지** (#1864): `cloud nohup --source /root/miniforge3/etc/profile.d/conda.sh` 또는 명령에 conda activate prepend
- **atlas 누적** (g62): 🟢 verdict 마다 `hexa atlas register --from-verify allen_dynes_tc <λ> <ω_log> <μ*> <Tc>` (#1901 + #1913 으로 rounded-literal fold)
- **회수 대비**: vast transport-drop 시 `cloud reboot <id>`(미배선 — vast_reboot 직접) + QE recover resume. 2026-05-29 13잡 dark 회수 선례 참조 (INBOX #1966·#1978)

## 5. 현 자원 상태 (발사 시점)

- vast 양 pod (ssh6 37868501 · ssh9 38095989) 8잡 grinding 중 (회수 6 + 진행 2) · billing
- ssh9 여유 큼 (cabeh8 np8 만 사용) → Wave 1 일부 흡수 가능
- throttle storm 반복 → deck 준비 agent fan-out cap 2–3 (분산)
- y2be2h6 = restart-needed (deck redesign, relax geom 보존) — Wave 재설계 시 포함

## 6. deck 준비 (Wave 1 선행 작업)

substitution 후보의 deck = anchor 구조 CIF/POSCAR + 원소 치환 + vc-relax 입력 + pseudo. 후보별:
1. anchor 구조 확보 (arxiv/Materials Project/직접 작도)
2. 원소 치환 → 초기 격자 스케일
3. vc-relax.in · scf.in · ph.in 생성 (deck 표준)
4. pseudo 매칭 (d13 coverage)
5. `cloud preflight` sizing → pod 배치

이 5단계가 Wave 1 의 실제 선행 — agent fan-out (후보별 1 agent, throttle cap 내).
