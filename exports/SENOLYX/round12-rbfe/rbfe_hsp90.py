#!/usr/bin/env python3
# SENOLYX R12 — breakthrough-path ② : SINGLE-TOPOLOGY relative free energy
# perturbation (RBFE) for the 17AG <-> 17AAG congeneric pair on HSP90.
#
# ── WHY THIS REPLACES THE ABFE-DIFFERENCE PROXY ──────────────────────────────
# R12-GOLD computed ΔΔG = ABFE(17AG) − ABFE(17AAG) by subtracting two SEPARATE
# absolute-binding-free-energy runs (abfe_hsp90_pair.py). The definitive result
# (ΔΔG = +2.74) had the WRONG SIGN (exp ≈ −1.9, 17AG tighter) and was CLOSED-
# NEGATIVE because each per-leg absolute ΔG is run-to-run BISTABLE (the solvent-
# decoupling λ-leg does not reproduce), and the difference of two unstable
# absolutes does NOT cancel that error.
#
# This deck instead alchemically MORPHS 17AG <-> 17AAG directly inside ONE box
# (single-topology / hybrid-topology). The two ligands share the entire ansamycin
# macrocycle + quinone core; only the C17 substituent differs (amino[17AG] vs
# allylamino[17AAG]). In a relative perturbation, the shared core is NEVER
# decoupled — it stays fully interacting in both end states — so the systematic
# FF error AND the bistable solvent-decoupling pathology cancel BY CONSTRUCTION.
# Only the handful of perturbed C17 atoms are alchemically transformed. This is
# the textbook-correct tool for a congeneric pair and is what was wanted in R12
# all along; the proxy was used ONLY because openfe was absent from summer's env.
#
# ── ENGINE ───────────────────────────────────────────────────────────────────
# OpenFE RelativeHybridTopologyProtocol (openmmtools HREX replica exchange under
# the hood + MBAR) over a single-edge LigandNetwork (17AG <-> 17AAG) with a
# LOMAP atom mapping across the shared core. Two legs are run automatically by
# the protocol: 'complex' (ligand in the HSP90 pocket) and 'solvent' (ligand in
# water). ΔΔG_bind = ΔG_complex − ΔG_solvent. Native .nc storage → resumable.
#
# ── BOX-FIX (inherited from abfe_hsp90_pair.py) ──────────────────────────────
# The ligand SDFs are origin-centred (centroid ~0,0,0 Å) while the receptor sits
# at centroid ~(68.9,-28.6,63.6) Å ≈ 9.8 nm away (verified). Before handing the
# ligands to OpenFE we TRANSLATE each ligand's centroid onto the receptor
# centroid (the HSP90 N-domain ATP pocket) so the solvated complex box wraps the
# receptor (~31k atoms) instead of the 9.8 nm origin→receptor span (~289k atoms).
#
# ── FEASIBILITY NOTE (READ RBFE_PLAN.md) ─────────────────────────────────────
# openfe IS installable on summer for free: the PINNED, strict-channel solve
# converges in ~23 s to openfe 1.11.1 (total download ~120 MB; most CUDA deps
# already cached). Env-create command (one-time, new env, leaves `fep` untouched):
#   micromamba create -n rbfe -c conda-forge --channel-priority strict \
#       openfe python=3.11 -y
# This deck is CONFIRMED against the installed OpenFE 1.11.1 / gufe 1.10.0 API on
# summer (every former `# API-CONFIRM` settings-field path validated against a live
# `RelativeHybridTopologyProtocol.default_settings()` dump — see RBFE_PLAN.md §6).
#
# ── USAGE ────────────────────────────────────────────────────────────────────
#   SMOKE=1 LEGS=solvent python3 rbfe_hsp90.py   # protein-free smoke (no dock req.)
#   SMOKE=1 python3 rbfe_hsp90.py                # both legs (complex needs a dock)
#   N_REPEATS=3 python3 rbfe_hsp90.py            # production (default below)
#   python3 rbfe_hsp90.py                        # resumes from *.nc if present
#   env knobs: SMOKE LEGS N_REPLICAS EQ_PS PROD_PS N_REPEATS
#
# ── VALIDATION STATE (2026-06, summer / openfe 1.11.1) ───────────────────────
# Validated end-to-end on summer's free RTX 5070 up to and including the HREX
# sampler + MBAR estimator (solvent leg, smoke size): MCS core-align (77 atoms,
# 0.82 Å) → 77-atom LOMAP map → protocol/DAG build → OpenMM system create →
# minimize → equilibrate → HREX production → pymbar MBAR converged. Every former
# `# API-CONFIRM` field was confirmed against the live 1.11.1 API. Production
# PREREQUISITE (being fixed — WIP): the COMPLEX leg starts from a centroid box-fix
# that buries the ligand in the protein bulk → steric clash → NaN at equilibration
# step 0. The complex-leg pocket-pose + pre-relaxation fix is in progress; see the
# _load_and_dock_ligands() pocket-pose branch and RBFE_PLAN.md §7.
#
import os, sys, json, time, pathlib

