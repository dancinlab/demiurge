#!/usr/bin/env python3
# MM-GBSA v5 — SINGLE-TRAJECTORY (the methodologically correct protocol).
# v4 bug: minimizing complex/receptor/ligand SEPARATELY lets the 2325-atom receptor
# relax to unrelated minima, so internal-energy noise (~100 kcal/mol) swamps binding.
# Fix: minimize the COMPLEX once, then single-point receptor & ligand on the SAME
# coordinates (no re-minimization). dG_bind = E_cplx - E_rec - E_lig, all one frame.
from openmm import app, unit, LangevinIntegrator, Platform, LocalEnergyMinimizer, Context
from openff.toolkit import Molecule
from openff.toolkit.utils.nagl_wrapper import NAGLToolkitWrapper
from openmmforcefields.generators import SMIRNOFFTemplateGenerator
from pdbfixer import PDBFixer
import numpy as np

fixer = PDBFixer(filename='rec_protein.pdb')
fixer.findMissingResidues(); fixer.missingResidues = {}
fixer.findNonstandardResidues(); fixer.replaceNonstandardResidues()
fixer.removeHeterogens(keepWater=False)
fixer.findMissingAtoms(); fixer.addMissingAtoms(); fixer.addMissingHydrogens(7.0)
with open('rec_fixed.pdb','w') as f: app.PDBFile.writeFile(fixer.topology, fixer.positions, f)

lig = Molecule.from_file('lig.sdf')
NAGLToolkitWrapper().assign_partial_charges(lig, partial_charge_method='openff-gnn-am1bcc-1.0.0.pt')
lig_top = lig.to_topology().to_openmm(); lig_pos = lig.conformers[0].to_openmm()

ff = app.ForceField('amber14/protein.ff14SB.xml', 'implicit/obc2.xml')
gen = SMIRNOFFTemplateGenerator(molecules=lig, forcefield='openff-2.1.0.offxml')
ff.registerTemplateGenerator(gen.generator)
rec = app.PDBFile('rec_fixed.pdb')

# build complex
cplx = app.Modeller(rec.topology, rec.positions); cplx.add(lig_top, lig_pos)
n_rec = rec.topology.getNumAtoms(); n_tot = cplx.topology.getNumAtoms()
print(f'receptor atoms {n_rec}, complex atoms {n_tot}, ligand {n_tot-n_rec}')

def make_ctx(topology):
    s = ff.createSystem(topology, nonbondedMethod=app.NoCutoff, constraints=None,
                        soluteDielectric=1.0, solventDielectric=78.5)
    return Context(s, LangevinIntegrator(300*unit.kelvin,1/unit.picosecond,0.002*unit.picoseconds),
                   Platform.getPlatformByName('CPU'))

# 1) minimize the COMPLEX once
ctx_c = make_ctx(cplx.topology); ctx_c.setPositions(cplx.positions)
LocalEnergyMinimizer.minimize(ctx_c, maxIterations=1000)
pos = ctx_c.getState(getPositions=True).getPositions(asNumpy=True)
E_c = ctx_c.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)

# 2) single-point receptor & ligand on the SAME (minimized-complex) coordinates
ctx_r = make_ctx(rec.topology); ctx_r.setPositions(pos[:n_rec])
E_r = ctx_r.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)
ctx_l = make_ctx(lig_top); ctx_l.setPositions(pos[n_rec:])
E_l = ctx_l.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)

print(f'E[complex]={E_c:.2f}  E[receptor]={E_r:.2f}  E[ligand]={E_l:.2f} kcal/mol')
dG = E_c - E_r - E_l
print(f'\n=== dG_bind (single-trajectory MM-GBSA, GBSA-OBC2) = {dG:.2f} kcal/mol ===')
print(f'  Vina docking reference = -7.77 kcal/mol')
print(f'  g63: single-snapshot, no entropy term; magnitude over-binds vs Vina is expected for raw MM-GBSA.')
