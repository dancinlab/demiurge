# AGA-RX AR Off-Target Gate — VERDICT (round-3, breakthrough resolved)

Round-2 🟠 INCONCLUSIVE → RESOLVED. Validation gate PASS (TES redock 1.23 Å flex / 1.27 Å rigid, <2 Å).
Root cause of round-2 non-discrimination = 2 setup bugs (box 24 Å off pocket + truncated C18 ligand), both fixed.
Corrected-pocket rigid rescore (Vina 1.2.7, exhaustiveness 64):

| ligand | class | AR-LBD ΔG | Δ vs DHT | gate |
|---|---|---:|---:|---|
| DHT | agonist control | −9.89 | 0 | (reference) |
| testosterone | agonist control | −9.50 | +0.39 | (reference) |
| finasteride | 5ARI (non-AR-binder) control | −5.04 | +4.85 | (correctly weak) |
| **WAY-316606** | **lead (PATH A)** | **−5.38** | **+4.51** | **🟢 PASS — does NOT bind AR like an androgen** |
| 2-naphthylguanidine | lead (PATH B frag) | −7.30 | +2.59 | 🟡 partial separation (intermediate) |
| 4-guanidinobenzoic acid | lead (PATH B frag) | −6.25 | +3.64 | 🟢 PASS |
| tyramine-guanidine hybrid | lead (PATH B frag) | −6.45 | +3.44 | 🟢 PASS |

VERDICT: the primary lead **WAY-316606 clears the AR off-target gate** (binds AR ~4.5 kcal/mol weaker than
the androgen agonists, at finasteride's non-binder level) → the non-AR "no finasteride-like sexual-side-effect"
thesis HOLDS in-silico for the lead. 2-naphthylguanidine is the one to watch (closest to agonist band, but still
+2.6). Corroborated by an orthogonal method (R3-A ADMET QSAR: all 4 leads NR-AR 0.025–0.057 = AR-inactive).

Residual to wet-lab confirm (out-of-silico-scope per d19): AR transactivation reporter assay.
