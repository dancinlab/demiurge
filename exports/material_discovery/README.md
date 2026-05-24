# exports/material_discovery — H₃X DFT campaign canonical numerical SSOT

이 디렉토리 = RTSC H₃X DFT el-ph campaign 의 **canonical numerical SSOT** (machine-readable).
`RTSC.md §9` 표 · `RTSC.log.md §9.15` · `archive/session-notes/` 는 모두 human-readable snapshot 이며,
numerical value 불일치 시 **본 디렉토리의 JSON 이 authority**.

## 파일 naming

```
rtsc_h3<X>_dft_<grid>_<class>_<date>.json
   예: rtsc_h3cl_dft_6x6x6q_novel_20260524.json
       rtsc_h3s_dft_6x6x6q_textbook_proof_20260522.json
```

- `<X>` — anion (s/se/te/o/po/cl/f/si …)
- `<grid>` — phonon q-grid (`6x6x6q` = 6³ irreducible)
- `<class>` — `novel` (no measured Tc) · `textbook_proof` (measured-anchored) · `validation`
- `<date>` — capture stamp `YYYYMMDD`

## schema 필드 (Tier 2)

| 필드 | 의미 |
|---|---|
| `system` / `celldm` | Im-3m BCC primitive (4 atom) + celldm bohr |
| `results_by_broadening[]` | broadening 별 `lambda_BZ` · `omega_log_K` · `Tc_AD_mu010_K` · `Tc_AD_mu013_K` |
| `ALIGNN_per_cand` | per-candidate ambient-ML baseline (λ · ω_log · Tc-direct) — d7 wall 비교축 |
| `section_9_15_verdict` | §9.15 predicted band 대비 PASS/FAIL + broadening monotonicity caveat |
| `provenance` | `result.txt` (raw QE) 경로 · DFT host · capture date |
| `absorbed` | **항상 `false`** (simulation-only — d6 measured-oracle 미충족) |
| `gate_type` | **`simulation-only-prediction`** (R4 보호 · domain=material) |

## 현재 H₃X DFT 6³q records (8)

- 기존 (2026-05-22): `rtsc_h3s_…textbook_proof` · `rtsc_h3se_…novel` · `rtsc_h3te_…novel`
- 신규 (2026-05-24): `rtsc_h3o_…` · `rtsc_h3po_…` · `rtsc_h3cl_…` · `rtsc_h3f_…` · `rtsc_h3si_…`

(이 디렉토리에는 위 8개 외에 ALIGNN/BETE-NET crossmodel · MONDALOY · novel-discovery sweep JSON 도 공존.)

## derive chain

```
result.txt (raw QE, ~/etc/rtsc-results/<cand>/)
   → JSON (curated SSOT, 본 디렉토리)
   → RTSC.md §9 표 (human-readable snapshot)
```
