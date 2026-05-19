#!/usr/bin/env bash
# test-3d-rtsc.sh — build + launch the standalone RtscView3D test
# window as a proper .app bundle.
#
# Sibling of test-3d.sh — same recipe, different env switch
# (DEMIURGE_TEST_3D_RTSC=1) so it lands on the HTS solenoid viewer
# instead of ComponentView3D.
#
# Usage:  ./cockpit/test-3d-rtsc.sh
set -euo pipefail
COCKPIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$COCKPIT_DIR/.." && pwd)"
cd "$COCKPIT_DIR"

echo "[test-3d-rtsc] building CockpitApp…"
xcrun --sdk macosx swift build --product CockpitApp
BIN=".build/debug/CockpitApp"
[ -x "$BIN" ] || { echo "[test-3d-rtsc] ERROR: build produced no binary"; exit 1; }

APP="/tmp/demiurge-test-3d-rtsc.app"
echo "[test-3d-rtsc] assembling ${APP} bundle…"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"
cp "$BIN" "$APP/Contents/MacOS/demiurge-test-3d-rtsc"
cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>               <string>Demiurge 3D RTSC</string>
  <key>CFBundleDisplayName</key>        <string>Demiurge 3D RTSC</string>
  <key>CFBundleExecutable</key>         <string>demiurge-test-3d-rtsc</string>
  <key>CFBundleIdentifier</key>         <string>lab.dancin.demiurge.test3d.rtsc</string>
  <key>CFBundlePackageType</key>        <string>APPL</string>
  <key>CFBundleShortVersionString</key> <string>0.0.1</string>
  <key>CFBundleVersion</key>            <string>0.0.1</string>
  <key>LSMinimumSystemVersion</key>     <string>14.0</string>
  <key>NSHighResolutionCapable</key>    <true/>
  <key>LSEnvironment</key>
  <dict>
    <key>DEMIURGE_TEST_3D_RTSC</key><string>1</string>
    <key>DEMIURGE_REPO</key><string>${REPO_DIR}</string>
  </dict>
</dict>
</plist>
PLIST

echo "[test-3d-rtsc] launching…"
open "$APP"
echo "[test-3d-rtsc] RtscView3D test window opened."
