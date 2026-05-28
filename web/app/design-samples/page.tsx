// /design-samples — DEV-ONLY 섹션 구분 스타일 8종 비교 (디자이너 스크래치패드).
//
// 같은 더미 콘텐츠(Overview · Metrics · Activity)를 8 옵션(A~H)으로 동시 렌더해
// 사용자가 한 페이지에서 비교 후 채택. 모든 옵션은 동일한 bg-surface 위에서
// "섹션 분리 메커니즘"만 달리한다. 배경색 차이로 나누지 않는다.
//
// 인증 불필요: middleware.ts 의 PROTECTED 정규식은 /(dashboard|spec|…|account)
// 만 매칭한다. /design-samples 는 거기 없으므로 미들웨어가 통과시킨다 → 200.
//
// dev-only: 프로덕션 빌드는 notFound() 로 통째 404 (/demi-icons 패턴과 동일).
//
// 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT). 하드코딩 hex / gray-* / neutral-* 금지.

import { notFound } from "next/navigation";

export const dynamic = "force-dynamic";

// ───────────────────────── 더미 콘텐츠 ─────────────────────────
// 8 옵션 모두 같은 콘텐츠를 받아 "분리 메커니즘"만 달리해 렌더한다.

type SectionData = {
  index: string; // "01", "02", "03" — 옵션 D/G 에서 사용
  eyebrow: string; // 작은 라벨 — 옵션 E 에서 사용
  heading: string;
  body: string;
  metrics?: { label: string; value: string }[];
  list?: string[];
};

const SECTIONS: SectionData[] = [
  {
    index: "01",
    eyebrow: "context",
    heading: "Overview",
    body: "이 도메인의 현재 상태 요약. 7-verb 파이프라인의 어느 단계에 있고, 다음으로 어떤 입력이 필요한지.",
    metrics: [
      { label: "open milestones", value: "12" },
      { label: "absorbed", value: "84%" },
      { label: "tier", value: "🟢 closed" },
    ],
  },
  {
    index: "02",
    eyebrow: "telemetry",
    heading: "Metrics",
    body: "최근 24시간의 핵심 지표. 임계값을 벗어나는 항목은 강조 표시.",
    metrics: [
      { label: "verify pass", value: "97.3%" },
      { label: "cycle p50", value: "2m 14s" },
      { label: "queued", value: "3" },
    ],
  },
  {
    index: "03",
    eyebrow: "stream",
    heading: "Activity",
    body: "최근 라운드의 이벤트 스트림. 가장 위가 가장 최근.",
    list: [
      "verify atom h3o_eigenvector → 🟢 PASS",
      "fan-out 4 agents (cycle round 12)",
      "atlas register from drill: rtsc_native",
      "ship: domains/RTSC/papers/rtsc-campaign-2026",
      "harvest pod vast-mini-7: ALL_PASS",
    ],
  },
];

// ───────────────────────── 공용 콘텐츠 조각 ─────────────────────────

function Body({ text }: { text: string }) {
  return <p className="max-w-prose text-sm leading-relaxed text-body">{text}</p>;
}

function MetricGrid({ metrics }: { metrics: { label: string; value: string }[] }) {
  return (
    <dl className="mt-3 grid grid-cols-3 gap-3">
      {metrics.map((m) => (
        <div
          key={m.label}
          className="rounded-control border border-hairline-soft bg-canvas px-3 py-2"
        >
          <dt className="text-[10px] uppercase tracking-wider text-muted-soft">
            {m.label}
          </dt>
          <dd className="mt-0.5 font-mono text-sm text-ink">{m.value}</dd>
        </div>
      ))}
    </dl>
  );
}

function ListBlock({ items }: { items: string[] }) {
  return (
    <ul className="mt-3 space-y-1.5 text-sm text-body">
      {items.map((it) => (
        <li key={it} className="flex gap-2">
          <span className="text-muted-soft">·</span>
          <span>{it}</span>
        </li>
      ))}
    </ul>
  );
}

function SectionInner({ s }: { s: SectionData }) {
  return (
    <>
      <Body text={s.body} />
      {s.metrics && <MetricGrid metrics={s.metrics} />}
      {s.list && <ListBlock items={s.list} />}
    </>
  );
}

