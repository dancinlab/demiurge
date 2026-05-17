# hexa-arch — universal hexa-native technical-design architecture program

> Standalone repo · `~/core/hexa-arch` · created 2026-05-18 · Status: **SCAFFOLD**
> Family: sibling of `hexa-matter` (물질·소재) · `hexa-bio` (화학분자).
> This one = **모든 기술설계의 아키텍쳐** — chip is one domain, space another, …
> Single self-contained handoff for picking this up anywhere: `HANDOFF.md`.

---

## Concept

```
📐 HEXA-ARCH — "만능 설계 아키텍쳐 프로그램"

- 하는 일: 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계 의
           7-verb hexa-native 파이프라인으로; 분야는 플러그인 도메인으로 꽂힘
- 비유: 만능 설계실 — 칩·가속기·초전도·우주선·BCI 책상이 한 건물 안에
```

```
            hexa-arch (umbrella)
   ┌───────────────────────────────────────────────────┐
   │ 명세→구조→설계→해석⟲→합성→검증→인계               │  7-verb 범용 파이프라인 (cited)
   └───────────────────────────────────────────────────┘
       │      │       │      │      │      │       │
    [chip] [cern] [anti-  [rtsc] [space][energy][brain]
   EDA    가속기   matter  초전도  우주선  배터리  BCI 임플란트
       ▲
     comb (hexa-lang, n=6 fabric) 가 [chip] 도메인을 *사용*
     — 소비자일 뿐, EDA 흡수 주체 아님 (typed-interface 패턴)
     hexa-matter/hexa-bio 도 동일 패턴 (소비, 흡수 X — design.md D2)
```

vs 기존: hexa-matter = 물질을 계산, hexa-bio = 분자를 계산, **hexa-arch =
설계 자체를 계산·검증** (분야 무관 메타프레임워크). 외부 오픈소스를 도메인별로
흡수하는 메커니즘은 hexa-matter(⟵ASE/pymatgen)·hexa-bio(⟵AlphaFold) 와 동일.

## Files

- `HANDOFF.md` — **완전 자기완결 인수인계**. 다른 곳/세션에서 0-context 로
  이어가기 위한 단일 문서 (전체 외부-오픈소스 매핑표 포함). 먼저 읽을 것.
- `CHARTER.md` — mission · scope · non-goals · 거버넌스 · 도메인 모델
- `PLAN.md` — 진행 로그 SSOT
- `ARCH.tape` — tape v1.2 인덱스 (identity · 도메인맵 · 흡수 패턴)

## Related repos (구분 — 혼동 방지)

- `~/core/hexa-chip` — **별개 기존 repo** (5G/6G·advanced packaging·accel).
  hexa-arch 의 chip *도메인*(EDA 설계 파이프라인 흡수) 과 다름. 향후 조율은
  HANDOFF §related 참조.
- `~/core/hexa-space` — 별개 기존 repo. 향후 hexa-arch 의 space 도메인과
  연계 가능 (현재 미연결).
- `~/core/hexa-lang` — substrate. `comb/` (n=6 fabric R&D) 가 첫 소비자.

## First domain = chip (drives comb)

chip 도메인이 외부 EDA(gem5-Garnet/BookSim2 · Yosys · OpenROAD · Verilator ·
ngspice · SKY130 …)를 흡수. 첫 산출 = NoC 사이클 sim → hexa-lang `comb`
RFC 057 F1/F2 (degree-6 vs degree-4) 직접 해소. 전체 매핑 = `HANDOFF.md`.
