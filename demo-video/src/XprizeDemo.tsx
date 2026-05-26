// Main composition — visual-first design.
// Each shot is an animated scene driven by Remotion springs/interpolate.
// English narration appears as a slim bottom caption strip.

import {
  AbsoluteFill,
  Audio,
  Sequence,
  spring,
  interpolate,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import narration from "./content/narration.json";

type Shot = {
  id: string;
  duration_sec: number;
  narration: string;
  subtitle_ko: string;
  capture: string;
};

const palette = {
  bg0: "#05050a",
  bg1: "#0d0a1e",
  fg: "#fafafa",
  muted: "#94a3b8",
  accent: "#a855f7",
  accent2: "#22d3ee",
  hot: "#facc15",
  good: "#10b981",
  bad: "#ef4444",
};

const useSpringIn = (delay = 0): number => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  return spring({
    frame: frame - delay,
    fps,
    config: { damping: 200, stiffness: 120, mass: 0.7 },
  });
};

const Caption: React.FC<{ text: string }> = ({ text }) => {
  const o = useSpringIn(2);
  return (
    <div
      style={{
        position: "absolute",
        bottom: 50,
        left: 100,
        right: 100,
        textAlign: "center",
        fontSize: 38,
        lineHeight: 1.35,
        fontWeight: 500,
        color: palette.fg,
        textShadow: "0 2px 12px rgba(0,0,0,0.7)",
        opacity: o,
        transform: `translateY(${(1 - o) * 14}px)`,
        fontFamily: 'Inter, system-ui, -apple-system, sans-serif',
      }}
    >
      {text}
    </div>
  );
};

const ProgressBar: React.FC<{ index: number; total: number }> = ({
  index,
  total,
}) => {
  const pct = ((index + 1) * 100) / total;
  return (
    <div
      style={{
        position: "absolute",
        top: 0,
        left: 0,
        right: 0,
        height: 4,
        background: `linear-gradient(to right, ${palette.accent} 0%, ${palette.accent} ${pct}%, #ffffff15 ${pct}%, #ffffff15 100%)`,
      }}
    />
  );
};

const ShotLabel: React.FC<{ id: string; index: number; total: number }> = ({
  id,
  index,
  total,
}) => (
  <div
    style={{
      position: "absolute",
      top: 40,
      right: 60,
      fontSize: 18,
      letterSpacing: 4,
      color: palette.muted,
      fontFamily: "ui-monospace, monospace",
    }}
  >
    {String(index + 1).padStart(2, "0")} · {id.replace(/^\d+_/, "")} ·{" "}
    <span style={{ color: palette.accent }}>{total}</span>
  </div>
);

