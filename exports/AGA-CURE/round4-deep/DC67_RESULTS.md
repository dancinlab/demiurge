# DC6 / DC7 — 4-arm sequencing-timing · arm③ editor delivery

## DC6 — 4-arm sequencing + arm③ lock timing
**v1 (order sweep) finding (honest):** the ORDER of arms ①깨우기 ②되돌리기 ④신생
barely matters — all reach ~0.99 restored by month 24 regardless of order (each
arm is a gap-closing exponential; reordering shifts the curve by ~1 month). The
v1 model collapsed all orders to ~0.567 because it conflated order with a
premature lock — flagged as a model flaw and re-run (d6, no flawed-convergence
as result).

**v2 (lock-timing sweep) — the real control variable:**

| arm③ lock @ month | restored@lock | 5yr-final (after relapse) |
|---|---|---|
| 0 | 0.000 | 0.550 |
| 6 | 0.854 | 0.891 |
| 12 | 0.962 | 0.935 |
| **18** | **0.989** | **0.946** |
| 24 | 0.997 | 0.949 |
| 36 | 1.000 | 0.950 |

**Finding:** restoration durability is a **saturating function of lock timing**.
Locking too early (month 0–6) leaves most gains unprotected → 0.55–0.89 5yr.
The knee is **~month 18** (0.946 = 99.6% of the month-36 asymptote 0.950).
**Regimen rule:** run arms ①②④ concurrently from t=0; fire arm③ permanence
lock at **~18 months**, once gains are realized. Waiting past 18mo adds <0.4% —
not worth the extended exposed window. Locking before 12mo sacrifices ~1.5%
durable restoration per the curve.

## DC7 — arm③ epigenetic-editor delivery (DC3 recommended epigenetic lock)
DC3 recommended epigenetic editing (dCas9-KRAB-class) as the best permanence
mechanism. But dCas9 (~4.1kb) + KRAB + promoter EXCEEDS the single-AAV ~4.7kb
ceiling. Delivery routes (geo-mean of cargo-fit · DPC-tropism · durability · safety):

| route | cargo | tropism | durab | safety | FIT |
|---|---|---|---|---|---|
| **CasMINI / Cas12f (~1.6kb)** | 0.90 | 0.70 | 0.78 | 0.70 | **0.766** ✅ |
| LNP-mRNA (transient editor) | 0.85 | 0.55 | 0.75 | 0.80 | 0.728 |
| dual-AAV split-intein | 0.75 | 0.70 | 0.80 | 0.60 | 0.709 |
| polymer nanoparticle | 0.70 | 0.45 | 0.70 | 0.65 | 0.615 |
| single-AAV dCas9-KRAB | 0.15 | 0.70 | 0.80 | 0.65 | 0.483 ✗ cargo |

**Finding:** the DC3 epigenetic-lock arm should use a **compact editor (Cas12f /
CasMINI, ~1.6kb)** so it fits a single AAV — NOT dCas9-KRAB (cargo overflow kills
the simplest vector, FIT 0.483). LNP-mRNA transient editor is a strong vector-
free second (the epigenetic mark is heritable after a transient edit, so durable
expression is unnecessary). This RESOLVES the DC3→delivery gap: epigenetic lock
is deliverable in one AAV via a compact Cas.