// ───────────────────────── 8 옵션 ─────────────────────────

// A · 공간만 — 단일 톤, 섹션 간 큰 여백 + h2 만으로 분리.
function OptionA() {
  return (
    <div className="space-y-16">
      {SECTIONS.map((s) => (
        <section key={s.index}>
          <h2 className="text-xl font-semibold text-ink">{s.heading}</h2>
          <SectionInner s={s} />
        </section>
      ))}
    </div>
  );
}

// B · 얇은 hairline — 섹션 사이 가로 1줄.
function OptionB() {
  return (
    <div className="space-y-10">
      {SECTIONS.map((s, i) => (
        <section
          key={s.index}
          className={
            i === 0 ? "" : "border-t border-hairline pt-10"
          }
        >
          <h2 className="text-xl font-semibold text-ink">{s.heading}</h2>
          <SectionInner s={s} />
        </section>
      ))}
    </div>
  );
}

// C · 점선 divider — dashed hairline.
function OptionC() {
  return (
    <div className="space-y-10">
      {SECTIONS.map((s, i) => (
        <section
          key={s.index}
          className={
            i === 0 ? "" : "border-t border-dashed border-hairline pt-10"
          }
        >
          <h2 className="text-xl font-semibold text-ink">{s.heading}</h2>
          <SectionInner s={s} />
        </section>
      ))}
    </div>
  );
}

// D · 인덱싱 — 큰 모노 번호 + 헤딩 한 줄.
function OptionD() {
  return (
    <div className="space-y-12">
      {SECTIONS.map((s) => (
        <section key={s.index}>
          <div className="flex items-baseline gap-4">
            <span className="font-mono text-3xl font-light text-muted-soft">
              {s.index}
            </span>
            <h2 className="text-xl font-semibold text-ink">{s.heading}</h2>
          </div>
          <div className="mt-3">
            <SectionInner s={s} />
          </div>
        </section>
      ))}
    </div>
  );
}

// E · eyebrow 라벨 — 작은 uppercase tracking-wide + 큰 헤딩.
function OptionE() {
  return (
    <div className="space-y-12">
      {SECTIONS.map((s) => (
        <section key={s.index}>
          <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
            {s.eyebrow}
          </p>
          <h2 className="mt-1 text-xl font-semibold text-ink">{s.heading}</h2>
          <div className="mt-2">
            <SectionInner s={s} />
          </div>
        </section>
      ))}
    </div>
  );
}

// F · 좌측 라벨 + 우측 콘텐츠 — grid 200px / 1fr.
function OptionF() {
  return (
    <div className="space-y-10">
      {SECTIONS.map((s) => (
        <section
          key={s.index}
          className="grid grid-cols-1 gap-4 sm:grid-cols-[200px_1fr] sm:gap-8"
        >
          <div className="sm:pt-1">
            <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
              {s.eyebrow}
            </p>
            <h2 className="mt-1 text-sm font-semibold text-ink">{s.heading}</h2>
          </div>
          <div>
            <SectionInner s={s} />
          </div>
        </section>
      ))}
    </div>
  );
}

// G · 인덱스 + hairline 결합 (D + B).
function OptionG() {
  return (
    <div className="space-y-10">
      {SECTIONS.map((s, i) => (
        <section
          key={s.index}
          className={i === 0 ? "" : "border-t border-hairline pt-10"}
        >
          <div className="flex items-baseline gap-4">
            <span className="font-mono text-3xl font-light text-muted-soft">
              {s.index}
            </span>
            <h2 className="text-xl font-semibold text-ink">{s.heading}</h2>
          </div>
          <div className="mt-3">
            <SectionInner s={s} />
          </div>
        </section>
      ))}
    </div>
  );
}

// H · 타이포 위계만 — weight/size/tracking 만으로(여백 동일, 구분선 0).
function OptionH() {
  return (
    <div className="space-y-8">
      {SECTIONS.map((s) => (
        <section key={s.index}>
          <h2 className="font-display text-3xl font-light tracking-tight text-ink">
            {s.heading}
          </h2>
          <div className="mt-2">
            <SectionInner s={s} />
          </div>
        </section>
      ))}
    </div>
  );
}