# pin pymbar's JAX to CPU BEFORE any openmmtools/openfe import — otherwise JAX and
# OpenMM both grab the single GPU and segfault (same lesson as abfe_hsp90_pair.py).
os.environ.setdefault("JAX_PLATFORMS", "cpu")
os.environ.setdefault("JAX_PLATFORM_NAME", "cpu")
os.environ.setdefault("CUDA_VISIBLE_DEVICES", "0")

import numpy as np

HERE = pathlib.Path(__file__).resolve().parent
REC_PDB = HERE / "hsp90_rec_clean.pdb"     # cleaned but HYDROGEN-FREE crystal PDB
REC_PDB_H = HERE / "hsp90_rec_H.pdb"       # protonated (PDBFixer) — built on demand
LIG_A_SDF = HERE / "17AG.sdf"      # state A (amino C17, exp-tighter)
LIG_B_SDF = HERE / "17AAG.sdf"     # state B (allylamino C17)

SMOKE = os.environ.get("SMOKE", "0") == "1"
OUT_DIR = HERE / ("rbfe_smoke" if SMOKE else "rbfe_prod")

# Production protocol settings (OpenFE RelativeHybridTopologyProtocol defaults are
# already publication-grade; we make the sampler length env-overridable). Defaults:
#   - 11 lambda windows (protocol default), HREX replica exchange
#   - 5 ns / replica production, 1 ns equilibration (defaults)
#   - 3 repeats for a statistical uncertainty (defaults). SMOKE shrinks all of it.
if SMOKE:
    N_REPLICAS = int(os.environ.get("N_REPLICAS", "5"))
    EQ_PS = float(os.environ.get("EQ_PS", "10"))        # 10 ps
    PROD_PS = float(os.environ.get("PROD_PS", "20"))    # 20 ps
    N_REPEATS = int(os.environ.get("N_REPEATS", "1"))
else:
    N_REPLICAS = int(os.environ.get("N_REPLICAS", "11"))
    EQ_PS = float(os.environ.get("EQ_PS", "1000"))      # 1 ns
    PROD_PS = float(os.environ.get("PROD_PS", "5000"))  # 5 ns / replica
    N_REPEATS = int(os.environ.get("N_REPEATS", "3"))


