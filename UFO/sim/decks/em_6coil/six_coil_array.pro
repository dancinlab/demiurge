// ============================================================================
//  six_coil_array.pro — 3-D magnetostatic six-solenoid array TEMPLATE
//  (GetDP · linear A-formulation · formulation id = magstat_a_linear_3d)
// ----------------------------------------------------------------------------
//  UFO magnet bay · six RTSC solenoids on a 60-deg conformal ring.
//  Drives six_coil_array.geo (same physical-group contract). Inherits the
//  linear curl-curl A-formulation + source-coupling pattern from the RTSC
//  precedent  RTSC/magnet/getdp/solenoid_axisym.pro  (Δ=-1.40% cross-check),
//  promoted from the 2-D axisymmetric A_phi (Form1P) to the full 3-D edge
//  element A (HCurl) because six discrete coils are NOT an axisymmetric body.
//
//  HONEST SCOPE (commons g3): linear, mu_r = 1 everywhere. Models the
//  vacuum field of a prescribed engineering current density only — HTS
//  critical-state Jc(B,T,theta), quench, ramp-loss are NOT captured (the RTSC
//  H-formulation track supersedes this for HTS-grade physics). The array
//  field is EXACT-by-superposition in this linear regime: the total field is
//  the sum of the six single-coil fields, so the on-axis disc-centre value
//  and the array deviation are physically well-posed FEM observables.
//
//  REFERENCES:
//    - C. Geuzaine, "GetDP: a general FE solver for the de Rham complex",
//      PAMM 7(1):1010603, 2007.  (get-dp.org)
//    - GetDP tutorial models/MagnetoStatics — 3-D linear A (h-curl edges).
//
//  COORDINATE CONVENTION: full Cartesian (x,y,z), disc centre at origin.
//
//  PHYSICAL-GROUP CONTRACT (the .geo MUST tag exactly these):
//    Physical Volume  "AIR"     -> 1000   (vacuum/air, mu_r = 1)
//    Physical Volume  "COIL"    -> 2000   (all six windings, J_phi source)
//    Physical Surface "FAR_BND" -> 4000   (truncation box, Dirichlet A x n = 0)
//
//  PARAMETERS (override on the command line, e.g.
//      getdp six_coil_array.pro -setnumber N_TURNS 4000 -setnumber I_CURRENT 300
//   DefineConstant gives each a default so the template runs as-is).
// ============================================================================

DefineConstant[
  N_TURNS   = { 4000,  Name "Coil/Number of turns N"            },  // [-]
  I_CURRENT = { 300,   Name "Coil/Current per turn I [A]"        },  // [A]
  N_COIL    = { 6,     Name "Array/Number of coils"              },  // [-]
  R_ARR     = { 2.4,   Name "Array/Coil-centre radius [m]"       },  // [m]
  A_IN      = { 0.20,  Name "Coil/Winding inner radius a [m]"    },  // [m]
  B_OUT     = { 0.30,  Name "Coil/Winding outer radius b [m]"    },  // [m]
  H_COIL    = { 0.60,  Name "Coil/Winding axial height h [m]"    },  // [m]
  // Engineering current density magnitude  |J_phi| = N*I / A_coil  [A/m^2],
  // A_coil = (b - a) * h is the rectangular winding-window cross-section.
  // (Defaulted to the verb-3 design window (0.30-0.20)*0.60 = 0.06 m^2.)
  A_COIL    = { 0.06,  Name "Coil/Winding cross-section A [m^2]" },
  Z_SWEEP   = { 1.2,   Name "Post/Axial sweep half-length [m]"   },
  OUT_DIR   = { ".",   Name "Post/Output directory"             }
];

Group {
  Air    = Region[ 1000 ];
  Coil   = Region[ 2000 ];
  FarBnd = Region[ 4000 ];
  Domain = Region[ { Air, Coil } ];
}

