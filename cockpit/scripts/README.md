# cockpit/scripts/ — INTENTIONALLY EMPTY (D61 / g_demiurge_pointer_only)

This directory is kept as a tombstone — **no producer scripts may live
here** per AGENTS.tape `g_demiurge_pointer_only` (design.md D61).

## Why empty

demiurge is a *pointer / spawn wrapper* for external-tool producers.
The script SSOT lives in `~/core/hexa-lang/stdlib/<domain>/`, NEVER in
`demiurge/`. demiurge's `*Producer.swift` files only `Process`-spawn
the hexa-lang-owned script; they hold no compute logic.

## Migration history (2026-05-20 — κ-45..κ-53 consolidation round)

The following scripts were born here in violation of D61 and have been
migrated to their hexa-lang stdlib home:

```
cockpit/scripts/bipv_freecad.py   → ~/core/hexa-lang/stdlib/freecad/bipv.py
cockpit/scripts/sscb_ngspice.py   → ~/core/hexa-lang/stdlib/sscb/ngspice.py
cockpit/scripts/energy_pvlib.py   → ~/core/hexa-lang/stdlib/energy/pvlib_clearsky.py
cockpit/scripts/bot_urdf.py       → ~/core/hexa-lang/stdlib/bot/urdfpy_basics.py (from worktree-a1f29b2)
cockpit/scripts/grid_networkx.py  → ~/core/hexa-lang/stdlib/grid/networkx_basics.py (from worktree-a43f562)
cockpit/scripts/space_skyfield.py → ~/core/hexa-lang/stdlib/space/skyfield_sgp4.py (from worktree-ad7eee3)
```

Each Producer's `locateScript()` was updated to resolve the absolute
path under `~/core/hexa-lang/stdlib/<domain>/`. Any new producer script
landing here is an automatic block per `g_demiurge_pointer_only`.

## Pattern for new producers

```swift
public static func locateScript() -> String? {
    let path = NSString(
        string: "~/core/hexa-lang/stdlib/<domain>/<tool>.py"
    ).expandingTildeInPath
    return FileManager.default.fileExists(atPath: path) ? path : nil
}
```

See `AntimatterAnalyzeProducer.swift` (κ-43) or
`ComponentVerifyProducer.swift` (κ-44) for the canonical D61-from-birth
pattern.
