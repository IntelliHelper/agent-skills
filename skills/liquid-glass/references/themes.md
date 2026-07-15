# Themes

## Available themes

| ID | Label | Description |
| --- | --- | --- |
| `mono` | Mono Basic | Pure black and white — foundational minimal UI |
| `aurora` | Cool Aurora | Deep navy base with cyan-violet aurora accents |
| `sunset` | Warm Sunset | Amber-coral gradients with rose-gold glass |
| `frost` | Neutral Frost | Icy slate surfaces with crystalline clarity |
| `ocean` | Deep Ocean | Teal depths with bioluminescent aqua accents |

Source of truth for agents: MCP tool `list_themes`.

## Agent workflow

1. Ask (or infer) product mood: minimal → `mono`/`frost`; cool tech → `aurora`/`ocean`; warm product → `sunset`.
2. Ensure CSS pipeline loads IntelliHelper tokens/themes after `init` (see https://ui.intellihelper.in/getting-started).
3. Prefer theme CSS variables and component glass classes over hard-coded colors.
4. When switching themes in demos, keep structure/components constant — only theme tokens should change.

## Do / Don't

**Do**

- Use theme variables for backgrounds, borders, and accent glass
- Test light and dark (or dual mode if the app supports it)
- Keep chrome neutral even when the theme accent is strong

**Don't**

- Mix multiple accent palettes on one screen
- Override glass utilities with random `bg-purple-500/40` stacks
- Assume theme IDs beyond the five listed without calling `list_themes`
