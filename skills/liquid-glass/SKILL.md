---
name: liquid-glass
description: >-
  IntelliHelper Liquid Glass design system — chrome vs content layers, frosted
  surfaces, themes (mono, aurora, sunset, frost, ocean), glass primitives, and
  visual polish. Use when styling glass UI, choosing button variants, building
  toolbars vs CTAs, setting themes, or fixing washed-out/over-saturated glass.
  Triggers: "liquid glass", "glassmorphism", "frosted glass", "chrome layer",
  "glass-bar", "theme mono aurora", "glass button variant".
---

# Liquid Glass design system

IntelliHelper UI is a **two-layer glass language**:

| Layer | Role | Feel | Typical components / variants |
| --- | --- | --- | --- |
| **Chrome** | Toolbars, icon controls, navigation chrome, secondary actions | Neutral, frosted, Apple mini-player | `outline`, `secondary`, `ghost`, `glass`; `glass-bar`, `glass-icon-button` |
| **Content** | Primary CTAs, marketing panels, destructive emphasis | Theme-saturated, expressive | `primary`, `destructive`; `glass-content-card` |

**Rule of thumb:** chrome stays quiet so content and data stay legible. One saturated CTA per region is usually enough.

## Before styling

1. Call MCP `list_themes` for theme IDs and descriptions.
2. Call `get_component` for the real `variant` / `size` / `shape` APIs — do not invent them.
3. Ensure project CSS loads tokens/themes (init + docs: https://ui.intellihelper.in/getting-started).

## Themes

| ID | Label | Character |
| --- | --- | --- |
| `mono` | Mono Basic | Pure black/white foundational minimal |
| `aurora` | Cool Aurora | Deep navy + cyan-violet accents |
| `sunset` | Warm Sunset | Amber-coral + rose-gold glass |
| `frost` | Neutral Frost | Icy slate, crystalline |
| `ocean` | Deep Ocean | Teal depths + aqua accents |

Themes drive CSS variables used by glass utilities. Prefer theme tokens over ad-hoc hex for surfaces, borders, and glow.

## Glass system components

Prefer these over custom `backdrop-blur` one-offs:

| Component | Use |
| --- | --- |
| `glass-bar` | Neutral capsule for grouped media / chrome controls |
| `glass-icon-button` | Circular icon-only chrome actions |
| `glass-content-card` | Expressive saturated content panels under chrome |
| `background-picture-picker` | Mesh/gradient/upload backgrounds for glass stages |
| `component-preview` | Live preview + source (docs/playground style) |
| `card` | Frosted panels for chrome and content layouts |

Install: `npx @intellihelper/cli@latest add glass-bar glass-icon-button card -y`

## Button language (verify with `get_component`)

Typical `button` variants in the design system:

| Variant | Layer | Use |
| --- | --- | --- |
| `default` / `glass` | Chrome-ish frosted | Default frosted control |
| `outline` / `secondary` / `ghost` | Chrome | Neutral toolbars, secondary actions |
| `primary` | Content | Main CTA |
| `destructive` | Content | Destructive CTA |
| `link` | Material | Text link, no glass chrome |

Shapes commonly include `rounded`, `pill`, `rectangular`. Sizes: `default`, `sm`, `lg`, `icon`.

```tsx
// Chrome toolbar
<Button variant="outline" size="icon"><Settings /></Button>
<Button variant="ghost">Cancel</Button>

// Content CTA
<Button variant="primary">Continue</Button>
<Button variant="destructive">Delete</Button>
```

Always re-check exports and prop names via MCP before shipping.

## Visual quality bar

Ship interfaces that feel intentional:

- **Hierarchy:** one primary action; chrome supports, content leads.
- **Density:** pick comfortable (`gap-6` / `p-6`) or compact (`gap-4` / `p-4`) per page — do not mix randomly.
- **Radius:** stay consistent with component shapes; avoid stacking many different radii.
- **Contrast:** verify light/dark on frosted surfaces (audit checklist).
- **Motion:** prefer existing component transitions over custom bounce everywhere.
- **Icons:** Lucide at consistent sizes (`size-4` / `h-4 w-4`).

## Anti-patterns

- Glass on every surface (noise, illegible text)
- Saturated primary chrome on icon toolbars
- Nested glass cards three levels deep
- Random gradients + glow competing with theme
- Ignoring `focusRing` / keyboard focus styles
- Using playground internal imports (`@intelli/ui`, `@intelli/utils`) in consumer apps

## Progressive disclosure

- Layer details & pairing → [references/layers.md](references/layers.md)
- Theme setup notes → [references/themes.md](references/themes.md)
- Page recipes → skill `compose-ui`
- Install path → skill `add-component`
