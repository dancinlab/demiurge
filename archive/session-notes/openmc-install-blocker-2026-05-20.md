# OpenMC install blocker — Track D / H-3 (energy + verify, ENDF/B-VIII.0)

> status: **blocked** — neither macOS arm64 conda-forge wheel nor Linux pool
> reachable. No k-eff measurement produced. Substrate record unchanged
> (still `gate_type: "data-gated"`). H-3 stays open in NEXT_SESSIONS.md.

- date: 2026-05-20
- agent: agent-a9584a4285d9c2a11 (worktree-isolated, off origin/main)
- target: `~/core/hexa-lang/stdlib/energy/openmc_keff.py` (κ-49, ROI 12)
- cited oracle: arxiv:2506.22559 (OpenMC vs MCNP spent-fuel criticality
  benchmark, 2025)
- governance: D80 (provisional flag for substrate runs absent hexa-native
  port), D61 (substrate stays in hexa-lang/stdlib/energy/, demiurge
  unchanged), g3 scope_caveats

## Root cause — two independent blockers, both upstream of OpenMC itself

### Blocker 1: OpenMC has no `osx-arm64` conda-forge build

```
$ /tmp/miniforge3/bin/conda search -c conda-forge --platform osx-arm64 openmc
Loading channels: done
No match found for: openmc. Search: *openmc*
```

Cross-checked `linux-64` for control:

```
$ /tmp/miniforge3/bin/conda search -c conda-forge --platform linux-64 openmc
openmc                        0.15.3 nodagmc_mpi_openmpi_py313hfe8cc3d_1  conda-forge
openmc                        0.15.3 nodagmc_nompi_py311h3d810a6_1        conda-forge
…                              0.15.3 nodagmc_nompi_py313he95176b_0       conda-forge
```

So OpenMC 0.15.3 is published for `linux-64` (multiple build variants:
MPI / no-MPI, with/without DAGMC, py311/312/313) — but the
`osx-arm64` channel ships only `openmc-plotter` and `ramp-openmc`,
both of which list `openmc` as a runtime dep without providing it.

Pip is also a dead end: `pip3 index versions openmc` returns
`No matching distribution found for openmc`, and
`curl https://pypi.org/pypi/openmc/json` returns `{"message": "Not Found"}`.
OpenMC is not published to PyPI — by upstream design, it's CMake-only or
conda-forge-only.

Homebrew has no `openmc` formula either (`brew search openmc` →
nearest match is `opencv`).

The only remaining macOS-arm64 install route is **build-from-source**:

- CMake ≥ 3.16, C++17 compiler ✓ (Xcode CLT present)
- HDF5 (parallel optional) — Homebrew has `hdf5` ✓
- libpng, eigen3, pugixml, gsl-lite, xtensor, fmt — vendored / Homebrew
- Optional: MPI (OpenMPI / MPICH), DAGMC (CAD-based geometry), libMesh
- Python bindings via `pip install -e .` after CMake build

Empirical wall-clock for this on macOS arm64 (per OpenMC GitHub Actions
osx-14 matrix): ~25-45 min for the full configure+build+install,
assuming none of the transitive C++ deps need a from-source build.
This is outside the H-3 task envelope — H-3 budgets "install OpenMC"
as a `pip install`-or-`conda install` step, not a CMake build.

### Blocker 2: Linux pool unreachable from this macOS host

H-3 explicitly says "ubu-pool preferred (3 GB download + multi-GB run
intermediates)" and the Track D briefing reiterates "heavy Bash on
Linux pool. wilson-pool auto-routes." Reality on this host today
(2026-05-20):

```
$ ssh -o ConnectTimeout=5 ubu-1
ssh: connect to host 10.142.0.1 port 22: Operation timed out

$ ssh -o ConnectTimeout=5 ubu-2-ts
ssh: connect to host 100.72.76.118 port 22: Operation timed out

$ ssh -o ConnectTimeout=5 ubu-1-ts
ssh: connect to host 100.96.193.56 port 22: Operation timed out

$ ping -c 1 100.96.193.56
1 packets transmitted, 0 packets received, 100.0% packet loss

$ ping -c 1 10.142.0.1
1 packets transmitted, 0 packets received, 100.0% packet loss
```

Tailscale-side IPs (100.x.x.x) and direct LAN-side IPs (10.142.x.x,
192.168.50.x) are both down. The host's `/usr/local/bin/tailscale` is a
68-byte shim pointing at `/Applications/Tailscale.app`, but that .app
bundle is missing:

```
$ ls /Applications/ | grep -i tail
(no output)

$ /usr/local/bin/tailscale status
/usr/local/bin/tailscale: line 2: /Applications/Tailscale.app/Contents/MacOS/tailscale: No such file or directory
```

So even if the pool nodes are up on Tailscale, this host has no
Tailscale daemon to reach them, and the LAN-side IPs are not on the
current network (this host is on 192.168.50.x but ICMP to .39 / .60 /
.119 all time out — likely a different subnet or the pool is off).

`wilson-pool` (the auto-routing wrapper from the Track D briefing) is
not on `$PATH` either:

```
$ which wilson-pool
wilson-pool not found
```

so even the routing-layer fallback is absent — `wilson 0.0.1` per the
user-global identity tape is still in-flight, with no shipped
pool-router CLI.

## What I did NOT do (deliberately)

Per the Track D task spec — "If download or install fails, capture the
root cause in `~/core/demiurge/inbox/notes/openmc-install-blocker-2026-05-20.md`
and stop." — and per andrej-karpathy-skills (surgical changes,
no speculative features), I stopped before:

- Building OpenMC 0.15.3 from source on macOS arm64 (~30-45 min CMake
  build; outside H-3's "install" budget; would also need Homebrew
  `hdf5` + `pugixml` + `xtensor-blas` + `gsl-lite` provisioning).
- Extending the substrate `openmc_keff.py` from its current 99-line
  stub (which only writes a `gate_type: data-gated` skip record) to
  include real single-pin LWR geometry. The substrate today does not
  define materials, surfaces, cells, or settings — the H-3 task
  assumed `OPENMC_CROSS_SECTIONS` was the only missing piece, but
  the substrate is also missing the geometry definition that consumes
  those cross-sections. This is a second, smaller blocker that the
  H-3 NEXT_SESSIONS entry did not anticipate.
- Downloading the ~3 GB ENDF/B-VIII.0 HDF5 bundle. The macOS host has
  77 GB free, so disk is not the issue — there is just no OpenMC
  binary to point it at, and the H-3 verification record requires
  `provenance.data_pin = <ENDF SHA256>` which only makes sense once
  there is an OpenMC build that loads it.
- Modifying `hexa-lang` or `demiurge` repos beyond this note. No
  branch created, no commits made on either tree (apart from this
  blocker note on the demiurge worktree, per the task spec).

## What needs to change before H-3 can land

Two independent fixes, either of which alone unblocks one half of the
problem:

1. **Restore Linux pool reachability** — bring Tailscale back up on this
   macOS host (reinstall `Tailscale.app`, run `tailscale up`), OR ship
   `wilson-pool` auto-router so SSH alias resolution doesn't depend on
   the Tailscale-on-laptop config. With pool reachable, the conda-forge
   `linux-64` build of `openmc=0.15.3` is one `mamba install -c
   conda-forge openmc=0.15.3` away (~2 min), and ENDF/B-VIII.0 ships via
   `openmc-data-downloader endf-b8.0` (~3 GB, ~5-15 min depending on
   pool bandwidth to ANL Box).

2. **Promote `kernels/mc_transport/` to a hexa-native port** (per D80,
   D72 §"kernel goes hexa-native once" — `mc_transport` already has 3
   consumers: antimatter+analyze κ-31, fusion+verify, this one). A
   hexa-native MC-transport kernel would drop the OpenMC install
   dependency entirely; the resulting record could carry `absorbed=true`
   instead of `provisional=true` per D80.

Plus a third, smaller follow-up — extend the substrate
`openmc_keff.py` to actually define the single-pin LWR geometry
(`openmc.Material` for UO₂ / Zr clad / H₂O moderator, `openmc.ZCylinder`
surfaces, a 1.26 cm square reflective lattice cell, `openmc.Settings`
with batches/inactive/particles, then `openmc.run()` and parse
`statepoint.h5` for `k_combined.nominal_value`). The arxiv:2506.22559
benchmark target lives in their Table II; cite a specific row when the
record is written.

## Cross-session safety — what this attempt touched

- `hexa-lang`: read-only. No branch created, no commits, no edits to
  `stdlib/energy/openmc_keff.py`. Current branch `s1-step2-codegen-perf`
  was not switched; HEAD = `1d4e0ce6` (untouched).
- `demiurge`: worktree-isolated
  (`.claude/worktrees/agent-a9584a4285d9c2a11`, off origin/main `f64e23b`).
  Only this single file added; no other tree changes.
- `/tmp/miniforge3/`: installed (~54 MB downloader + ~700 MB env). This
  is throwaway scratch; can be deleted with `rm -rf /tmp/miniforge3
  /tmp/miniforge.sh`. Did NOT modify `~/.bashrc`/`~/.zshrc` (used
  miniforge installer's `-b` flag = batch / no-init).
- `~/.openmc/`: still does not exist (verified). `OPENMC_CROSS_SECTIONS`
  still unset.
- No nuclear data downloaded.

## Provenance pins for the next session

- conda-forge channel state captured 2026-05-20: `openmc=0.15.3` is the
  latest release on `linux-64`, with both MPI and no-MPI builds across
  py311/312/313 and DAGMC on/off variants.
- Miniforge installer used: `Miniforge3-MacOSX-arm64.sh` from
  `https://github.com/conda-forge/miniforge/releases/latest/download/`
  (the "latest" pin will drift; next session should record the exact
  release tag once miniforge is reinstalled on a Linux pool node).
- ENDF/B-VIII.0 source: per OpenMC docs, `openmc-data-downloader` script
  downloads from ANL Box (`https://anl.app.box.com/s/...`); the
  per-file SHA256 set is reproducible across downloads and should be
  pinned in `provenance.data_pin` once known.

## Re-entry recipe (for the next session that picks H-3 up)

```bash
# On a reachable Linux pool node:
mamba install -y -c conda-forge openmc=0.15.3 openmc-data-downloader
openmc-data-downloader endf-b8.0 -d ~/.openmc/endf-b-viii.0
export OPENMC_CROSS_SECTIONS=~/.openmc/endf-b-viii.0/cross_sections.xml
sha256sum ~/.openmc/endf-b-viii.0/cross_sections.xml  # pin in record

# Then extend stdlib/energy/openmc_keff.py with single-pin LWR
# geometry (currently a stub) and have it call openmc.run() +
# parse statepoint k_combined.nominal_value. Cite arxiv:2506.22559
# Table II row used. provisional=true per D80 (hexa-native MC-transport
# port absent).

# Worktree off origin/main, FF-push, rebase + retry ≤3, cleanup.
```
