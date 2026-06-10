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
# This deck targets the documented OpenFE >= 1.x API. The handful of settings-field
# paths that need a live `import openfe` to confirm for the installed version are
# tagged  # API-CONFIRM  and wrapped in best-effort try/except where optional.
#
# ── USAGE ────────────────────────────────────────────────────────────────────
#   SMOKE=1 python3 rbfe_hsp90.py          # ~minutes, pipeline-validity only
#   N_REPEATS=3 python3 rbfe_hsp90.py      # production (default below)
#   python3 rbfe_hsp90.py                  # resumes from *.nc if present
#
import os, sys, json, time, pathlib

# pin pymbar's JAX to CPU BEFORE any openmmtools/openfe import — otherwise JAX and
# OpenMM both grab the single GPU and segfault (same lesson as abfe_hsp90_pair.py).
os.environ.setdefault("JAX_PLATFORMS", "cpu")
os.environ.setdefault("JAX_PLATFORM_NAME", "cpu")
os.environ.setdefault("CUDA_VISIBLE_DEVICES", "0")

import numpy as np

HERE = pathlib.Path(__file__).resolve().parent
REC_PDB = HERE / "hsp90_rec_clean.pdb"
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
    """Load both ligands and translate their centroids onto the receptor centroid,
    exactly as abfe_hsp90_pair.build_complex does, so OpenFE solvates a small box
    that wraps the receptor (not the 9.8 nm origin→receptor span)."""
    from rdkit import Chem

    # receptor centroid (Å) straight from the PDB
    rec = []
    for line in REC_PDB.read_text().splitlines():
        if line.startswith(("ATOM", "HETATM")):
            rec.append((float(line[30:38]), float(line[38:46]), float(line[46:54])))
    rec_centroid = np.array(rec).mean(axis=0)  # Å

    def shifted(sdf_path):
        m = Chem.MolFromMolFile(str(sdf_path), removeHs=False, sanitize=True)
        if m is None:
            sys.exit(f"ligand load failed: {sdf_path}")
        conf = m.GetConformer()
        pos = np.array([list(conf.GetAtomPosition(i)) for i in range(m.GetNumAtoms())])
        pos = pos - pos.mean(axis=0) + rec_centroid     # centroid → pocket (Å)
        for i in range(m.GetNumAtoms()):
            conf.SetAtomPosition(i, tuple(float(x) for x in pos[i]))
        return m

    return shifted(LIG_A_SDF), shifted(LIG_B_SDF), rec_centroid


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

    protein = ProteinComponent.from_pdb_file(str(REC_PDB), name="HSP90")
    # 0.15 M NaCl, neutralizing — matches the ABFE deck's solvation.
    solvent = SolventComponent(ion_concentration=0.15 * offunit.molar)

    # single-topology atom mapping over the shared ansamycin core (LOMAP).
    # Kartograf is a geometry-aware alternative; LOMAP is the OpenFE default and
    # is robust for a single C17-substituent edit.
    from openfe.setup.atom_mapping import LomapAtomMapper  # API-CONFIRM symbol path
    mapper = LomapAtomMapper(threed=True, element_change=False)
    mapping = next(mapper.suggest_mappings(ligA, ligB))
    n_mapped = len(mapping.componentA_to_componentB)
    print(f"[rbfe] LOMAP mapping: {n_mapped} core atoms mapped "
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
    settings.engine_settings.compute_platform = "CUDA"            # API-CONFIRM field
    settings.protocol_repeats = N_REPEATS                          # API-CONFIRM field

    # lambda windows / HREX.
    settings.lambda_settings.lambda_windows = N_REPLICAS           # API-CONFIRM field

    # sampler length: simulation_settings carries equilibration/production lengths.
    ss = settings.simulation_settings
    ss.equilibration_length = EQ_PS * offunit.picosecond           # API-CONFIRM field
    ss.production_length = PROD_PS * offunit.picosecond            # API-CONFIRM field
    # checkpoint cadence for .nc resumability.
    try:
        ss.checkpoint_interval = 250 * offunit.timestep           # API-CONFIRM field
    except Exception:
        pass

    # HMR + 4 fs timestep (matches the ABFE deck) when the field is exposed.
    try:
        settings.integrator_settings.timestep = 4 * offunit.femtosecond
        settings.forcefield_settings.hydrogen_mass = 3.0
    except Exception:
        pass

    return RelativeHybridTopologyProtocol(settings)


def main():
    t0 = time.time()
    OUT_DIR.mkdir(exist_ok=True)
    print(f"=== SENOLYX R12 RBFE 17AG↔17AAG / HSP90 (SMOKE={SMOKE}, "
          f"repeats={N_REPEATS}, windows={N_REPLICAS}, "
          f"eq={EQ_PS}ps prod={PROD_PS}ps) ===", flush=True)

    mapping, (complexA, complexB), (solventA, solventB) = build_components()
    protocol = make_protocol()

    # two legs of the relative perturbation.
    legs = {
        "complex": protocol.create(stateA=complexA, stateB=complexB, mapping=mapping),
        "solvent": protocol.create(stateA=solventA, stateB=solventB, mapping=mapping),
    }

    leg_dG = {}
    for leg_name, dag in legs.items():
        print(f"[rbfe] --- leg '{leg_name}': executing DAG "
              f"({len(dag.protocol_units)} unit(s)) ---", flush=True)
        leg_dir = OUT_DIR / leg_name
        leg_dir.mkdir(exist_ok=True)
        from gufe.protocols import execute_DAG  # API-CONFIRM symbol path
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

    # ΔΔG_bind(17AG→17AAG) = ΔG_complex − ΔG_solvent
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
