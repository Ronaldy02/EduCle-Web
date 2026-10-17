#!/bin/bash
# Publie une migration SQL sur EduCle-Web (branche main) puis la lance via le workflow GitHub db-migration.yml.
# usage : run_sql.sh <fichier.sql> <simulation|appliquer> "<message de commit>"
#   simulation = la transaction finit par ROLLBACK (rien n'est écrit) ; appliquer = COMMIT.
# Ne fait jamais de checkout dans le dossier web partagé : passe par un worktree temporaire sur origin/main.
set -e
REPO="${EDUCLE_WEB_REPO:-C:/Users/frona/OneDrive/Documents/Coding Club/Projet Quiz Educatif/quiz-educatif/version-web-personnel}"
WT="$(mktemp -d)/wt_main"
F="$1"; MODE="$2"; MSG="$3"; B=$(basename "$F")
git -C "$REPO" fetch -q origin main
git -C "$REPO" worktree add -q -B tmp-sql "$WT" origin/main
cp "$F" "$WT/scripts/migrations/$B"
if ! git -C "$WT" ls-files --error-unmatch "scripts/migrations/$B" >/dev/null 2>&1 || ! git -C "$WT" diff --quiet origin/main -- "scripts/migrations/$B"; then
  git -C "$WT" add "scripts/migrations/$B"
  git -C "$WT" commit -q -m "$MSG

Co-Authored-By: Claude <noreply@anthropic.com>"
  git -C "$WT" push -q origin HEAD:main
fi
git -C "$REPO" worktree remove --force "$WT"; git -C "$REPO" branch -D -q tmp-sql
cd "$REPO"
gh workflow run db-migration.yml --ref main -f fichier="$B" -f mode="$MODE" >/dev/null
sleep 8
ID=$(gh run list --workflow=db-migration.yml --limit 1 --json databaseId -q '.[0].databaseId')
gh run watch $ID --exit-status >/dev/null 2>&1 || true
echo "run $ID : $(gh run view $ID --json conclusion -q .conclusion)"
gh run view $ID --log | sed 's/^[^\t]*\t[^\t]*\t[^ ]* //' | awk '/^BEGIN/{p=1} p{print} /^(COMMIT|ROLLBACK)$/{exit} /ERROR/{e=1} e&&/##\[error\]/{exit}' | grep -v "^INSERT\|^CREATE\|^\s*$"
