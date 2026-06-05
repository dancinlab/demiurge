// /sample — PUBLIC showcase (no login). A one-page gallery of every COSMOS
// visual piece so anyone can see the 3D pieces at a glance without an account.
// `/sample` is NOT in the middleware PROTECTED regex → ungated; the 3D viewers
// hit the public `/api/structure` + `/api/cosmos` routes (also ungated).

import type { Metadata } from "next";
import { DomainModel3D } from "@/components/DomainModel3D";
import { MolViewer } from "@/components/MolViewer";
import type { Rung } from "@/lib/cosmos";

export const metadata: Metadata = {
  title: "COSMOS 샘플 — 둘러보기",
  description: "로그인 없이 보는 COSMOS 3D 샘플 갤러리",
};

// The 6-band rung ladder — each shows its stylized 3D shape (data-less → ⚪).
const RUNGS: { rung: Rung; emoji: string; ko: string; shape: string; domain: string }[] = [
  { rung: "atom", emoji: "⚛️", ko: "원자", shape: "격자 (lattice)", domain: "QUBIT" },
  { rung: "materials", emoji: "🔬", ko: "물질", shape: "슈퍼셀 (supercell)", domain: "MATTER" },
  { rung: "bio", emoji: "🧬", ko: "바이오", shape: "나선 (helix)", domain: "BIO" },
  { rung: "chem", emoji: "⚗️", ko: "화학", shape: "분자 (molecule)", domain: "CHEM" },
  { rung: "chip", emoji: "💠", ko: "칩", shape: "다이 (die)", domain: "CHIP" },
  { rung: "system", emoji: "🛸", ko: "시스템", shape: "코일 (coil)", domain: "UFO" },
];

// Real-structure viewers (Mol* → 3Dmol.js) fed from public APIs.
const STRUCTURES: {
  source: "alphafold" | "pdb" | "pubchem";
  id: string;
  emoji: string;
  title: string;
  caption: string;
}[] = [
  {
    source: "alphafold",
    id: "Q8N474",
    emoji: "🧬",
    title: "AGA-RX · SFRP1 단백질",
    caption: "AlphaFold 예측 접힘 (314잔기) · 색 = 신뢰도 pLDDT · AlphaFold DB · CC-BY",
  },
  {
    source: "pdb",
    id: "3ZLR",
    emoji: "🧫",
    title: "SENOLYX · BCL-xL 단백질",
    caption: "실험으로 풀린 실제 구조 (290잔기) · PDB 3ZLR · RCSB · CC0",
  },
  {
    source: "pubchem",
    id: "16727102",
    emoji: "💊",
    title: "WAY-316606 · 약 분자",
    caption: "실제 분자 공-막대 (C18H19F3N2O4S2) · PubChem CID 16727102 · public domain",
  },
];

function Card({
  emoji,
  title,
  sub,
  children,
}: {
  emoji: string;
  title: string;
  sub: string;
  children: React.ReactNode;
}) {
  return (
    <div className="overflow-hidden rounded-2xl border border-hairline bg-surface">
      <div className="h-56 w-full bg-[#16130f]">{children}</div>
      <div className="space-y-1 p-4">
        <h3 className="text-sm font-medium text-ink">
          {emoji} {title}
        </h3>
        <p className="text-xs text-muted">{sub}</p>
      </div>
    </div>
  );
}

export default function SamplePage() {
  return (
    <main className="mx-auto max-w-6xl space-y-12 px-5 py-10">
      <header className="space-y-2">
        <h1 className="text-2xl font-semibold text-ink">🌌 COSMOS 샘플 — 둘러보기</h1>
        <p className="text-sm text-muted">
          로그인 없이 보는 3D 샘플 갤러리. 마우스로 드래그하면 돌려볼 수 있어요.
          전체 우주는 로그인 후 <code className="text-body">/cosmos</code>.
        </p>
      </header>

      {/* ── 6-band rung shapes ─────────────────────────────────────────── */}
      <section className="space-y-4">
        <h2 className="text-lg font-medium text-ink">① 6단 스케일 — 단별 3D 모양</h2>
        <p className="text-sm text-muted">
          원자 → 물질 → 바이오 → 화학 → 칩 → 시스템. 각 단이 고유한 모양으로
          그려집니다 (데이터 없는 일반형 = ⚪ 양식화).
        </p>
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {RUNGS.map((r) => (
            <Card key={r.rung} emoji={r.emoji} title={`${r.ko} (${r.rung})`} sub={r.shape}>
              <DomainModel3D
                domain={r.domain}
                rung={r.rung}
                state="unverified"
                noDataLabel="데이터 없음"
                errorLabel="3D 오류"
              />
            </Card>
          ))}
        </div>
      </section>

      {/* ── real structures (3Dmol.js) ─────────────────────────────────── */}
      <section className="space-y-4">
        <h2 className="text-lg font-medium text-ink">② 실제 구조 — 단백질 접힘 · 약 분자</h2>
        <p className="text-sm text-muted">
          AlphaFold·RCSB·PubChem에서 실제 구조를 받아 그립니다 (3Dmol.js).
        </p>
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {STRUCTURES.map((s) => (
            <Card key={s.id} emoji={s.emoji} title={s.title} sub={s.caption}>
              <MolViewer source={s.source} id={s.id} />
            </Card>
          ))}
        </div>
      </section>

      <footer className="border-t border-hairline pt-6 text-xs text-muted">
        COSMOS · demiurge web GUI · 샘플 페이지(공개) — 데이터는 `.demi` SSOT +
        AlphaFold DB(CC-BY) / RCSB PDB(CC0) / PubChem(public domain).
      </footer>
    </main>
  );
}
