# wave3b — d16 dry-run + fire runbook (4 candidates, coords RESOLVED)

Status: **coords resolved + decks authored**; FIRE BLOCKED on a sustained vast.ai SSH-proxy
outage on pod-2 (`ssh9.vast.ai:15988`, contract 38095989) AND pod-1 (`ssh6.vast.ai:28500`,
contract 37868501). TCP port is OPEN on both proxies and the vast API lists both contracts
LIVE, but the SSH handshake/auth through the vast gateway fails (`exit 255`) for BOTH
`hexa cloud exec` (cycle A) and `hexa cloud copy-to` (cycle B), with and without
`--identity ~/.ssh/id_vast_anima`. This is a vast.ai-side proxy fault, not a key/network
fault on our side. **The research + decks are done; only transport blocks the fire.**

## Decks (this dir) — per candidate: vc-relax.in · ph.in · scf.in.head · scf.in.tail · run.sh
Plus shared `extract.py` (alat→bohr cell fix). All authored with:
ecutwfc=80 ecutrho=800 · MP smearing degauss=0.02 · conv_thr=1d-12 · k 12³ · ph 4×4×4 simple.
Structures use QE `space_group` + `ATOMIC_POSITIONS crystal_sg` (representative sites only;
QE expands the 12k/32f/96g orbits — avoids hand-expansion error).

| candidate | SG / ibrav | press (kbar) | est nat (prim) | anchor |
|-----------|-----------|--------------|----------------|--------|
| CeH9      | P6₃/mmc #194 / ibrav=4 | 1000 (100 GPa) | ~20 (Ce₂H₁₈ conv) | ~100K @ 80-100 GPa (Salke 2019) |
| YH9       | P6₃/mmc #194 / ibrav=4 | 2500 (250 GPa) | ~20 (Y₂H₁₈ conv)  | 243K @ 201 GPa measured (Kong 2021) |
| YH10      | Fm-3m #225 / ibrav=1   | 2500 (250 GPa) | ~11 (YH₁₀ prim)   | ~303K @ 400 GPa pred (Liu/Peng 2017) |
| Li2MgH16  | Fd-3m #227 o2 / ibrav=1 | 2500 (250 GPa) | ~38 (Li₂MgH₁₆ prim)| 473K @ 250 GPa pred (Sun 2019) |

## FIRE STEPS (run when ssh9 transport recovers — re-test with the §0 probe first)

### 0. transport probe (must succeed before anything else)
```
hexa cloud exec "root@ssh9.vast.ai --port 15988 --insecure --identity /Users/ghost/.ssh/id_vast_anima" -- "echo OK; nproc"
```
If still `exit 255`: vast proxy still down. Options — (a) wait + retry; (b) `hexa cloud list`
to confirm contract live; (c) if pod is genuinely dead, the decks are pod-agnostic — rent a
fresh vast pod (`hexa cloud rent vast ...`), stage pseudo + decks, fire there.

### 1. resolve pseudo filenames (decks use bare `Ce.UPF`/`Y.UPF`/`Li.UPF`/`Mg.UPF`/`H.UPF`)
The prior wave-3 agent staged rrkjus_psl 1.0.0 pseudos at `~/wave3/pseudo/`. List + symlink
to the bare names the decks expect (or sed-patch ATOMIC_SPECIES):
```
hexa cloud exec "root@ssh9.vast.ai --port 15988 --insecure --identity /Users/ghost/.ssh/id_vast_anima" -- "ls ~/wave3/pseudo/"
# then per element, e.g.:
#   ln -sf Ce.pbe-spdn-rrkjus_psl.1.0.0.UPF  ~/wave3/pseudo/Ce.UPF   (etc. for Y, Li, Mg, H)
```
Each deck dir is a sibling of `pseudo/` (deck `pseudo_dir = '../pseudo'`), so place deck dirs
at `~/wave3/CeH9/`, `~/wave3/YH9/`, `~/wave3/YH10/`, `~/wave3/Li2MgH16/`.

### 2. stage decks to the pod
```
hexa cloud copy-to "root@ssh9.vast.ai --port 15988 --insecure --identity /Users/ghost/.ssh/id_vast_anima" \
  /Users/ghost/core/demiurge/exports/wave3b-decks/CeH9 /root/wave3/CeH9 -r
# repeat for YH9, YH10, Li2MgH16; and copy extract.py into EACH deck dir:
hexa cloud copy-to "...conn..." /Users/ghost/core/demiurge/exports/wave3b-decks/extract.py /root/wave3/CeH9/extract.py
# (the staged tree already has extract.py at the wave3b-decks root — copy it into each dir)
```

### 3. d16 FREE dry-run per candidate (~30s, catch ibrav/coord/pseudo errors cheaply)
```
hexa cloud exec "...conn..." -- "cd /root/wave3/CeH9 && source /root/miniforge3/etc/profile.d/conda.sh && conda activate qe && timeout 90 mpirun --allow-run-as-root -np 2 pw.x -inp vc-relax.in 2>&1 | tail -40"
```
PASS = SCF starts iterating (energy printed, no `rgen: too many r-vectors`, no pseudo-not-found,
no `Wrong space group` / `number of atoms` mismatch). Paste any error VERBATIM (g5).
- If Li2MgH16 reports a space_group/origin atom-count mismatch → flip `origin_choice = 1`
  in its vc-relax.in (the paper's origin label was ambiguous; o2 is the first guess).
- If YH9/YH10 lattice guess (A) is far off → vc-relax still converges (cell_factor=3.0); only
  a `too many r-vectors` at START would indicate a bad initial A — bump A up ~10%.

### 4. on dry-run PASS → fire the full chain (nohup, np=6), record PID
```
hexa cloud nohup "root@ssh9.vast.ai --port 15988 --insecure --identity /Users/ghost/.ssh/id_vast_anima" \
  /root/wave3/CeH9/chain.log --env NP=6 -- bash /root/wave3/CeH9/run.sh
# capture the printed remote pid; repeat for the other 3.
```
Budget: 4 jobs × np=6 = 24 cores. pod-2 already runs cabeh8(8)+YH6(6)+LaBH8(6)=20 → total ~44/128
(throttle-safe, <70). ~$24 @ $0.40/hr authorized.

### 5. arm command per job (parent arms watchers — do NOT self-arm)
```
hexa cloud exec "...conn..." -- 'grep -c "CHAIN DONE" /root/wave3/<C>/chain.log'   # 1 = done
```
