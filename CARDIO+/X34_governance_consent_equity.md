# X34 — 거버넌스·동의·형평 (배포 제도·윤리·접근성 인프라)

> CARDIO+ 메타도메인 X34 산출물 · cross-cutting · current-state · no history.
> **목적 (1줄) = X29 EMR-CDS 배포가 한국 병원에서 실제로 돌아가게 만드는 3대 제도 인프라 — (a) 다학제 PGx 위원회(병원 내 거버넌스 바디), (b) genotype 동의·데이터 거버넌스(저장·재사용·프라이버시·재동의 · 한국 개인정보보호법·생명윤리법), (c) 형평/접근(비-3차 지역 PCI 센터까지 POCT+telegenetics 로 3-axis 도달성↑)를 spec 수준에서 형식화한다. 본 문서는 제도 설계(institutional design)이며 법률 자문·실배포가 아니다.**
> 출처 = X29 (BPA 배포·POCT turnaround·SaaS scale-out·audit log·tenant 격리 VERBATIM) · X18 (3국 분포 transport / 백인 비적용 / 형평 분포 근거 VERBATIM) · X9 (§5 3-axis panel 6-wall 동시 · 채혈 1회 NHIS 급여 배포 VERBATIM) · X15 (§1 채혈 1회 + 동의·자의중단 금지 환자 프레이밍 VERBATIM) · X8 (g5 rubric VERBATIM). grade 는 X8/X29/X18/X9/X15 ledger VERBATIM — **X34 새 판정 0건** (per @D g5 · LLM self-judge 0건).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 본 문서는 **PGx 결정지원 시스템 배포의 제도·윤리·접근성 설계이며, 법률 자문·처방·진단·용량 지시가 아니다.**
> - **법적 해석 ≠ 법률 자문 (가장 중요)**: 아래 §2 의 한국 법령(개인정보보호법·생명윤리및안전에관한법률) 적용·동의 모델·보관/재사용 판단은 본 문서 작성자의 **제도 설계 가정(⚪/🟡)**이며, **반드시 별도의 전문 법률 검토(IRB·개인정보보호책임자·기관생명윤리위원회 IRB·법무)를 거쳐야 한다.** 어떤 동의 문안·보관 기간·재사용 범위도 법적 확정으로 해석해서는 안 된다.
> - 모든 약제·검사·용량·중단 결정은 심장내과 전문의가 환자별로 종합 판단한다. 위원회·동의·형평 설계는 **거버넌스 구조**이며 임상 결정을 대체하지 않는다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험 (X15 §1 VERBATIM).
> - 근거 등급(g5)은 X8/X29/X18/X9/X15 verify verdict 의 **VERBATIM 인용**이다 (본 X34 가 새로 판정한 것이 아님 · LLM self-judge 0건). 제도 효과(위원회 의사결정 품질 · 동의율 · 형평 도달 격차 해소)는 ⚪/🟠 로 분리한다.
> - **제도 미실증(d6 정직)**: 본 X34 의 위원회 구성·동의 모델·형평 배포는 모두 **설계 명세이며 실 병원 거버넌스 가동·동의 운영·지역센터 배포 0건**이다. 법적 적합성·동의율·도달 격차 해소 효과는 전부 ⚪ SPEC-FENCED / 🟡 / 🟠 — 법률 검토·IRB·실배포 audit 으로만 검증 가능하다. 어떤 제도 수치도 실증 결과로 제시하지 않는다.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric` · X8 §1)

| 등급 | 의미 (X34 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite · 법령 조문 carry (literature/법령 carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · 법률 검토 · 배포 audit 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | calc DETERMINISTICALLY disagrees — 닫힌 음성 (large RCT null 등) |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (제도 효과 추정 · 동의율 · 형평 격차 해소 · **법적 해석**) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 grade 는 X8/X29/X18/X9/X15 ledger 의 verbatim carry 다. 분포 근거(ALDH2*2 40% · CYP2C19 LoF 40% · Lp(a) ≥50 12-13%)는 X18 §1 / X9 §5 VERBATIM, 채혈 1회 NHIS 급여 배포는 X9 §5.2 / X15 §1 VERBATIM, POCT turnaround·tenant 격리·audit log 는 X29 §3/§4 VERBATIM 이다. **법적 해석(개인정보·생명윤리 적용)은 본 X34 의 제도 설계 가정이며 전부 ⚪/🟡 로 격리** — 전문 법률 검토 별도 필요. d6 — 억지 등급/숫자 강제 0건 · 제도 미실증 명시.

---

## §1. 다학제 PGx 위원회 — 구성·기능 표 (#29 병원 내 거버넌스 바디)

> X29 §4 가 정의한 배포 인프라(deterministic backbone · audit log · tenant 격리 · grade ledger read-only)를 **병원 내 의사결정/책임 주체**에 매핑한다. 위원회 = "BPA 트리거·overrideReasons·alert fatigue 게이팅(X29 §1.1)을 누가 승인·감사·재튜닝하는가"의 책임 바디. **직역·역할은 X29 배포 요소를 책임 주체로 매핑한 제도 설계이며, 의사결정 품질·운영 효과는 ⚪ (가동 audit 의존).**

| 직역 | 역할 | 의사결정 범위 |
|---|---|---|
| **심장내과 전문의 (위원장)** | 임상 책임자 — DAPT 결정맵(X29 §1 BPA trigger)·hard gate(≥75세 prasug·CYP3A4+노인 ticag)의 임상 타당성 승인, override 정책의 임상 적정성 검토 | **임상 결정맵 승인** — BPA trigger/severity 의 임상 채택, hard stop vs override 허용 경계 확정 (X29 §1 VERBATIM: hard gate 만 override 불가) |
| **약제부 임상약사 (PGx 약사)** | 약물유전학 해석 — CYP2C19 phenotype→약물 매핑(NM/IM/PM × HBR), 약물상호작용(CYP3A4·ticagrelor) 자문, 약가·급여 경로 검토 | **PGx 해석·약물 매핑 승인** — phenotype→권고 약제 룰, 약물상호작용 alert 내용 (X29 §1 alert = X16 §4 VERBATIM 수준에서만) |
| **진단검사의학과 (검사실)** | caller concordance 책임 — CYP2C19 PCR/POCT caller 정확도(X29 stage 0 1순위), 검체→결과 turnaround, ref 패널(KOVA/KRGDB) 대비 검증 | **검사 품질 gate** — caller concordance 승인이 모든 배포에 선행(X29 §5 stage 0 VERBATIM), POCT cartridge 도입 검증 |
| **의료정보팀 (IT/EMR)** | BPA/CDS Hooks 구현·운영 — FHIR R4 mapping, alert fatigue 4-layer 게이팅(X29 §1.1) 구현, audit log 인프라, tenant 격리 운영 | **시스템 구현·게이팅 운영** — BPA 렌더링(modal/inline/배지), de-dup·관련성 게이팅 구현, audit log·override rate 모니터 (X29 §1.1 VERBATIM) |
| **개인정보보호책임자 (CPO) / 정보보호** | 데이터 거버넌스 — genotype 저장·재사용·de-link(X29 §4 환자 식별 de-link), 개인정보보호법 준수, 침해사고 대응 | **데이터 보호 gate** — genotype store 접근통제·암호화·보관기간(§2), tenant 간 데이터 격리 감사 (X29 §4 VERBATIM) |
| **기관생명윤리위원회 (IRB) 연계** | 윤리 심의 — 연구 재사용 동의·재동의, 잔여검체/유전정보 2차 이용, pilot(shadow mode)·전향 cohort IRB(X29 §5 stage 1·5) | **윤리 심의 gate** — 동의 모델 승인(§2), 연구 목적 재사용 심의, 환자 권리(열람·삭제·동의철회) 보장 |
| **(자문) 임상유전 전문가 / 유전상담** | 유전 결과 상담 — phenotype 의미·평생 1회 측정(X9 §5 "유전 결정 ~90%")·가족 함의 설명 지원, telegenetics 원격 상담(§3) | **유전 결과 커뮤니케이션** (자문) — 환자/가족 결과 설명, 비-3차 센터 telegenetics 상담 백업 (§3) |

> **위원회 핵심**: deterministic 결정 backbone 1개(X29 §4)를 공유하되, **책임은 직역별로 분리**된다 — 임상 채택(심장내과) · PGx 해석(약제) · caller 품질(진검) · 시스템·게이팅(IT) · 데이터 보호(CPO) · 윤리(IRB). 위원회의 단일 합의 원칙 = **권고강도 = 근거강도** — BPA alert·결정맵은 X8 grade / X16 §4 stopping rule VERBATIM 수준에서만 채택하고, ⚪/🟠 영역(배포 효과·미측정 outcome)을 확정처럼 가이드하지 않는다(X30 §champion "근거 초과 홍보 금지" 정신 carry). **위원회 가동의 의사결정 품질·운영 효과는 ⚪ SPEC-FENCED** (가동 audit 의존, 미실증).

### 1.1 위원회 책임 ↔ X29 배포 요소 매핑 (ASCII)

```
 X29 배포 요소 (VERBATIM)                       X34 책임 직역 (governance body)
 ──────────────────────────────                ──────────────────────────────
 §1 BPA trigger / severity / hard gate   ──►   심장내과 (임상 채택) + 약제 (PGx 해석)
 §1.1 alert fatigue 4-layer 게이팅        ──►   의료정보팀 (구현·운영) + 심장내과 (override 정책)
 §3/§5 stage0 caller concordance (1순위)  ──►   진단검사의학과 (검사 품질 gate · 모든 배포 선행)
 §4 genotype store · de-link · tenant 격리 ──►   CPO/정보보호 (데이터 gate) + 의료정보팀 (구현)
 §5 stage1 shadow pilot · stage5 cohort   ──►   IRB (윤리 심의 gate) + 심장내과 (임상 책임)
 §4 grade ledger read-only (X8 VERBATIM)  ──►   위원회 공동 원칙 "권고강도 = 근거강도"
 ──────────────────────────────────────────────────────────────────────────────
 → 단일 deterministic backbone(X29 §4) · 책임만 직역 분리 · 의사결정 품질 = ⚪ (audit 의존)
