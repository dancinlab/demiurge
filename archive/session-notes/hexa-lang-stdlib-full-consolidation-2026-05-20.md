# hexa-lang stdlib — domain module consolidation into origin/main

> status: **resolved** (κ-45) — all 15 domain modules + 13 D72 kernels landed on hexa-lang `origin/main` `7332e162`. Note kept as audit-trail of the multi-branch consolidation walk.

date: 2026-05-20
goal: origin/main = canonical base for all demiurge producers.

## Result

- origin/main before: `0154227d`
- origin/main after:  `4afe3c13` (consolidation commit, fast-forward push)
- 3 of 6 target domains integrated. 3 do not exist on any branch.

## Integrated domains (3)

| domain | source commit | source branch | files | notes |
|--------|---------------|---------------|-------|-------|
| sscb   | `8d161974` | flame-spiking-substrate-primitives | README.md, devsim.hexa, devsim_test.hexa, fixtures/c3m0021120k.lib, fixtures/sample_sic_mosfet.lib, ngspice.hexa, sscb.hexa, vdmos.hexa, vdmos_test.hexa, wolfspeed.hexa, wolfspeed_parity.hexa, wolfspeed_test.hexa | latest version chosen — κ-41 hexa-native VDMOS DC model, absorbed=true, no stubs left. Older `b321582d` had `.hexa.stub` files (devsim/sscb) and only `sample_sic_mosfet.lib`; superseded. |
| fusion | `dbfb0ba7` | flame-spiking-substrate-primitives (also rfc006-yosys-rtlil-skeleton) | plasma_metrics.hexa, plasma_metrics.py, plasma_metrics_test.hexa | only commit that added the dir. κ-46 / demiurge D69 — substrate + hexa-native Stage 2 port. |
| brain  | `f87a631e` | flame-spiking-substrate-primitives (also rfc006-yosys-rtlil-skeleton, t4-emt-calc) | lif_brian2.py | only commit that added the dir. `.py` substrate ONLY — no hexa-native port exists in any branch yet. Taken as-is; flag for future κ-port. |

Extraction method: origin/main-based worktree (`/private/tmp/wt-stdlib-consol`),
`git checkout <commit> -- stdlib/<domain>/` (read-only path extract). No
side-branch checkout, no working-tree contact. All 3 are new directories on
origin/main → 0 file conflicts.

## aura·bot·energy — RECOVERED 2026-05-20 (follow-up)

The 3 domains absent from all branches above were found in the hexa-lang
**live working tree as untracked files** — the producer Agents wrote them
but never `git add`/commit/push:
- `stdlib/aura/aura_mne.py`     (MNE EEG signal processing)
- `stdlib/bot/urdfpy_basics.py` (yourdfpy URDF)
- `stdlib/energy/pvlib_clearsky.py` (pvlib solar clear-sky)

Recovered + D72-restructured in a fresh origin/main worktree
(`/private/tmp/wt-aura-bot-energy`) — live tree never touched (untracked
files read-only). All 3 are new dirs on origin/main → 0 conflicts.

D72 2-layer split applied (kernel extracted, domain module → thin ①b adapter):

| domain | ①a kernel extracted | ①b adapter |
|--------|---------------------|------------|
| aura   | `kernels/signal_proc/mne_psd_kernel.py` (Welch PSD · band power · line-noise) | `aura/aura_mne.py` (EEG channels · montage · synthetic stimulus) |
| bot    | `kernels/urdf/urdf_kernel.py` (URDF parse · kinematic-tree facts) | `bot/urdfpy_basics.py` (2-link arm URDF XML) |
| energy | `kernels/solar/pvlib_kernel.py` (Ineichen clear-sky · CEC SAPM ModelChain) | `energy/pvlib_clearsky.py` (Phoenix site · module/inverter picks) |

Adapters locate the kernel `__file__`-relative (`../kernels/<k>/`) — same
pattern as `kernels/graph` callers. Script locations/names unchanged →
demiurge Swift producers (`AuraAnalyzeProducer` / `BotStructureProducer` /
`EnergyAnalyzeProducer`) need no edit.

Verification: all 3 producers byte-identical to the pre-D72 originals —
bot meta+urdf, energy meta+csv, aura meta+fif all diff-clean (mne 1.12.1 /
pvlib 0.15.1 / yourdfpy 0.0.60). gate/absorbed/record fields: 0 changes.

- origin/main: `4afe3c13` → `7332e162` (commit `feat(stdlib): recover
  aura·bot·energy domains + extract D72 kernels`, rebase-clean push)

## Final origin/main stdlib domain inventory (45 dirs)

alloc **aura** antimatter atoms aws **bot** booksim **brain** cern cert ckpt
cloud component core crystal **energy** flame **fusion** grid hal hash kernels
linalg math matrix mc_integrate mlff mobility mol net optim policy qrng quantum
regex scope sim_universe space **sscb** tensor test time tokenize xeno yosys

(bold = added by this consolidation + the aura·bot·energy follow-up)

D72 kernels on origin/main: circuit · fem · graph · logic_synth · mc_transport ·
neural · noc_sim · orbital · plasma · **signal_proc** · **solar** · **urdf** ·
wave_optics (13).

## Exit criterion

Outcome (a) — complete: all 6 target domains now integrated + verified on
origin/main. aura·bot·energy recovered from the live working tree (untracked),
D72-restructured (3 kernels extracted), byte-identical self-test, pushed.
