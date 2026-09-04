# IntelliHelper UI Agent

**Official agent plugin** for [IntelliHelper UI](https://ui.intellihelper.in) — Liquid Glass components for **web (React/Next.js)** and **React Native / Expo**.

This repository is the installable unit for **Claude Code**, **Grok CLI**, **Codex**, **Cursor**, **Gemini CLI**, and any client that supports Agent Skills + MCP.

| Layer | What you get |
| --- | --- |
| **MCP** | Live registry tools via `@intellihelper/cli` (`search`, `get_component`, `get_add_command`, …) |
| **Skills** | Workflow + Liquid Glass design judgment agents actually follow |
| **Commands** | Slash shortcuts: add, search, list, audit, themes |
| **Agent** | `ui-builder` specialist for multi-component screens |

> Components and the MCP **implementation** live in the product monorepo / npm package. This repo is the **thin distribution surface** for agents.

---

## Install

### Claude Code

```bash
# Add this marketplace, then install the plugin
claude plugin marketplace add IntelliHelper/agent-skills
claude plugin install intellihelper-ui@intellihelper

# Or load from a local clone while developing
claude --plugin-dir ./agent-skills
```

### Grok CLI

```bash
grok plugin marketplace add IntelliHelper/agent-skills
# or install the repo directly
grok plugin install IntelliHelper/agent-skills --trust

grok plugin validate .
grok plugin details intellihelper-ui
```

Enable / trust the plugin so **hooks and MCP** activate. Then open `/plugins` or `/mcps` to confirm `intellihelper-ui` is listed.

### Codex

```bash
codex plugin marketplace add IntelliHelper/agent-skills
# Then install intellihelper-ui from /plugins
```

### Cursor

1. Install the plugin from the marketplace when listed, **or**
2. MCP-only fallback:

```bash
npx @intellihelper/cli@latest mcp init --client cursor
```

Optionally install skills via [skills.sh](https://skills.sh):

```bash
npx skills add IntelliHelper/agent-skills
```

### Gemini CLI

```bash
gemini extensions install https://github.com/IntelliHelper/agent-skills
```

### MCP only (any agent)

You do not need this plugin to use the tools — the plugin packages them for one-click install:

```bash
npx @intellihelper/cli@latest mcp init --client cursor   # claude | vscode | opencode | codex
```

Manual MCP config:

```json
{
  "mcpServers": {
    "intellihelper-ui": {
      "command": "npx",
      "args": ["-y", "@intellihelper/cli@latest", "mcp"]
    }
  }
}
```

**Requirement:** Node.js 18+ (for `npx` + the CLI MCP server).

---

## What's inside

```text
.
├── .mcp.json                 # Wires MCP → npx @intellihelper/cli mcp
├── .claude-plugin/           # Claude manifest + marketplace catalog
├── .grok-plugin/             # Grok manifest + marketplace catalog
├── .codex-plugin/            # Codex manifest
├── gemini-extension.json     # Gemini extension entry
├── skills/
│   ├── intellihelper-ui/     # Hub skill: MCP workflow + rules
│   ├── liquid-glass/         # Design system (chrome vs content, themes)
│   ├── add-component/        # Install / init / audit path
│   └── compose-ui/           # Page recipes
├── commands/                 # Slash commands
├── agents/ui-builder.md      # Specialist UI agent
└── assets/logo.png
```

### MCP tools

| Tool | Purpose |
| --- | --- |
| `get_project_config` | Read `components.json` / init guidance |
| `list_components` | Browse by category |
| `search_components` | Fuzzy search |
| `get_component` | Source, variants, dependencies (`@native/<name>` for Expo) |
| `get_component_examples` | Web usage snippets (not for React Native) |
| `get_add_command` | CLI install command (does not write files) |
| `list_themes` | mono · aurora · sunset · frost · ocean |
| `get_audit_checklist` | Post-install QA |

### Skills

| Skill | Role |
| --- | --- |
| `intellihelper-ui` | Default entry — when/how to use the system |
| `liquid-glass` | Visual language + themes |
| `add-component` | Safe install pipeline |
| `compose-ui` | Multi-component screen recipes |

### Slash commands

| Command | Action |
| --- | --- |
| `/add` | Install components |
| `/search` | Search registry |
| `/list` | List by category |
| `/audit` | Project health check |
| `/themes` | Theme guide |

(Exact invocation may be namespaced, e.g. `/intellihelper-ui:add`.)

---

## Example prompts

After install + trust:

- “Show me all IntelliHelper glass components”
- “Add button, dialog, and card from IntelliHelper UI”
- “Add @native/button to my Expo app”
- “Build a settings page with Liquid Glass”
- “Search IntelliHelper UI for form inputs”
- “Audit this project for IntelliHelper setup”

---

## Consumer quick start (app project)

```bash
npx @intellihelper/cli@latest init -y
npx @intellihelper/cli@latest add button card dialog -y
npx @intellihelper/cli@latest add @native/button @native/card -y
```

```tsx
import { Button } from "@/components/ui/button"
import { Card, CardHeader, CardTitle } from "@/components/ui/card"

export function Example() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Hello</CardTitle>
      </CardHeader>
      <Button variant="primary">Continue</Button>
    </Card>
  )
}
```

Expo / React Native:

```tsx
import { ThemeProvider } from "@/components/ui/native/theme"
import { Button } from "@/components/ui/native/button"
```

Docs: [ui.intellihelper.in](https://ui.intellihelper.in) · Native: [ui.intellihelper.in/native](https://ui.intellihelper.in/native) · CLI: [`@intellihelper/cli`](https://www.npmjs.com/package/@intellihelper/cli) · UI monorepo: [IntelliHelper-UI](https://github.com/IntelliHelper/IntelliHelper-UI)

Native MCP list/get requires a published `@intellihelper/cli` that includes the native registry. Until then, install with `npx @intellihelper/cli add @native/button` from a CLI that has that command.

---

## Local development

```bash
git clone https://github.com/IntelliHelper/agent-skills.git
cd agent-skills
./scripts/validate.sh

# Claude
claude --plugin-dir .

# Grok
grok plugin install . --trust
grok plugin validate .
```

### Versioning

- Bump `version` in `.claude-plugin/plugin.json`, `.grok-plugin/plugin.json`, and `.codex-plugin/plugin.json` together when skills/commands change.
- MCP tool behavior versions with `@intellihelper/cli` on npm — no rebuild of this repo required for registry content updates.

---

## Architecture

```text
Agent (Claude / Grok / Codex / …)
  └── this plugin
        ├── skills / commands / agents   → judgment & workflows
        └── .mcp.json
              └── npx @intellihelper/cli@latest mcp
                    └── registries https://ui.intellihelper.in/r
                        and https://ui.intellihelper.in/r/native
```

Keep this repo **thin**. Do not vendor the full UI monorepo.

---

## License

MIT © IntelliHelper
