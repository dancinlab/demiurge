# 모든 후보 최종 검증 매트릭스 (신규성 + ⟨g⟩ + SC-pairing-channel · c2/d6 honest)
검증 깊이: A 신규성(arxiv) · B ⟨g⟩(컨벤션 audit RESOLVED) · C SC pairing channel(실재료, 가장 깊은 게이트)

| candidate | 2D-BKT Tc (glue-side) | novelty | SC-channel verdict | grade |
|---|---|---|---|---|
| tMoTe2 (moiré C=1)        | 16K  | PARTIAL(published) | ✅ real SC ~1-3K, geom order-consistent | 🟢 DEFENSIBLE (유일 통과·최저Tc) |
| CoSn (kagome SOC-iso)     | 128K | NOVEL | 🟡 UNKNOWN→PLAUSIBLE-via-gating (FB 80-100meV<E_F·도핑→spin-glass) | 🟡 GLUE-ONLY |
| Nb3Cl8 (breathing-kagome) | 99K  | NOVEL | 🟡 UNKNOWN (Mott 1.5eV·압력 100GPa BLOCKED·도핑 PLAUSIBLE) | 🟡 GLUE-ONLY |
| sp2C N-Lieb COF (Lieb)    | 136K | NOVEL/partial | 🔴 BLOCKED (실재료 FB 매장<E_F·wide-gap·도핑→Dirac밴드·EPC무시·CDW) | 🔴 REJECT(이상모델뿐) |
| graphene-Kekulé           | (547K)| PARTIAL | — (pair 비compact) | 🔴 REJECT |
| Re6Se8Cl2 (anchor)        | 5K   | published | real SC ~8K but pair 비compact | 🔴 REJECT(앵커) |
| light-kagome TARGET       | 290-680K(unverified) | OPEN-NOVEL | top=hP8-B 보론 kagome(금속FB@E_F·140meV glue) | 🟡 DESIGN(덱 spec) |

🆕 NEW LEAD: GaNb4Se8(2.9K)/GaTa4Se8(5.8K)/Ge-GaNb4Se8(45K) cluster-Mott bond-phonon SC = off-diagonal FB-GEOM 기전의 경험적 family-validation + 더 나은 실후보.

## 정직한 종합 (d6)
- **확립된 고-Tc 후보 = 없음.** tMoTe2만 실 SC(저온 ~1-16K). 고-Tc 투영(128/136/...)은 전부 glue-side/이상모델 숫자 — 검증 안 된 캐리어 채널에 조건부, "확립 SC Tc"로 보고 금지.
- **기전(off-diagonal bond-Peierls 기하강성)은 健全 + family-validated(GaNb4Se8).** high-⟨g⟩ 국소화는 자기상쇄 아님.
- **벽 = 실재료 캐리어 채널** (CoSn FB<E_F+자성 / Nb3Cl8 Mott / COF wide-gap). flat-band이 high-⟨g⟩를 주는 바로 그 국소화가 캐리어도 가둠.
- **2 구체 다음-compute(무료, 포드 無)**: (1) hP8-B 보론 kagome 기하-route 덱(QFORGE GPU davidson) → Δ(기하Tc vs λTc) OR closed-neg, (2) GaNb4Se8 패밀리 = 실 bond-phonon SC lead.
