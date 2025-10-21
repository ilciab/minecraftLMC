#!/usr/bin/env bash
set -euo pipefail

REPO="git@github.com:ilciab/minecraftLMC.git"

if [ -d .git ]; then
  git fetch origin
  git reset --hard origin/main
else
  git clone "$REPO" .
fi

./start.sh

git add -A
TS=$(date -u +"%Y-%m-%d_%H-%M-%S_UTC")
git commit -m "auto save $TS" || true
git pull --rebase origin main || true
git push origin main || true
