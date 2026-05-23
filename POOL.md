# POOL — pool CLI as canonical external-compute routing layer

> Infrastructure SSOT for **how heavy / cross-platform / install-gated
> compute reaches a host that can actually run it**. Sibling of `RTSC.md`
> (compositional discovery) · `NUCLEAR.md` (elemental discovery) — those
> are *discovery-axis* stacks; POOL.md is the *infrastructure-axis* doc
> that any cohort can call into when its compute cannot land on the
> macOS dev host.
>
> opened: 2026-05-22 KST · status: spec-as-implemented (Phase 1 wrap-as-is)
> parent: demiurge `~/core/demiurge` · sibling repo `~/core/pool/`
> (single-Python-file CLI · D116 amendment: `~/core/pool/` is the CLI's
> own repo, NOT a demiurge sibling-doc repo).

---

## §1. Goal

Promote the `pool` CLI from an ad-hoc shell habit ("ssh into ubu-2 and
run it there") to a **first-class infrastructure layer** that:

1. **Has a single SSOT** for the host roster (`~/.pool/pool.json` ·
   `mini` macOS / `ubu-1` Linux / `ubu-2` Linux + auth via system ssh).
2. **Routes heavy / install-gated / GPU / cross-platform compute** off
   the macOS dev host onto a host that can actually run it, *without*
   pretending the result was produced locally.
3. **Surfaces honest skip records** when the pool itself is the gate
   (`gate_type=pool-unavailable` · `gate_type=heavy-run-not-opted-in` ·
   `gate_type=install-gated` — already in production at
   `~/core/hexa-lang/stdlib/material/cross_code_dft.py`).
4. **Stays out of the SSOT graph** — pool does NOT sync filesystems
   (user norm, NEXT_SESSIONS P-④). Every pool dispatch is "drive the
   substrate on a remote host"; nothing on the local tree changes
   silently.
5. **Composes orthogonally with the 7-verb spine** — pool is an
   *execution venue*, not a verb. Any `(domain, verb)` cell can route
   its substrate through pool by setting an opt-in env var; the typed
   record schema is unchanged.

Why first-class (not ad-hoc): the same dispatch pattern recurs in
RTSC §9.4 (cross-code DFT) · RTSC §9.9.1 Phase 1 wrap precedent ·
NUCLEAR §6.1 (HFBTHO wrap) · ARCH §11.4 H-* heavy-substrate sessions ·
chip §B substrate-axis cross-platform reproducibility (`inbox/notes/
2026-05-21-pool-gate_v3-abc-diagnosis.md`). Naming it as infrastructure
lets every cohort cite a single spec instead of re-deriving the
"how do I get this off the Mac" recipe ad hoc per session.

---

## §2. Routing taxonomy — what kinds of compute route through pool

Mirror of RTSC §8.7 (a)(b)(c)(d)(e) gate pattern. Each row names a
*kind of compute* that legitimately routes through pool. Anything not
matching these rows should NOT use pool — see §6 anti-patterns.

| kind | description | concrete example | current host | gate_type when pool-routed |
|------|-------------|------------------|--------------|---------------------------|
| **(a)** Build / CI cross-platform verify | reproduce a build or measurement on Linux gcc/clang/yosys *before* claiming a result is platform-invariant | `gate_v3` BLIF emitter bug — Mac arm64 Abort trap 6 reproduced on ubu-2 Linux x86_64 with same assertion (chip rfc006 §5 diagnosis) | mac dev host + `ubu-2` ssh | `pool-cross-platform-verify` (proposed) |
| **(b)** Heavy science compute | HFBTHO Fortran SCF · BSk22/24/27 cross-validation · multi-hour MC transport · DFT SCF in QE / ABINIT — local install impractical or Mac arm64 incompatible | RTSC N4 `cross_code_dft.py` heavy path = `pool run qe_scf ...` + `pool run abinit_scf ...` (Phase 2 wiring · current Phase 1 = honest skip with `pool_cli_path` audit field) · NUCLEAR §6.1 HFBTHO 3.00+ wrap (Fortran 95) | ubu-1 / ubu-2 (linux) | `pool-unavailable` / `heavy-run-not-opted-in` |
| **(c)** Large-data fetch | JET pulse archive (when SSO unblocks) · PhysioNet bulk · NREL Wind Toolkit · AME 2020 mass tables · OpenMC ENDF/B-VIII.0 (~3 GB) — fetch on a host with the bandwidth + disk | NUCLEAR §6.1 NSDC AME2020 fetch · NEXT_SESSIONS H-3 OpenMC ENDF | linux pool (disk + bandwidth) | `pool-unavailable` / `network-fail` |
| **(d)** GPU / accelerator workload | OpenROAD P&R · CUDA · ROCm · BETE-NET inference (when notebook surface upgrades to GPU) · ML ensemble bootstraps | OpenROAD on `ubu-1` (built earlier · NEXT_SESSIONS P-④ §B+§D Tier-3 P&R recipe) · κ-50 OpenROAD blocker timeline (PLAN 2026-05-18) | ubu-1 (had OpenROAD built) | `pool-unavailable` / `gpu-not-present` |
| **(e)** Sandboxed risky operations | untrusted subprocess · network operations · long-running jobs that risk OOM the dev host · concurrent agent fanout (`pool on all <cmd>`) | rfc_006 §9 sweep + multiple OpenROAD attempts rate-limit-killed twice on local host (PLAN 2026-05-18) | any pool host | `pool-rate-limited` / `pool-host-down` |

→ A cell that fits ≥ 1 row is a legitimate pool-routing candidate.
A cell that doesn't fit any row should run locally (§6).

---

## §3. Honest invariants (g3 · non-negotiable)

### §3.1 Pool does NOT sync filesystems (user norm)

- The pool CLI (`~/core/pool/bin/pool`) is *exec-only*. Verbs: `add` /
  `rm` / `off` / `list` / `on <host> <cmd>` / `on all <cmd>` / `init` /
  `status` / `refresh`. **There is no `pool sync`, no `pool autosync`,
  no implicit rsync of the local tree.** `pool/TODO.md` "Future verbs
  (deferred indefinitely)" explicitly lists `pool autosync on/off/
  mirror` as not-built.
- Any local file edit must be pushed to the remote host *explicitly*
  (rsync · scp · git push to a remote checkout · etc.) before `pool on
  <host>` will see the new code. The pool CLI does not paper over this
  gap.
- Consequence: a pool-dispatched cohort's substrate must already exist
  on the target host (typically via the host's own checkout of
  `~/core/hexa-lang` + the cohort's input files staged into the
  host's `~/<cohort>/` working dir). Sessions that forget this hit
  "stdlib/<domain>/<script>.py: not found" on the remote — honest
  skip, not silent failure.

### §3.2 R4 carry-over (`absorbed=false` 영구)

Records emitted from pool-routed compute still respect every existing
g3 invariant:

- **R4 invariant**: any simulation-stack record (RTSC §9.7 N1–N5 ·
  NUCLEAR §4 N6–N10) is `gate_type=simulation-only-prediction` ·
  `absorbed=false 영구`, regardless of whether the compute ran locally
  or on pool. Routing through pool does NOT promote the record's
  honesty status — it just moves where the FLOPs happen.
- **D106 illustrative-physics gate**: `MeasuredOracleRef` invariant
  still applies to pool-emitted records the same way it does to
  locally-emitted ones (κ-68 G30 / κ-69 G33 / κ-70 G37 pattern).
- **D80 hexa-native endpoint**: pool dispatch does not change the
  hexa-native endpoint requirement. A cell can be pool-routed AND
  still need a hexa-native parity port for `absorbed=true` legitimacy.

### §3.3 Provenance must cite the pool host

Any record that ran *any* substep on pool must surface the host in
its `provenance` block:

```json
{
  "provenance": {
    "pool_host": "ubu-2",
    "pool_command": "pool on ubu-2 -- bash -lc '...'",
    "pool_cli_path": "/Users/ghost/.hx/bin/pool",
    "remote_workdir": "~/gate_v3_pool/",
    "host_uname": "Linux x86_64",
    "primary_refs": [...]
  }
}
```

`cross_code_dft.py` already carries `pool_cli_path` as an audit field
on every record (even when the heavy path was honest-skipped) —
canonical pattern. Records that pretend to be local but actually ran
on pool are a g3 violation (the macOS arm64 vs Linux x86_64 result
delta is a substantive scope_caveat in many cohorts; hiding it via
loose provenance falsifies the gate).

### §3.4 Records that emitted via pool must be re-verified locally before commit

The chip rfc006 §5 pool-gate_v3 audit (`inbox/notes/2026-05-21-pool-
gate_v3-abc-diagnosis.md`) used pool to *invalidate a local "OK"*
claim — Mac arm64 Abort trap 6 + Linux x86_64 assertion failure both
in the same BLIF emitter bug → "macOS abc build issue" hypothesis
*falsified*. The honest g3 generalization: pool's job is to provide
cross-platform reproducibility audit, not to replace local
verification. A record that ONLY ran on pool (without any local sanity
re-run when feasible) should carry a stronger scope_caveat than one
where local + pool agree.

### §3.5 Pool is a venue, not a verb

The 7-verb spine (명세 / 구조 / 설계 / 해석 / 합성 / 검증 / 인계 ·
ARCH §3) is unchanged by pool. There is no `pool` verb. The cell's
typed Record schema does not gain a pool-specific shape. Pool surfaces
in `provenance.pool_host` + `provenance.pool_command` + optional
`gate_type=pool-unavailable` / `heavy-run-not-opted-in` — that's the
entire footprint at the record level.

---

## §4. Cohort routing examples — concrete patterns

### §4.1 RTSC §9.9.1 cross_code_dft `_pool_cli_present` precedent

The canonical first-class example. `~/core/hexa-lang/stdlib/material/
cross_code_dft.py` carries a small helper:

```python
def _pool_cli_present() -> str | None:
    """Return path to pool CLI if available (~/.hx/bin/pool or PATH)."""
    cand = os.path.expanduser("~/.hx/bin/pool")
    if Path(cand).is_file():
        return cand
    return shutil.which("pool")
```

Opt-in env var (`DEMIURGE_DFT_HEAVY_RUN=1`) tells the adapter the
caller *wants* the heavy QE/ABINIT path. Combined with pool CLI
presence, this gives four honest gate_type outputs:

| `DEMIURGE_DFT_HEAVY_RUN` | pool CLI present | gate_type emitted |
|--------------------------|------------------|-------------------|
| unset / `0` | either | `simulation-only-prediction` (light consensus path) OR `heavy-run-not-opted-in` |
| `1` | not found | `pool-unavailable` (with install hint to `hx install pool`) |
| `1` | found | currently `heavy-run-not-opted-in` (wrap-as-is — Phase 2 will wire `pool run qe_scf ...`); record carries `pool_cli_path` for audit |

This is the **shape every other cohort should follow** when promoting
to first-class pool routing. Phase 1 = make the gate_type honest. Phase
2 = wire the actual dispatch.

### §4.2 NUCLEAR §6.1 HFBTHO routing (potential · install-gated currently)

NUCLEAR.md §6.1 N6 first-land says: HFBTHO is the most-mature open-
source HFB binary; honest skip paths are `install-gated` /
`weights-missing` / `network-fail`. The pool-routing extension (next-
session work): instead of skipping on the Mac when HFBTHO binary +
BSk22/24/27 `.dat` tables are not installed locally, route to ubu-1
or ubu-2 where the Fortran 95 build is more tractable. This stays
Phase 1 wrap-as-is until someone actually drives an HFBTHO install on
a pool host; until then the install-gated skip is the honest record.

### §4.3 κ-rounds substrate-axis bridge stacks — when to route vs local

The κ-68/κ-69/κ-70 measured-oracle rounds (Energy/solar pyranometer ·
Aura/EEG PhysioNet Sleep-EDF · Ufo/plasma JET-like λ_D) all ran
*locally* on Mac. Reason: the bridge stack was either anonymous HTTPS
fetch (NREL MIDC · PhysioNet wget · synthetic JET-like fallback) +
small closed-form kernel (libm) → no pool benefit + extra honesty
cost from cross-platform reconciliation.

**Heuristic** (decide local vs pool per cell):

| signal | local | pool |
|--------|:-----:|:----:|
| Pure closed-form / closed-loop math (CODATA-2022 + libm) | ✓ | overkill |
| Anonymous HTTPS fetch + small data | ✓ | overkill |
| Binary build needs Linux (e.g., HFBTHO Fortran 95 build is brittle on macOS arm64) | partial | ✓ |
| ENDF/B-VIII.0 ~3 GB data files | partial | ✓ |
| Multi-hour MC transport (Geant4 / OpenMC) | ✗ (will OOM dev) | ✓ |
| OpenROAD P&R (built only on ubu-1) | ✗ | ✓ |
| Cross-platform reproducibility audit | both | ✓ pool *complements* local |

The κ-70 G37 Ufo/plasma cell stayed local. The chip rfc006 §5 audit
went pool. The pattern: pool is the heavy-compute / cross-platform-
audit lane; local is the light closed-form lane. Honest cells pick
the lane they belong in.

### §4.4 Concurrent agent fanout

`pool on all <cmd>` (added 2026-05-21 evening · `pool/TODO.md`
LANDED row) is the generic parallel fanout: `ThreadPoolExecutor` with
`--jobs N` / `--timeout S`, aggregate exit = max returncode, per-host
output prefixed `[hostname]`. Zero domain knowledge — composes with
existing wrappers. Use when a cohort needs the same probe / build /
sanity-check across mini + ubu-1 + ubu-2. (Anti-pattern: do NOT
embed cohort-specific verbs into `pool` itself — see §6 and the
2026-05-21 revert of `pool boot` / `--akida` extras per pool
constitution Principle I "Minimal — Single File, Zero Deps".)

---

## §5. Pool CLI invocation patterns

### §5.1 Canonical wrapper location

- **Repo**: `~/core/pool/` (separate repo · MIT license · single-file
  Python CLI).
- **Installed shim**: `/Users/ghost/.hx/bin/pool` → symlink to
  `~/.hx/packages/pool/bin/pool`.
- **State file**: `~/.pool/pool.json` (host roster · single JSON ·
  override via `POOL_STATE=<path>`).
- **Install command**: `hx install pool` (via the hexa package manager;
  `hx` wires the shim into `~/.hx/bin/` which must be on PATH).

### §5.2 Verbs (current as of 2026-05-22)

```
pool add <name> <user@host> [--sudo]   register host (ssh-probes uname -s for OS)
pool rm  <name>                         remove from roster
pool off <name>                         disable (kept in roster)
pool list [--json] [--live]             show roster (--live = parallel cpu/ram/gpu/disk probe)
pool on  <name> <cmd...>                ssh + exec on host
pool on  all <cmd...> [--jobs N] [--timeout S]   parallel fanout to every enabled host
pool status                             live reachability probe (each host)
pool refresh                            re-probe os for every host
pool init                               bootstrap every enabled host (tailscale / disk-cleanup
                                        / no-sleep / persistent-journal / panic-recovery /
                                        earlyoom / swapfile / watchdog)
```

### §5.3 Sync mechanism

**There is none** (per §3.1). To run a remote substrate the caller must:

1. Stage the substrate (and any data) onto the target host out-of-band.
   Typical pattern: rsync to `summer@ubu-2:~/<cohort>/` (e.g., the
   chip rfc006 §5 audit used `~/gate_v3_pool/` for lib + input blif).
2. `pool on <host> -- bash -lc 'cd ~/<cohort> && <cmd>'`.
3. rsync results back (or `scp ubu-2:<output>` to local).

For cohorts that pull `~/core/hexa-lang` on the remote: each pool host
maintains its OWN clone of the repo. The dispatcher's `pool on <host>
<cmd>` sees that host's checkout, NOT the local Mac's working tree.

### §5.4 Auth mechanism

ssh (system ssh client). Options baked in:

```
-o BatchMode=yes  -o ConnectTimeout=3  -o StrictHostKeyChecking=accept-new
```

No token / no API key / no separate ssh-config layer — the user's
`~/.ssh/config` + system keys carry. `BatchMode=yes` prevents
password prompts (so any host that needs a passphrase must use
ssh-agent or a key without one). Sudo for `pool init` is per-host
via the `--sudo` flag at `pool add` time.

### §5.5 Output retrieval pattern

`pool on` is *exec-only*; it streams stdout / stderr / exit code from
the remote to the local terminal but does NOT copy files. For typed
record JSON emit:

- Remote substrate writes record JSON to the remote host's tempdir or
  to `~/<cohort>/out/`.
- Caller rsyncs / scps that file back to local
  `~/core/demiurge/exports/<domain>/<verb>/<stamp>/`.
- Or: substrate emits the JSON to stdout, caller captures via shell
  redirect (small records only — > a few KB starts to feel fragile).

The `_pool_cli_present` precedent in `cross_code_dft.py` shows the
honest gate emit path *without* output retrieval — the record carries
`pool_cli_path` + `skipped_reason` and says "this is the recipe; Phase
2 wires the actual dispatch". That is the correct Phase 1 shape:
honest about what didn't run.

### §5.6 `pool init` features

`pool init` runs eight bootstrap features on every enabled host in
order (`pool/README.md`):

| feature | linux | macos |
|---|---|---|
| tailscale (headless) | curl tailscale.com/install.sh | `brew install tailscale` |
| `/etc/cron.daily/disk-cleanup` | journalctl vacuum + apt cleanup + `~/.cache/*` 3d+ atime | skipped |
| no-sleep | skipped (servers don't display-sleep) | `pmset -a displaysleep=0 sleep=0` |
| persistent-journal | `mkdir /var/log/journal` + restart journald | skipped (unified log) |
| panic-recovery | `kernel.panic=10` via `/etc/sysctl.d/` | skipped (Darwin auto-restarts) |
| earlyoom | `apt install earlyoom` | skipped (Jetsam) |
| swapfile | 32 GB `/swapfile-pool` + `vm.swappiness=10` | skipped (dynamic swap) |
| watchdog | softdog + `RuntimeWatchdogSec=30s` | skipped |

The OOM-resilience block (last 5 rows) was added after a host-OOM
incident on concurrent heavy workload (17 GB ckpt eval + 17 GB HF
upload on a 30 GB host — kernel OOM hung, host needed physical
reboot). Together: earlyoom kills lower-priority job → if escalates,
swap absorbs spike → if kernel still hangs, watchdog auto-resets in
30s. The dispatcher-side reservation ledger that would *prevent* the
race is a deferred roadmap item (`pool/TODO.md` "Dispatcher-side
reservation ledger").

### §5.7 Hexa-native port status

`bin/pool.hexa` (Phase 1 draft, ~210 LoC) compiles cleanly but cannot
be wired as the entry yet — two runtime primitives are non-functional:

| primitive | status | upstream patch |
|---|---|---|
| `env(name)` | returns `""` (stub) | filed at `hexa-lang/inbox/patches/runtime-env-and-exec-capture-stubs-block-cli-tools.md` |
| `exec_capture(cmd)` | SIGSEGV | same patch |

The Python prototype (`bin/pool`) carries until the runtime patch
lands. `pool/TODO.md` "Hexa-native port" section documents this
honestly. Pool CLI itself follows D116 amendment's spirit: the
binary lives in `~/core/pool/`, NOT in `~/core/hexa-lang/`, because
`pool` is an *infrastructure* tool not a *substrate* — same shape as
the `hx` package manager.

---

## §6. Anti-patterns — when NOT to use pool

### §6.1 Trivial compute (overhead > value)

Pure closed-form math (CODATA-2022 + libm · BCS · McMillan · WHK ·
λ_D Debye length) runs faster locally + has zero cross-platform
risk. Round-trip pool ssh latency + remote workdir setup typically
exceeds the compute time by 100×+ for such cohorts. Anti-example:
the κ-70 G37 Ufo/plasma λ_D measurement (`mean_rel_err = 2.21e-06` ·
N=50 stationary timesteps) ran locally in ms; pool routing would add
~5s of ssh overhead per probe with no honesty benefit.

### §6.2 Records emitting from pool must be re-verified locally before commit

(§3.4 invariant.) An "OK" verdict that only exists on pool is a
single-host claim. The chip rfc006 §5 case is the canonical example
of how pool *complements* local verification — cross-platform
reproducibility audit. Cohorts that drop the local verification step
and treat pool output as authoritative are setting up the same g3
trap as the gate_v3 `[OK] d4:abc_map` false-positive (where the
wrapper swallowed an ABC Abort trap 6 and emitted `exit=0`).

### §6.3 Don't push from pool

The pool hosts have their own git checkouts. `git push` from a pool
host risks pushing a *stale* tree (host hasn't pulled in days/weeks)
or a state that the local dev host hasn't reviewed. Use pool for
*compute*; use local for *git operations*. The `feedback_hexa_lang_
concurrent_agents.md` memory pattern (shared `~/core/hexa-lang` main
worktree concurrently modified) extends naturally: pool hosts'
checkouts are even less synchronized.

### §6.4 Don't embed cohort-specific verbs into pool

`pool/TODO.md` "REVERTED 2026-05-21 (evening) — constitution Principle
I": 3 anima-specific verbs (`pool boot` · `pool status --anima`) + 4
`--live` extras (`--akida` / `--fpga_tools` / `--arduino` /
`--anima_repo`) were reverted because they embedded
`~/anima/SUB_ENGINES/` / akida SDK / lspci akida / iverilog/yosys /
arduino-cli knowledge directly into the Python carrier. Constitution
NON-NEGOTIABLE Principle I: "Minimal — Single File, Zero Deps".
**Same rule applies for demiurge cohorts**: a demiurge-specific verb
like `pool run qe_scf <composition>` does NOT belong inside `pool`
itself — it belongs in the cohort's adapter
(`stdlib/material/cross_code_dft.py`) which composes `pool on <host>
-- <generic-shell-script>`. Pool stays generic.

### §6.5 Don't conflate pool with sync / autosync

Pool is exec-only (§3.1). Cohorts that want a sync abstraction should
build it explicitly (rsync wrapper · git push to remote checkout ·
etc.) — NOT silently piggyback "the file is on the remote because I
edited it locally". This invariant is the load-bearing reason for
the inbox memory note `feedback_stale_temp_files.md` (measurement
pipelines emitting `_out.blif` need truncate-before-exec — stale
files masking exec failures as "success") generalizing across the
pool boundary.

### §6.6 Don't assume pool host availability

`pool status` is the live reachability probe; hosts go up and down
(see PLAN.log.md 2026-05-18 OpenROAD build timeline — ubu-2 unreachable
under load, ubu-1 recovered after multiple session sweeps + agent
rate-limits). A cohort that *requires* pool to make progress must
either (a) accept honest skip when the host is down, or (b) carry
a fallback path. The "pool-unavailable" gate_type (cross_code_dft.py
canonical) is the correct shape for case (a).

---

## §7. Citations + anchors

### §7.1 Pool CLI itself

- `~/core/pool/README.md` — verb reference + state schema + `pool init`
  feature table + OOM-resilience block rationale.
- `~/core/pool/TODO.md` — LANDED row (parallel fanout `pool on all`) ·
  REVERTED row (anima-specific verbs · constitution Principle I) ·
  hexa-native port phasing · dispatcher-side reservation ledger
  roadmap.
- `~/core/pool/bin/pool` — single Python file (~700 LOC · MIT license)
  · zero deps.
- `~/.hx/bin/pool` → `~/.hx/packages/pool/bin/pool` (installed shim).
- `~/.pool/pool.json` — host roster SSOT.

### §7.2 Existing demiurge pool routing

- **canonical precedent**: `~/core/hexa-lang/stdlib/material/
  cross_code_dft.py` — `_pool_cli_present()` helper + four honest
  gate_type outputs (RTSC §9.7 N4 cohort).
- **cross-platform audit precedent**: `~/core/demiurge/inbox/notes/
  2026-05-21-pool-gate_v3-abc-diagnosis.md` — chip rfc006 §5
  gate_v3 BLIF emitter bug confirmed Linux-side via ubu-2 (Mac arm64
  Abort trap 6 + Linux x86_64 assertion failure both at same
  invariant violation).
- **bootstrap pool verify precedent**: `~/core/demiurge/inbox/notes/
  2026-05-22-pool-bootstrap-verify.md` — hexa-lang bootstrap CI
  Linux Stage 0 RED root-causing via pool (`pool list` confirms 3
  hosts · isolated clone at `~/_hexa_pool_verify/hexa-lang` ·
  iter-2c flock macro replacement diagnosis). Canonical
  *invocation-pattern audit* of `pool list` + `pool status` + `pool
  on <name> '<cmd>'` shape.
- **session pickup**: `NEXT_SESSIONS.md` P-④ (chip measurement
  session) — "ubu pool: summer@ubu-2 (linux). Heavy bash auto-routes
  there. Pool does NOT sync filesystems — local file edits are not
  visible on ubu until the user syncs."
- **OpenROAD on ubu-1**: PLAN.log.md 2026-05-18 — OpenROAD build timeline
  on ubu-2 → recovery on ubu-1 → Part E (routed GDS) COMPLETE on
  ubu-1 · 5.2 GB OpenROAD-flow-scripts checkout.
- **heavy-substrate handoffs**: NEXT_SESSIONS.md H-* (H-1
  hexa-lang live-tree re-align · H-2 Geant4 antimatter · H-3 OpenMC
  TBR · H-6 pyfemm Linux pool · H-7 firmware QEMU) — every H-N
  references pool as the routing layer.

### §7.3 Honesty invariants this doc cites

- ARCH.md §0 first principle (hexa-only ultimate form) — pool dispatch
  does not change the hexa-native endpoint requirement.
- ARCH.md §7 records / gates / honesty (D9 / D12 / g3) — pool
  surfaces in `provenance.pool_host`; record schema unchanged.
- RTSC.md §9.6 — sim PASS still means `gate_type=simulation-only-
  prediction` regardless of compute venue.
- NUCLEAR.md §3 — same R4 invariant carry-over for nuclear records.
- DESIGN.md D116 (sibling repos = docs only) — `~/core/pool/` is the
  pool CLI's own infrastructure repo, NOT a demiurge doc-sibling.
  POOL.md (this file) is the doc-side anchor.

### §7.4 Future axes (deferred · not in this Phase 1 spec)

- Phase 2 wiring of actual `pool run qe_scf ...` / `pool run abinit_
  scf ...` dispatch in cross_code_dft.py (RTSC §9.9.1 Phase 2
  stabilization scope).
- Dispatcher-side reservation ledger (`pool/TODO.md` "Dispatcher-side
  reservation ledger") — typed `--reserve ram=...,disk=...,wall=...`
  + `~/.pool/active_tickets.json` per-host commitment sum.
- Hexa-native port wire (`bin/pool.hexa` ready to replace `bin/pool`
  Python once `env(name)` + `exec_capture(cmd)` runtime stubs are
  landed per `hexa-lang/inbox/patches/runtime-env-and-exec-capture-
  stubs-block-cli-tools.md`).
- Companion sidecar plugin (PreToolUse route heavy Bash → pool ·
  SessionStart inject roster status) — out of scope for both pool
  repo and demiurge per `pool/TODO.md` "Companion sidecar plugin".

---

---

Historical log entries are in [`./POOL.log.md`](./POOL.log.md).
