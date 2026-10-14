#!/usr/bin/env bash
# Deploys this profile README to github.com/Wyhrdev123100/Wyhrdev123100
set -euo pipefail

REPO="https://github.com/Wyhrdev123100/Wyhrdev123100.git"
WORK="$(mktemp -d)"
SRC="$(cd "$(dirname "$0")" && pwd)"

echo "→ cloning ${REPO}"
git clone --quiet "${REPO}" "${WORK}"
cd "${WORK}"

# 1. README must be exactly README.md  (the old lowercase readme.md shadowed it)
rm -f readme.md
cp "${SRC}/readme.md" README.md

# 2. artwork + screenshots + workflow
rm -rf assets .github
cp -R "${SRC}/assets" .
mkdir -p .github/workflows
cp "${SRC}/.github/workflows/snake.yml" .github/workflows/

git add -A
git commit -q -m "profile readme: terminal theme, glitch wordmark, certificates wall" || echo "nothing to commit"
git push -q origin main

echo "✓ pushed. Now open:"
echo "  https://github.com/Wyhrdev123100/Wyhrdev123100/actions"
echo "  → run 'Generate contribution snake' once so ~/contributions.log has images."
rm -rf "${WORK}"
