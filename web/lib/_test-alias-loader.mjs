// _test-alias-loader.mjs — ESM resolve hook so `@/...` and extensionless TS
// relative imports work under `node --experimental-strip-types` (the runner used
// by the *.test.ts smoke files). Maps the tsconfig "@/*": ["./*"] alias to a
// file:// URL rooted at web/, and appends the on-disk extension for
// extensionless / dotted (".server"/".test") relative specifiers.
//
// Self-registers via module.register() so it works with `node --import`.
// Test-only; never bundled by Next.
import { register } from "node:module";

register("./_test-alias-hooks.mjs", import.meta.url);
