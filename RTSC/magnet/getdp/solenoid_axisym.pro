// ============================================================================
//  solenoid_axisym.pro — 2-D axisymmetric magnetostatic coil TEMPLATE
//  (GetDP · linear A-φ formulation · formulation id = magstat_a_linear)
// ----------------------------------------------------------------------------
//  RTSC magnet sub-track · device-agnostic within the axisymmetric family.
//  The SAME file drives both `solenoid_axisym.geo` and `pancake_axisym.geo`
//  because both expose the identical physical-group contract (below).
//
//  HONEST SCOPE (commons g3): linear, μ_r = 1 everywhere. This models the
//  vacuum/air field of a prescribed engineering current density only —
//  HTS critical-state (Jc(B,T,θ)), quench, ramp-loss and 3-D end effects
//  are NOT captured. See RTSC.md §4.3 caveats. For HTS-grade physics the
//  H-formulation track (multi-week) supersedes this.
//
//  REFERENCES:
//    - C. Geuzaine, "GetDP: a general finite-element solver for the de Rham
//      complex", PAMM 7(1):1010603, 2007.  (get-dp.org)
//    - GetDP tutorial `models/Magnetostatics` — linear A-φ axisymmetric.
//    - F. Henrotte et al., JCAM 209(4), 2007 (formulation ancestry; we use
//      only the linear branch).
//
//  COORDINATE CONVENTION (GetDP axisymmetric):  gmsh x → r,  gmsh y → z.
//  The VolAxiSqu Jacobian carries the 2π·r measure appropriate for the
//  azimuthal vector potential A_φ and is regular on the symmetry axis r=0.
//
//  PHYSICAL-GROUP CONTRACT (the .geo MUST tag exactly these):
//    Physical Surface "AIR"     → 1000   (vacuum/air, μ_r = 1)
//    Physical Surface "COIL"    → 2000   (winding cross-section, J_φ source)
//    Physical Curve   "AXIS"    → 3000   (r = 0 symmetry line, Dirichlet A=0)
//    Physical Curve   "FAR_BND" → 4000   (truncation boundary, Dirichlet A=0)
//
//  PARAMETERS (override on the command line, e.g.
//      getdp solenoid_axisym.pro -setnumber N_TURNS 240 -setnumber I_CURRENT 150 ...
//   or substitute by a producer before invoke). DefineConstant gives each a
//   default so the template is runnable as-is.
// ============================================================================

DefineConstant[
  N_TURNS   = { 120,    Name "Coil/Number of turns N"          },  // [-]
  I_CURRENT = { 100,    Name "Coil/Current per turn I [A]"      },  // [A]
  // Coil winding-window cross-section area A_coil [m^2]. For a rectangular
  // winding this is (R_outc - R_in) * H_coil. Defaulted to the solenoid_axisym
  // .geo reference window (0.055-0.030) * 0.200 = 0.005 m^2. Override to match
  // whatever .geo is meshed (the pancake stub uses the same window product).
  A_COIL    = { 0.005,  Name "Coil/Winding cross-section A [m^2]" },
  // Axial sweep half-length for the on-axis B(z) post-op line [m].
  Z_SWEEP   = { 0.6,    Name "Post/Axial sweep half-length [m]"  },
  // Output directory for the Print[] tables (Format Table → plain text).
  OUT_DIR   = { ".",    Name "Post/Output directory"            }
];

Group {
  Air    = Region[ 1000 ];
  Coil   = Region[ 2000 ];
  Axis   = Region[ 3000 ];
  FarBnd = Region[ 4000 ];
  Domain = Region[ { Air, Coil } ];
}

Function {
  mu0     = 4 * Pi * 1e-7;       // vacuum permeability [H/m]
  nu[All] = 1 / mu0;             // reluctivity ν = 1/μ ; μ_r = 1 (linear)

  // Engineering azimuthal current density  J_φ = N·I / A_coil  [A/m^2].
  // For the Form1P (perpendicular-edge) axisymmetric A-φ formulation the
  // source is a VECTOR whose component perpendicular to the (r,z) mesh
  // plane (here the gmsh-z slot) carries the azimuthal current; a scalar
  // would yield a zero RHS because the test function {a} is a perp form.
  js[Coil] = Vector[ 0, 0, (N_TURNS * I_CURRENT) / A_COIL ];
}