// ───────────────────────── 카드 래퍼 ─────────────────────────

type Option = {
  id: string; // "A" .. "H"
  title: string;
  blurb: string;
  Render: () => React.JSX.Element;
};

const OPTIONS: Option[] = [
  { id: "A", title: "공간만", blurb: "단일 톤 + 큰 여백 + h2. 가장 미니멀, 구분선 0.", Render: OptionA },
  { id: "B", title: "얇은 hairline", blurb: "섹션 사이 가로 1줄(border-t border-hairline).", Render: OptionB },
  { id: "C", title: "점선 divider", blurb: "border-dashed border-hairline. B 보다 더 가벼움.", Render: OptionC },
  { id: "D", title: "인덱싱", blurb: "큰 모노 01·02·03 + 헤딩 한 줄. 문서 톤.", Render: OptionD },
  { id: "E", title: "eyebrow 라벨", blurb: "작은 uppercase tracking-wide + 큰 헤딩. 잡지 톤.", Render: OptionE },
  { id: "F", title: "좌측 라벨 + 우측 콘텐츠", blurb: "grid 200px/1fr. Stripe/Linear docs 톤.", Render: OptionF },
  { id: "G", title: "인덱스 + hairline 결합", blurb: "D+B 합본. 가장 강한 구분.", Render: OptionG },
  { id: "H", title: "타이포 위계만 ✅ Section SSOT 채택안", blurb: "weight/size/tracking 만으로. 구분선·여백 차이 없이 위계로. components/ui/Section.tsx 에 이식 완료.", Render: OptionH },
];

function VariantCell({
  variant,
  Render,
}: {
  variant: "light" | "dark";
  Render: () => React.JSX.Element;
}) {
  const isDark = variant === "dark";
  return (
    <div
      className={
        (isDark ? "dark " : "") +
        "rounded-panel border border-hairline bg-surface p-6 text-ink"
      }
    >
      <div className="mb-4 text-[10px] font-semibold uppercase tracking-wider text-muted-soft">
        {isDark ? "dark bg" : "light bg"}
      </div>
      <Render />
    </div>
  );
}

// ───────────────────────── 페이지 ─────────────────────────

export default function DesignSamplesPage() {
  if (process.env.NODE_ENV === "production") notFound();

  return (
    <main className="min-h-screen bg-canvas px-8 py-8 text-ink antialiased">
      <header className="mb-8 max-w-3xl">
        <h1 className="font-display text-2xl font-light tracking-tight text-ink">
          dev · 섹션 구분 스타일 8종 (Section dividers)
        </h1>
        <p className="mt-2 text-sm text-body">
          같은 더미 콘텐츠(Overview · Metrics · Activity)를 A~H 8 옵션으로 동시 렌더.
          모든 옵션은 동일한 <code className="text-muted">bg-surface</code> 위에서
          "섹션 분리 메커니즘"만 달리한다. 배경색 차이로 나누지 않는다.
        </p>
        <p className="mt-2 text-xs text-muted-soft">
          하나를 골라 알려주면 본 페이지(dashboard/spec/...)에 채택한다. 라이트/다크 둘 다 확인.
        </p>
      </header>

      <div className="space-y-10">
        {OPTIONS.map((o) => (
          <article key={o.id}>
            <header className="mb-3 flex items-baseline gap-3">
              <span className="font-mono text-sm font-semibold text-ink">
                {o.id}
              </span>
              <span className="text-sm text-ink">·</span>
              <h2 className="text-sm font-semibold text-ink">{o.title}</h2>
              <p className="text-xs text-muted">{o.blurb}</p>
            </header>
            <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
              <VariantCell variant="light" Render={o.Render} />
              <VariantCell variant="dark" Render={o.Render} />
            </div>
          </article>
        ))}
      </div>

      <p className="mt-10 text-xs text-muted-soft">
        채택할 옵션 id 를 알려주세요 (A · B · C · D · E · F · G · H). 지금은 프리뷰만.
      </p>
    </main>
  );
}
