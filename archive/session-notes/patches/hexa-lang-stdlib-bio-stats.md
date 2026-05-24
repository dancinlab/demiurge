---
title: hexa-lang stdlib bio-stats kernel — HW · binomial CI · Wilson CI · Markov^n · ICER (verify --expr 확장)
target_repo: hexa-lang
target_kind: stdlib-extension (compiler/verify _recompute 분기 + stdlib/bio/stats/*)
status: open
source: demiurge/DAPTPGX V2 formal-identity push
created: 2026-05-24
related: [[hexa-pool-wrapper-compile-bug]] [[2026-05-24-bio-verify-kernel-extension]]
---

# §0. 한 줄 요약

`hexa verify --expr` 의 내장 함수 목록(sigma · phi · mu · tau · is_perfect · aliquot · gamma0_* · jacobi · kronecker)은 number-theory 전용. DAPTPGX 결정맵의 closed-form 항등식(Hardy-Weinberg · binomial CI · Wilson CI · Markov^n row-stochastic · ICER 부호) **8개 bio-stat 함수 추가**로 🔵 SUPPORTED-FORMAL 자동 round-trip 가능. 본 patch 흡수 후 V2 ledger 10+ atom escalation 가능.

---

# §1. 동기 — 현 verify --expr 한계 vs DAPTPGX 수요

| 함수 클래스 | hexa verify --expr 지원 | DAPTPGX 적용 cell |
|---|---|---|
| number-theory (phi · sigma · tau · is_perfect) | 🟢 지원 | 무관 |
| Hardy-Weinberg 다대립 (hw_phenotype) | 🔴 미지원 | C05/C06/C15/C20 (PM/IM+PM/곱cell) |
| binomial 95% CI (Wilson) | 🔴 미지원 | C01/C02/C03/C04/C12/C13 (allele freq + HBR rate) |
| Markov^n row-stochastic check | 🔴 미지원 | C25/C27 (ICER 5y · budget) |
| ICER 부호 invariant (Δcost/ΔQALY) | 🔴 미지원 | C25 reconciliation |

→ DAPTPGX 30 claim 중 **10개** (33%) 가 bio-stat kernel 흡수 시 🟡 → 🔵 직행 가능. 현 staging shard 4개는 binary 흡수 후에만 verify round-trip이 🔵로 닫힘.

---

# §2. 제안 함수 시그니처 (8개)

```hexa
// 1. Hardy-Weinberg 2-allele
fn hw_diplotype(p: f64, q: f64) -> (f64, f64, f64) {
    // returns (homA, het, homB) = (p^2, 2pq, q^2), identity sum=1.
    assert!((p + q - 1.0).abs() < 1e-9);
    (p*p, 2.0*p*q, q*q)
}

// 2. Hardy-Weinberg multi-allele (CYP2C19 *1/*2/*3/*17 같은 ≥3 allele)
fn hw_multiallele_sum(freqs: &[f64]) -> f64 {
    // closed-form: (sum p_i)^2 = 1 (identity)
    let s: f64 = freqs.iter().sum();
    s * s  // expects ≈ 1.0
}

// 3. CYP phenotype aggregation (CPIC mapping)
fn cyp_phenotype_freq(allele_freqs: &HashMap<&str, f64>, phenotype_map: &CpicMap) -> f64 {
    // PM = Σ over PM diplotypes (closed-form HW sum)
}

// 4. Wilson 95% CI for binomial proportion
fn wilson_ci(k: u64, n: u64, alpha: f64) -> (f64, f64) {
    let z = inv_norm(1.0 - alpha/2.0);  // 1.96 for α=0.05
    let p = k as f64 / n as f64;
    let denom = 1.0 + z*z/n as f64;
    let center = (p + z*z/(2.0*n as f64)) / denom;
    let halfw = z * ((p*(1.0-p)/n as f64 + z*z/(4.0*(n as f64).powi(2))).sqrt()) / denom;
    (center - halfw, center + halfw)
}

// 5. Binomial exact CI (Clopper-Pearson)
fn clopper_pearson_ci(k: u64, n: u64, alpha: f64) -> (f64, f64) {
    // exact via incomplete-beta inverse (closed-form for k=0, k=n; else Newton)
}

// 6. Markov^n row-stochastic check (transition matrix)
fn markov_iterate(p_init: &[f64], trans: &[[f64]], n: u32) -> Vec<f64> {
    // each step: row_sum invariant = 1.0 (formal identity)
}

// 7. ICER sign invariant (Δcost/ΔQALY)
fn icer_sign(c_a: f64, c_b: f64, q_a: f64, q_b: f64) -> Sign {
    // closed-form: sign((c_b - c_a) / (q_b - q_a))
    // 🔵 if matches expected sign (dominated · dominant · trade-off)
}

// 8. Budget impact closed-form (Δper-patient × N × years)
fn budget_impact(delta_cost: f64, n_patients: u64, years: u32) -> f64 {
    delta_cost * (n_patients as f64) * (years as f64)
}
```

---

# §3. verify --expr 분기 추가

`tool/verify_cli.hexa` 의 `_recompute` 매칭 테이블에 8개 fn 추가:

```hexa
match fn_name {
    // ... 기존 phi/sigma/... ...

    "hw_phenotype" => {
        // verify --expr hw_phenotype "0.59,0.31,0.08,0.02" 1.0
        let freqs = parse_csv_f64(args[0]);
        let calc = hw_multiallele_sum(&freqs);
        (calc, "Hardy-Weinberg multi-allele identity")
    }
    "wilson_lo" => {
        // verify --expr wilson_lo "k,n,alpha" 0.27
        let (lo, _) = wilson_ci(k, n, alpha);
        (lo, "Wilson 95% CI lower bound")
    }
    "wilson_hi" => { ... }
    "icer_sign" => { ... }
    "markov_rowsum" => { ... }
    // ... 등 8개
}
```

→ `hexa verify --expr hw_phenotype "0.59,0.31,0.08,0.02" 1.0` 가 🔵 SUPPORTED-FORMAL 반환.

---

# §4. atlas K kind 매핑 (현 K 사용 vs 확장 여부)

| 현 K kind | 적합도 | 비고 |
|---|---|---|
| `@P primitive` (455개) | 🟡 가능 | "primitive" 의미가 fundamental 물리상수 위주 — PGx allele freq에 의미 매칭 약함 |
| `@F formula` (1313개) | 🟢 best | DAPTPGX의 HW closed-form, ICER 공식이 정확히 "formula" 정의 부합 |
| `@L law` (531개) | 🟢 best for HW identity | Hardy-Weinberg는 law of conservation (p²+2pq+q² ≡ 1) |
| `@C constant` (5763개) | 🟡 | clinical cited rate (예: NHIS 약가) 는 measured constant 적합 |

**제안 매핑** (V2 staging shard에 적용):

| atom | kind |
|---|---|
| CYP2C19.kor.PM.freq (0.1521 closed-form) | F (formula) |
| CYP2C19.kor.IM_plus_PM.freq | F |
| CYP2C19.kor.diplotype.star2_star2.freq | F |
| HardyWeinberg.identity.binomial (p²+2pq+q²≡1) | L (law) |

→ 기존 K 활용 가능. **새 K 신설 불필요** (확장 cost vs 의미 게인 trade-off에서 기존 F/L 충분).

---

# §5. 흡수 후 효과

| metric | 현 | bio-stat kernel 흡수 후 |
|---|---|---|
| DAPTPGX 30 claim 중 🔵 도달 | 0 | 6-10 (HW · binomial · Markov ID) |
| `hexa verify <id>` round-trip | 🟠 INSUFFICIENT (atlas binary 미흡수) | 🔵 (binary 흡수 후) |
| 향후 PGx 도메인 (다른 약물-유전자) 재사용 | 🔴 (V3 hand-coded sim) | 🟢 (stdlib fn 호출) |

---

# §6. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 현 verify --expr fn 목록 정확성 | 🟢 SUPPORTED-NUMERICAL | `hexa verify rubric` stdout VERBATIM (phi/sigma/tau 등) |
| hw_phenotype kernel design | 🔵 (수식)/ 🟠 (impl 부재) | HW 항등식 자체는 수학 closed-form |
| atlas K=F/L 매핑 결정 | 🟢 | 기존 1313 F + 531 L 사례 통계 기반 |
| 본 patch 흡수 ROI | 🟢 (DAPTPGX 10+ atom escalation) | V1 inventory + V3 stdout cross-ref |

---

# §7. 후속

- 본 patch 흡수 후 demiurge V4 final ledger 갱신 (🔵 카운트 재집계)
- HERPES · LPA · RTSC 등 사이블링 도메인의 epidemiological closed-form 도 동일 kernel 재사용 가능 (cross-domain win)
- 관련 inbox: hexa-lang/inbox/patches/bio-verify-kernel-extension-2026-05-25.md 와 통합 가능 (확인 후 dedup)
