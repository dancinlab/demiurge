# MP API real-query setup needed — 2026-05-21

End-to-end probe of `~/core/hexa-lang/stdlib/material/mp_query.py` (RTSC.md
§8.2 + §8.5 Tier 1 sibling) requested a real Materials Project query against
MgB2 / YBa2Cu3O7 / Pb10Cu(PO4)6O. Probe results say **Branch B — setup
required**. Specifics below.

## Probe results (exact)

| Check | Result |
|---|---|
| `echo $MP_API_KEY` | empty (unset) |
| `echo $MP_API_KEY_NEW` | empty (unset) |
| `python3 -c "import pymatgen"` | OK (no `__version__` attr at root, but module imports) |
| `python3 -c "from pymatgen.core import Composition; Composition('MgB2').reduced_formula"` | OK → `MgB2` |
| `python3 -c "from pymatgen.ext.matproj import MPRester"` | **OK** (legacy path importable) |
| `python3 -c "from mp_api.client import MPRester"` | **FAIL** — ImportError chain (see below) |
| `pymatgen` version | 2024.8.9 (`pkg_resources`) |
| `mp-api` version | 0.45.9 |
| `emmet-core` version | 0.84.6rc4 |

### `mp_api.client` import failure (verbatim)

```
ImportError: cannot import name 'SymmetryUndeterminedError' from
'pymatgen.symmetry.analyzer'
(/Users/ghost/Library/Python/3.9/lib/python/site-packages/pymatgen/symmetry/analyzer.py)
```

Chain: `mp_api.client.mprester` → `emmet.core.electronic_structure` →
`emmet.core.material_property` → `emmet.core.material` →
`emmet.core.structure` → `emmet.core.symmetry` → tries to import
`SymmetryUndeterminedError` from pymatgen, which doesn't exist in 2024.8.9.

This is the classic `emmet-core` newer-than-pymatgen drift: `emmet-core
0.84.6rc4` was published expecting `pymatgen >= 2024.10.x`.

## Blockers (ranked)

1. **API key absent.** Neither `MP_API_KEY` (legacy 16-char) nor
   `MP_API_KEY_NEW` (new 32-char) is exported in the current shell. The
   adapter would emit `gate_type="api-key-missing"` and skip every formula.
   Demiurge clean-room policy: **the adapter never embeds a key, and this
   agent never prompts the user for one to paste**. User must export it
   themselves before re-running.

2. **`mp-api` (new client) broken on this machine.** The legacy `pymatgen.ext.matproj.MPRester`
   path still imports cleanly, so once a key is exported the adapter would
   still run via the legacy dispatcher (`mpr.query(...)`). But new-API
   features (`summary.search`, full mp-api filters) are unreachable until
   the version drift is fixed.

## Setup steps (in order)

### 1. Get an API key (free, ~30 sec)

- **New API (preferred)**: https://next-gen.materialsproject.org/api
  → 32-char key → export as `MP_API_KEY_NEW`
- **Legacy**: https://legacy.materialsproject.org/dashboard
  → 16-char key → export as `MP_API_KEY`

Either works; `mp_query.py::_resolve_api_key()` prefers
`MP_API_KEY_NEW` if both are set.

### 2. Export the key

```bash
# For one-shot:
export MP_API_KEY_NEW='<your-32-char-key>'

# Or persist in ~/.zshrc (your shell):
echo 'export MP_API_KEY_NEW="<your-32-char-key>"' >> ~/.zshrc
source ~/.zshrc
```

### 3. (Optional) Fix `mp-api` import — only needed if you want the new-API path

```bash
# Bump pymatgen to a version emmet-core 0.84.6rc4 expects:
pip3 install --upgrade pymatgen
# Or pin emmet-core to a version that matches pymatgen 2024.8.9:
pip3 install 'emmet-core<0.84'
```

The legacy `pymatgen.ext.matproj.MPRester` path **already works** without
this step, so step 3 is optional for a smoke test.

### 4. Re-run the three formulas

```bash
# MgB2 — replicated 2001 conventional SC, sanity row
MP_API_KEY_NEW="$MP_API_KEY_NEW" python3 \
  ~/core/hexa-lang/stdlib/material/mp_query.py \
  /Users/ghost/core/demiurge/exports/material_query/mgb2 \
  MgB2

# YBa2Cu3O7 — REBCO HTS, expected row_count > 0
MP_API_KEY_NEW="$MP_API_KEY_NEW" python3 \
  ~/core/hexa-lang/stdlib/material/mp_query.py \
  /Users/ghost/core/demiurge/exports/material_query/yba2cu3o7 \
  YBa2Cu3O7

# Pb10Cu(PO4)6O — LK-99-family; informative either way (likely zero hits
# since not real, OR a theoretical structure with no replicated Tc)
MP_API_KEY_NEW="$MP_API_KEY_NEW" python3 \
  ~/core/hexa-lang/stdlib/material/mp_query.py \
  /Users/ghost/core/demiurge/exports/material_query/lk99 \
  'Pb10Cu(PO4)6O'
```

### 5. Confirm `absorbed=false` + `gate_type="external-api"`

Each emitted `material_query_<stamp>.json` should have:

```json
"absorbed": false,
"gate_type": "external-api",
"backend": "MP_API_KEY_NEW (new API · api.materialsproject.org)",
"row_count": <N>
```

RTSC.md §8.8 stance — MP-derived rows never promote to absorbed=true (DFT
≠ measurement; PBE-GGA band gap underestimate 30-50%, formation energy
±0.1 eV/atom, no Debye temperature / e-ph coupling in MP).

## Honest stance

- Demiurge clean-room **cannot** embed an API key in code or commits. The
  adapter's `_resolve_api_key()` reads `os.environ` only — by design.
- Quota: `mp-api` free tier is generous, but this run is bounded to 3
  formulas per `g3` in the original ask.
- All three emitted records will carry `absorbed=false`,
  `gate_type="external-api"`, `provisional=true` (per mp_query.py L321-323).

## Cross-refs

- Adapter SSOT: `/Users/ghost/core/hexa-lang/stdlib/material/mp_query.py`
- RTSC anchor: `/Users/ghost/core/demiurge/RTSC.md` §8.2 (family matrix),
  §8.5 (handoff schema), §8.7 (Tier 1 sibling honest 한계), §8.8 (g3
  DFT ≠ measurement stance)
- Sibling adapter pattern: `~/core/hexa-lang/stdlib/material/sim_adapter.py`
- Export dest (when re-run): `/Users/ghost/core/demiurge/exports/material_query/<formula_slug>/`