Function {
  mu0     = 4 * Pi * 1e-7;       // vacuum permeability [H/m]
  nu[All] = 1 / mu0;             // reluctivity nu = 1/mu ; mu_r = 1 (linear)

  Jdens = (N_TURNS * I_CURRENT) / A_COIL;   // |J_phi| magnitude [A/m^2]

  // --- per-point azimuthal current direction about the NEAREST coil axis ---
  //  Each coil sits at (R_ARR cos th_k, R_ARR sin th_k, 0) with a vertical
  //  (z) axis. The winding current circulates azimuthally about that local
  //  axis, i.e. tangential in the local (x-cx, y-cy) plane:
  //     J = Jdens * ( -(y-cy), (x-cx), 0 ) / |(x-cx, y-cy)|
  //  We sum the six coil contributions; for any field point inside COIL only
  //  the enclosing coil's annulus is non-empty, so the sum collapses to the
  //  local coil's tangential direction (RTSC trap #3: the source must be a
  //  VECTOR aligned with the physical current, never a scalar -> zero RHS).
  //
  //  NOTE (getdp .pro syntax): the Function{} block has NO For/~{} loop;
  //  the six coil centres are written as explicit Cos/Sin literals of the
  //  60-deg angles k*60deg (k=0..5). R_ARR stays an overridable constant.
  //  cx_k = R_ARR*cos(k*60deg), cy_k = R_ARR*sin(k*60deg).

  cx0 =  R_ARR * 1.0;            cy0 =  R_ARR * 0.0;             // 0   deg
  cx1 =  R_ARR * 0.5;            cy1 =  R_ARR * 0.86602540378;   // 60  deg
  cx2 = -R_ARR * 0.5;           cy2 =  R_ARR * 0.86602540378;    // 120 deg
  cx3 = -R_ARR * 1.0;           cy3 =  R_ARR * 0.0;              // 180 deg
  cx4 = -R_ARR * 0.5;           cy4 = -R_ARR * 0.86602540378;    // 240 deg
  cx5 =  R_ARR * 0.5;           cy5 = -R_ARR * 0.86602540378;    // 300 deg

  // squared in-plane distance to coil k  (avoid div-by-zero with +1e-12)
  rho2_0[] = (X[]-cx0)*(X[]-cx0) + (Y[]-cy0)*(Y[]-cy0) + 1e-12;
  rho2_1[] = (X[]-cx1)*(X[]-cx1) + (Y[]-cy1)*(Y[]-cy1) + 1e-12;
  rho2_2[] = (X[]-cx2)*(X[]-cx2) + (Y[]-cy2)*(Y[]-cy2) + 1e-12;
  rho2_3[] = (X[]-cx3)*(X[]-cx3) + (Y[]-cy3)*(Y[]-cy3) + 1e-12;
  rho2_4[] = (X[]-cx4)*(X[]-cx4) + (Y[]-cy4)*(Y[]-cy4) + 1e-12;
  rho2_5[] = (X[]-cx5)*(X[]-cx5) + (Y[]-cy5)*(Y[]-cy5) + 1e-12;

  // membership test: field point inside coil k's annulus (a <= rho <= b and
  // |z| <= h/2). Returns 1.0 inside, 0.0 outside.
  In_0[] = ( (Sqrt[rho2_0[]] >= A_IN) && (Sqrt[rho2_0[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;
  In_1[] = ( (Sqrt[rho2_1[]] >= A_IN) && (Sqrt[rho2_1[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;
  In_2[] = ( (Sqrt[rho2_2[]] >= A_IN) && (Sqrt[rho2_2[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;
  In_3[] = ( (Sqrt[rho2_3[]] >= A_IN) && (Sqrt[rho2_3[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;
  In_4[] = ( (Sqrt[rho2_4[]] >= A_IN) && (Sqrt[rho2_4[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;
  In_5[] = ( (Sqrt[rho2_5[]] >= A_IN) && (Sqrt[rho2_5[]] <= B_OUT) && (Fabs[Z[]] <= H_COIL/2) ) ? 1.0 : 0.0;

  // tangential current vector for coil k:  Jdens * (-(y-cy),(x-cx),0)/rho
  Jk_0[] = In_0[] * Jdens / Sqrt[rho2_0[]] * Vector[ -(Y[]-cy0), (X[]-cx0), 0 ];
  Jk_1[] = In_1[] * Jdens / Sqrt[rho2_1[]] * Vector[ -(Y[]-cy1), (X[]-cx1), 0 ];
  Jk_2[] = In_2[] * Jdens / Sqrt[rho2_2[]] * Vector[ -(Y[]-cy2), (X[]-cx2), 0 ];
  Jk_3[] = In_3[] * Jdens / Sqrt[rho2_3[]] * Vector[ -(Y[]-cy3), (X[]-cx3), 0 ];
  Jk_4[] = In_4[] * Jdens / Sqrt[rho2_4[]] * Vector[ -(Y[]-cy4), (X[]-cx4), 0 ];
  Jk_5[] = In_5[] * Jdens / Sqrt[rho2_5[]] * Vector[ -(Y[]-cy5), (X[]-cx5), 0 ];

  // total source: sum over the six coils (only the enclosing annulus fires).
  js[Coil] = Jk_0[] + Jk_1[] + Jk_2[] + Jk_3[] + Jk_4[] + Jk_5[];
}

Constraint {
  { Name a_BC; Type Assign;
    Case {
      // Dirichlet  n x A = 0  on the far box (proxy for infinity).
      { Region FarBnd; Value 0; }
    }
  }
}

Jacobian {
  { Name Vol; Case { { Region All; Jacobian Vol; } } }   // 3-D Cartesian
  { Name Sur; Case { { Region All; Jacobian Sur; } } }
}

Integration {
  { Name I1;
    Case { { Type Gauss;
      Case {
        { GeoElement Tetrahedron; NumberOfPoints 4; }
        { GeoElement Triangle;    NumberOfPoints 4; }
      } } } }
}

FunctionSpace {
  { Name H_a; Type Form1;    // 3-D edge (h-curl) element -> vector potential A
    BasisFunction {
      { Name se; NameOfCoef ae; Function BF_Edge;
        Support Region[ { Domain, FarBnd } ];
        Entity EdgesOf[ All ]; }
    }
    Constraint {
      { NameOfCoef ae; EntityType EdgesOf; NameOfConstraint a_BC; }
    }
  }
}

Formulation {
  { Name Magstat_a; Type FemEquation;
    Quantity {
      { Name a; Type Local; NameOfSpace H_a; }
    }
    Equation {
      // curl-curl stiffness:  integral nu (curl A).(curl A')
      Integral { [ nu[] * Dof{d a}, {d a} ];
                 In Domain; Jacobian Vol; Integration I1; }
      // source coupling:  - integral J.A'
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
    }
  }
}

PostOperation {
  { Name MagStat; NameOfPostProcessing MagStat;
    Operation {
      // |B| and Bz at the disc geometric centre (r=0, z=0) — the array head.
      Print[ bmag, OnPoint {0, 0, 0},
             File StrCat[OUT_DIR, "/bmag_center.txt"], Format Table ];
      Print[ bz,   OnPoint {0, 0, 0},
             File StrCat[OUT_DIR, "/bz_center.txt"], Format Table ];
      // on-axis |B| swept along z in [-Z_SWEEP, +Z_SWEEP], 120 samples.
      Print[ bmag, OnLine { {0, 0, -Z_SWEEP} {0, 0, Z_SWEEP} } {120},
             File StrCat[OUT_DIR, "/bmag_axis.txt"], Format Table ];
      // Bz at the centre of coil C1 (x=R_ARR,y=0,z=0) — single-coil anchor
      // for the closed-form (ioffe_loop_bz / Wheeler) cross-check.
      Print[ bz,   OnPoint {2.4, 0, 0},
             File StrCat[OUT_DIR, "/bz_coil1_center.txt"], Format Table ];
    }
  }
}