def _load_and_dock_ligands():
    """Load both ligands, translate ligand A's centroid onto the receptor centroid
    (so OpenFE solvates a small box that wraps the receptor, not the 9.8 nm
    origin→receptor span), then MUTUALLY SUPERIMPOSE ligand B onto ligand A over
    their shared ansamycin core.

    The mutual-core alignment is REQUIRED for single-topology RBFE: the two input
    SDFs are independently origin-centred with *different* internal orientations, so
    although they share ~77 core atoms graph-wise, their 3D core coordinates do NOT
    coincide. LOMAP's `threed=True` distance filter then discards every candidate
    pair (>max3d apart) and `suggest_mappings` yields NOTHING (StopIteration). After
    an MCS-based rigid alignment the cores overlap (~0.8 Å RMSD) and LOMAP maps the
    full shared core. (Verified on summer / openfe 1.11.1: 0 → 77 atoms mapped.)"""
    from rdkit import Chem
    from rdkit.Chem import rdFMCS, rdMolAlign

    # receptor centroid (Å) straight from the PDB
    rec = []
    for line in REC_PDB.read_text().splitlines():
        if line.startswith(("ATOM", "HETATM")):
            rec.append((float(line[30:38]), float(line[38:46]), float(line[46:54])))
    rec_centroid = np.array(rec).mean(axis=0)  # Å

    def load(sdf_path):
        m = Chem.MolFromMolFile(str(sdf_path), removeHs=False, sanitize=True)
        if m is None:
            sys.exit(f"ligand load failed: {sdf_path}")
        return m

    def shift_centroid_to(m, target):
        conf = m.GetConformer()
        pos = np.array([list(conf.GetAtomPosition(i)) for i in range(m.GetNumAtoms())])
        pos = pos - pos.mean(axis=0) + target           # centroid → target (Å)
        for i in range(m.GetNumAtoms()):
            conf.SetAtomPosition(i, tuple(float(x) for x in pos[i]))
        return m

    rdmA = shift_centroid_to(load(LIG_A_SDF), rec_centroid)   # A → pocket
    rdmB = load(LIG_B_SDF)
    # NOTE (production prerequisite): this centroid translation is a BOX-FIX (keeps
    # the solvated box small), NOT a dock. It places the ligand centroid at the
    # *receptor* centroid, which for this construct can overlap protein atoms — a
    # SMOKE run then NaNs at equilibration step 0 (a starting clash minimization
    # can't clear). The complex leg therefore requires a properly POCKET-FIT ligand
    # pose (the abfe smallbox pose, or a short restrained pre-min/dock) before a
    # production fire. The SOLVENT leg has no protein and is unaffected.

    # rigid-body align B onto A over the maximum common substructure (shared core).
    mcs = rdFMCS.FindMCS([rdmA, rdmB], ringMatchesRingOnly=True,
                         completeRingsOnly=True, timeout=120)
    patt = Chem.MolFromSmarts(mcs.smartsString)
    matchA = rdmA.GetSubstructMatch(patt)
    matchB = rdmB.GetSubstructMatch(patt)
    if not matchA or not matchB or len(matchA) != len(matchB):
        sys.exit(f"MCS match failed (A={len(matchA)} B={len(matchB)}); cannot align "
                 f"ligand cores for single-topology RBFE")
    rmsd = rdMolAlign.AlignMol(rdmB, rdmA, atomMap=list(zip(matchB, matchA)))
    print(f"[rbfe] MCS shared-core align: {mcs.numAtoms} atoms, "
          f"B→A RMSD = {rmsd:.3f} Å", flush=True)

    return rdmA, rdmB, rec_centroid


def _protonate_receptor():
    """Return a path to a fully-protonated receptor PDB.

    `hsp90_rec_clean.pdb` is a cleaned but HYDROGEN-FREE crystal structure. OpenFE's
    `ProteinComponent` feeds the PDB straight into an OpenMM ForceField, which has NO
    template for a heavy-atom-only residue and raises `No template found for residue
    0 (ASP) ... missing 4 H atoms`. Unlike the ABFE openmmtools path, OpenFE does not
    protonate for us, so we run the SAME PDBFixer recipe the ABFE deck used (add
    missing heavy atoms + add hydrogens at pH 7) and cache the result. Idempotent:
    reuses hsp90_rec_H.pdb if already present."""
    if REC_PDB_H.exists():
        print(f"[rbfe] using cached protonated receptor {REC_PDB_H.name}", flush=True)
        return REC_PDB_H
    from pdbfixer import PDBFixer
    from openmm.app import PDBFile
    fixer = PDBFixer(filename=str(REC_PDB))
    fixer.findMissingResidues(); fixer.missingResidues = {}
    fixer.findNonstandardResidues(); fixer.replaceNonstandardResidues()
    fixer.removeHeterogens(keepWater=False)
    fixer.findMissingAtoms(); fixer.addMissingAtoms()
    fixer.addMissingHydrogens(7.0)
    with open(REC_PDB_H, "w") as fh:
        PDBFile.writeFile(fixer.topology, fixer.positions, fh, keepIds=True)
    print(f"[rbfe] PDBFixer: protonated receptor written → {REC_PDB_H.name}", flush=True)
    return REC_PDB_H


