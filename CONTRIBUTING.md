# Contributing

Thanks for improving the IntelliHelper UI agent plugin.

## Principles

1. **Thin distribution** — skills, commands, manifests, MCP wiring only. No monorepo packages.
2. **MCP is the source of truth** for component APIs; skills must not invent props.
3. **Progressive disclosure** — keep `SKILL.md` lean; put depth under `references/`.
4. **Strong triggers** — skill `description` frontmatter must list clear use cases and phrases.
5. **Non-interactive CLI** — document `-y` / defaults so agents never hang on prompts.

## Layout

| Path | Purpose |
| --- | --- |
| `skills/*/SKILL.md` | Agent skills |
| `commands/*.md` | Slash commands |
| `agents/*.md` | Specialist agents |
| `.mcp.json` | MCP server config |
| `.claude-plugin/`, `.grok-plugin/`, `.codex-plugin/` | Marketplace manifests |

## Local checks

```bash
./scripts/validate.sh
grok plugin validate .   # if Grok CLI installed
claude plugin validate . # if Claude Code installed
```

## Skill writing checklist

- [ ] Frontmatter `name` matches folder name
- [ ] `description` includes triggers and when-to-use
- [ ] MCP tool names match `@intellihelper/cli` (`get_project_config`, `search_components`, …)
- [ ] Consumer import paths use `@/components/ui` (web) or `@/components/ui/native` (Expo), never `@intelli/ui`
- [ ] Links to https://ui.intellihelper.in where helpful

## Releases

1. Bump `version` in all plugin manifests.
2. Update marketplace entries if description changes.
3. Tag `vX.Y.Z` and push.

Registry component updates ship via `@intellihelper/cli` / the docs site — not this repo.
