#!/usr/bin/env bash
# Structural validation for the IntelliHelper UI agent plugin.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
ERR=0

ok() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; ERR=1; }

echo "Validating IntelliHelper UI Agent plugin at $ROOT"

# Required roots
for f in \
  .mcp.json \
  .claude-plugin/plugin.json \
  .claude-plugin/marketplace.json \
  .grok-plugin/plugin.json \
  .codex-plugin/plugin.json \
  gemini-extension.json \
  README.md \
  LICENSE
do
  if [[ -f "$f" ]]; then ok "$f"; else fail "missing $f"; fi
done

# Skills
for skill in intellihelper-ui liquid-glass add-component compose-ui; do
  if [[ -f "skills/$skill/SKILL.md" ]]; then
    ok "skills/$skill/SKILL.md"
    # frontmatter name check
    if head -n 20 "skills/$skill/SKILL.md" | grep -q "^name: $skill"; then
      ok "skills/$skill name frontmatter"
    else
      fail "skills/$skill SKILL.md missing name: $skill"
    fi
  else
    fail "missing skills/$skill/SKILL.md"
  fi
done

# Commands
for cmd in add search list audit themes; do
  if [[ -f "commands/$cmd.md" ]]; then ok "commands/$cmd.md"; else fail "missing commands/$cmd.md"; fi
done

# Agent
if [[ -f agents/ui-builder.md ]]; then ok "agents/ui-builder.md"; else fail "missing agents/ui-builder.md"; fi

# MCP points at official CLI
if grep -q '@intellihelper/cli@latest' .mcp.json && grep -q '"mcp"' .mcp.json; then
  ok ".mcp.json targets @intellihelper/cli mcp"
else
  fail ".mcp.json must invoke @intellihelper/cli@latest mcp"
fi

# JSON syntax (python is widely available)
if command -v python3 >/dev/null 2>&1; then
  for j in .mcp.json .claude-plugin/plugin.json .claude-plugin/marketplace.json \
           .grok-plugin/plugin.json .grok-plugin/marketplace.json \
           .codex-plugin/plugin.json gemini-extension.json; do
    if python3 -c "import json; json.load(open('$j'))" 2>/dev/null; then
      ok "json $j"
    else
      fail "invalid json $j"
    fi
  done
fi

# Optional external validators
if command -v grok >/dev/null 2>&1; then
  if grok plugin validate . >/dev/null 2>&1; then
    ok "grok plugin validate"
  else
    # still surface output
    if grok plugin validate .; then ok "grok plugin validate"; else fail "grok plugin validate failed"; fi
  fi
else
  ok "grok CLI not installed (skipped)"
fi

if command -v claude >/dev/null 2>&1; then
  if claude plugin validate . >/dev/null 2>&1; then
    ok "claude plugin validate"
  else
    if claude plugin validate .; then ok "claude plugin validate"; else fail "claude plugin validate failed (or unsupported)"; fi
  fi
else
  ok "claude CLI not installed (skipped)"
fi

echo
if [[ "$ERR" -ne 0 ]]; then
  echo "Validation FAILED"
  exit 1
fi
echo "Validation PASSED"
