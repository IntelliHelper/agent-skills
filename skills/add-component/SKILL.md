---
name: add-component
description: >-
  Install IntelliHelper UI components into a project correctly: init components.json,
  resolve dependencies, run CLI add (web slugs or @native/<name> for Expo),
  verify imports, and audit. Use when the user wants to add, install, scaffold,
  update, or diff IntelliHelper/shadcn-style or React Native components, fix
  missing components.json, or wire the registry.
  Triggers: "add button", "add @native/button", "install dialog",
  "npx @intellihelper/cli", "init components.json", "update components",
  "registry add", "expo components".
---

# Add IntelliHelper components

Goal: leave the project with **installed, compiling, correctly imported** components — not just a pasted snippet.

## Decision tree

```text
components.json missing?
  YES → init first (non-interactive)
  NO  → read config (MCP get_project_config)

Know exact component names?
  YES → get_component → get_add_command → CLI add
  NO  → search_components / list_components → then install
```

## 1. Project config

**MCP:** `get_project_config`

**CLI:**

```bash
npx @intellihelper/cli@latest init -y
```

Always prefer `-y` / non-interactive flags in agent shells so prompts do not hang.

Default config highlights (web):

- **Style:** `intelli-glass`
- **Registry:** `https://ui.intellihelper.in/r`
- **UI alias:** `@/components/ui`
- **Utils alias:** `@/lib/utils`
- **CSS:** `app/globals.css` (adjust if project uses `src/app`)

Expo / React Native: still `init -y` is fine. Native files always land in `components/ui/native/` when you `add @native/<name>`. Use `init --native -y` only for Expo-only repos where unprefixed names should mean native.

Ensure `tsconfig` path aliases match `components.json`.

## 2. Discover names

**MCP:**

```text
search_components { "query": "dialog" }
list_components { "category": "forms" }
```

**CLI:**

```bash
npx @intellihelper/cli@latest list
```

Use **registry slugs** — web: `button`, `dialog`, `glass-bar`. Native: `@native/button`, `@native/dialog`. Not React display names alone.

If the project is Expo/RN, **do not** pass unprefixed names unless `init --native` was used.

## 3. Read API before coding

**MCP:**

```text
get_component { "name": "button" }
get_component { "name": "@native/button" }
get_component { "names": ["dialog", "button"] }
get_component_examples { "name": "dialog" }   # web only
```

Extract: exports, variants, sizes, shapes, npm + registry deps. Web: `"use client"`. Native: `onPress` / `style` / ThemeProvider.

## 4. Install (source of truth)

**MCP:** `get_add_command` with `{ "components": ["button", "dialog"] }` or `{ "components": ["@native/button"] }`  
Then **run the returned command** in the project shell.

**CLI direct:**

```bash
npx @intellihelper/cli@latest add button dialog card -y
npx @intellihelper/cli@latest add @native/button @native/card -y
npx @intellihelper/cli@latest add button @native/card -y   # mixed, no overwrite
```

Useful flags:

| Flag | Purpose |
| --- | --- |
| `-y, --yes` | Skip confirmations (agent default) |
| `-o, --overwrite` | Overwrite local files |
| `--dry-run` | Preview only |

The CLI resolves **registry dependencies** (e.g. `utils`) and installs **npm dependencies**.

## 5. Update / diff

```bash
npx @intellihelper/cli@latest update -y
npx @intellihelper/cli@latest update button --skip-modified
npx @intellihelper/cli@latest diff button
npx @intellihelper/cli@latest diff @native/button
npx @intellihelper/cli@latest list --installed
```

Never blindly overwrite user-customized files without checking `diff` / modified state.

## 6. Audit

**MCP:** `get_audit_checklist`

Verify at minimum:

- [ ] `components.json` present; aliases match tsconfig
- [ ] Imports use UI alias (`@/components/ui/...` or `@/components/ui/native/...`)
- [ ] Named/default imports match exports
- [ ] Registry + npm deps installed (native pulls `native-theme`, `native-utils`, siblings)
- [ ] Web: theme/token CSS loaded. Native: root wrapped in `ThemeProvider`
- [ ] Chrome vs content variants chosen deliberately
- [ ] Web client components marked `"use client"` when needed
- [ ] No TS/lint (or Metro) errors

## 7. Compose

After install, import from local paths:

```tsx
import { Button } from "@/components/ui/button"
import { Button } from "@/components/ui/native/button"
```

Do **not** import from `@intelli/ui` or `@intelli/ui-native` in consumer apps — those are monorepo-internal.

For layout recipes, use skill `compose-ui`. For glass rules, use skill `liquid-glass`.

## Failure modes & fixes

| Symptom | Fix |
| --- | --- |
| Interactive CLI hanging | Re-run with `-y` |
| Module not found `@/lib/utils` | `add utils` / re-init aliases |
| Wrong import path | Read `components.json` aliases |
| Missing glass styles | Check global CSS / theme setup in docs |
| Props TypeScript errors | Re-run `get_component`; stop inventing props |
| MCP tools missing | Plugin trust/MCP enable, or CLI fallback |
| Web button in Expo / Metro className errors | Re-install with `@native/button`; import `@/components/ui/native/button` |

## Docs

- https://ui.intellihelper.in/getting-started
- https://ui.intellihelper.in
- https://ui.intellihelper.in/native
