// ===========================================================================
//  disc_frame.geo  —  UFO lenticular disc frame, circular-plate FEA model.
//
//  PHYSICAL MODEL (verb-2 structure, integrated-vehicle-structure.md s1 + s5):
//     The primary load-bearing frame is a CFRP lenticular disc.  For the
//     LC-1..5 inertial G-load gate we reduce it to an equivalent flat
//     circular plate of radius a and effective bending thickness t, built
//     from CFRP T700 quasi-isotropic face material.  The full vehicle mass
//     (650 kg) rides this disc; under N*g inertial load the plate sees a
//     uniform downward body load.  Rim is the frame-to-skirt attach ring,
//     modelled here as a simply-supported / clamped boundary (BC set in deck).
//
//  GEOMETRY:
//     a = 3.0 m   (outer radius, D = 6.0 m  -> structure s1.1)
//     t = 0.040 m (effective bending thickness of the CFRP sandwich skin;
//                   see stress-fea.md for the mass-consistency derivation)
//     -> solid disc, 3-D, swept hex/tet via gmsh.
//
//  OUTPUT:  Abaqus .inp (gmsh -3 -format inp) consumed by CalculiX ccx.
//  (extension-less `run` drives gmsh + ccx; @D d16 free dry-run first.)
// ===========================================================================
SetFactory("OpenCASCADE");

// ---- parameters ----------------------------------------------------------
a  = 3.0;     // outer radius [m]
t  = 0.040;   // effective plate thickness [m]
lc = 0.18;    // mesh characteristic length [m]

// ---- solid disc (cylinder of radius a, height t) -------------------------
Cylinder(1) = {0, 0, 0,  0, 0, t,  a};

// ---- physical groups -----------------------------------------------------
// volume = the plate body (material + body load applied here)
Physical Volume("PLATE") = {1};

// surfaces: gmsh OCC cylinder -> {1}=lateral(rim), {2}=top(+z), {3}=bottom(-z)
//   (verified by gmsh; if reordered the run script remaps by area.)
Physical Surface("RIM")    = {1};   // lateral cylindrical face -> edge support
Physical Surface("TOP")    = {2};   // +z face
Physical Surface("BOTTOM") = {3};   // -z face

// ---- mesh controls -------------------------------------------------------
Mesh.CharacteristicLengthMin = lc * 0.5;
Mesh.CharacteristicLengthMax = lc;
Mesh.ElementOrder = 2;            // quadratic tets (C3D10) -> accurate bending
Mesh.Algorithm3D = 1;            // Delaunay
Mesh.Optimize = 1;
Mesh.OptimizeNetgen = 1;
