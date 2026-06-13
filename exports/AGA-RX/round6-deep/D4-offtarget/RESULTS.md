# DEEP D4 — siRNA transcriptome-wide seed off-target (closes R3-D PARTIAL)

Pure-python seed-complement scan (no BLAST needed — miRNA-like 7-mer seed, guide pos 2-8, is the dominant off-target driver) over **205,792 Ensembl GRCh38 cDNA r111 transcripts** (75MB fetched live).

| guide (R3-D lead) | seed site (mRNA 7-mer) | off-target transcripts | % | vs random baseline (~8.7%) |
|---|---|---:|---:|---|
| AR_2857 | TTCTTCA | 44,670 | 21.7% | **2.5×** HIGH |
| DKK1_cds539 | CTGCAAA | 34,517 | 16.8% | 1.9× HIGH |
| DKK1_g971 | CTTTTAT | 28,659 | 13.9% | 1.6× HIGH |
| SRD5A2_1427 | GTTGATG | 21,372 | 10.4% | 1.2× MOD |
| SFRP1_3006 | CTGATAA | 19,327 | 9.4% | ~1.0× (best) |

(random 7-mer expectation ≈ 18,005 transcripts / 8.7% for a 1.5kb avg transcript)

VERDICT (closes the R3-D "transcriptome BLAST = PARTIAL"): the transcriptome-wide seed pool is now QUANTIFIED.
- SFRP1 guide = near random baseline → lowest seed-driven off-target risk (preferred).
- AR_2857 (2.5×) + DKK1 guides (1.6-1.9×) carry ABOVE-baseline seed load → **pre-synthesis seed-minimization redesign gate**: scan alternative guide registers for minimal seed-match frequency, and/or position-2 chemical modification to blunt seed pairing.
- Honest tier: this is the any-region 7-mer UPPER BOUND. Next refinement (out-of-scope here, NOT a gap): 3'UTR-restricted + tissue-expression-weighted scoring (siSPOTR/GESS) + thermodynamic seed-pairing stability — narrows the pool to the functionally-silencing subset.
