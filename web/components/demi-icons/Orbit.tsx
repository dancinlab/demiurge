"use client";

// 데미 아이콘 후보 A — 오비탈 닷 (Orbit)
// 중심 노란 닷 고정 + 둘레를 도는 작은 점 8개 (= 8-verb 은유).
// idle = 느린 공전(8s), thinking = 빠른 공전(2.4s) + 점 밝아짐.
//
// Hydration-safe: 서버 + 첫 클라 렌더는 동일한 정적 SVG 구조를 그린다 (분기 트리
// 없음 — 노드 갯수/위치 동일). 모션(회전·점멸)은 mount 이후에만 켠다. 프리뷰
// 평가용이라 reduce-motion 은 무시하고 항상 애니(useEffectiveReducedMotion 미사용).

import { useEffect, useState } from "react";
import { motion } from "motion/react";

const DOTS = 8;
const ORBIT_R = 8.5; // px in 0..24 viewBox space

export function Orbit({
  state = "idle",
  size = 24,
}: {
  state?: "idle" | "thinking";
  size?: number;
}) {
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const thinking = state === "thinking";
  const period = thinking ? 2.4 : 8; // s per revolution
  const satOpacity = thinking ? 0.95 : 0.55;
  const satR = thinking ? 1.15 : 0.95;

  // Fixed satellite positions (same on server + client → no hydration drift).
  const positions = Array.from({ length: DOTS }, (_, i) => {
    const a = (i / DOTS) * Math.PI * 2;
    return { x: 12 + ORBIT_R * Math.cos(a), y: 12 + ORBIT_R * Math.sin(a) };
  });

  return (
    <svg
      viewBox="0 0 24 24"
      width={size}
      height={size}
      fill="none"
      aria-hidden="true"
      style={{ display: "block" }}
    >
      {/* faint orbit guide ring */}
      <circle
        cx="12"
        cy="12"
        r={ORBIT_R}
        stroke="currentColor"
        strokeWidth={0.5}
        strokeOpacity={0.18}
      />

      {/* revolving satellite group — rotates as one rigid body */}
      <motion.g
        style={{ transformOrigin: "12px 12px" }}
        animate={mounted ? { rotate: 360 } : undefined}
        transition={
          mounted
            ? { duration: period, ease: "linear", repeat: Infinity }
            : undefined
        }
      >
        {positions.map((p, i) => (
          <circle
            key={i}
            cx={p.x}
            cy={p.y}
            r={satR}
            fill="currentColor"
            fillOpacity={satOpacity}
          />
        ))}
      </motion.g>

      {/* center brand dot (yellow) — gentle pulse only when thinking */}
      <motion.circle
        cx="12"
        cy="12"
        r="3"
        className="fill-yellow-300"
        style={{ transformOrigin: "12px 12px" }}
        animate={mounted && thinking ? { scale: [1, 1.18, 1] } : undefined}
        transition={
          mounted && thinking
            ? { duration: 1.1, ease: "easeInOut", repeat: Infinity }
            : undefined
        }
      />
    </svg>
  );
}
