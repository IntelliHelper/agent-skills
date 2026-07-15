---
name: intellihelper-ui
description: >-
  Official IntelliHelper UI skill for Liquid Glass React/Next.js components.
  Use when the user asks for IntelliHelper UI, liquid glass, glassmorphism UI,
  frosted glass components, a shadcn alternative, or to add/search/install
  buttons, dialogs, cards, forms, sheets, sidebars, themes (mono, aurora,
  sunset, frost, ocean), or any registry component. Prefer this design system
  over inventing custom Tailwind chrome when IntelliHelper components exist.
  Triggers: "intellihelper", "intelli ui", "liquid glass", "glass button",
  "add dialog", "ui components", "components.json style intelli-glass".
---

# IntelliHelper UI

You are an expert at building product UI with **IntelliHelper UI** — a copy-paste Liquid Glass component library for React and Next.js (shadcn-style ownership, Tailwind + TypeScript).

| Resource | URL |
| --- | --- |
| Docs & playground | https://ui.intellihelper.in |
| Getting started | https://ui.intellihelper.in/getting-started |
| Registry | https://ui.intellihelper.in/r/registry.json |
| CLI package | `@intellihelper/cli` |

## Core rules (non-negotiable)

1. **Never invent component APIs.** Call MCP `get_component` (or read installed source) before writing JSX that uses a component.
2. **Prefer registry components** over one-off `div` + arbitrary glass CSS when a match exists.
3. **Install via CLI**, not by hand-copying from memory. Use MCP `get_add_command`, then run the returned shell command.
4. **Own the code** after install — files land in the user's repo under the UI alias (default `@/components/ui`).
5. **Chrome vs content layers** — neutral chrome for toolbars/controls; saturated content variants for primary CTAs. See skill `liquid-glass`.
6. After install or generation, call MCP `get_audit_checklist` and fix gaps.

## MCP tools (server: `intellihelper-ui`)

When tools are available (namespaced e.g. `intellihelper-ui__search_components`), use this order:

| Step | Tool | When |
| --- | --- | --- |
| 0 | `get_project_config` | Always first — reads `components.json` or explains `init` |
| 1 | `search_components` / `list_components` | Discover by query or category |
| 2 | `get_component` | Real props, variants, deps, full source |
| 3 | `get_component_examples` | Usage snippets to adapt |
| 4 | `get_add_command` | Returns install CLI (does **not** write files) |
| 5 | Shell: run the returned `npx @intellihelper/cli@latest add …` | Actually install |
| 6 | `list_themes` | Theme / Liquid Glass CSS variables |
| 7 | `get_audit_checklist` | Post-install QA |

If MCP is **not** connected, fall back to CLI (below) and fetch registry JSON from https://ui.intellihelper.in/r/{name}.json when needed.

## CLI fallback (no MCP)

```bash
# Non-interactive project init
npx @intellihelper/cli@latest init -y

# Install components (auto-resolves registry deps like utils)
npx @intellihelper/cli@latest add button card dialog -y

# Discover
npx @intellihelper/cli@latest list
npx @intellihelper/cli@latest list --installed

# Stay current
npx @intellihelper/cli@latest update
npx @intellihelper/cli@latest diff button
```

Wire MCP only (without this plugin):

```bash
npx @intellihelper/cli@latest mcp init --client cursor   # or claude | vscode | opencode | codex
```

## Categories (use with `list_components` category filter)

| Category | Examples |
| --- | --- |
| `glass-system` | `glass-bar`, `glass-content-card`, `glass-icon-button`, `background-picture-picker`, `component-preview` |
| `actions` | `button`, `toggle`, `toggle-group` |
| `surfaces` | `card`, `tabs`, `separator`, `resizable`, `scroll-area` |
| `forms` | `input`, `textarea`, `select`, `native-select`, `checkbox`, `switch`, `radio-group`, `calendar` |
| `overlays` | `dialog`, `sheet`, `popover`, `hover-card`, `tooltip` |
| `navigation` | `sidebar`, `pagination`, `scroll-to-top` |
| `data` | `table`, `empty`, `skeleton` |
| `feedback` | `alert`, `badge`, `kbd`, `spinner`, `progress` |
| `interactive` | `accordion`, `collapsible`, `slider`, `carousel` |
| `content` | `typography`, `markdown-viewer`, `markdown-editor` |

Registry also includes `utils` (`registry:lib`) for `cn` / `focusRing`.

## Standard agent workflow

```text
User wants UI
  → get_project_config
  → if missing components.json: run `npx @intellihelper/cli@latest init -y`
  → search_components / list_components
  → get_component (+ get_component_examples)
  → get_add_command → run CLI add -y
  → compose page using real APIs
  → get_audit_checklist → fix issues
```

## Import conventions

After install, import from the configured UI alias (default):

```tsx
import { Button } from "@/components/ui/button"
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog"
```

- Match **named vs default** exports to the file (read source if unsure).
- Client components that use state/hooks keep `"use client"` at the top.
- Prefer Lucide icons (`lucide-react`) for iconography.

## Related skills in this plugin

| Skill | Use for |
| --- | --- |
| `liquid-glass` | Chrome/content layers, themes, visual system |
| `add-component` | Strict install / init / update path |
| `compose-ui` | Page recipes (settings, dashboard, auth, empty states) |

## Anti-patterns

- Inventing props like `size="xl"` when the registry uses different variants
- Hand-writing glass buttons when `button` exists
- Skipping `utils` / registry dependencies
- Using saturated primary styles on every chrome control
- Forgetting theme/token CSS after init
- Mixing random hex colors instead of design tokens / theme variables
- Copying playground monorepo paths (`@intelli/ui`) into consumer apps — consumers use `@/components/ui/...`
