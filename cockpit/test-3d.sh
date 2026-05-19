#!/usr/bin/env bash
# test-3d.sh — build + launch the standalone ComponentView3D test
# window as a proper .app bundle.
#
# A raw `swift run` binary does not always surface its window through
# LaunchServices (no bundle → no reliable activation). So this builds
# CockpitApp, wraps it in a throwaway .app at /tmp with the κ-28
# `DEMIURGE_TEST_3D` env baked into Info.plist's LSEnvironment, and
# `open`s it — LaunchServices then shows + foregrounds the window.
#
# DEMIURGE_REPO is baked too so the bundled app still finds
# ../exports/** (RecordLoader.exportsRoot).
#
# Usage:  ./cockpit/test-3d.sh
set -euo pipefail
COCKPIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$COCKPIT_DIR/.." && pwd)"
cd "$COCKPIT_DIR"

echo "[test-3d] building CockpitApp…"
swift build --product CockpitApp
BIN=".build/debug/CockpitApp"
[ -x "$BIN" ] || { echo "[test-3d] ERROR: build produced no binary"; exit 1; }

APP="/tmp/demiurge-test-3d.app"
echo "[test-3d] assembling ${APP} bundle…"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"
cp "$BIN" "$APP/Contents/MacOS/demiurge-test-3d"
cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>               <string>Demiurge 3D Test</string>
  <key>CFBundleDisplayName</key>        <string>Demiurge 3D Test</string>
  <key>CFBundleExecutable</key>         <string>demiurge-test-3d</string>
  <key>CFBundleIdentifier</key>         <string>lab.dancin.demiurge.test3d</string>
  <key>CFBundlePackageType</key>        <string>APPL</string>
  <key>CFBundleShortVersionString</key> <string>0.0.2</string>
  <key>CFBundleVersion</key>            <string>0.0.2</string>
  <key>LSMinimumSystemVersion</key>     <string>13.0</string>
  <key>NSHighResolutionCapable</key>    <true/>
  <key>LSEnvironment</key>
  <dict>
    <key>DEMIURGE_TEST_3D</key><string>1</string>
    <key>DEMIURGE_REPO</key><string>${REPO_DIR}</string>
  </dict>
</dict>
</plist>
PLIST

echo "[test-3d] launching…"
open "$APP"
echo "[test-3d] ComponentView3D test window opened."
