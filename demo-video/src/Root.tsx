import { Composition } from "remotion";
import narration from "./content/narration.json";
import { XprizeDemo } from "./XprizeDemo";

const FPS = narration._meta.fps;
const [W, H] = narration._meta.resolution as [number, number];

// Total duration = sum of all shot durations (in frames).
const TOTAL_FRAMES = Math.ceil(
  narration.shots.reduce((sum, s) => sum + s.duration_sec, 0) * FPS,
);

export const Root: React.FC = () => {
  return (
    <Composition
      id="XprizeDemo"
      component={XprizeDemo}
      durationInFrames={TOTAL_FRAMES}
      fps={FPS}
      width={W}
      height={H}
    />
  );
};
