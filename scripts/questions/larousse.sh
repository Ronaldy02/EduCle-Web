#!/bin/bash
# Télécharge les articles du Larousse en ligne et affiche leurs définitions.
# usage : larousse.sh <dossier_vide> mot1 "mot composé" mot3 …
# (-L obligatoire : larousse.fr répond par une redirection 301 ; le navigateur intégré est bloqué sur ce site)
set -e
OUT="$1"; shift; mkdir -p "$OUT"
for w in "$@"; do
  curl -s -L -m 25 -A "Mozilla/5.0" "https://www.larousse.fr/dictionnaires/francais/$(python -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$w")" -o "$OUT/n_$w.html"
done
cd "$OUT" && PYTHONIOENCODING=utf-8 python -I "$(dirname "$(readlink -f "$0")")/larousse_ext.py"