def build_components():
    """Build the OpenFE ChemicalSystems (complex + solvent) and the single-edge
    atom mapping over the shared core (LOMAP)."""
    from openfe import (SmallMoleculeComponent, ProteinComponent,
                        SolventComponent, ChemicalSystem)
    from openff.units import unit as offunit

    rdmA, rdmB, rec_centroid = _load_and_dock_ligands()
    print(f"[rbfe] receptor centroid (Å) = {rec_centroid.round(2).tolist()}", flush=True)

    ligA = SmallMoleculeComponent.from_rdkit(rdmA, name="17AG")
    ligB = SmallMoleculeComponent.from_rdkit(rdmB, name="17AAG")

    protein = ProteinComponent.from_pdb_file(str(_protonate_receptor()), name="HSP90")
    # 0.15 M NaCl, neutralizing — matches the ABFE deck's solvation.
    solvent = SolventComponent(ion_concentration=0.15 * offunit.molar)

    # single-topology atom mapping over the shared ansamycin core (LOMAP).
    # Kartograf is a geometry-aware alternative; LOMAP is the OpenFE default and
    # is robust for a single C17-substituent edit.
    from openfe.setup.atom_mapping import LomapAtomMapper  # CONFIRMED openfe 1.11.1
    mapper = LomapAtomMapper(threed=True, element_change=False)
    mapping = next(iter(mapper.suggest_mappings(ligA, ligB)), None)
    if mapping is None:
        # Kartograf is a geometry-aware fallback. If BOTH fail the ligands are not
        # superimposed — _load_and_dock_ligands must have failed the MCS align.
        from kartograf import KartografAtomMapper
        mapping = next(iter(KartografAtomMapper().suggest_mappings(ligA, ligB)), None)
        if mapping is None:
            sys.exit("no atom mapping found by LOMAP or Kartograf — the shared cores "
                     "are not superimposed (check the MCS align above)")
        print("[rbfe] LOMAP empty → using Kartograf geometry mapper", flush=True)
    n_mapped = len(mapping.componentA_to_componentB)
    print(f"[rbfe] atom mapping: {n_mapped} core atoms mapped "
          f"(17AG {rdmA.GetNumAtoms()} ↔ 17AAG {rdmB.GetNumAtoms()}); "
          f"perturbed = the C17 substituent only", flush=True)

    # ChemicalSystems for the two thermodynamic legs.
    complexA = ChemicalSystem({"ligand": ligA, "protein": protein, "solvent": solvent}, name="17AG_complex")
    complexB = ChemicalSystem({"ligand": ligB, "protein": protein, "solvent": solvent}, name="17AAG_complex")
    solventA = ChemicalSystem({"ligand": ligA, "solvent": solvent}, name="17AG_solvent")
    solventB = ChemicalSystem({"ligand": ligB, "solvent": solvent}, name="17AAG_solvent")
    return mapping, (complexA, complexB), (solventA, solventB)