```

---

## §2. genotype 동의·데이터 거버넌스 표 (#17 저장·재사용·프라이버시·재동의)

> X29 §4 가 정의한 genotype store(평생 1회 재사용 · tenant 격리 · de-link · audit log) VERBATIM 을 한국 법체계(개인정보보호법·생명윤리및안전에관한법률) 위에서 동의·보관·재사용 모델로 형식화한다. **⚠ 아래 "한국 법적 근거" 열의 법령 적용·동의 모델 권고·보관/재사용 판단은 전부 본 X34 의 제도 설계 가정(⚪/🟡)이며, 반드시 전문 법률 검토(CPO·IRB·법무)를 별도로 거쳐야 한다 — 법적 확정이 아니다.**

| 항목 | 한국 법적 근거 (개인정보·생명윤리 · ⚪/🟡 가정) | 동의 모델 (broad / dynamic) | 재사용 / 보관 |
|---|---|---|---|
| **① 진료 목적 genotype 검사·저장** (CYP2C19 PCR — DAPT 결정) | 「개인정보보호법」 제23조 **민감정보**(유전정보 포함) 처리 — 정보주체 **별도 동의** 또는 법령 근거 · 「의료법」 진료기록 보존 · 🟡 (법령 조문 carry) | **specific consent** (진료 목적 명시 1차 동의) — 검사·저장·CDS 활용에 국한 | **진료기록 보존기간**(의료법 통상 10년 — 법률 검토 필요 ⚪) · phenotype 평생 1회(X9 §5 "유전 결정 ~90%") → 재PCI/타병원 재사용은 환자 동의·tenant 격리 전제(X29 §4 VERBATIM) |
| **② 연구 목적 2차 재사용** (cohort·caller 검증·RCT — X29 §5 stage1·5) | 「생명윤리 및 안전에 관한 법률」(생명윤리법) **인체유래물·유전정보 연구** — IRB 심의 + 정보주체 동의(제16·37·38조 계열) · 🟡 (법령 carry · 적용범위 ⚪) | **broad consent** (포괄동의) — 향후 광범위 연구 목적 사전 포괄 동의 + **IRB 심의로 개별 연구 통제** (한국 생명윤리법 정합 가정 ⚪) | **인체유래물은행/유전정보 보관** — 익명화/가명화 후 보관, 보관기간·폐기는 IRB·법령 의존 ⚪ · 재사용 시 IRB 재심의 |
| **③ 동의 변경·확장** (당초 범위 외 신규 연구 — 예: AI/ML refinement M17) | 생명윤리법 — 당초 동의 범위 초과 시 **재동의 또는 IRB 동의면제 심의** · 🟡 (재동의 원칙 carry) | **dynamic consent** (동적동의) — 환자가 결과·재사용 범위를 시점별로 갱신·철회 (전자 동의 플랫폼 가정 ⚪) | 동의 변경 이력 audit log 보존(X29 §3.1 audit VERBATIM 패턴) · 신규 목적 = 재동의 트리거 |
| **④ 프라이버시·접근통제** (de-link · 암호화 · tenant 격리) | 개인정보보호법 **안전성 확보조치**(암호화·접근통제·접속기록) · 가명·익명처리 기준 · 🟡 (조문 carry) | (동의 무관 — 기술적·관리적 보호조치) | genotype store 접근통제 + 환자 식별 de-link(X29 §4 VERBATIM) · 접속기록 audit · 침해 시 통지 의무 ⚪ |
| **⑤ 환자 권리** (열람·정정·삭제·동의철회) | 개인정보보호법 정보주체 권리(열람·정정·삭제·처리정지) + 생명윤리법 동의철회권 · 🟡 (권리 조문 carry) | dynamic consent 가 철회권 운영 매개 (X15 §6 환자 질문 스크립트 정신 carry) | 동의철회 시 연구 재사용 중단·검체 폐기 원칙(예외·범위 = IRB·법률 검토 ⚪) · 진료기록 법정 보존분은 별도 |

> **동의 모델 권고 (핵심)**: **진료(①) = specific + 연구 재사용(②) = broad + 변경(③) = dynamic** 의 **3-계층 하이브리드**를 권고한다 — (1) **진료 목적**은 DAPT 결정에 국한한 **specific consent**(개인정보보호법 제23조 민감정보 별도 동의), (2) **연구 2차 재사용**은 한국 생명윤리법이 IRB 심의를 전제로 하므로 **broad consent + IRB 개별 심의** 조합(포괄동의의 무제한성을 IRB 가 통제), (3) **신규 목적·범위 확장**은 환자가 시점별로 갱신·철회하는 **dynamic consent**(전자 동의)로 재동의 부담을 낮춘다. genotype 은 평생 1회 측정(X9 §5)이라 **한 번의 동의가 평생 재사용을 좌우**하므로 broad/dynamic 조합이 재동의 마찰을 줄이되 IRB·철회권으로 환자 통제를 보장하는 것이 설계 의도다. **단 위 법령 적용·동의 모델·보관기간은 전부 ⚪/🟡 제도 가정이며 — 한국 개인정보보호법·생명윤리법의 구체 적용은 전문 법률 검토(CPO·IRB·법무) 없이 확정할 수 없다 (d6 정직).**

---

## §3. 형평 / 접근 — 3차 병원 → 지역 PCI 센터 도달성 (#12)

> X9 §5.2 "채혈 1회 + PCR panel — 기존 NHIS 급여 안에서 배포 가능" VERBATIM + X29 §3 POCT(~90분 turnaround) + X18 §1 3국 공통 분포 VERBATIM 을 **지역 형평**으로 확장한다. 핵심 = **채혈만 필요한 3-axis 패널**(추가 천자 0 · X11 §1 "채혈 1회")은 3차 병원의 full PGx 인프라 없이도 **지역 PCI 센터에 POCT + telegenetics 로 도달 가능** → 도달 격차를 줄이는 형평 이점. **형평 격차 해소 효과·도달률은 ⚪/🟠 (배포 audit 의존).**

```
╔══════════════════════════════════════════════════════════════════════════════════════╗
║  3-axis 도달성 형평 — 3차 병원 (full) → 지역 PCI 센터 (POCT+telegenetics)               ║
╚══════════════════════════════════════════════════════════════════════════════════════╝

  [3차 병원 — full PGx 인프라]                    [지역 PCI 센터 — 비-3차]
  ┌────────────────────────────┐                ┌────────────────────────────┐
  │ · 다학제 PGx 위원회 (§1)    │   도달 격차    │ · 위원회 미상주 (champion 1)│
  │ · 중앙검사 genotyping       │  ◄══════════►  │ · 중앙검사 송부 → 수일~1주  │
  │ · 임상유전·유전상담 상주    │  (gap 1: 결과  │ · 유전상담 부재             │
  │ · BESTCare/AMIS CDS Hooks   │   지연 · 인력) │ · 단순 EMR / CDS 미통합     │
  │ · cath lab 내부 POCT 가능   │  (gap 2: 인프라)│ · POCT 장비 도입 부담       │
  └─────────────┬──────────────┘                └─────────────┬──────────────┘
                │                                              │
                │            ★ 채혈 1회 3-axis 패널 = 형평 매개체              │
                │   (추가 천자 0 · X11 §1 "채혈 1회" · X9 §5.2 NHIS 급여 배포)  │
                ▼                                              ▼
  ┌──────────────────────────────────────────────────────────────────────────┐
  │  형평 brige 2축                                                            │
  │   ① POCT (X29 §3): cath lab 내부 single-cartridge PCR ~90분               │
  │      → 지역 센터가 중앙검사 수일 대신 퇴실 전 phenotype 확보 (turnaround↓) │
  │   ② telegenetics (원격 유전상담): 3차 병원 임상유전·약제(§1 자문) 가       │
  │      지역 센터 환자를 원격 상담 → 유전상담 인력 격차 보전                  │
  │   + SaaS 중앙 CDS API(X29 §4): 지역 EMR 이 CDS Hooks 로 동일 backbone 호출 │
  │      (d4 tenant manifest only · 병원명 분기 0)                            │
  └──────────────────────────────────────────────────────────────────────────┘
                ▼                                              ▼
  도달 격차 해소 (⚪ 효과 audit 의존):
   gap 1 (결과 지연)  →  POCT ~90분 으로 지역도 퇴실 전 결정 가능 (X29 §3 VERBATIM)
   gap 2 (인프라)     →  telegenetics + 중앙 SaaS CDS 로 위원회·상담 인력 원격 보전
   gap 3 (분포 균일)  →  ALDH2*2 40% · CYP2C19 LoF 40% · Lp(a)≥50 12-13% 는
                         지역-수도권 인구 분포 차이 작음 (East Asian 공통 · X18 §1)
                         → 패널 가치가 지역에서 떨어지지 않음 (형평 정당성)
