---
description: Search the IntelliHelper UI registry for components
argument-hint: "<query>"
---

Search IntelliHelper UI for: **$ARGUMENTS**

1. Prefer MCP `search_components` with the query (and optional category if the user implied one).
2. Present results as a compact table: name · category · one-line description.
3. For the top 1–3 matches, offer to fetch `get_component` / `get_component_examples` or install via `/add`.
4. If no MCP, run `npx @intellihelper/cli@latest list` and filter, or fetch `https://ui.intellihelper.in/r/registry.json`.

If `$ARGUMENTS` is empty, ask for a query (e.g. "form", "glass", "dialog").
