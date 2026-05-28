"use client";

// 데미 아이콘 후보 B — 모핑 닷 (Morph) · 가장 미니멀
// 노란 닷 하나가 원 ↔ 다각형(◆/⬡) 으로 숨쉬듯 변형. SVG <path> d 모핑은 점 갯수가
// 일치해야 보간이 깔끔하므로, 세 형태(원·육각·다이아) 모두 6-앵커 경로로 통일했다.
// idle = 느린 변형(5.5s), thinking = 빠른 맥동(1.6s) + scale 펄스.
//
// Hydration-safe: 서버 + 첫 클라 렌더 = 동일한 정적 path(원). 모션은 mount 이후만.
// 프리뷰 평가용 → reduce-motion 무시, 항상 애니.

import { useEffect, useState } from "react";
import { motion } from "motion/react";

// All paths share 6 anchor points so morphing interpolates cleanly.
// cx,cy = 12,12. r tuned per shape so visual mass stays similar.
function hexPath(r: number, rot = 0): string {
  const pts = Array.from({ length: 6 }, (_, i) => {
    const a = rot + (i / 6) * Math.PI * 2;
    return [12 + r * Math.cos(a), 12 + r * Math.sin(a)] as const;
  });
  return (
    `M ${pts[0][0].toFixed(2)} ${pts[0][1].toFixed(2)} ` +
    pts
      .slice(1)
      .map((p) => `L ${p[0].toFixed(2)} ${p[1].toFixed(2)}`)
      .join(" ") +
    " Z"
  );
}

// A circle approximated with 6 cubic beziers would need C commands; to keep the
// same command-shape as the polygons (all "M L L L L L Z") we approximate the
// "circle" state as a near-regular 6-gon with a slightly larger radius — reads
// as a soft round dot at icon scale and morphs perfectly to the sharp hexagon.
const CIRCLE = hexPath(6.3, Math.PI / 6); // soft, flat-top → round-ish
const HEX = hexPath(6.6, 0); // pointy-side hexagon ⬡
const DIAMOND =
  // a 6-anchor diamond: top, upper-right, lower-right, bottom, lower-left, upper-left
  "M 12.00 5.20 L 16.80 9.40 L 16.80 14.60 L 12.00 18.80 L 7.20 14.60 L 7.20 9.40 Z";

export function Morph({
  state = "idle",
  size = 24,
}: {
  state?: "idle" | "thinking";
  size?: number;
}) {
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const thinking = state === "thinking";
  const dur = thinking ? 1.6 : 5.5;

  return (
    <svg
      viewBox="0 0 24 24"
      width={size}
      height={size}
      aria-hidden="true"
      style={{ display: "block" }}
    >
      <motion.path
        d={CIRCLE}
        className="fill-yellow-300"
        style={{ transformOrigin: "12px 12px" }}
        animate={
          mounted
            ? {
                d: [CIRCLE, HEX, DIAMOND, CIRCLE],
                scale: thinking ? [1, 1.12, 0.94, 1] : [1, 1.03, 0.99, 1],
                rotate: thinking ? [0, 8, -8, 0] : [0, 3, -3, 0],
              }
            : undefined
        }
        transition={
          mounted
            ? { duration: dur, ease: "easeInOut", repeat: Infinity }
            : undefined
        }
      />
      {/* tiny inner ink core for depth — static, hydration-identical */}
      <circle cx="12" cy="12" r="1.3" fill="currentColor" fillOpacity={0.22} />
    </svg>
  );
}
