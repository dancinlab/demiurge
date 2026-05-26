// Regenerate ElevenLabs mp3s from src/content/narration.json into public/voice/.
//
// Reads `ELEVENLABS_API_KEY` from env (export it before running):
//   ELEVENLABS_API_KEY=$(secret get elevenlabs.api_key) npm run voice
//
// Output: public/voice/<shot.id>.mp3  (Remotion picks up via staticFile()).

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

type Shot = {
  id: string;
  narration: string;
  duration_sec: number;
};

type NarrationFile = {
  _meta: {
    voice_id: string;
    model_id: string;
    stability: number;
    similarity_boost: number;
    style: number;
    use_speaker_boost: boolean;
  };
  shots: Shot[];
};

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const ROOT = path.resolve(__dirname, "..");

async function main(): Promise<void> {
  const apiKey = process.env.ELEVENLABS_API_KEY;
  if (!apiKey) {
    console.error(
      "ELEVENLABS_API_KEY env var not set. Try:\n" +
        "  ELEVENLABS_API_KEY=$(secret get elevenlabs.api_key) npm run voice",
    );
    process.exit(1);
  }

  const narrationPath = path.join(ROOT, "src/content/narration.json");
  const raw = fs.readFileSync(narrationPath, "utf8");
  const data = JSON.parse(raw) as NarrationFile;
  const m = data._meta;

  const outDir = path.join(ROOT, "public/voice");
  fs.mkdirSync(outDir, { recursive: true });

  console.log(`generating ${data.shots.length} mp3s into ${outDir}`);
  for (const shot of data.shots) {
    if (!shot.narration) {
      console.log(`  ⏭ ${shot.id} (visual-only)`);
      continue;
    }
    const url = `https://api.elevenlabs.io/v1/text-to-speech/${m.voice_id}?output_format=mp3_44100_128`;
    const body = JSON.stringify({
      text: shot.narration,
      model_id: m.model_id,
      voice_settings: {
        stability: m.stability,
        similarity_boost: m.similarity_boost,
        style: m.style,
        use_speaker_boost: m.use_speaker_boost,
      },
    });
    const res = await fetch(url, {
      method: "POST",
      headers: {
        "xi-api-key": apiKey,
        "Content-Type": "application/json",
        Accept: "audio/mpeg",
      },
      body,
    });
    if (!res.ok) {
      const text = await res.text();
      console.error(`  ✖ ${shot.id} HTTP ${res.status}: ${text.slice(0, 200)}`);
      process.exit(2);
    }
    const buf = Buffer.from(await res.arrayBuffer());
    const outPath = path.join(outDir, `${shot.id}.mp3`);
    fs.writeFileSync(outPath, buf);
    console.log(`  ✓ ${shot.id.padEnd(20)}  ${buf.length} bytes`);
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(3);
});
