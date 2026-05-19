# bipv_verify.py — phase κ-34 (P-⑨ verify) — gmsh mesh stats reader for
# demiurge `component + verify`.
#
# Invoked by Swift's ComponentVerifier AFTER the CLI `gmsh -3` has
# already produced a .msh file. We just open the .msh via gmsh's
# Python API and read out node / element / quality statistics into
# a typed sidecar.
#
# Usage:
#   python3 bipv_verify.py <msh_file> <output_dir>
#   PYTHONPATH=<brew gmsh lib>
#
# Why two-stage (CLI mesh + Python stats):
#   * `gmsh -3 step -o msh` matches `gmsh` CLI defaults exactly — 1944
#     nodes / 9226 elements on the κ-33 BIPV STEP in <2s.
#   * Driving the same mesh through gmsh's Python API meshes each of
#     the 90 sub-solids independently (~63k nodes, ~10min) because the
#     option defaults differ from the CLI. Honest path: use the CLI
#     for meshing, use the Python API only for stats — that's what the
#     user observed too.
#
# Outputs:
#   <output_dir>/bipv_freecad_v1.mesh.json  — typed stats sidecar
#   stderr line `BIPV_VERIFY_RESULT <json>` — Swift parses this.
#
# HONESTY (g3):
#   * A mesh is NOT a verdict. measurement_gate stays GATE_OPEN.
#   * Salome-Meca Code_Aster .comm authoring + as_run convergence is
#     the next pickup (κ-35 candidate, D55 gap ②).

import json
import os
import sys


GEOMETRY_ID = "bipv_freecad_v1"


def banner(msg):
    sys.stderr.write(f"BIPV_VERIFY_LOG {msg}\n")
    sys.stderr.flush()


def emit_summary(payload):
    sys.stderr.write("BIPV_VERIFY_RESULT " + json.dumps(payload) + "\n")
    sys.stderr.flush()


def main():
    if len(sys.argv) < 3:
        banner("usage: python3 bipv_verify.py <msh_file> <output_dir>")
        emit_summary({"ok": False, "error": "missing arguments"})
        return 2

    msh_path = os.path.abspath(sys.argv[1])
    out_dir = os.path.abspath(sys.argv[2])
    if not os.path.exists(msh_path):
        emit_summary({"ok": False, "error": f"MSH not found: {msh_path}"})
        return 2
    os.makedirs(out_dir, exist_ok=True)

    try:
        import gmsh
    except ImportError as e:
        emit_summary({
            "ok": False,
            "error": f"gmsh python module unavailable: {e}",
        })
        return 3

    stats_path = os.path.join(out_dir, f"{GEOMETRY_ID}.mesh.json")

    gmsh.initialize()
    try:
        gmsh.option.setNumber("General.Terminal", 0)
        banner(f"open MSH {msh_path}")
        gmsh.open(msh_path)

        vol_dimtags = gmsh.model.getEntities(3)
        face_dimtags = gmsh.model.getEntities(2)
        banner(f"entities — volumes={len(vol_dimtags)} faces={len(face_dimtags)}")

        node_tags, _, _ = gmsh.model.mesh.getNodes()
        n_nodes = len(node_tags)
        _types, elem_tags, _ = gmsh.model.mesh.getElements()
        n_elements = sum(len(t) for t in elem_tags)

        # Quality histogram — jacobian distribution.
        quality_bins = {}
        try:
            all_eltags = []
            for tarr in elem_tags:
                all_eltags.extend(list(tarr))
            if all_eltags:
                qs = gmsh.model.mesh.getElementQualities(all_eltags)
                for q in qs:
                    bucket = max(0, min(int(q * 10), 9))
                    key = f"{bucket/10:.1f}-{(bucket+1)/10:.1f}"
                    quality_bins[key] = quality_bins.get(key, 0) + 1
        except Exception as e:
            banner(f"quality histogram failed: {e}")

        gmsh_version = gmsh.option.getString("General.Version")

        # MED export — Salome-Meca / Code_Aster's native format. CLI's
        # `gmsh -3 ... -o foo.med` would do this directly; we run it
        # from Python so the stats + MED stay in one pipeline pass.
        med_path = os.path.join(out_dir, f"{GEOMETRY_ID}.med")
        med_ok = False
        med_err = None
        try:
            banner(f"write MED {med_path}")
            gmsh.write(med_path)
            med_ok = os.path.exists(med_path) and os.path.getsize(med_path) > 0
        except Exception as e:
            med_err = str(e)
            banner(f"MED export failed: {e}")

        stats = {
            "geometry_id": GEOMETRY_ID,
            "producer": "gmsh",
            "producer_version": gmsh_version,
            "msh_file": os.path.basename(msh_path),
            "med_file": os.path.basename(med_path) if med_ok else None,
            "med_export_error": med_err,
            "node_count": int(n_nodes),
            "element_count": int(n_elements),
            "volume_count": len(vol_dimtags),
            "face_count": len(face_dimtags),
            "quality_histogram": quality_bins,
            "honest_gap": [
                "Mesh is NOT a verdict — measurement_gate stays GATE_OPEN.",
                "A successful mesh means downstream FEA *can* run; thermal / structural verdicts are separate gates.",
                "Salome-Meca Code_Aster .comm authoring + as_run convergence is the next pickup (κ-35 candidate, D55).",
                "STEP has 90 sub-solids — logical 5-layer grouping (glass / PV / frame / sink / mount) is the .comm authoring's job, not the mesh's.",
            ],
        }
        with open(stats_path, "w", encoding="utf-8") as fp:
            json.dump(stats, fp, indent=2, sort_keys=True)

        emit_summary({
            "ok": True,
            "geometry_id": GEOMETRY_ID,
            "node_count": int(n_nodes),
            "element_count": int(n_elements),
            "volume_count": len(vol_dimtags),
            "exports": {
                "msh": os.path.basename(msh_path),
                "med": stats["med_file"],
                "stats": os.path.basename(stats_path),
            },
            "gmsh_version": gmsh_version,
        })
    finally:
        gmsh.finalize()

    return 0


if __name__ == "__main__":
    rc = main()
    sys.exit(rc)
