# grid_networkx.py — phase κ-36 (P-⑧ cohort producer prototype, D57)
# NetworkX graph-topology producer for `grid + structure` — the SECOND
# **cohort** domain wired to a real measuring engine tool (after κ-34 /
# D55's `sscb + analyze` via ngspice).
#
# Invoked by Swift's GridStructureProducer via:
#   /usr/bin/env python3 cockpit/scripts/grid_networkx.py <output_dir>
#
# What it does (honest scope):
#   1. Builds the IEEE 14-bus standard test topology (Christie 1962 /
#      pglib-opf canonical) as a NetworkX Graph. 14 nodes / 20 edges.
#   2. Computes the deterministic graph-theoretic metrics that ARE
#      mathematical facts about the topology:
#         - node_count, edge_count, density
#         - diameter (max shortest-path hops)
#         - avg_shortest_path_hops
#         - radius (min eccentricity)
#         - is_connected
#         - average_clustering
#         - bisection_min_cut_edges (min over node-pair s-t cuts; the
#           graph-theoretic surrogate for "fabric bisection bandwidth"
#           — counted in LINKS, not Gbps; no SerDes assumption, g3).
#         - top-N betweenness centrality (which buses sit on the most
#           shortest paths — the "load-bearing" nodes).
#         - top-N degree centrality (the highest-fan-out buses).
#   3. Writes the graph + metrics + provenance to
#      `<output_dir>/grid_ieee14_v1.{gml,meta.json}`.
#
# HONESTY (g3 — non-negotiable):
#   • producer = "networkx@<version>" — pins the library, NOT the
#     real-world fabric. IEEE 14-bus is a *published reference test
#     case* (Christie 1962, archived at the University of Washington
#     Power Systems Test Case Archive, now mirrored as pglib-opf
#     `case14`). The TOPOLOGY is canonical; the *graph metrics
#     computed by NetworkX ARE mathematical facts* about that
#     topology — IEEE-754-deterministic, NOT a model prediction.
#     → measurement_gate = GATE_CLOSED_MEASURED is honest here
#       (the graph IS the measurement, like F1F2 chip records).
#   • absorbed = false ALWAYS — NetworkX is an EXTERNAL Python
#     library, not an absorbed-into-hexa-lang stdlib. The day a
#     `hexa-graph` stdlib lands and re-computes these metrics with
#     a numerically-identical kernel, absorbed flips elsewhere — not
#     in this script.
#   • SCOPE CAVEATS embedded:
#       - IEEE 14-bus is a POWER-GRID reference case; the demiurge
#         `grid` domain is AI DATACENTER fabric (DomainCatalog id
#         "grid" = "AI 데이터센터"). This producer demonstrates the
#         WIRING (cohort producer #2 after sscb) on a canonical
#         graph the field has measured — NOT a real DC fat-tree
#         pulled from a hyperscaler manifest.
#       - bisection_min_cut_edges counts LINKS, not Gbps. No SerDes
#         channel model, no congestion-control assumption. The "real"
#         DC bisection bandwidth gate lives in ns-3 / SST simulation
#         (domains/grid.md §2 ANALYZE) + HFSS / Sigrity SI (§4 gap).
#       - top-N centrality is reported for N=3 — single-point, not
#         a sensitivity sweep. Sweep belongs in a later phase.

import hashlib
import json
import os
import subprocess
import sys
import time
from typing import Any


# --- Topology identifier (the "geometry id" analogue for graphs)
GEOMETRY_ID = "grid_ieee14_v1"
TOP_N = 3


def build_ieee14_edges() -> list:
    """IEEE 14-bus standard test topology — 14 buses, 20 transmission
    lines / transformers, all distinct (no parallel-edge multi-graph).
    Edge list mirrors the canonical Christie 1962 / pglib-opf `case14`
    adjacency (1-indexed bus numbers).

    Source: <https://labs.ece.uw.edu/pstca/pf14/pg_tca14bus.htm> +
    pglib-opf `pglib_opf_case14_ieee.m` branch table. The TOPOLOGY is
    canonical and reproducible; this list IS the SSOT for this script.
    """
    return [
        (1, 2), (1, 5),
        (2, 3), (2, 4), (2, 5),
        (3, 4),
        (4, 5), (4, 7), (4, 9),
        (5, 6),
        (6, 11), (6, 12), (6, 13),
        (7, 8), (7, 9),
        (9, 10), (9, 14),
        (10, 11),
        (12, 13),
        (13, 14),
    ]


def edges_sha256_16(edges: list) -> str:
    """Hash the canonical edge list (sorted, undirected normal form)
    so cross-host drift is visible — same hash → byte-identical
    topology. Truncated to 16 hex chars to mirror sscb_ngspice's
    netlist_sha256_16."""
    norm = sorted((min(a, b), max(a, b)) for a, b in edges)
    payload = ";".join(f"{a}-{b}" for a, b in norm).encode("utf-8")
    return hashlib.sha256(payload).hexdigest()[:16]


def networkx_version(nx_mod: Any) -> str:
    try:
        return str(nx_mod.__version__)
    except Exception:
        return "unknown"


