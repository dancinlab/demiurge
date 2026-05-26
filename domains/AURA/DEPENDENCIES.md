# DEPENDENCIES — hexa-aura 의존관계 한 장 요약

> Snapshot: 2026-05-15 · source: `.roadmap.hexa_aura` + `AGENTS.tape` + `~/core/*` 정찰

```
                       echoes/LATTICE_POLICY ─┐
                       atlas/README-FORMAT  ──┤   (거버넌스/포맷)
                       tape v1.2 spec     ────┤
                       bedrock/RSC        ────┤
                                              ▼
   canon(KR) ──────►  hexa-aura  ◄──── wilson (agent harness)
                       │  │  │  │
                  clip │ coil│cortex│safety   (4 pillar)
                       │  │  │  │
                       ▼  ▼  ▼  ▼
                  F-AURA-1/2/3/4 (15 sub-ID, all OPEN)
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
   hexa-rtsc 🔴      hexa-brain 🟠      hexa-mind / hexa-senses (pending split)
   (coil 의존)       (cortex 검증)      (인지/감각 동사 위임)
        │
        └── hexa-chip · hexa-codex · hexa-grid · hexa-cern · hexa-ufo · hexa-bio
            (sibling substrate / serving / sister RSC 모범)
```

**핵심 발견**:
1. hexa-aura 는 **substrate-only** — 인지·감각·디코더 ML 은 모두 sibling 으로 위임 (README `Scope discipline`).
2. **단 한 개의 깨질 수 있는 외부 의존**은 `hexa-rtsc` 뿐 (F-AURA-2 DEMOTE 트리거).
3. 거버넌스 4계층: `echoes` (격자정책) → `bedrock` (RSC) → `atlas` (포맷) → `tape` (문법) → 각 hexa-* repo 가 local copy 로 재-선언.
4. 코드-layer 폐쇄 100% 이지만 **T4 (in-vivo·임상·FDA) 는 전부 unstarted** (§A.6).
