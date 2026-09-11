#!/usr/bin/env bash
# Copia le skill di questo repo dentro Claude Code.
# Da rilanciare ogni volta che fai "git pull".
set -euo pipefail

QUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"

for skill in "$QUI"/*/; do
  nome="$(basename "$skill")"
  [ -f "$skill/SKILL.md" ] || continue
  rm -rf "$DEST/$nome"
  cp -R "$skill" "$DEST/$nome"
  echo "installata: $nome"
done

echo
echo "Fatto. Riavvia Claude Code e scrivi /bizstudio-proposta per usarla."