def compute_metrics(nx_mod: Any, graph: Any) -> dict:
    """Compute the deterministic graph-theoretic metrics. Every value
    here IS a mathematical fact about the topology (no model, no
    parameter, no Monte Carlo). The honesty gate is on the *real-world
    interpretation* (caveats), NOT on the *measurement*.

    Returns a flat dict serializable to JSON.
    """
    n = graph.number_of_nodes()
    m = graph.number_of_edges()
    connected = bool(nx_mod.is_connected(graph))

    # Shortest-path metrics — only well-defined on a connected graph.
    if connected:
        diameter = int(nx_mod.diameter(graph))
        radius = int(nx_mod.radius(graph))
        avg_sp = float(nx_mod.average_shortest_path_length(graph))
    else:
        diameter = None
        radius = None
        avg_sp = None

    density = float(nx_mod.density(graph))
    avg_clustering = float(nx_mod.average_clustering(graph))

    # Bisection-min-cut surrogate: minimum edge-connectivity (the
    # smallest s-t cut over all node pairs). For a connected graph
    # this is well-defined and = edge_connectivity(G). Counted in
    # LINKS — NOT Gbps (g3 caveat #2).
    if connected:
        bisection_min_cut = int(nx_mod.edge_connectivity(graph))
    else:
        bisection_min_cut = None

    # Centrality — top-N by score, ties broken by node id.
    btw = nx_mod.betweenness_centrality(graph)
    deg = nx_mod.degree_centrality(graph)

    def _top_n(d: dict) -> list:
        items = sorted(d.items(), key=lambda kv: (-kv[1], kv[0]))[:TOP_N]
        return [{"node": int(k), "score": float(v)} for k, v in items]

    return {
        "node_count": int(n),
        "edge_count": int(m),
        "is_connected": connected,
        "density": density,
        "diameter": diameter,
        "radius": radius,
        "avg_shortest_path_hops": avg_sp,
        "average_clustering": avg_clustering,
        "bisection_min_cut_edges": bisection_min_cut,
        "top_betweenness": _top_n(btw),
        "top_degree": _top_n(deg),
    }


def main(argv: list) -> int:
    if len(argv) < 2:
        sys.stderr.write("usage: grid_networkx.py <output_dir>\n")
        return 2
    output_dir = argv[1]
    os.makedirs(output_dir, exist_ok=True)

    # Import networkx — honest gap if missing (the Swift side has
    # already located python3, but networkx is an `import`-time
    # dependency, so the failure manifests here).
    try:
        import networkx as nx
    except ImportError as exc:
        sys.stderr.write(
            f"grid_networkx: networkx import failed — {exc}. "
            "Install with `pip3 install --user networkx` (g3 — "
            "silent success forbidden).\n")
        summary = {"ok": False, "geometry_id": GEOMETRY_ID,
                   "error": "networkx_import_failed"}
        sys.stderr.write(
            "GRID_NETWORKX_RESULT " + json.dumps(summary, sort_keys=True) + "\n")
        return 3

    nx_version = networkx_version(nx)

    edges = build_ieee14_edges()
    edges_hash = edges_sha256_16(edges)

    g = nx.Graph()
    g.add_nodes_from(range(1, 15))
    g.add_edges_from(edges)

    t0 = time.perf_counter()
    try:
        meas = compute_metrics(nx, g)
    except Exception as exc:
        sys.stderr.write(
            f"grid_networkx: metric computation failed — {exc} (g3).\n")
        summary = {"ok": False, "geometry_id": GEOMETRY_ID,
                   "edges_sha256_16": edges_hash,
                   "error": f"compute_failed: {exc}"}
        sys.stderr.write(
            "GRID_NETWORKX_RESULT " + json.dumps(summary, sort_keys=True) + "\n")
        return 4
    t_elapsed = time.perf_counter() - t0

    # Persist the graph (GML — widely-readable, NetworkX round-trip
    # safe) so downstream tools can re-load it.
    gml_path = os.path.join(output_dir, f"{GEOMETRY_ID}.gml")
    meta_path = os.path.join(output_dir, f"{GEOMETRY_ID}.meta.json")

    try:
        nx.write_gml(g, gml_path)
    except Exception as exc:
        sys.stderr.write(
            f"grid_networkx: GML write failed — {exc} (g3).\n")
        summary = {"ok": False, "geometry_id": GEOMETRY_ID,
                   "edges_sha256_16": edges_hash,
                   "error": f"gml_write_failed: {exc}"}
        sys.stderr.write(
            "GRID_NETWORKX_RESULT " + json.dumps(summary, sort_keys=True) + "\n")
        return 5

    meta = {
        "ok": True,
        "geometry_id": GEOMETRY_ID,
        "edges_sha256_16": edges_hash,
        "networkx_version": nx_version,
        "topology": {
            "name": "IEEE 14-bus",
            "source": "Christie 1962 / pglib-opf case14",
            "node_count": g.number_of_nodes(),
            "edge_count": g.number_of_edges(),
            "edges": [list(e) for e in edges],
        },
        "measurements": meas,
        "compute_elapsed_s": t_elapsed,
        "artifacts": {
            "gml": f"{GEOMETRY_ID}.gml",
        },
    }
    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2, sort_keys=True)
        f.write("\n")

    sys.stderr.write(
        f"grid_networkx: wrote {meta_path} "
        f"(nodes={meas['node_count']}, edges={meas['edge_count']}, "
        f"diameter={meas['diameter']}, "
        f"bisection={meas['bisection_min_cut_edges']})\n")

    artifacts_with_meta = dict(meta["artifacts"])
    artifacts_with_meta["meta"] = f"{GEOMETRY_ID}.meta.json"
    summary = {
        "ok": True,
        "geometry_id": GEOMETRY_ID,
        "edges_sha256_16": edges_hash,
        "networkx_version": nx_version,
        "node_count": meas["node_count"],
        "edge_count": meas["edge_count"],
        "diameter": meas["diameter"],
        "avg_shortest_path_hops": meas["avg_shortest_path_hops"],
        "bisection_min_cut_edges": meas["bisection_min_cut_edges"],
        "artifacts": artifacts_with_meta,
    }
    sys.stderr.write(
        "GRID_NETWORKX_RESULT " + json.dumps(summary, sort_keys=True) + "\n")
    sys.stderr.flush()
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
