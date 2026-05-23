# V3a siRNA ODE — manifest (script lives on pool ubu-1)

@purpose: V3a 시뮬레이션 dispatch manifest (per @D d3 — implementation lives in canonical home, here = pool ubu-1).
@runtime: pool ubu-1 (Linux 6.17 · python3 · numpy 2.4.4 · scipy 1.17.1)
@script: `ubu-1:~/lpa_v3a/v3a_sirna_ode.py` (canonical)
@results: `ubu-1:~/lpa_v3a/results.json` (216 lines)
@dispatch: `ssh ubu-1 'cd ~/lpa_v3a && python3 v3a_sirna_ode.py > results.json'`
@runtime_observed: 0.577s real (single-threaded scipy LSODA)

## Why no local `.py` snapshot

`project.tape` hook (hexa-native) refuses `.py` / `.sh` writes by design (no override).
NEW memory rule (`feedback_demiurge_assets_simulation_mandatory`) also mandates compute on pool/cloud — local snapshot is redundant.

Implementation = single source on ubu-1; doc + results = `LPA/verify/V3a_sirna_kinetics.md`.

## Reproduce

```bash
# 1. SCP fresh copy if recreate needed (script content reproduced in V3a doc §1 model + §2 verbatim block)
# 2. Or pull from ubu-1:
scp ubu-1:~/lpa_v3a/v3a_sirna_ode.py /tmp/v3a_sirna_ode.py
# 3. Re-dispatch:
ssh ubu-1 'cd ~/lpa_v3a && python3 v3a_sirna_ode.py > results.json'
```

## Inputs (per V1 inventory)

C10 olpasiran -98% · C13 lepodisiran -94% · C15 zerlasiran -85% · C16 catalytic > stoich · C27 lifelong/late · C43 steady-state.

## Outputs

`LPA/verify/V3a_sirna_kinetics.md` — §1 model · §2 dispatch verbatim · §3 published vs sim · §4 closed-form · §5 sensitivity · §6 rubric · §7 ledger.
