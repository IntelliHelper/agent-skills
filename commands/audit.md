---
description: Audit the project for correct IntelliHelper UI setup and usage
---

Run an IntelliHelper UI health check on the current project.

1. Call MCP `get_project_config` and summarize `components.json` (or report missing init).
2. Call MCP `get_audit_checklist` and evaluate each item against the repo (aliases, imports, CSS, client components, TS).
3. Optionally call `list_themes` and note whether theme CSS appears wired.
4. If components are installed, sample one import path and verify the file exists under the UI alias.
5. If the app is Expo/RN, confirm imports are `@/components/ui/native/...` and `ThemeProvider` wraps the tree — not web `className` files.
6. Return a pass/fail checklist with concrete fix commands (e.g. `init -y`, `add utils -y`, `add @native/button -y`).