def make_protocol():
    """RelativeHybridTopologyProtocol with env-overridable sampler length + SMOKE."""
    from openfe.protocols.openmm_rfe import RelativeHybridTopologyProtocol
    from openff.units import unit as offunit

    settings = RelativeHybridTopologyProtocol.default_settings()

    # GPU platform (summer RTX 5070, mixed precision) — same as the ABFE deck.
    # CONFIRMED openfe 1.11.1: engine_settings.compute_platform accepts "CUDA".
    settings.engine_settings.compute_platform = "CUDA"
    # CONFIRMED: protocol_repeats is a TOP-LEVEL int field (default 3).
    settings.protocol_repeats = N_REPEATS

    # lambda windows / HREX. CONFIRMED openfe 1.11.1: the number of HREX replicas
    # lives in TWO coupled fields — lambda_settings.lambda_windows (the alchemical
    # path discretisation) AND simulation_settings.n_replicas (the replica-exchange
    # sampler size). For standard HREX they MUST be equal, so we set both.
    settings.lambda_settings.lambda_windows = N_REPLICAS
    settings.simulation_settings.n_replicas = N_REPLICAS

    # sampler length: simulation_settings carries equilibration/production lengths.
    # CONFIRMED openfe 1.11.1: equilibration_length / production_length accept openff
    # picosecond Quantities, BUT each MUST be an integer multiple of
    # `time_per_iteration` (the # of MD steps between MC/exchange moves; default
    # 2.5 ps = 625 steps @ 4 fs) or system creation raises ValueError. For a SMOKE
    # the default 2.5 ps grid is coarser than the requested few-ps lengths, so we
    # shrink time_per_iteration first, then SNAP eq/prod up to its nearest multiple.
    ss = settings.simulation_settings
    if SMOKE:
        # 0.5 ps/iteration (= 125 steps @ 4 fs) gives a fine SMOKE grid.
        tpi_ps = 0.5
        ss.time_per_iteration = tpi_ps * offunit.picosecond
    else:
        tpi_ps = ss.time_per_iteration.to(offunit.picosecond).magnitude

    def _snap(ps):
        # round UP to the nearest whole multiple of tpi_ps (>= 1 iteration).
        import math
        return max(1, math.ceil(round(ps / tpi_ps, 6))) * tpi_ps

    eq_ps, prod_ps = _snap(EQ_PS), _snap(PROD_PS)
    ss.equilibration_length = eq_ps * offunit.picosecond
    ss.production_length = prod_ps * offunit.picosecond
    if SMOKE and (eq_ps != EQ_PS or prod_ps != PROD_PS):
        print(f"[rbfe] SMOKE: snapped eq {EQ_PS}->{eq_ps} ps, prod {PROD_PS}->{prod_ps} ps "
              f"(time_per_iteration {tpi_ps} ps)", flush=True)

    # checkpoint cadence for .nc resumability. CONFIRMED openfe 1.11.1: the
    # checkpoint cadence lives on OUTPUT_settings (not simulation_settings) and is a
    # TIME quantity, and (like the sampler lengths) is grid-quantised by
    # time_per_iteration. Use one full iteration as the cadence — the smallest valid
    # value — so even a SMOKE writes a checkpoint, and production checkpoints often.
    settings.output_settings.checkpoint_interval = tpi_ps * offunit.picosecond

    # HMR + 4 fs timestep (matches the ABFE deck). CONFIRMED both fields exist and
    # already default to 4 fs / H-mass 3.0 amu in openfe 1.11.1; set explicitly.
    settings.integrator_settings.timestep = 4 * offunit.femtosecond
    settings.forcefield_settings.hydrogen_mass = 3.0

    return RelativeHybridTopologyProtocol(settings)


