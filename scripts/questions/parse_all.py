"""Parse tous les _QSeed d'un database_helper.dart -> liste de dicts."""
import json, sys

BS = chr(92)

def tokens(s):
    toks = []; i = 0; n = len(s)
    while i < n:
        if s.startswith("_ChapitreSeed(", i): toks.append(("CH", None)); i += 14; continue
        if s.startswith("_QSeed(", i): toks.append(("Q", None)); i += 7; continue
        if s.startswith("ajouterMatiere(", i): toks.append(("MAT", None)); i += 15; continue
        if s.startswith("//", i):
            j = s.find("\n", i); i = n if j < 0 else j; continue
        c = s[i]
        if c == "'":
            j = i + 1; buf = []
            while s[j] != "'":
                if s[j] == BS: buf.append(s[j + 1]); j += 2
                else: buf.append(s[j]); j += 1
            toks.append(("S", "".join(buf))); i = j + 1; continue
        if c == '"':
            j = i + 1; buf = []
            while s[j] != '"':
                if s[j] == BS: buf.append(s[j + 1]); j += 2
                else: buf.append(s[j]); j += 1
            toks.append(("S", "".join(buf))); i = j + 1; continue
        if c in "[]": toks.append((c, None))
        i += 1
    return toks

def parse(path):
    s = open(path, encoding="utf-8").read()
    start = s.find("ajouterMatiere(")
    toks = tokens(s[start:])
    out = []; mat = niv = ch = None; k = 0; qi = 0
    while k < len(toks):
        t = toks[k][0]
        if t == "MAT":
            niv, mat = toks[k + 1][1], toks[k + 2][1]; k += 3; continue
        if t == "CH":
            ch = toks[k + 1][1]; qi = 0; k += 2; continue
        if t == "Q":
            en = toks[k + 1][1]
            if toks[k + 2][0] != "[": k += 1; continue
            m = k + 3; choix = []
            while toks[m][0] != "]": choix.append(toks[m][1]); m += 1
            bonne, expl, diff = toks[m + 1][1], toks[m + 2][1], toks[m + 3][1]
            out.append(dict(matiere=mat, niveau=niv, chapitre=ch, idx=qi, enonce=en, choix=choix,
                            bonne=bonne, expl=expl, diff=diff))
            qi += 1; k = m + 4; continue
        k += 1
    return out

if __name__ == "__main__":
    a = parse(sys.argv[1]); b = parse(sys.argv[2])
    print(len(a), len(b))
    json.dump({"avant": a, "apres": b}, open(sys.argv[3], "w", encoding="utf-8"), ensure_ascii=False)
