---
title: DAPTPGX M11 — POC CYP2C19 genotyping devices (Spartan RX · Genomadix Cube · Verigene · AutoGenomics INFINITI · 한국 ID-CHIP)
target_repo: atlas
target_kind: hw-ref
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# §0. 한 줄 요약

M7 §8.1 cath-lab 60-min TAT 약속은 **POC genotyping hardware** 에 의존 — 현 시점 (2026-05) **available 한 FDA 510(k) 기기는 Genomadix Cube 단 1개**. Spartan RX (회사 청산) · Verigene CYP2C19 (discontinued) · AutoGenomics INFINITI (정밀 lab) 모두 fail 또는 unavailable. 한국 ID-CHIP (KRIBB?) ⚪ SPECULATION-FENCED — **HW layer 가 M7 결정맵의 약한 고리**.

---

## §1. 도구 비교 표

| Device | Maintainer | License/Reg | 한국 도입 | TAT | Sens/Spec | Status | URL |
|---|---|---|---|---|---|---|---|
| **Genomadix Cube CYP2C19** | Genomadix (Spartan Bio 후신, Canada) | FDA 510(k) cleared (medium complexity) | ⚪ KFDA 미확인 | ~60 min | 100% / 100% (systematic review 2024) | 🟢 **유일 생존 FDA POC** | https://genomadix.com/genomadix-cube-cyp2c19-test/ |
| **Spartan RX CYP2C19** | Spartan Bioscience (Canada, 청산됨) | FDA 510(k) 과거 cleared | 서울대 등 일부 (M7 §8.1) | ~60 min | 100% / 100% | 🔴 **discontinued** (회사 liquidation) | n/a (history) |
| **Verigene CYP2C19** (Luminex) | Luminex (now DiaSorin) | FDA cleared 과거 | ✗ | ~3 h | 매우 높음 | 🔴 **Luminex가 CYP2C19 cartridge 단종 확인** (2024 systematic review) | https://www.diasorin.com (history) |
| **AutoGenomics INFINITI CYP2C19** | AutoGenomics | FDA cleared (lab) | ⚪ | ~8 h | high | 🟡 lab POC 아님 (4-8h) | https://www.autogenomics.com (확인) |
| **한국 ID-CHIP** ⚪ SPECULATION-FENCED | KRIBB? 또는 한국 진단기기 회사? | ⚪ KFDA 미확인 | 🟢 (한국 origin 추정) | ⚪ | ⚪ | ⚪ direct confirmation 필요 | n/a (1차 source 부재) |
| (참조) PCR (lab-based) | 일반 분자진단 | KFDA lab | 🟢 광범위 (Big-5 + 중형 병원) | 2-4 h | high | 🟢 backup path | n/a |
| (참조) NGS panel (확장) | ClinPharmSeq 등 | research/clinical | 일부 academic | 1-3 d | very high (다중 변이) | 🟢 (TAT 길지만 cover 광범위) | https://github.com/sbslee/clinpharmseq-paper |
| (참조) 신생 — smartphone microfluidic | 학계 PoC | n/a | ✗ | ⚪ | ⚪ | 🟠 prototype | n/a |

---

## §2. M7 §8.1 60-min TAT 약속의 현재 평가

| Device | 가용성 | KR 임상 도입 가능성 | M7 §8.1 cath-lab fit |
|---|---|---|---|
| Genomadix Cube | 🟢 (구매 가능) | 🟡 KFDA 인증 필요 (Spartan과 largely equivalent 인정 시 가속) | 🟢 OK |
| Spartan RX | 🔴 (단종) | 🔴 | 🔴 |
| Verigene CYP2C19 | 🔴 (단종) | 🔴 | 🔴 |
| AutoGenomics INFINITI | 🟡 (lab POC 분류) | ⚪ | 🟠 (TAT 4-8h, primary STEMI 부적합) |
| 한국 ID-CHIP | ⚪ | ⚪ | ⚪ |

→ **현재 한국 cath-lab 에 즉시 deploy 가능한 FDA-POC = 0개 (KFDA 별도)** + lab PCR 2-4h backup 만 신뢰성 있음. M7 §8.1 의 60-min 약속이 사실상 Genomadix Cube 단독 의존 + KFDA 진입 미확정.

---

## §3. handoff request

### §3.1 atlas K=X (HW ref) 등록

```
atlas append-witness --kind X --id Genomadix.Cube.CYP2C19.FDA510k.tat60min \
  --raw 'Genomadix Cube — FDA 510(k) cleared, ~60 min TAT, Sens/Spec 100% (Tandfonline 2024 systematic review). Successor to Spartan RX/FRX (largely equivalent).'

atlas append-witness --kind X --id Spartan.RX.CYP2C19.discontinued.2022 \
  --raw 'Spartan RX — Spartan Bioscience liquidated, manufacturing ceased. Historical M7 §8.1 reference for SNU import only.'

atlas append-witness --kind X --id Verigene.CYP2C19.discontinued \
  --raw 'Verigene (Luminex/DiaSorin) — CYP2C19 cartridge discontinued (2024 systematic review confirmation). Other Verigene panels remain.'

atlas append-witness --kind X --id KRIBB.ID-CHIP.CYP2C19.kr \
  --raw '⚪ SPECULATION-FENCED — Korean ID-CHIP CYP2C19 platform, KRIBB or 진단기기 회사 origin 미확인. 1차 source needed.'

atlas append-witness --kind X --id ClinPharmSeq.NGS.panel.kr.sbslee \
  --raw 'ClinPharmSeq — Korean clinical PGx NGS panel (sbslee, PLOS ONE 2022). TAT 1-3d, 27-gene cover, PyPGx pipeline.'
```