def main():
    t0 = time.time()
    OUT_DIR.mkdir(exist_ok=True)
    print(f"=== SENOLYX R12 RBFE 17AG↔17AAG / HSP90 (SMOKE={SMOKE}, "
          f"repeats={N_REPEATS}, windows={N_REPLICAS}, "
          f"eq={EQ_PS}ps prod={PROD_PS}ps) ===", flush=True)

    mapping, (complexA, complexB), (solventA, solventB) = build_components()
    protocol = make_protocol()

    # two legs of the relative perturbation. LEGS env (comma-sep) selects which to
    # run — default both. The solvent leg is protein-free (no docking prerequisite),
    # so `LEGS=solvent` is the clean end-to-end SMOKE that exercises the full
    # sampler→MBAR→estimate path; `LEGS=complex` resumes the protein leg alone.
    _all_legs = {
        "complex": lambda: protocol.create(stateA=complexA, stateB=complexB, mapping=mapping),
        "solvent": lambda: protocol.create(stateA=solventA, stateB=solventB, mapping=mapping),
    }
    want = [s.strip() for s in os.environ.get("LEGS", "complex,solvent").split(",") if s.strip()]
    legs = {name: _all_legs[name]() for name in want}

    leg_dG = {}
    for leg_name, dag in legs.items():
        print(f"[rbfe] --- leg '{leg_name}': executing DAG "
              f"({len(dag.protocol_units)} unit(s)) ---", flush=True)
        leg_dir = OUT_DIR / leg_name
        leg_dir.mkdir(exist_ok=True)
        from gufe.protocols import execute_DAG  # CONFIRMED openfe 1.11.1 / gufe 1.10.0
        dagres = execute_DAG(
            dag,
            shared_basedir=leg_dir,          # .nc + checkpoints land here → resumable
            scratch_basedir=leg_dir,
            keep_shared=True,
            raise_error=True,
        )
        result = protocol.gather([dagres])
        dG = result.get_estimate()
        err = result.get_uncertainty()
        leg_dG[leg_name] = (dG, err)
        print(f"[rbfe] leg '{leg_name}': ΔG = {dG} ± {err}", flush=True)

    # ΔΔG_bind(17AG→17AAG) = ΔG_complex − ΔG_solvent. Only computed when BOTH legs
    # ran; a single-leg run (e.g. a `LEGS=solvent` smoke) just reports its leg ΔG.
    if not {"complex", "solvent"} <= set(leg_dG):
        print(f"\n[rbfe] single-leg run ({list(leg_dG)}): per-leg ΔG reported above; "
              f"ΔΔG needs both legs.", flush=True)
        return
    from openff.units import unit as offunit
    dG_c, err_c = leg_dG["complex"]
    dG_s, err_s = leg_dG["solvent"]
    ddG = (dG_c - dG_s).to(offunit.kilocalorie_per_mole)
    err = ((err_c ** 2 + err_s ** 2) ** 0.5).to(offunit.kilocalorie_per_mole)

    # convention: the perturbation A→B is 17AG→17AAG, so ΔΔG_bind(17AG→17AAG) is
    # POSITIVE when 17AAG binds weaker. exp ΔΔG(17AAG→17AG) ≈ −1.9 (17AG tighter)
    # ⇒ exp ΔΔG(17AG→17AAG) ≈ +1.9. PASS when computed sign is POSITIVE and
    # |ΔΔG − (+1.9)| ≤ ~1.5 kcal/mol.
    out = {
        "edge": "17AG->17AAG",
        "dG_complex_kcal": dG_c.to(offunit.kilocalorie_per_mole).magnitude,
        "dG_solvent_kcal": dG_s.to(offunit.kilocalorie_per_mole).magnitude,
        "ddG_bind_17AG_to_17AAG_kcal": ddG.magnitude,
        "ddG_err_kcal": err.magnitude,
        "exp_ddG_17AG_to_17AAG_kcal": +1.9,
        "wall_h": (time.time() - t0) / 3600.0,
        "smoke": SMOKE,
    }
    (OUT_DIR / "ddG_result.json").write_text(json.dumps(out, indent=2))
    print("\n" + "=" * 64, flush=True)
    print(f"=== ΔΔG_bind(17AG→17AAG) = {ddG.magnitude:.2f} ± {err.magnitude:.2f} "
          f"kcal/mol  (exp ≈ +1.9; PASS if sign>0 and |Δ|≤1.5) ===", flush=True)
    print(f"  complex ΔG = {out['dG_complex_kcal']:.2f}  "
          f"solvent ΔG = {out['dG_solvent_kcal']:.2f}", flush=True)
    print(f"  wall = {out['wall_h']:.2f} h  →  {OUT_DIR/'ddG_result.json'}", flush=True)


if __name__ == "__main__":
    main()
