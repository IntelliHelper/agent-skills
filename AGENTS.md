# Agent notes (this repository)

This repo **is** the IntelliHelper UI agent plugin. When editing it:

- Keep the package thin: skills, commands, agents, manifests, `.mcp.json` only.
- MCP implementation and component source of truth: `@intellihelper/cli` + https://ui.intellihelper.in
- Do not vendor monorepo packages or large component sources here.
- After changes, run `./scripts/validate.sh`.
- Bump plugin `version` fields in all manifests when releasing.

## Test install

```bash
grok plugin install . --trust
claude --plugin-dir .
```

## Smoke prompts

- “List IntelliHelper glass-system components”
- “Add button and dialog with IntelliHelper UI”
- “Add @native/button in Expo”
- “What themes does IntelliHelper UI support?”
