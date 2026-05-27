// Pricing tier registry — single source of truth.
//
// Price IDs come from env so dev/prod can point at different products
// without code changes. Create products in
// https://dashboard.stripe.com/test/products then set:
//   STRIPE_PRICE_SOLO   = price_...
//   STRIPE_PRICE_TEAM   = price_...
//   STRIPE_PRICE_ORG    = price_...

export type Tier = {
  id: "solo" | "team" | "org";
  label: string;
  monthlyUsd: number;
  seats: number;
  highlights: string[];
  /** Stripe price_... id, resolved at request time so dev mode without
   *  Stripe configured still renders the pricing page. */
  priceEnv: string;
};

export const TIERS: Tier[] = [
  {
    id: "solo",
    label: "Solo",
    monthlyUsd: 29,
    seats: 1,
    highlights: [
      "1 seat",
      "8-verb pipeline · CLI + Web",
      "Gemini 2.5 draft 어시스트",
      "GPU/TPU = GCP 실사용량 정산",
      "14d 무료 trial",
    ],
    priceEnv: "STRIPE_PRICE_SOLO",
  },
  {
    id: "team",
    label: "Team",
    monthlyUsd: 99,
    seats: 5,
    highlights: [
      "5 seats",
      "Solo 전체 +",
      "공유 도메인 SSOT",
      "GPU/TPU = GCP 실사용량 정산",
      "Workspace SSO (post-M16)",
    ],
    priceEnv: "STRIPE_PRICE_TEAM",
  },
  {
    id: "org",
    label: "Org",
    monthlyUsd: 299,
    seats: 25,
    highlights: [
      "25 seats",
      "Team 전체 +",
      "GPU/TPU = GCP 실사용량 정산 (월별 통합 청구서)",
      "audit log + BigQuery export",
      "우선 지원 (24h)",
    ],
    priceEnv: "STRIPE_PRICE_ORG",
  },
];

export function priceIdFor(tier: Tier["id"]): string {
  const t = TIERS.find((x) => x.id === tier);
  if (!t) throw new Error(`unknown tier: ${tier}`);
  const id = process.env[t.priceEnv];
  if (!id) {
    throw new Error(
      `${t.priceEnv} unset. Create the ${t.label} product in Stripe ` +
        `(monthly $${t.monthlyUsd}) and export the price_... id.`
    );
  }
  return id;
}
