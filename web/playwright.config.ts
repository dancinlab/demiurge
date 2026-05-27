import { defineConfig, devices } from "@playwright/test";

// Playwright e2e config — QA conformance + mobile R3F.
// Default base URL = production Cloud Run; override with PLAYWRIGHT_BASE_URL.
// Run with `npx playwright test` from web/.

export default defineConfig({
  testDir: "./e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: process.env.CI ? "github" : "list",
  use: {
    baseURL: process.env.PLAYWRIGHT_BASE_URL ?? "https://demiurge.dancinlab.org",
    trace: "on-first-retry",
  },
  projects: [
    {
      name: "desktop-chromium",
      use: { ...devices["Desktop Chrome"] },
    },
    {
      name: "mobile-iphone",
      use: { ...devices["iPhone 14"] },
    },
  ],
});
