---
description: Install one or more IntelliHelper UI components into the current project
argument-hint: "<component> [component...]"
---

Install IntelliHelper UI component(s): **$ARGUMENTS**

Follow skill `add-component` strictly:

1. Call MCP `get_project_config`. If `components.json` is missing, run:
   `npx @intellihelper/cli@latest init -y`
2. Resolve each name with `search_components` if ambiguous.
3. Call `get_component` for each target (batch with `names` when possible).
4. Call `get_add_command` with the component list, then run the returned command with non-interactive flags.
5. Show a short summary of files added and example imports using the project's UI alias.
6. Call `get_audit_checklist` and fix any obvious gaps.

If `$ARGUMENTS` is empty, ask which components to install or offer popular starters: `button`, `card`, `dialog`, `input`.