### §3.2 hexa-lang manifest only (no code)

POC HW 는 hexa-lang stdlib 에 wrapper 코드 신설 안 함 (HW 가 source-code 가 아님). 대신:

```
hexa-lang/stdlib/bio/pgx/poc/
└── poc_devices.ai.md       # 도구 매트릭스 + 권장 deployment 문서 (manifest only)
```

→ atlas SSOT 가 HW 식별의 single source, hexa stdlib 은 reference doc 만 유지.

### §3.3 next-action ticket

```
priority 1: 한국 ID-CHIP confirmation
  - KRIBB (한국생명공학연구원) 분자진단 그룹 contact
  - 식약처 의료기기 DB 검색 ("CYP2C19" + "한국")
  - 분당서울대/서울아산 LDT 사용 platform 확인
  - 결과 → atlas K=X update + 본 노트 status=absorbed

priority 2: Genomadix Cube KFDA 진입 경로
  - 캐나다 Genomadix Inc.의 한국 distributor 확인
  - 식약처 의료기기 인허가 (Spartan RX 과거 인증 승계 가능성)
  - 결과 → M7 §8.1 60-min TAT 약속의 실현 가능 시점 확정
```

---

## §4. 한국 환경 적용 가능성

- **Genomadix Cube** — 캐나다 FDA 510(k) 기기. 한국 KFDA 신규 인증 또는 Spartan RX 인증 승계 (equivalent device) path. distributor 없으면 individual import (병원 ethics committee).
- **한국 ID-CHIP** ⚪ — KRIBB 분자진단 platform? 또는 마크로젠 등 진단회사? 1차 source 부재로 specs/TAT 미확인. 본 노트 의 가장 큰 정보 공백.
- **lab PCR 2-4h** — Big-5 + 중형 병원 routine 검사실 가능. M7 §8.1 의 STEMI primary (golden time) 에는 too slow 그러나 NSTE-ACS · elective PCI 에는 충분. **현실적 한국 standard**.
- **NGS panel (ClinPharmSeq)** — sbslee 의 한국 panel. 27-gene cover, TAT 1-3d 라 acute setting 부적합, 그러나 once-in-lifetime preemptive 시나리오 (M7 §5.2 genotype re-test 비권고 with germline) 에 적합.
- **KFDA 인허가** — Genomadix Cube 의 한국 진입 미확정 + Spartan RX 시절 일부 병원 import 경험만 존재.
- **NHIS 수가** — CYP2C19 검사 수가 코드 존재 (확인 필요), POC vs lab 수가 분리 여부 불확실.

---

## §5. license/regulation 호환성

| Device | FDA | KFDA | EC CE | NMPA (중국) |
|---|---|---|---|---|
| Genomadix Cube | 🟢 510(k) | ⚪ 미확인 | 🟡 추정 | ⚪ |
| Spartan RX | (과거 🟢) | (과거 일부 import) | (과거 🟡) | ⚪ |
| Verigene CYP2C19 | (과거 🟢, 단종) | n/a | n/a | n/a |
| AutoGenomics INFINITI | 🟢 (lab) | ⚪ | 🟡 | ⚪ |
| 한국 ID-CHIP | ⚪ | ⚪ | ✗ | ✗ |

→ POC HW 는 hexa-lang 직접 통합 대상 아님 (HW 는 source 가 아님). atlas SSOT 에 reference 만 등재.

---

## §6. ⚪ SPECULATION-FENCED

- 한국 ID-CHIP 의 origin · CYP2C19 cover · TAT · KFDA 등록 (1차 source 미확보, 본 노트의 최대 정보 공백)
- Genomadix Cube 의 한국 KFDA 인증 status (Spartan RX 인증 승계 가능성 미확인)
- AutoGenomics INFINITI 의 한국 도입 사례
- 한국 NHIS 수가 코드 (CYP2C19 검사 분류 N0017? 또는 다른 코드)
- 신생 microfluidic / smartphone PoC 의 상용화 시점

---

## §7. 핵심 통찰 (3 bullets)

- **POC HW layer 가 M7 결정맵 전체에서 가장 약함 — single point of failure (Genomadix Cube)** — Spartan RX 청산 + Verigene CYP2C19 단종으로 2022 이후 FDA-cleared POC 는 Genomadix Cube 1개. M7 §8.1 의 60-min TAT 약속 실현이 단일 vendor + 한국 KFDA 진입 미확정에 의존 → **fragile**. backup = lab PCR 2-4h (STEMI 골든타임 fail).
- **한국 ID-CHIP confirmation 이 next-priority 1** — 한국 origin POC HW 가 실제 존재하고 KFDA 인증 + cath-lab fit (60min) 이면 M7 §8.1 의 vendor risk 즉시 해소. KRIBB 또는 진단회사 직접 contact 가 single highest-leverage action.
- **NGS panel (ClinPharmSeq) preemptive 가 long-game best path** — POC 60min 약속이 fragile 한 반면, preemptive WGS/panel 은 한 번 측정 → 평생 사용 (M7 §5.2 once-in-lifetime). 비용 hurdle 만 ↓ 시 (NHIS 수가 신설) M7 cube 의 input layer 가 fundamentally robust 해짐. 5-10y 시점에서 POC HW 의존도 자체가 ↓ 예상.

---

## §8. cross-reference

- PMID/PMC: PMC11418221 (2024 systematic review POC CYP2C19), PMC11031274 (community hospital bedside CYP2C19), PMC7641128 (Thai WGS PGx)
- M7 매핑: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §8.1 (POC table), §5.2 (once-in-lifetime genotype)
- atlas K-prefix: `X` (HW reference)
- next action: 한국 ID-CHIP 1차 source 확인 (KRIBB contact)