Constraint {
  { Name a_BC; Type Assign;
    Case {
      // Dirichlet A_φ = 0 on the far boundary (proxy for infinity).
      { Region FarBnd; Value 0; }
      // Dirichlet A_φ = 0 on the symmetry axis r=0: a regular on-axis
      // B-field requires the vector potential to vanish there. VolAxiSqu's
      // u = r·A_φ substitution implies this analytically; pinning it
      // explicitly stabilises Form1P node DOFs against drift along r=0.
      { Region Axis; Value 0; }
    }
  }
}

Jacobian {
  { Name Vol; Case { { Region All; Jacobian VolAxiSqu; } } }  // 2π·r volume
  { Name Sur; Case { { Region All; Jacobian SurAxi;    } } }  // 2π·r surface
}

Integration {
  { Name I1;
    Case { { Type Gauss;
      Case {
        { GeoElement Triangle; NumberOfPoints 4; }
        { GeoElement Line;     NumberOfPoints 4; }
      } } } }
}

FunctionSpace {
  { Name H_a; Type Form1P;     // perpendicular 1-form → axisymmetric A_φ
    BasisFunction {
      { Name se; NameOfCoef ae; Function BF_PerpendicularEdge;
        // Support must include the 1-D boundary regions so the Dirichlet
        // constraint can pin their nodes; otherwise the constrained DOFs
        // never enter the system and the boundary value is silently ignored.
        Support Region[ { Domain, FarBnd, Axis } ];
        Entity NodesOf[ All ]; }
    }
    Constraint {
      { NameOfCoef ae; EntityType NodesOf; NameOfConstraint a_BC; }
    }
  }
}

Formulation {
  { Name Magstat_a; Type FemEquation;
    Quantity {
      { Name a; Type Local; NameOfSpace H_a; }
    }
    Equation {
      // curl-curl stiffness:  ∫ ν (∇×A)·(∇×A')
      Integral { [ nu[] * Dof{d a}, {d a} ];
                 In Domain; Jacobian Vol; Integration I1; }
      // source coupling:  -∫ J·A'   (sign per GetDP A-φ convention)
      Integral { [ -js[], {a} ];
                 In Coil; Jacobian Vol; Integration I1; }
    }
  }
}

Resolution {
  { Name MagStat;
    System { { Name Sys_Mag; NameOfFormulation Magstat_a; } }
    Operation {
      InitSolution[ Sys_Mag ];
      Generate[ Sys_Mag ];
      Solve[ Sys_Mag ];
      SaveSolution[ Sys_Mag ];
      PostOperation[ MagStat ];
    }
  }
}

PostProcessing {
  { Name MagStat; NameOfFormulation Magstat_a;
    Quantity {
      { Name b;    Value { Local { [ {d a} ];        In Domain; Jacobian Vol; } } }
      { Name bmag; Value { Local { [ Norm[{d a}] ];  In Domain; Jacobian Vol; } } }
      { Name bz;   Value { Local { [ CompZ[{d a}] ]; In Domain; Jacobian Vol; } } }
      { Name az;   Value { Local { [ CompZ[{a}] ];   In Domain; Jacobian Vol; } } }
      // Stored magnetic energy  W = 0.5 ∫ ν |B|² dV   →   L = 2W / I²
      { Name Wmag;
        Value { Integral { [ 0.5 * nu[] * SquNorm[{d a}] ];
                In Domain; Jacobian Vol; Integration I1; } } }
    }
  }
}

PostOperation {
  { Name MagStat; NameOfPostProcessing MagStat;
    Operation {
      // |B| at the coil/axis center (r=0, z=0).
      Print[ bmag, OnPoint {0, 0, 0},
             File StrCat[OUT_DIR, "/bmag_center.txt"], Format Table ];
      // Signed Bz at the center.
      Print[ bz, OnPoint {0, 0, 0},
             File StrCat[OUT_DIR, "/bz_center.txt"], Format Table ];
      // |B| swept along the axis z ∈ [-Z_SWEEP, +Z_SWEEP], 200 samples.
      Print[ bmag, OnLine { {0, -Z_SWEEP, 0} {0, Z_SWEEP, 0} } {200},
             File StrCat[OUT_DIR, "/bmag_axis.txt"], Format Table ];
      // Total stored energy (→ inductance L = 2W/I²).
      Print[ Wmag[Domain], OnGlobal,
             File StrCat[OUT_DIR, "/stored_energy.txt"], Format Table ];
    }
  }
}
