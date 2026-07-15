# Chrome vs content layers

## Intent

Liquid Glass separates **instrumentation** (chrome) from **expression** (content):

- **Chrome** is the control surface — it should feel physical, neutral, and reusable.
- **Content** is where brand color and emphasis live — CTAs, hero panels, alerts of consequence.

Agents that paint every control `primary` destroy hierarchy and make the UI feel like a marketing site, not a product.

## Pairing matrix

| Region | Chrome | Content |
| --- | --- | --- |
| App header / dock | `glass-bar`, outline/ghost buttons, icon buttons | Single primary CTA if needed |
| Form footer | Cancel = ghost/outline | Submit = primary; Delete = destructive |
| Media player strip | `glass-bar` + `glass-icon-button` | None (or progress as feedback) |
| Marketing section | Minimal chrome | `glass-content-card`, primary buttons |
| Data table toolbar | outline filters, ghost row actions | Primary "Create" only |
| Destructive flow | Dialog/sheet chrome | Destructive button + clear copy |

## Component mapping

### Chrome-first

- `glass-bar`
- `glass-icon-button`
- `button` variants: `outline`, `secondary`, `ghost`, `glass`, `default`
- `toggle` / `toggle-group` for mode switches
- `sidebar` navigation chrome
- `tabs` list chrome

### Content-first

- `glass-content-card`
- `button` variants: `primary`, `destructive`
- `alert` for consequential messages
- `badge` for status emphasis (sparingly)
- Hero / empty-state CTAs

## Depth stacking

Recommended z / blur stack (conceptual):

1. **Background** — mesh, photo, or theme base (`background-picture-picker` stage)
2. **Content glass** — cards / panels with readable type
3. **Chrome glass** — floating bars, sticky toolbars
4. **Overlays** — dialog, sheet, popover above chrome

Do not put heavy blur chrome behind body text at large scale.

## Accessibility

- Maintain WCAG contrast on frosted fills in both light and dark.
- Never rely on glass alone for state (pair with text, icons, `aria-*`).
- Keep focus rings visible (`focusRing` from utils).
- Overlays must trap focus and restore it (registry dialog/sheet do this — do not reimplement).
