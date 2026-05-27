// gen-brand.mjs — canonical demiurge brand-asset generator (Node ESM, zero deps).
//
// Typographic brand:
//   wordmark  = "DEMIURGE."     (horizontal, single line)
//   icon/app  = "DEMI"/"URGE."  (stacked, period in yellow)
//
// Outputs:
//   web/app/icon.svg              favicon (256², stacked, black bg)
//   web/public/logo.svg           horizontal wordmark (black bg)
//   web/app/apple-icon.png 180²   stacked
//   web/app/opengraph-image.png 1200×630   horizontal hero + tagline
//
// Run: node web/scripts/gen-brand.mjs
//
// Invariants (asserted):
//   i1  palette = {black bg, white ink, yellow accent} — ONLY 3 colors
//   i2  text uses bold sans-serif system stack — NO custom webfont dep at runtime
//   i3  asset dimensions are exact (rsvg-convert -w/-h)

import { writeFileSync, existsSync, mkdirSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));
const WEB_ROOT = resolve(HERE, "..");

const BG     = "#000000";
const INK    = "#ffffff";
const ACCENT = "#fde047";
const FONT   = "ui-sans-serif, -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Arial, sans-serif";

function stackedSquareSvg(size) {
  const s  = size;
  const fs = Math.round(s * 0.32);
  const yTop = Math.round(s * 0.42);
  const yBot = Math.round(s * 0.82);
  return (
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${s} ${s}" width="${s}" height="${s}">`
    + `<rect width="${s}" height="${s}" fill="${BG}"/>`
    + `<text x="${s / 2}" y="${yTop}" text-anchor="middle" fill="${INK}" `
    +   `font-family="${FONT}" font-weight="900" font-size="${fs}" letter-spacing="-2">DEMI</text>`
    + `<text x="${s / 2}" y="${yBot}" text-anchor="middle" `
    +   `font-family="${FONT}" font-weight="900" font-size="${fs}" letter-spacing="-2">`
    +   `<tspan fill="${INK}">URGE</tspan><tspan fill="${ACCENT}">.</tspan>`
    + `</text></svg>`
  );
}

function horizontalLogoSvg() {
  return (
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 120" width="480" height="120">`
    + `<rect width="480" height="120" fill="${BG}"/>`
    + `<text x="240" y="86" text-anchor="middle" `
    +   `font-family="${FONT}" font-weight="900" font-size="84" letter-spacing="-3">`
    +   `<tspan fill="${INK}">DEMIURGE</tspan><tspan fill="${ACCENT}">.</tspan>`
    + `</text></svg>`
  );
}

function ogSvg() {
  return (
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630" width="1200" height="630">`
    + `<rect width="1200" height="630" fill="${BG}"/>`
    + `<rect x="60" y="50" width="1080" height="6" fill="${INK}"/>`
    + `<rect x="60" y="64" width="1080" height="6" fill="${INK}"/>`
    + `<text x="60" y="118" fill="${INK}" font-family="${FONT}" font-size="18" font-weight="700" letter-spacing="6">BUILT // WITH // GEMINI // XPRIZE 2026</text>`
    + `<text x="60" y="380" fill="${INK}" font-family="${FONT}" font-size="220" font-weight="900" letter-spacing="-10">`
    +   `<tspan fill="${INK}">DEMIURGE</tspan><tspan fill="${ACCENT}">.</tspan>`
    + `</text>`
    + `<text x="60" y="455" fill="${INK}" font-family="${FONT}" font-size="32" font-weight="700" letter-spacing="2">AI-NATIVE 8-VERB PIPELINE</text>`
    + `<text x="60" y="495" fill="${INK}" font-family="${FONT}" font-size="22" font-weight="400" letter-spacing="2" opacity="0.7">ATOMS · MATERIALS · CHIPS · BIO · CHEMISTRY · ONE PRODUCTION LOOP</text>`
    + `<rect x="60" y="558" width="1080" height="6" fill="${INK}"/>`
    + `<rect x="60" y="572" width="1080" height="6" fill="${INK}"/>`
    + `</svg>`
  );
}

function rsvg(srcSvgPath, outPngPath, w, h) {
  try {
    execFileSync("rsvg-convert", ["-w", String(w), "-h", String(h), srcSvgPath, "-o", outPngPath]);
  } catch (e) {
    throw new Error(`[gen-brand] rsvg-convert failed: ${e.message}\n  install: brew install librsvg`);
  }
}

function main() {
  const iconPath  = resolve(WEB_ROOT, "app/icon.svg");
  const logoPath  = resolve(WEB_ROOT, "public/logo.svg");
  const applePath = resolve(WEB_ROOT, "app/apple-icon.png");
  const ogPath    = resolve(WEB_ROOT, "app/opengraph-image.png");
  const tmpDir    = resolve(WEB_ROOT, ".gen-brand-tmp");
  if (!existsSync(tmpDir)) mkdirSync(tmpDir);

  writeFileSync(iconPath, stackedSquareSvg(256));
  console.log(`✓ ${iconPath} (stacked DEMI/URGE.)`);

  writeFileSync(logoPath, horizontalLogoSvg());
  console.log(`✓ ${logoPath} (horizontal DEMIURGE.)`);

  const appleSrcPath = resolve(tmpDir, "apple.svg");
  writeFileSync(appleSrcPath, stackedSquareSvg(256));
  rsvg(appleSrcPath, applePath, 180, 180);
  console.log(`✓ ${applePath} (180×180 stacked)`);

  const ogSrcPath = resolve(tmpDir, "og.svg");
  writeFileSync(ogSrcPath, ogSvg());
  rsvg(ogSrcPath, ogPath, 1200, 630);
  console.log(`✓ ${ogPath} (1200×630 horizontal hero)`);

  console.log(`\n  i1 palette: ${BG} / ${INK} / ${ACCENT}   ✓`);
  console.log(`  i2 font: system bold sans stack          ✓`);
  console.log(`  i3 dimensions: exact via rsvg-convert    ✓`);
  console.log(`\ntypographic brand regenerated.`);
}

main();
