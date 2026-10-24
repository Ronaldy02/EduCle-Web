"""Outils pour préparer un chapitre de questions : construction, widget de validation, enregistrement.

Construction (dans un script build_<chapitre>.py) :
    from chapitre import Chapitre
    c = Chapitre("B19", "Biologie", "NS3 ch.1 (Les muscles)", base_dart="dh_corrige.dart")
    c.groupe("Les types de muscles")
    c.new(1, "F", "Définition…", ["Bonne", "Faux 1", "Faux 2", "Faux 3"], "Explication.", "Larousse : mot", "D")
    c.base(1573, en="Nouvel énoncé ?", ch=[...], ex="…", typ="D")   # question déjà en base, réécrite
    c.ecrire("chNN")          # -> chNN_Q.json + chNN_widget.html (à afficher avec show_widget)

Enregistrement après validation :
    python chapitre.py enregistrer chNN_Q.json sortie.json --matiere-id 11 --matiere Biologie \
        --chapitre "Titre exact dans la table chapitres" --niveaux NS3 --unite 3.1 \
        --rejetees "B19-04,Q1600" [--ns3 auto]

Le premier élément de « choix » est toujours la bonne réponse ; l'application mélange l'ordre.
Type « D » = définition (énoncé = définition, réponse = terme), « C » = connaissance.
"""
import argparse, datetime, json, os, sys

ICI = os.path.dirname(os.path.abspath(__file__))
D = {"Facile": "F", "Moyen": "M", "Difficile": "D"}
LBL = {"F": "Facile", "M": "Moyen", "D": "Difficile"}


class Chapitre:
    def __init__(self, prefixe, matiere, titre_widget, base_dart=None):
        self.p, self.matiere, self.titre = prefixe, matiere, titre_widget
        self.G = []
        self.q = None
        if base_dart:
            sys.path.insert(0, ICI)
            from parse_all import parse
            self.q = parse(base_dart)

    def groupe(self, nom):
        self.G.append(["g", nom])

    def new(self, i, d, en, ch, ex, src, typ):
        self.G.append(["%s-%02d" % (self.p, i), d, en, ch, ex, src, typ, None])

    def base(self, n, en=None, ch=None, ex=None, src=None, typ="C"):
        x = self.q[n]
        choix = ch or [x["bonne"]] + [c for c in x["choix"] if c != x["bonne"]]
        modif = en or ch or ex
        self.G.append(["Q%04d" % n, D[x["diff"]], en or x["enonce"], choix, ex or x["expl"],
                       src or ("Base Q%04d" % n) + (" (modifiée)" if modif else ""), typ, x["enonce"]])

    def verifier(self):
        n = [x for x in self.G if x[0] != "g"]
        ids = [x[0] for x in n]
        assert len(ids) == len(set(ids)), "identifiants en double"
        for x in n:
            assert len(x[3]) == 4 and len(set(x[3])) == 4, x[0] + " : il faut 4 choix différents"
            assert all(len(c.split()) <= 6 for c in x[3]), x[0] + " : réponse de plus de 6 mots"
            if x[6] == "C":
                assert x[2].rstrip().endswith("?"), x[0] + " : une question de connaissance finit par « ? »"
        return n

    def ecrire(self, base_nom, widget=False):
        """Écrit base_nom_Q.json (brouillon à ouvrir dans le Studio). widget=True produit en plus l'ancien widget de chat (coûteux : à éviter)."""
        n = self.verifier()
        json.dump(self.G, open(base_nom + "_Q.json", "w", encoding="utf-8"), ensure_ascii=False)
        if not widget:
            print(len(n), "questions dont", sum(1 for x in n if x[0].startswith("Q")), "déjà en base ->", base_nom + "_Q.json (à ouvrir dans scripts/questions/studio/index.html)")
            return
        t = open(os.path.join(ICI, "widget_template.html"), encoding="utf-8").read()
        q = "[\n" + ",\n".join(json.dumps(x[:7], ensure_ascii=False) for x in self.G) + "\n]"
        t = t.replace("const Q=__Q__;", "const Q=" + q + ";")
        t = t.replace("__PREFIXE__", "Validation %s %s" % (self.matiere, self.titre))
        t = t.replace("__TITRE__", "%s %s" % (self.matiere, self.titre))
        open(base_nom + "_widget.html", "w", encoding="utf-8").write(t)
        print(len(n), "questions dont", sum(1 for x in n if x[0].startswith("Q")), "déjà en base")


def enregistrer(a):
    G = json.load(open(a.q_json, encoding="utf-8"))
    rej = [r for r in (a.rejetees or "").split(",") if r]
    mods = json.load(open(a.modifs, encoding="utf-8")) if a.modifs else {}
    par_groupe, cur = {}, ""
    for x in G:
        if x[0] == "g": cur = x[1]
        elif a.niveau_par_groupe and cur.split(" ")[0] in a.niveaux: par_groupe[x[0]] = cur.split(" ")[0]
    niv = par_groupe
    out = []
    for x in G:
        if x[0] == "g" or x[0] in rej: continue
        e = dict(id=x[0], enonce=x[2], choix=x[3], bonne_reponse=x[3][0], explication=x[4],
                 niveau_complexite=LBL[x[1]], source=x[5])
        if x[0] in niv: e["niveau"] = niv[x[0]]
        if x[0].startswith("Q"): e["ancien_enonce"] = x[7]
        if x[0] in mods:  # {"id": {"enonce":…, "choix":[…], "explication":…, "niveau_complexite":"F|M|D", "source":…}}
            m = mods[x[0]]
            e.update({k: v for k, v in m.items() if k != "niveau_complexite"})
            if "niveau_complexite" in m: e["niveau_complexite"] = LBL[m["niveau_complexite"]]
            e["bonne_reponse"] = e["choix"][0]
            e["statut"] = "à revalider"
        out.append(e)
    doc = dict(matiere_id=a.matiere_id, matiere=a.matiere, chapitre=a.chapitre, niveaux=a.niveaux,
               unite_programme=a.unite, statut="validé par l'utilisateur " + datetime.date.today().isoformat(),
               rejetees=rej, base_rejetees_a_supprimer=[dict(id=x[0], enonce=x[7]) for x in G if x[0] in rej and x[0].startswith("Q")],
               questions=out)
    json.dump(doc, open(a.sortie, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
    print(len(out), "questions enregistrées,", sum(1 for e in out if e.get("statut")), "à revalider")


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    sp = ap.add_subparsers(dest="cmd", required=True)
    e = sp.add_parser("enregistrer")
    e.add_argument("q_json"); e.add_argument("sortie")
    e.add_argument("--matiere-id", type=int, required=True); e.add_argument("--matiere", required=True)
    e.add_argument("--chapitre", required=True, help="titre exact de la ligne dans la table chapitres")
    e.add_argument("--niveaux", nargs="+", required=True); e.add_argument("--unite", default="")
    e.add_argument("--rejetees", default=""); e.add_argument("--modifs", help="JSON des questions « À modifier » réécrites")
    e.add_argument("--niveau-par-groupe", action="store_true",
                   help="chapitre multi-niveaux : le niveau de chaque question est le 1er mot de son groupe (ex. « NS3 — … »)")
    enregistrer(ap.parse_args())
