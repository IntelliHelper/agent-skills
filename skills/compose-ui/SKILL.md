---
name: compose-ui
description: >-
  Compose production pages and Expo screens with IntelliHelper UI components —
  settings, dashboards, auth, CRUD tables, empty/loading/error states, mobile
  nav, and glass-stage layouts. Use when building screens, layouts, or
  multi-component flows rather than installing a single primitive.
  Prefer registry composition over custom shells. Triggers include Expo /
  React Native screens using @native/ components.
---

# Compose UI with IntelliHelper

Build **screens**, not isolated widgets. Always:

1. Discover/install missing pieces via skill `add-component` / MCP.
2. Apply chrome vs content rules from skill `liquid-glass`.
3. Match real APIs via `get_component` / `get_component_examples`.

## Reach for this first

| Use case | Components | Why |
| --- | --- | --- |
| Settings page | `tabs` + `card` + form controls + `button` | Grouped sections, clear save |
| Dashboard | `card` + `badge` + `table` + `skeleton` | Summary + dense data |
| CRUD table | `table` + `sheet`/`dialog` + `button` + `empty` | Browse, edit, create |
| Auth / onboarding | `card` + `input` + `button` + `alert` + `separator` | Focused entry |
| Mobile nav | `sheet` + `button` + `separator` | Compact shell |
| Detail page | header + `badge` + `card` + `separator` | Hierarchy without nesting chaos |
| Filters | `select` + `popover`/`sheet` + `button` | Desktop + mobile |
| Confirm destructive | `dialog` + destructive `button` | Explicit consequence |
| Empty / loading / error | `empty` + `skeleton` + `alert` + primary CTA | Designed non-happy paths |
| Glass stage / media | `background-picture-picker` + `glass-bar` + `glass-icon-button` | Liquid Glass showcase chrome |
| Docs / content | `typography` + `markdown-viewer` / `markdown-editor` | Long-form surfaces |
| Sidebar app shell | `sidebar` + `separator` + `scroll-area` | Product navigation |

Install only what you need:

```bash
# Web
npx @intellihelper/cli@latest add tabs card button input alert table sheet dialog empty skeleton -y

# Expo / React Native (same slugs, namespaced)
npx @intellihelper/cli@latest add @native/card @native/button @native/input @native/alert @native/sheet -y
```

On native, wrap the app in `ThemeProvider` from `@/components/ui/native/theme`. Do not paste web `className` recipes into RN.

## Composition recipes

### Settings

- `Tabs` for sections (Profile, Appearance, Billing)
- Each section: `Card` with header + form fields
- Footer actions: ghost Cancel + primary Save
- Prefer `switch` for boolean prefs; `select` for enums

### Admin dashboard

- Top row: 3–4 summary `Card`s (metric + muted label)
- Toolbar: outline filters + primary “New …”
- Main: `Table` with row actions in ghost/outline buttons
- Loading: `Skeleton` matching card/table shape

### Entity detail

- Title row + status `Badge`
- Main column `Card` for core fields
- Side `Card` for metadata
- Destructive action in dialog, not inline surprise

### Auth

- Centered max-width `Card`
- `Input` + labels, primary submit
- `Alert` for errors (never only toast)
- `Separator` “or continue with” social row if needed

### Glass media chrome

- Stage background via theme / `background-picture-picker`
- Floating `glass-bar` with `glass-icon-button` cluster
- Content CTA separate from chrome cluster

### Empty state

```text
Empty illustration/title/description
  + primary Button (create/import)
  + optional outline secondary
```

Use `empty` when available; otherwise compose with `card` + typography + buttons.

## Layout quality rules

1. **One primary CTA** per visible region.
2. **Consistent spacing scale** — do not mix `gap-2` and `gap-10` without hierarchy reason.
3. **Prefer components over raw shells** — if `Dialog` exists, do not reinvent modal markup.
4. **Responsive:** `sheet` for mobile filters/nav; keep desktop sidebars from `sidebar`.
5. **States:** happy path alone is incomplete — ship loading, empty, and error.
6. **Accessibility:** labels on inputs, dialog titles, button names, focus order.

## Workflow for multi-file features

```text
1. get_project_config / init
2. Plan component list for the screen
3. search + get_component for each unfamiliar API
4. get_add_command → CLI add -y (batch installs)
5. Compose page/components
6. get_audit_checklist
7. Visual pass: chrome quiet, CTA clear, contrast OK
```

## Anti-patterns

- Dashboard of only nested cards with no table/data hierarchy
- Every button `primary`
- Missing empty/loading states
- Custom modal without focus trap when `dialog` exists
- Hard-coded colors fighting the active theme
- Importing monorepo packages in consumer apps
- Using web `get_component_examples` as Expo/React Native source
- Installing unprefixed web components into a native screen
