# 리포트 표 sample — pocket VQE iteration matrix

본 파일 = 사용자가 명시한 reporting style sample (2026-05-11). 향후 리포트 시 본 형식의
표를 포함한다 (own preference 등록).

---

## sample 1 — pocket VQE iteration matrix (cumulative 진행)

```
┌──────┬─────────┬────────────────┬───────────────────┬─────────┐
│ iter │ target  │ best optimizer │ best delta (µHa)  │ sub-µHa │
├──────┼─────────┼────────────────┼───────────────────┼─────────┤
│ 0    │ HDAC6   │ L_BFGS_B       │ 14.515            │ ❌      │
│ 1    │ SARM1   │ L_BFGS_B       │ 96.09             │ ❌      │
│ 2    │ ClC-1   │ SLSQP          │ 0.237             │ ⭐      │
│ 3    │ MFN2    │ L_BFGS_B       │ 10.34             │ ❌      │
│ 4    │ Cx32    │ SLSQP          │ 0.587             │ ⭐      │
│ 5    │ c9orf72 │ SLSQP          │ 1.376             │ ❌ near │
│ 6    │ TBK1    │ SLSQP          │ 0.615             │ ⭐      │
│ 7    │ KIF5A   │ L_BFGS_B       │ 0.023             │ ⭐⭐    │
│ 8    │ stmn2   │ L_BFGS_B       │ 0.0002            │ ⭐⭐⭐  │
│ 9    │ atxn2   │ L_BFGS_B       │ 0.0009            │ ⭐⭐⭐  │
└──────┴─────────┴────────────────┴───────────────────┴─────────┘
```

또는 markdown 표 (rendered) :

| iter | target  | best optimizer | best delta (µHa) | sub-µHa |
|------|---------|----------------|------------------|---------|
| 0    | HDAC6   | L_BFGS_B       | 14.515           | ❌      |
| 1    | SARM1   | L_BFGS_B       | 96.09            | ❌      |
| 2    | ClC-1   | SLSQP          | 0.237            | ⭐      |
| 3    | MFN2    | L_BFGS_B       | 10.34            | ❌      |
| 4    | Cx32    | SLSQP          | 0.587            | ⭐      |
| 5    | c9orf72 | SLSQP          | 1.376            | ❌ near |
| 6    | TBK1    | SLSQP          | 0.615            | ⭐      |
| 7    | KIF5A   | L_BFGS_B       | 0.023            | ⭐⭐    |
| 8    | stmn2   | L_BFGS_B       | 0.0002           | ⭐⭐⭐  |
| 9    | atxn2   | L_BFGS_B       | 0.0009           | ⭐⭐⭐  |

---

## sample 2 — paradigm 정리 표 (chem environment vs delta)

결과 분포 / paradigm 발견을 정리할 때 본 형식 (행 = 환경 class, 열 = 대표 사례 / 지표 / 비율):

```
┌────────────────────────────┬───────────────┬─────────────┬──────────────┐
│        environment         │   examples    │ best delta  │ sub-µHa rate │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 💧 RNA WC + thiophosphate  │ stmn2, atxn2  │ ~0.0005 µHa │ 2/2 = 100%   │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 🧬 light-atom H-bond rich  │ KIF5A         │ 0.023 µHa   │ 1/1 = 100%   │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 🔬 ionic/saturated/protein │ ClC-1, Cx32   │ 0.4 µHa     │ 2/2 = 100%   │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ ⚛️ Mg+adenine+S+indole     │ TBK1          │ 0.62 µHa    │ 1/1 = 100%   │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 🪨 transition metal        │ HDAC6         │ 14.5 µHa    │ 0/1 = 0%     │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 🌐 K⁺/Mg²⁺ + nucleobase    │ MFN2, c9orf72 │ ~10 µHa     │ 0/2 = 0%     │
├────────────────────────────┼───────────────┼─────────────┼──────────────┤
│ 🌀 conjugated heterocycle  │ SARM1         │ 96 µHa      │ 0/1 = 0%     │
└────────────────────────────┴───────────────┴─────────────┴──────────────┘
```

markdown 표 (rendered) :

| environment | examples | best delta | sub-µHa rate |
|-------------|----------|------------|--------------|
| 💧 RNA WC + thiophosphate | stmn2, atxn2 | ~0.0005 µHa | 2/2 = 100% |
| 🧬 light-atom H-bond rich | KIF5A | 0.023 µHa | 1/1 = 100% |
| 🔬 ionic/saturated/protein | ClC-1, Cx32 | 0.4 µHa | 2/2 = 100% |
| ⚛️ Mg+adenine+S+indole | TBK1 | 0.62 µHa | 1/1 = 100% |
| 🪨 transition metal | HDAC6 | 14.5 µHa | 0/1 = 0% |
| 🌐 K⁺/Mg²⁺ + nucleobase | MFN2, c9orf72 | ~10 µHa | 0/2 = 0% |
| 🌀 conjugated heterocycle | SARM1 | 96 µHa | 0/1 = 0% |

→ 해석: light-atom dominant cluster (RNA Watson-Crick, H-bond rich, ionic/saturated, 황 포함)
은 L_BFGS_B gradient 로 sub-µHa 도달. metal d-orbital / π-stack / conjugated heterocycle 은
sto-3g 4e/4o 한계 — basis 확장 (def2-svp) + larger active-space (6e/6o+) 필요.

---

## 표 형식 규칙 (own 등록 reference)

1. **컬럼 헤더** — `iter | target | optimizer | delta (µHa) | sub-µHa` 형식 또는 동등 axis
2. **숫자 alignment** — 숫자 정밀도 통일 (`.3f` 또는 `.6f`)
3. **상태 emoji** — `❌` (FAIL) / `⭐` (PASS sub-µHa) / `⭐⭐` / `⭐⭐⭐` (best 또는 record) / `✅` (chem-acc OK)
4. **ASCII box-drawing** OR **markdown pipe-table** 둘 다 사용 가능 (둘 다 병기 권장)
5. **paradigm 발견** 또는 **결과 분포** 명시 시 sample 2 형식 (환경 class × 지표) 우선

향후 리포트 (CMT/ALS/기타 disease 또는 양자 chemistry 진행) 시 본 sample 형식 적용.
