---
description: List IntelliHelper UI registry components (optionally by category)
argument-hint: "[category]"
---

List IntelliHelper UI components.

1. Call MCP `list_components`. If `$ARGUMENTS` is a known category, pass it as `category`:
   `glass-system`, `actions`, `surfaces`, `forms`, `overlays`, `navigation`, `data`, `feedback`, `interactive`, `content`.
2. Group output by category when listing everything.
3. Mention docs: https://ui.intellihelper.in and native: https://ui.intellihelper.in/native
4. When listing everything, show web slugs and `@native/<name>` entries separately if MCP returns both.
5. Offer next steps: search, get details, or install (`add button` vs `add @native/button`).