```

| 형평 축 | 3차 병원 (full) | 지역 PCI 센터 (bridge) | 형평 이점 / grade |
|---|---|---|---|
| genotyping turnaround | cath lab POCT ~90분 또는 중앙검사 | **POCT ~90분 도입** 시 중앙검사 송부(수일) 우회 | 결과 지연 격차↓ · 🟡(X29 §3 carry) + ⚪(도입 효과) |
| CDS 인프라 | BESTCare/AMIS CDS Hooks 통합 | **중앙 SaaS CDS API 호출**(d4 tenant only · X29 §4) | 시스템 개발 부담 없이 동일 backbone · 🟡(X29 §4) |
| 유전상담 인력 | 임상유전·유전상담 상주 | **telegenetics 원격 상담**(§1 자문 직역) | 인력 격차 보전 · ⚪(원격 상담 효과 미실증) |
| 위원회 거버넌스 | 다학제 위원회 상주(§1) | 중앙 위원회 + 지역 champion 연계 | 거버넌스 도달 · ⚪(연계 모델 효과) |
| 패널 자체 부담 | 채혈 1회(추가 천자 0) | **동일 — 채혈만 필요** (X11 §1 VERBATIM) | ★ 채혈-only 가 최대 형평 이점 |

> **형평 최대 이점 (핵심)**: 3-axis 패널은 **채혈 1회 + 추가 천자 0**(X11 §1 "채혈 1회" VERBATIM)이고 **기존 NHIS 급여 안에서 배포 가능**(X9 §5.2 VERBATIM)이므로, 지역 PCI 센터에 요구되는 추가 침습·고가 장비 진입장벽이 본질적으로 낮다 — 환자에게는 **혈액 1 tube 만**이면 N(ALDH2*2)+D(CYP2C19)+L(Lp(a)) 3축이 동시에 stratify 된다(X9 §5.2 6-wall 동시 leverage). 여기에 **POCT(~90분 · X29 §3)로 결과 지연 격차를, telegenetics 로 유전상담 인력 격차를, 중앙 SaaS CDS(d4 tenant only · X29 §4)로 시스템 개발 격차를** 각각 보전하면, 지역 환자도 3차 병원과 동등한 PGx-guided DAPT 결정에 도달할 수 있다. 분포 균일성(ALDH2*2 40% · CYP2C19 LoF 40% · Lp(a)≥50 12-13% — East Asian 공통 · X18 §1 VERBATIM)이 지역-수도권 차이가 작아 **패널 가치가 지역에서 떨어지지 않는다**는 점이 형평 정당성의 생물학적 근거다. **단 도달 격차 해소 효과·POCT 지역 도입률·telegenetics 상담 효과는 전부 ⚪/🟠 — 실배포 audit 으로만 검증 가능(d6 미실증)이며, "현 방법으로 지역 배포 불가" 식 단정은 하지 않는다(d2 — POCT·telegenetics·SaaS 3 bridge 명명).**

---

## §4. g5 grade — X34 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 다학제 위원회 구성·기능 | 🟡 + ⚪ (compositional) | 직역↔배포요소 매핑 = X29 §1/§3/§4/§5 VERBATIM carry · 위원회 가동 의사결정 품질·운영 효과 = ⚪ (audit 의존) |
| §2 동의·데이터 거버넌스 | 🟡 + ⚪ | genotype store/de-link/재사용/audit = X29 §4 VERBATIM · 법령 적용(개인정보·생명윤리)·동의 모델·보관기간 = ⚪/🟡 제도 가정 (전문 법률 검토 별도 필요) |
| §3 형평/접근 | 🟡 + ⚪ | 채혈 1회 NHIS 급여 = X9 §5.2 / X11 §1 VERBATIM · POCT turnaround = X29 §3 VERBATIM · 분포 균일 = X18 §1 VERBATIM · 도달 격차 해소·telegenetics 효과 = ⚪/🟠 (미실증) |

**X34 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — X29 배포 요소 + X18 분포 transport + X9 §5 3-axis panel + X15 환자 동의 프레이밍 + X8 grade rubric 을 **한국 병원 PGx 배포의 제도(위원회)·윤리(동의·데이터)·형평(지역 접근) 인프라로 형식화**. **X34 새 판정 0건** (per @D g5 · LLM self-judge 0건). 위원회 직역↔배포요소·genotype store·채혈 1회 NHIS 급여·POCT turnaround·3국 분포는 X29/X9/X18/X11 VERBATIM carry · grade 는 X8 ledger VERBATIM · **법적 해석(개인정보보호법·생명윤리법 적용·동의 모델·보관기간)은 전부 ⚪/🟡 로 격리(전문 법률 검토 별도 필요)** · 제도 효과(위원회 의사결정 품질 · 동의율 · 형평 도달 격차 해소 · telegenetics 상담 효과)는 ⚪/🟠 정직 격리(d6 — 제도 미실증 명시) · d2 — 지역 배포 격차에 POCT·telegenetics·SaaS 3 bridge 명명("불가" 단정 0회) · "거버넌스, 처방 아님" 톤 · completed-form 제도 설계(d1).

---

## §5. X34 산출 요약

- **다학제 위원회 (#29)**: 단일 deterministic backbone(X29 §4)을 공유하되 책임을 **7 직역으로 분리** — ① 심장내과(위원장·임상 채택) ② 약제부 PGx 약사(phenotype 해석) ③ 진단검사의학과(caller concordance gate — 모든 배포 선행, X29 stage0 VERBATIM) ④ 의료정보팀(BPA/게이팅 구현) ⑤ CPO/정보보호(데이터 gate) ⑥ IRB(윤리 심의 gate) ⑦ (자문) 임상유전/유전상담. 공동 원칙 = **권고강도 = 근거강도**(X8 grade VERBATIM 수준에서만 채택).
- **동의·데이터 거버넌스 (#17)**: **3-계층 하이브리드** 권고 — 진료(specific · 개인정보보호법 제23조 민감정보 별도 동의) + 연구 재사용(broad · 생명윤리법 IRB 심의 전제 포괄동의) + 변경/확장(dynamic · 전자 동의로 시점별 갱신·철회). genotype 평생 1회 측정(X9 §5)이라 broad/dynamic 조합으로 재동의 마찰↓ + IRB·철회권으로 환자 통제 보장. **법령 적용·동의 모델·보관기간은 전부 ⚪/🟡 가정 — 전문 법률 검토(CPO·IRB·법무) 별도 필요.**
- **형평/접근 (#12)**: 3차 병원(full) → 지역 PCI 센터(bridge)를 **3 bridge**로 연결 — ① POCT ~90분(X29 §3, 결과 지연 격차↓) ② telegenetics 원격 유전상담(인력 격차↓) ③ 중앙 SaaS CDS(d4 tenant only · X29 §4, 시스템 개발 격차↓). **형평 최대 이점 = 채혈-only 3-axis 패널**(추가 천자 0 · X11 §1) + 기존 NHIS 급여 배포(X9 §5.2) + East Asian 분포 균일(X18 §1) → 지역 진입장벽 최소·패널 가치 지역에서도 유지.
- **g5/d1/d2/d6 준수**: 새 판정 0건 · grade X8/X29/X18/X9/X15 VERBATIM · **법적 해석 전부 ⚪/🟡(전문 법률 검토 별도 필요 명시)** · 제도 효과(위원회 품질·동의율·도달 격차·telegenetics) ⚪/🟠 정직 격리(d6 제도 미실증) · 지역 배포 격차에 3 bridge 명명("불가" 단정 0회 · d2) · completed-form 제도 설계(d1) · 거버넌스/처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 PGx 결정지원 배포의 제도·윤리·접근성 설계이며 **법률 자문·처방·진단·용량 지시가 아니다.** §2 의 한국 법령(개인정보보호법·생명윤리및안전에관한법률) 적용·동의 모델·보관/재사용 판단은 본 문서의 제도 설계 가정(⚪/🟡)이며 **반드시 전문 법률 검토(IRB·개인정보보호책임자·법무)를 별도로 거쳐야 한다 — 법적 확정이 아니다.** 위원회·동의·형평 설계는 거버넌스 구조이며 임상 결정을 대체하지 않고, 모든 약제·검사·용량·중단 결정은 전적으로 담당 심장내과 전문의 판단이다. 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험). 근거 등급은 X8/X29/X18/X9/X15 verify verdict 의 verbatim 인용이고, **제도 효과(위원회 의사결정 품질 · 동의율 · 형평 도달 격차 해소 · telegenetics 상담 효과)와 법적 해석은 모두 미실증·미검토 영역(⚪/🟡/🟠)이며 본 X34 의 어떤 제도 설계도 실 병원 거버넌스 가동·법률 검토·실배포 결과로 제시하지 않는다 (d6 정직).**
