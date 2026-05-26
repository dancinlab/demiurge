// ============================================================================
//  solenoid_axisym.geo — 2-D axisymmetric finite-SOLENOID geometry (Gmsh/OCC)
// ----------------------------------------------------------------------------
//  RTSC magnet sub-track · device = solenoid (rectangular annular winding).
//  Companion to solenoid_axisym.pro (magstat_a_linear). Exposes the shared
//  physical-group contract reused by pancake_axisym.geo.
//
//  A solenoid in axisymmetric (r,z) cross-section is a TALL, NARROW rectangle:
//  small radial extent (R_IN → R_OUTC), large axial height (H_COIL),
//  centred on z=0. (The pancake is the transpose — wide and flat.)
//
//          r=0 (axis)        r=R_OUT
//          +------+----+------+   <- z=+H_OUT
//          | air  | || | air  |   <- z=+H_COIL/2
//          |      | || |      |
//          |      |coil|      |
//          |      | || |      |
//          | air  | || | air  |   <- z=-H_COIL/2
//          +------+----+------+   <- z=-H_OUT
//          ^axis  r=R_IN
//                   r=R_OUTC
//
//  Coordinate convention: gmsh x → r, gmsh y → z  (matches the .pro).
//
//  NOTE on J_φ: winding-window area  A_coil = (R_OUTC - R_IN) * H_COIL.
//  Pass the matching A_COIL to the .pro (-setnumber A_COIL <value>).
//
//  PHYSICAL-GROUP CONTRACT (must match solenoid_axisym.pro):
//    Physical Surface "AIR"     → 1000
//    Physical Surface "COIL"    → 2000
//    Physical Curve   "AXIS"    → 3000
//    Physical Curve   "FAR_BND" → 4000
// ============================================================================

SetFactory("OpenCASCADE");

// ---- parameters (edit or override; a solenoid = narrow & tall) -------------
R_OUT  = 0.25;     // outer air-box radius [m] (far-field truncation)
H_OUT  = 0.60;     // air-box half-height  [m]
R_IN   = 0.030;    // winding inner radius [m]
R_OUTC = 0.055;    // winding outer radius [m]  (radially NARROW)
H_COIL = 0.200;    // winding axial height [m]  (axially TALL)
LC_AIR  = 0.025;   // mesh size in air  [m]
LC_COIL = 0.00625; // mesh size in coil [m]

// ---- half-plane rectangles (r ≥ 0) -----------------------------------------
air_full = news;
Rectangle(air_full) = {0, -H_OUT, 0, R_OUT, 2*H_OUT};
coil = news;
Rectangle(coil) = {R_IN, -H_COIL/2, 0, R_OUTC - R_IN, H_COIL};

// ---- fragment air around coil → conforming shared boundary -----------------
frag[] = BooleanFragments{ Surface{air_full}; Delete; }{ Surface{coil}; Delete; };

// ---- identify which fragment is air vs coil (larger area = air) ------------
m1 = Mass Surface { frag[0] };
m2 = Mass Surface { frag[1] };
If (m1 >= m2)
  AIR_TAG  = frag[0];
  COIL_TAG = frag[1];
Else
  AIR_TAG  = frag[1];
  COIL_TAG = frag[0];
EndIf

Physical Surface("AIR",  1000) = { AIR_TAG  };
Physical Surface("COIL", 2000) = { COIL_TAG };

// ---- boundary curves --------------------------------------------------------
axis_curves[] = Curve In BoundingBox { -1e-6, -H_OUT-1, -1e-6,
                                        1e-6,  H_OUT+1,  1e-6 };
bot_curves[] = Curve In BoundingBox { -1e-6, -H_OUT-1e-6, -1e-6,
                                       R_OUT+1e-6, -H_OUT+1e-6, 1e-6 };
top_curves[] = Curve In BoundingBox { -1e-6,  H_OUT-1e-6, -1e-6,
                                       R_OUT+1e-6,  H_OUT+1e-6, 1e-6 };
rgt_curves[] = Curve In BoundingBox { R_OUT-1e-6, -H_OUT-1e-6, -1e-6,
                                      R_OUT+1e-6,  H_OUT+1e-6, 1e-6 };

Physical Curve("AXIS",    3000) = axis_curves[];
Physical Curve("FAR_BND", 4000) = { bot_curves[], top_curves[], rgt_curves[] };

// ---- mesh sizing ------------------------------------------------------------
MeshSize { PointsOf{ Surface { AIR_TAG  }; } } = LC_AIR;
MeshSize { PointsOf{ Surface { COIL_TAG }; } } = LC_COIL;

Mesh.Algorithm     = 5;   // Delaunay — robust with OCC fragments
Mesh.ElementOrder  = 1;