// Shot 01 — Hook
const Hook01: React.FC = () => {
  const frame = useCurrentFrame();
  const title = "demiurge";
  const reveal = Math.floor(
    interpolate(frame, [0, 30], [0, title.length], { extrapolateRight: "clamp" }),
  );
  const locales = ["EN", "中文", "Русский", "日本語", "한국어"];
  return (
    <AbsoluteFill style={{ background: `radial-gradient(circle at 50% 45%, ${palette.bg1}, ${palette.bg0})` }}>
      <div
        style={{
          position: "absolute",
          top: "38%",
          left: 0,
          right: 0,
          textAlign: "center",
          fontSize: 200,
          fontWeight: 900,
          color: palette.fg,
          letterSpacing: -6,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        {title.slice(0, reveal)}
        <span style={{ color: palette.accent, opacity: frame % 30 < 15 ? 1 : 0 }}>|</span>
      </div>
      {locales.map((loc, i) => {
        const angle = (i / locales.length) * 2 * Math.PI + frame / 90;
        const r = 380;
        const x = Math.cos(angle) * r;
        const y = Math.sin(angle) * r * 0.45;
        const o = interpolate(frame, [40 + i * 6, 70 + i * 6], [0, 1], { extrapolateRight: "clamp" });
        return (
          <div
            key={loc}
            style={{
              position: "absolute",
              top: "60%",
              left: "50%",
              transform: `translate(calc(-50% + ${x}px), calc(-50% + ${y}px))`,
              fontSize: 36,
              color: palette.accent2,
              opacity: o,
              fontFamily: 'Inter, system-ui, sans-serif',
              fontWeight: 600,
            }}
          >
            {loc}
          </div>
        );
      })}
    </AbsoluteFill>
  );
};

const Domains02: React.FC = () => {
  const frame = useCurrentFrame();
  // SSOT: /DOMAINS.md (5축 × 4) — generic research domains, no third-party brands
  // atom · matter · chip · bio · chem
  const tiles = [
    "RTSC", "FUSION", "ANTIMATTER", "QUBIT",
    "PEROVSKITE", "GRAPHENE", "METAMATERIAL", "AEROGEL",
    "NEUROMORPHIC", "PHOTONIC", "MEMRISTOR", "SPINTRONIC",
    "GENE-EDIT", "RNA-THERAPY", "ORGANOID", "PROTEIN-FOLD",
    "ELECTROCAT", "PHOTOREDOX", "CO2-CAPTURE", "GREEN-NH3",
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      <div
        style={{
          position: "absolute",
          top: 40,
          left: 0,
          right: 0,
          textAlign: "center",
          fontSize: 32,
          color: palette.muted,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        20 research domains · one canonical engine
      </div>
      <div
        style={{
          position: "absolute",
          top: 110,
          left: 200,
          right: 200,
          display: "grid",
          gridTemplateColumns: "repeat(5, 1fr)",
          gap: 24,
        }}
      >
        {tiles.map((name, i) => {
          const delay = i * 1.5;
          const o = interpolate(frame, [delay, delay + 10], [0, 1], { extrapolateRight: "clamp" });
          const ty = interpolate(frame, [delay, delay + 10], [30, 0], { extrapolateRight: "clamp" });
          return (
            <div
              key={name}
              style={{
                height: 110,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                background: `linear-gradient(135deg, ${palette.accent}33, ${palette.accent2}33)`,
                border: `1px solid ${palette.accent}66`,
                borderRadius: 12,
                opacity: o,
                transform: `translateY(${ty}px)`,
                fontFamily: 'ui-monospace, "SF Mono", Menlo, monospace',
                fontSize: name.length > 9 ? 18 : 22,
                fontWeight: 700,
                color: palette.fg,
                letterSpacing: 1,
              }}
            >
              {name}
            </div>
          );
        })}
      </div>
    </AbsoluteFill>
  );
};

const Discover03: React.FC = () => {
  const frame = useCurrentFrame();
  const segments = 36;
  const rot = (frame * 4) % 360;
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      <div
        style={{
          position: "absolute",
          top: "50%",
          left: "50%",
          width: 560,
          height: 560,
          transform: `translate(-50%, -50%) rotate(${rot}deg)`,
        }}
      >
        {Array.from({ length: segments }).map((_, i) => {
          const a = (i / segments) * 2 * Math.PI;
          const r = 240;
          const x = Math.cos(a) * r;
          const y = Math.sin(a) * r;
          const size = 14 + Math.sin(frame / 8 + i) * 6;
          const c = i < segments / 2 ? palette.accent : palette.accent2;
          return (
            <div
              key={i}
              style={{
                position: "absolute",
                top: "50%",
                left: "50%",
                width: size,
                height: size,
                marginLeft: -size / 2,
                marginTop: -size / 2,
                transform: `translate(${x}px, ${y}px)`,
                background: c,
                borderRadius: "50%",
                boxShadow: `0 0 14px ${c}`,
              }}
            />
          );
        })}
        <div
          style={{
            position: "absolute",
            top: "50%",
            left: "50%",
            transform: `translate(-50%, -50%) rotate(${-rot}deg)`,
            fontSize: 28,
            color: palette.fg,
            fontWeight: 700,
            textAlign: "center",
            fontFamily: 'Inter, system-ui, sans-serif',
          }}
        >
          OUROBOROS
          <div style={{ fontSize: 14, color: palette.muted, marginTop: 6, letterSpacing: 3 }}>
            objective ↻ verifier
          </div>
        </div>
      </div>
    </AbsoluteFill>
  );
};

const Spec04: React.FC = () => {
  const frame = useCurrentFrame();
  const goal = "@goal: ship a verified RTSC candidate at 300 K ambient by D-83";
  const reveal = Math.floor(
    interpolate(frame, [20, 200], [0, goal.length], { extrapolateRight: "clamp" }),
  );
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      <div
        style={{
          position: "absolute",
          top: 80,
          left: 100,
          fontSize: 28,
          color: palette.muted,
          letterSpacing: 4,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        SPEC · Gemini draft
      </div>
      <div
        style={{
          position: "absolute",
          top: 240,
          left: 100,
          right: 100,
          fontSize: 56,
          color: palette.fg,
          fontFamily: 'ui-monospace, "SF Mono", Menlo, monospace',
          lineHeight: 1.4,
        }}
      >
        <span style={{ color: palette.accent }}>{goal.slice(0, reveal)}</span>
        <span style={{ color: palette.accent, opacity: frame % 30 < 15 ? 1 : 0 }}>▌</span>
      </div>
    </AbsoluteFill>
  );
};

const Structure05: React.FC = () => {
  const frame = useCurrentFrame();
  const nodes = [
    { x: 50, y: 20, label: "RTSC", depth: 0 },
    { x: 25, y: 50, label: "lattice", depth: 1 },
    { x: 50, y: 50, label: "DFT", depth: 1 },
    { x: 75, y: 50, label: "phonons", depth: 1 },
    { x: 15, y: 80, label: "MP", depth: 2 },
    { x: 35, y: 80, label: "AFLOW", depth: 2 },
    { x: 65, y: 80, label: "QE", depth: 2 },
    { x: 85, y: 80, label: "BETE-NET", depth: 2 },
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      {nodes.map((n, i) => {
        const o = interpolate(frame, [i * 8, i * 8 + 12], [0, 1], { extrapolateRight: "clamp" });
        return (
          <div
            key={n.label}
            style={{
              position: "absolute",
              top: `${n.y}%`,
              left: `${n.x}%`,
              transform: "translate(-50%, -50%)",
              padding: "12px 20px",
              border: `2px solid ${n.depth === 0 ? palette.accent : palette.accent2}`,
              background: `${n.depth === 0 ? palette.accent : palette.accent2}22`,
              borderRadius: 8,
              fontSize: 24,
              color: palette.fg,
              opacity: o,
              fontFamily: 'Inter, system-ui, sans-serif',
            }}
          >
            {n.label}
          </div>
        );
      })}
    </AbsoluteFill>
  );
};

const Design06: React.FC = () => {
  const frame = useCurrentFrame();
  const opts = [
    { name: "PBE", core: "fast · GGA", risk: "underestimates gap" },
    { name: "HSE06", core: "hybrid · accurate", risk: "10× slower" },
    { name: "GW", core: "many-body · best", risk: "100× slower" },
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0, display: "flex", flexDirection: "row", alignItems: "center", justifyContent: "center", gap: 36 }}>
      {opts.map((o, i) => {
        const sp = interpolate(frame, [i * 8, i * 8 + 20], [0, 1], { extrapolateRight: "clamp" });
        return (
          <div
            key={o.name}
            style={{
              width: 340,
              padding: 36,
              background: `${palette.accent}11`,
              border: `2px solid ${palette.accent}55`,
              borderRadius: 16,
              opacity: sp,
              transform: `translateY(${(1 - sp) * 40}px)`,
              fontFamily: 'Inter, system-ui, sans-serif',
            }}
          >
            <div style={{ fontSize: 42, fontWeight: 800, color: palette.fg }}>{o.name}</div>
            <div style={{ fontSize: 22, color: palette.muted, marginTop: 14 }}>{o.core}</div>
            <div style={{ fontSize: 18, color: palette.hot, marginTop: 24 }}>⚠ {o.risk}</div>
          </div>
        );
      })}
    </AbsoluteFill>
  );
};

const Analyze07: React.FC = () => {
  const frame = useCurrentFrame();
  const lines = [
    "round 1/5  · seed=ysbh6  · novelty=0.71",
    "round 2/5  · seed=labeh8 · novelty=0.54",
    "round 3/5  · seed=h3as   · novelty=0.38",
    "round 4/5  · seed=mghn7  · novelty=0.22",
    "round 5/5  · saturation reached ✓",
  ];
  const shown = Math.floor(
    interpolate(frame, [0, 130], [0, lines.length], { extrapolateRight: "clamp" }),
  );
  return (
    <AbsoluteFill style={{ background: palette.bg0, padding: 100 }}>
      <div style={{ fontFamily: 'ui-monospace, "SF Mono", Menlo, monospace', fontSize: 32, color: palette.good }}>
        $ demiurge cli action analyze RTSC
      </div>
      {lines.slice(0, shown).map((l, i) => (
        <div
          key={i}
          style={{
            fontFamily: 'ui-monospace, monospace',
            fontSize: 28,
            color: i === shown - 1 ? palette.accent2 : palette.muted,
            marginTop: 12,
          }}
        >
          {l}
        </div>
      ))}
    </AbsoluteFill>
  );
};

const Verify08: React.FC = () => {
  const frame = useCurrentFrame();
  const tiers = [
    { emoji: "🔵", name: "FORMAL",      c: "#3b82f6" },
    { emoji: "🟢", name: "NUMERICAL",   c: "#10b981" },
    { emoji: "🟡", name: "CITATION",    c: "#eab308" },
    { emoji: "🟠", name: "INSUFFICIENT",c: "#f97316" },
    { emoji: "🔴", name: "FALSIFIED",   c: "#ef4444" },
  ];
  const badge = interpolate(frame, [200, 240], [0, 1], { extrapolateRight: "clamp" });
  return (
    <AbsoluteFill style={{ background: palette.bg0, padding: "120px 80px" }}>
      <div
        style={{
          textAlign: "center",
          fontSize: 32,
          color: palette.muted,
          letterSpacing: 4,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        VERIFY · hexa calculator · 5 tiers
      </div>
      {/* horizontal 5-tier bar */}
      <div
        style={{
          marginTop: 120,
          display: "flex",
          flexDirection: "row",
          justifyContent: "center",
          alignItems: "flex-end",
          gap: 28,
        }}
      >
        {tiers.map((t, i) => {
          const o = interpolate(frame, [i * 14, i * 14 + 18], [0, 1], { extrapolateRight: "clamp" });
          const ty = interpolate(frame, [i * 14, i * 14 + 18], [60, 0], { extrapolateRight: "clamp" });
          return (
            <div
              key={t.name}
              style={{
                width: 280,
                opacity: o,
                transform: `translateY(${ty}px)`,
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
              }}
            >
              <div
                style={{
                  width: 200,
                  height: 200,
                  background: t.c,
                  borderRadius: 24,
                  boxShadow: `0 0 60px ${t.c}aa`,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 100,
                }}
              >
                {t.emoji}
              </div>
              <div
                style={{
                  marginTop: 28,
                  fontSize: 28,
                  color: palette.fg,
                  fontFamily: 'ui-monospace, monospace',
                  letterSpacing: 2,
                  textAlign: "center",
                  fontWeight: 700,
                }}
              >
                {t.name}
              </div>
            </div>
          );
        })}
      </div>
      <div
        style={{
          position: "absolute",
          left: 0,
          right: 0,
          bottom: 200,
          textAlign: "center",
        }}
      >
        <span
          style={{
            display: "inline-block",
            padding: "26px 72px",
            background: palette.bad,
            color: palette.fg,
            fontSize: 72,
            fontWeight: 900,
            borderRadius: 28,
            transform: `scale(${badge}) rotate(-3deg)`,
            opacity: badge,
            boxShadow: "0 20px 60px rgba(239,68,68,0.55)",
            fontFamily: 'Inter, system-ui, sans-serif',
            letterSpacing: 1,
          }}
        >
          0 LLM verdicts
        </span>
      </div>
    </AbsoluteFill>
  );
};

const Synth09: React.FC = () => {
  const frame = useCurrentFrame();
  // GCP-only targets — pool / Vast.ai 등 외부 인프라 demo 외로 제거
  const targets = [
    "Cloud Run",
    "Vertex AI Training",
    "Compute Engine GPU",
    "Cloud Build",
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0, padding: "100px 80px" }}>
      <div
        style={{
          textAlign: "center",
          fontSize: 32,
          color: palette.muted,
          letterSpacing: 4,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        SYNTH · Google Cloud dispatch
      </div>
      {/* source box + horizontal arrows + 4 GCP targets in a row */}
      <div
        style={{
          marginTop: 200,
          display: "flex",
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "center",
          gap: 24,
        }}
      >
        <div
          style={{
            padding: "30px 40px",
            border: `3px solid ${palette.accent}`,
            background: `${palette.accent}15`,
            borderRadius: 16,
            fontSize: 32,
            fontWeight: 800,
            color: palette.fg,
            fontFamily: 'Inter, system-ui, sans-serif',
            whiteSpace: "nowrap",
          }}
        >
          demiurge cli
        </div>
        <div style={{ fontSize: 64, color: palette.accent2 }}>→</div>
        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(2, 1fr)",
            gap: 16,
          }}
        >
          {targets.map((t, i) => {
            const o = interpolate(frame, [i * 12, i * 12 + 18], [0, 1], { extrapolateRight: "clamp" });
            const tx = interpolate(frame, [i * 12, i * 12 + 18], [40, 0], { extrapolateRight: "clamp" });
            return (
              <div
                key={t}
                style={{
                  opacity: o,
                  transform: `translateX(${tx}px)`,
                  padding: "22px 32px",
                  background: `linear-gradient(135deg, #4285F488, #34A85388)`,
                  borderRadius: 14,
                  fontSize: 26,
                  fontWeight: 600,
                  color: palette.fg,
                  fontFamily: 'Inter, system-ui, sans-serif',
                  whiteSpace: "nowrap",
                }}
              >
                {t}
              </div>
            );
          })}
        </div>
      </div>
      <div
        style={{
          position: "absolute",
          left: 0,
          right: 0,
          bottom: 220,
          textAlign: "center",
          fontSize: 28,
          color: palette.hot,
          fontFamily: 'ui-monospace, monospace',
        }}
      >
        deterministic routing · zero LLM in the dispatch path
      </div>
    </AbsoluteFill>
  );
};

const Handoff10: React.FC = () => {
  const frame = useCurrentFrame();
  const ko = "다음 단계 receiver: 첫 액션 = atlas register --from-verify";
  const en = "Next-stage receiver: first action = atlas register --from-verify";
  const koReveal = Math.floor(interpolate(frame, [10, 100], [0, ko.length], { extrapolateRight: "clamp" }));
  const enReveal = Math.floor(interpolate(frame, [110, 200], [0, en.length], { extrapolateRight: "clamp" }));
  return (
    <AbsoluteFill style={{ background: palette.bg0, display: "flex", flexDirection: "row" }}>
      <div style={{ flex: 1, padding: 80, borderRight: `1px solid ${palette.muted}33` }}>
        <div style={{ fontSize: 28, color: palette.accent, letterSpacing: 4, fontFamily: 'Inter, system-ui, sans-serif' }}>한국어</div>
        <div style={{ marginTop: 40, fontSize: 32, color: palette.fg, fontFamily: 'ui-monospace, monospace', lineHeight: 1.5 }}>
          {ko.slice(0, koReveal)}
        </div>
      </div>
      <div style={{ flex: 1, padding: 80 }}>
        <div style={{ fontSize: 28, color: palette.accent2, letterSpacing: 4, fontFamily: 'Inter, system-ui, sans-serif' }}>English</div>
        <div style={{ marginTop: 40, fontSize: 32, color: palette.fg, fontFamily: 'ui-monospace, monospace', lineHeight: 1.5 }}>
          {en.slice(0, enReveal)}
        </div>
      </div>
    </AbsoluteFill>
  );
};

const Pricing11: React.FC = () => {
  const frame = useCurrentFrame();
  const tiers = [
    { name: "Solo", price: 29, color: palette.good },
    { name: "Team", price: 99, color: palette.accent2 },
    { name: "Org", price: 299, color: palette.accent },
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0, display: "flex", flexDirection: "row", alignItems: "center", justifyContent: "center", gap: 40 }}>
      {tiers.map((t, i) => {
        const o = interpolate(frame, [i * 12, i * 12 + 20], [0, 1], { extrapolateRight: "clamp" });
        return (
          <div
            key={t.name}
            style={{
              width: 360,
              padding: 50,
              background: `${t.color}11`,
              border: `3px solid ${t.color}`,
              borderRadius: 20,
              opacity: o,
              transform: `translateY(${(1 - o) * 40}px)`,
              fontFamily: 'Inter, system-ui, sans-serif',
            }}
          >
            <div style={{ fontSize: 36, color: palette.muted }}>{t.name}</div>
            <div style={{ fontSize: 100, fontWeight: 900, color: palette.fg, marginTop: 10 }}>
              ${t.price}
              <span style={{ fontSize: 28, color: palette.muted, fontWeight: 400 }}>/mo</span>
            </div>
            <div style={{ fontSize: 22, color: palette.hot, marginTop: 30 }}>14-day free trial</div>
          </div>
        );
      })}
    </AbsoluteFill>
  );
};

