// ============================================================================
//  six_coil_array.geo — 3-D six-solenoid 60-deg conformal array (Gmsh/OCC)
// ----------------------------------------------------------------------------
//  UFO magnet bay · device = RTSC solenoid x6 on a ring (structure §3.1).
//  Companion to six_coil_array.pro (magstat_a_linear_3d). Inherits the
//  OCC + BooleanFragments fragment-then-classify pattern from the RTSC
//  precedent  RTSC/magnet/getdp/solenoid_axisym.geo  (Δ=-1.40% cross-check),
//  lifted from 2-D axisymmetric to the full 3-D array because six discrete
//  coils distributed in azimuth are NOT an axisymmetric body — the disc
//  centre sits ON the array symmetry axis but OFF each coil's own axis.
//
//  ARRAY LAYOUT (UFO/structure §3.1, verb-2 structure PR pending):
//    - 6 solenoids at azimuth 0,60,120,180,240,300 deg (60-deg conformal)
//    - array radius  R_ARR = 2.4 m   (disc OML D=6.0 m; core 1.0 m + 1.4 m)
//    - each coil axis is VERTICAL (z); coil centred at its own z=0 midplane
//    - per-coil winding window (verb-3 design PR pending):
//        inner radius a = 0.20 m, outer radius b = 0.30 m, axial h = 0.60 m
//        N = 4000 turns, I = 300 A  ->  NI = 1.2e6 At
//
//          z
//          ^      (each ring = rectangular-section solenoid, axis || z)
//          |   ___              ___
//          |  |   |   air      |   |
//          |  |[C1]|  . . . .  |[C4]|     <- ring at +-R_ARR on x-axis
//          |  |___|            |___|
//          +----------(disc centre, r=0,z=0)----------> x
//
//  COORDINATE CONVENTION: full Cartesian (x,y,z). Disc centre at origin.
//
//  PHYSICAL-GROUP CONTRACT (must match six_coil_array.pro):
//    Physical Volume  "AIR"     -> 1000   (vacuum/air box, mu_r = 1)
//    Physical Volume  "COIL"    -> 2000   (all six windings, J_phi source)
//    Physical Surface "FAR_BND" -> 4000   (outer box, Dirichlet A=0)
//  (No AXIS group: a 3-D Cartesian model has no r=0 degenerate line — the
//   RTSC axisym 'AXIS Dirichlet' trap is replaced by the closed FAR_BND box.)
// ============================================================================

SetFactory("OpenCASCADE");

// ---- parameters (override:  getdp/gmsh -setnumber R_ARR 2.4 ...) -----------
R_ARR   = 2.4;     // array radius: coil-centre distance from disc axis [m]
N_COIL  = 6;       // number of solenoids (60-deg spacing)
A_IN    = 0.20;    // per-coil winding inner radius [m]
B_OUT   = 0.30;    // per-coil winding outer radius [m]
H_COIL  = 0.60;    // per-coil winding axial height [m]
R_BOX   = 3.6;     // air-box radius (1.5 x R_ARR, far-field truncation) [m]
H_BOX   = 1.8;     // air-box half-height [m]
LC_AIR  = 0.30;    // mesh size in air  [m]
LC_COIL = 0.05;    // mesh size in coil [m]

// ---- air box (cylinder centred on origin, axis = z) ------------------------
air = news;
Cylinder(air) = {0, 0, -H_BOX, 0, 0, 2*H_BOX, R_BOX};

// ---- six rectangular-section solenoid rings (annulus extruded in z) --------
//  Each ring = (outer disc - inner disc) extruded over H_COIL, positioned at
//  azimuth theta on the circle r = R_ARR, axis || z. Built as a thick washer
//  via two coaxial cylinders + BooleanDifference.
coil_ids[] = {};
For k In {0:N_COIL-1}
  theta = k * 2*Pi / N_COIL;
  cx = R_ARR * Cos(theta);
  cy = R_ARR * Sin(theta);
  // outer solid cylinder (b) and inner hole cylinder (a), both axis || z
  outer = news;
  Cylinder(outer) = {cx, cy, -H_COIL/2, 0, 0, H_COIL, B_OUT};
  inner = news;
  Cylinder(inner) = {cx, cy, -H_COIL/2, 0, 0, H_COIL, A_IN};
  ring = news;
  BooleanDifference(ring) = { Volume{outer}; Delete; }{ Volume{inner}; Delete; };
  coil_ids[] += ring;
EndFor

// ---- fragment air around the six rings -> conforming shared boundary -------
//  BooleanFragments (RTSC trap #2: fragment, do NOT union — preserves the
//  coil/air interface so J_phi has a clean support boundary).
frag[] = BooleanFragments{ Volume{air}; Delete; }{ Volume{coil_ids[]}; Delete; };

// ---- classify fragments: largest volume = air, the rest = coils -----------
N_FRAG = #frag[];
vmax = -1; air_tag = -1;
For i In {0:N_FRAG-1}
  v = Mass Volume { frag[i] };
  If (v > vmax)
    vmax = v;
    air_tag = frag[i];
  EndIf
EndFor

coil_tags[] = {};
For i In {0:N_FRAG-1}
  If (frag[i] != air_tag)
    coil_tags[] += frag[i];
  EndIf
EndFor

Physical Volume("AIR",  1000) = { air_tag };
Physical Volume("COIL", 2000) = { coil_tags[] };

// ---- far boundary: all outer surfaces of the air box -----------------------
box_surf[] = Boundary { Volume { air_tag }; };
Physical Surface("FAR_BND", 4000) = { box_surf[] };

// ---- mesh sizing -----------------------------------------------------------
MeshSize { PointsOf{ Volume { air_tag };     } } = LC_AIR;
MeshSize { PointsOf{ Volume { coil_tags[] }; } } = LC_COIL;

Mesh.Algorithm    = 1;   // 2-D MeshAdapt
Mesh.Algorithm3D  = 1;   // 3-D Delaunay — robust with OCC fragments
Mesh.ElementOrder = 1;
Mesh.Optimize     = 1;
