"use client";

// 데미 아이콘 후보 C — 포지 스파크 (Forge)
// 입자(작은 선분 = 스파크)들이 중심 노란 닷으로 모였다 흩어진다 = 조물주가 재료를
// 벼리는 은유. idle = 은은한 명멸(스파크 opacity 호흡), thinking = 모임 ↔ 터짐 반복.
//
// Hydration-safe: 서버 + 첫 클라 렌더 = 동일한 정적 구조(스파크 6개 + 중심 닷).
// 모션(이동·명멸)은 mount 이후에만. 프리뷰 평가용 → reduce-motion 무시, 항상 애니.

import { useEffect, useState } from "react";
import { motion } from "motion/react";

const SPARKS = 6;
const FAR = 9.0; // dispersed radius
const NEAR = 4.2; // gathered radius

// Each spark is a short radial line segment; geometry fixed (server == client).
const angles = Array.from({ length: SPARKS }, (_, i) => (i / SPARKS) * Math.PI * 2);

export function Forge({
  state = "idle",
  size = 24,
}: {
  state?: "idle" | "thinking";
  size?: number;
}) {
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const thinking = state === "thinking";
  const dur = thinking ? 1.8 : 4.2;

  return (
    <svg
      viewBox="0 0 24 24"
      width={size}
      height={size}
      fill="none"
      aria-hidden="true"
      style={{ display: "block" }}
    >
      {angles.map((a, i) => {
        const ux = Math.cos(a);
        const uy = Math.sin(a);
        // dispersed endpoints (outer..outer+len)
        const len = 3.4;
        const farInner = { x: 12 + ux * NEAR, y: 12 + uy * NEAR };
        const farOuter = { x: 12 + ux * FAR, y: 12 + uy * FAR };
        const nearInner = { x: 12 + ux * (NEAR - 1.0), y: 12 + uy * (NEAR - 1.0) };
        const nearOuter = { x: 12 + ux * (NEAR + len - 1.0), y: 12 + uy * (NEAR + len - 1.0) };

        return (
          <motion.line
            key={i}
            // base render = dispersed (static, hydration-identical)
            x1={farInner.x}
            y1={farInner.y}
            x2={farOuter.x}
            y2={farOuter.y}
            stroke="currentColor"
            strokeWidth={1.1}
            strokeLinecap="round"
            animate={
              mounted
                ? thinking
                  ? {
                      // gather → burst loop
                      x1: [farInner.x, nearInner.x, farInner.x],
                      y1: [farInner.y, nearInner.y, farInner.y],
                      x2: [farOuter.x, nearOuter.x, farOuter.x],
                      y2: [farOuter.y, nearOuter.y, farOuter.y],
                      opacity: [0.7, 1, 0.7],
                    }
                  : {
                      // gentle twinkle in place (staggered)
                      opacity: [0.3, 0.85, 0.3],
                    }
                : undefined
            }
            transition={
              mounted
                ? {
                    duration: dur,
                    ease: "easeInOut",
                    repeat: Infinity,
                    delay: (i / SPARKS) * (thinking ? 0.25 : dur * 0.5),
                  }
                : undefined
            }
          />
        );
      })}

      {/* center brand dot (yellow) — flares on each gather when thinking */}
      <motion.circle
        cx="12"
        cy="12"
        r="2.6"
        className="fill-yellow-300"
        style={{ transformOrigin: "12px 12px" }}
        animate={
          mounted
            ? thinking
              ? { scale: [1, 1.3, 1], opacity: [0.85, 1, 0.85] }
              : { opacity: [0.8, 1, 0.8] }
            : undefined
        }
        transition={
          mounted
            ? { duration: dur, ease: "easeInOut", repeat: Infinity }
            : undefined
        }
      />
    </svg>
  );
}