const Gcp12: React.FC = () => {
  const frame = useCurrentFrame();
  const products = [
    "Vertex AI",
    "Cloud Run",
    "Cloud Build",
    "Artifact Registry",
    "Firestore",
    "Identity Toolkit",
    "Secret Manager",
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      <div
        style={{
          position: "absolute",
          top: 80,
          left: 0,
          right: 0,
          textAlign: "center",
          fontSize: 32,
          color: palette.muted,
          letterSpacing: 4,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        Google Cloud · seven products
      </div>
      <div
        style={{
          position: "absolute",
          top: 200,
          left: 0,
          right: 0,
          display: "grid",
          gridTemplateColumns: "repeat(4, 1fr)",
          gap: 24,
          padding: "0 140px",
        }}
      >
        {products.map((p, i) => {
          const o = interpolate(frame, [i * 14, i * 14 + 22], [0, 1], { extrapolateRight: "clamp" });
          const ty = interpolate(frame, [i * 14, i * 14 + 22], [40, 0], { extrapolateRight: "clamp" });
          return (
            <div
              key={p}
              style={{
                padding: "30px 24px",
                background: `linear-gradient(135deg, #4285F488, #34A85388)`,
                borderRadius: 14,
                textAlign: "center",
                fontSize: 26,
                color: palette.fg,
                opacity: o,
                transform: `translateY(${ty}px)`,
                fontFamily: 'Inter, system-ui, sans-serif',
                fontWeight: 600,
              }}
            >
              {p}
            </div>
          );
        })}
      </div>
      <div
        style={{
          position: "absolute",
          bottom: 220,
          left: 0,
          right: 0,
          textAlign: "center",
          fontSize: 36,
          color: palette.hot,
          fontFamily: 'ui-monospace, monospace',
        }}
      >
        zero secrets in code · metadata-server ADC
      </div>
    </AbsoluteFill>
  );
};

const NewProject13: React.FC = () => {
  const frame = useCurrentFrame();
  const o = useSpringIn(5);
  return (
    <AbsoluteFill
      style={{
        background: palette.bg0,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        fontFamily: 'Inter, system-ui, sans-serif',
      }}
    >
      <div style={{ fontSize: 32, color: palette.muted, letterSpacing: 6 }}>GCP PROJECT</div>
      <div style={{ fontSize: 140, fontWeight: 900, color: palette.fg, marginTop: 20 }}>dancinlab</div>
      <div
        style={{
          marginTop: 40,
          fontSize: 36,
          fontFamily: 'ui-monospace, monospace',
          color: palette.accent2,
          opacity: o,
          transform: `scale(${0.5 + o * 0.5})`,
        }}
      >
        created 2026-05-26T15:31Z
      </div>
      <div
        style={{
          marginTop: 30,
          fontSize: 26,
          color: palette.good,
          opacity: interpolate(frame, [30, 60], [0, 1], { extrapolateRight: "clamp" }),
        }}
      >
        ≥ 2026-05-19 submission start · RULE MET ✓
      </div>
    </AbsoluteFill>
  );
};

const LiveApi14: React.FC = () => {
  const frame = useCurrentFrame();
  const json = `{
  "text": "@goal: ...",
  "model": "gemini-2.5-flash",
  "usage": {
    "promptTokens": 200,
    "candidateTokens": 23,
    "totalTokens": 796
  }
}`;
  const reveal = Math.floor(interpolate(frame, [10, 220], [0, json.length], { extrapolateRight: "clamp" }));
  return (
    <AbsoluteFill style={{ background: palette.bg0, padding: 80 }}>
      <div style={{ fontSize: 28, color: palette.good, fontFamily: 'ui-monospace, monospace' }}>
        $ curl https://demiurge.dancinlab.org/api/llm
      </div>
      <div style={{ fontSize: 18, color: palette.muted, marginTop: 6, fontFamily: 'ui-monospace, monospace' }}>
        HTTP/2 200 · server: Google Frontend
      </div>
      <pre
        style={{
          marginTop: 40,
          fontSize: 34,
          color: palette.accent2,
          fontFamily: 'ui-monospace, "SF Mono", Menlo, monospace',
          whiteSpace: "pre-wrap",
        }}
      >
        {json.slice(0, reveal)}
        <span style={{ color: palette.accent, opacity: frame % 30 < 15 ? 1 : 0 }}>▌</span>
      </pre>
    </AbsoluteFill>
  );
};

const Close15: React.FC = () => {
  const o = useSpringIn(2);
  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 50%, ${palette.bg1}, ${palette.bg0})`,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        fontFamily: 'Inter, system-ui, sans-serif',
      }}
    >
      <div
        style={{
          fontSize: 96,
          fontWeight: 900,
          color: palette.fg,
          opacity: o,
          transform: `translateY(${(1 - o) * 30}px)`,
        }}
      >
        demiurge
        <span style={{ color: palette.accent }}>.dancinlab.org</span>
      </div>
      <div
        style={{
          marginTop: 36,
          padding: "18px 36px",
          fontSize: 32,
          color: palette.fg,
          background: `linear-gradient(135deg, ${palette.accent}, ${palette.accent2})`,
          borderRadius: 50,
          opacity: o,
        }}
      >
        Built with Gemini
      </div>
    </AbsoluteFill>
  );
};

const Outro16: React.FC = () => {
  const frame = useCurrentFrame();
  const evidence = [
    "Gemini API · live call",
    "7 Google Cloud products",
    "new project · post 2026-05-19",
    "custom domain · Google SSL",
    "5 locales · zero global friction",
    "verify sacred · 0 LLM verdicts",
  ];
  return (
    <AbsoluteFill style={{ background: palette.bg0, padding: 80 }}>
      <div
        style={{
          fontSize: 38,
          color: palette.muted,
          letterSpacing: 4,
          textAlign: "center",
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        XPRIZE evidence
      </div>
      {/* 2-column × 3-row horizontal grid */}
      <div
        style={{
          marginTop: 80,
          display: "grid",
          gridTemplateColumns: "repeat(2, 1fr)",
          gap: 24,
          padding: "0 140px",
        }}
      >
        {evidence.map((e, i) => {
          const o = interpolate(frame, [i * 12, i * 12 + 20], [0, 1], { extrapolateRight: "clamp" });
          const ty = interpolate(frame, [i * 12, i * 12 + 20], [30, 0], { extrapolateRight: "clamp" });
          return (
            <div
              key={e}
              style={{
                padding: "26px 36px",
                background: `${palette.good}15`,
                border: `2px solid ${palette.good}66`,
                borderRadius: 14,
                fontSize: 28,
                color: palette.fg,
                fontFamily: 'ui-monospace, monospace',
                opacity: o,
                transform: `translateY(${ty}px)`,
                display: "flex",
                alignItems: "center",
                gap: 18,
              }}
            >
              <span style={{ color: palette.good, fontSize: 36 }}>✓</span>
              <span>{e}</span>
            </div>
          );
        })}
      </div>
      <div
        style={{
          position: "absolute",
          bottom: 100,
          left: 0,
          right: 0,
          textAlign: "center",
          fontSize: 56,
          fontWeight: 900,
          color: palette.fg,
          fontFamily: 'Inter, system-ui, sans-serif',
        }}
      >
        <span style={{ color: palette.accent }}>demiurge.dancinlab.org</span>
      </div>
    </AbsoluteFill>
  );
};

const ShotRenderer: React.FC<{ shot: Shot }> = ({ shot }) => {
  switch (shot.id) {
    case "01_hook":
      return <Hook01 />;
    case "02_domains":
      return <Domains02 />;
    case "03_discover":
      return <Discover03 />;
    case "04_spec":
      return <Spec04 />;
    case "05_structure":
      return <Structure05 />;
    case "06_design":
      return <Design06 />;
    case "07_analyze":
      return <Analyze07 />;
    case "08_verify":
      return <Verify08 />;
    case "09_synth":
      return <Synth09 />;
    case "10_handoff":
      return <Handoff10 />;
    case "11_pricing":
      return <Pricing11 />;
    case "12_gcp":
      return <Gcp12 />;
    case "13_newproject":
      return <NewProject13 />;
    case "14_liveapi":
      return <LiveApi14 />;
    case "15_close":
      return <Close15 />;
    case "16_outro_montage":
      return <Outro16 />;
    default:
      return null;
  }
};

export const XprizeDemo: React.FC = () => {
  const { fps } = useVideoConfig();
  const shots = narration.shots as Shot[];

  let cursor = 0;
  return (
    <AbsoluteFill style={{ background: palette.bg0 }}>
      {shots.map((shot, i) => {
        const durationInFrames = Math.max(1, Math.round(shot.duration_sec * fps));
        const from = cursor;
        cursor += durationInFrames;
        return (
          <Sequence key={shot.id} from={from} durationInFrames={durationInFrames} name={shot.id}>
            <ShotRenderer shot={shot} />
            <ProgressBar index={i} total={shots.length} />
            <ShotLabel id={shot.id} index={i} total={shots.length} />
            {shot.narration && <Caption text={shot.narration} />}
            {shot.narration && (
              <Audio src={staticFile(`voice/${shot.id}.mp3`)} volume={1.0} />
            )}
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};
