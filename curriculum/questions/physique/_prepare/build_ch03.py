import sys, os
REPO = r"C:/Users/frona/OneDrive/Documents/Coding Club/Projet Quiz Educatif/Mobile/.claude/worktrees/stoic-noether-12a8aa"
S = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, REPO + "/scripts/questions")
from chapitre import Chapitre

c = Chapitre("PN1_03", "Physique", "NS1 ch.3 (Gravitation universelle, poids et masse)", base_dart=S + "/dh_old.dart")
B1 = "Programme B1"

c.groupe("La gravitation universelle")
c.new(1, "M", "Force attractive qui s'exerce entre tous les corps qui ont une masse", ["La gravitation", "La pesanteur", "La flottaison", "Le magnétisme"], "Elle maintient la Lune autour de la Terre et les planètes autour du Soleil.", "Larousse : gravitation", "D")
c.new(2, "F", "Qui a énoncé la loi de la gravitation universelle ?", ["Isaac Newton", "Galilée", "Albert Einstein", "Johannes Kepler"], "Il l'a publiée en 1687 dans son ouvrage Principia.", B1 + " ; Larousse : gravitation", "C")
c.new(3, "M", "De quoi dépend la force de gravitation entre deux corps ?", ["Leurs masses et leur distance", "Leur volume seulement", "Leur couleur et leur forme", "Leur température et leur vitesse"], "Elle augmente avec les masses et diminue quand la distance augmente.", B1 + " ; Larousse : gravitation", "C")
c.new(4, "D", "Quand la distance entre deux corps double, que devient la force de gravitation entre eux ?", ["Elle est divisée par quatre", "Elle est divisée par deux", "Elle double", "Elle reste la même"], "Elle varie comme l'inverse du carré de la distance : F = G·m·m′ / d².", B1 + " ; Larousse : gravitation", "C")
c.new(5, "M", "Quelle est l'expression de la loi de la gravitation universelle ?", ["F = G·m·m′/d²", "F = G·m·m′·d²", "F = G·(m+m′)/d", "F = m·g"], "G est la constante de gravitation, égale à 6,67 × 10⁻¹¹ N·m²/kg².", B1 + " ; Larousse : gravitation", "C")
c.new(6, "F", "La force de gravitation entre deux corps est-elle attractive ou répulsive ?", ["Toujours attractive", "Toujours répulsive", "Parfois répulsive", "Nulle dans le vide"], "Deux corps s'attirent mutuellement avec des forces de même valeur, même si l'un est bien plus massif que l'autre.", B1, "C")

c.groupe("Le poids")
c.new(11, "F", "Force d'attraction exercée par la Terre, ou un autre astre, sur un corps proche de sa surface", ["Le poids", "La masse", "La pression", "La densité"], "Il se mesure avec un dynamomètre et s'exprime en newtons.", "Larousse : poids (sens 2, précisé en physique) ; " + B1, "D")
c.new(12, "F", "Appareil destiné à la mesure d'une force", ["Un dynamomètre", "Un baromètre", "Un ampèremètre", "Un thermomètre"], "À l'intérieur, un ressort s'allonge proportionnellement à la force appliquée.", "Larousse : dynamomètre", "D")
c.new(13, "F", "Quelle est la nature du poids d'un corps ?", ["Une force", "Une quantité de matière", "Une énergie", "Une vitesse"], "C'est pourquoi le poids s'exprime en newtons et se représente par une flèche, un vecteur.", B1, "C")
c.new(14, "F", "Dans quelle unité exprime-t-on le poids d'un corps ?", ["Le newton", "Le kilogramme", "Le gramme", "Le joule"], "Le newton (N) est l'unité SI de force : 1 N est le poids d'une masse d'environ 100 g sur Terre.", "Larousse : newton", "C")
c.new(15, "M", "Quelle est la direction du poids d'un corps ?", ["La verticale, vers le bas", "L'horizontale, vers l'avant", "La verticale, vers le haut", "La direction du Soleil"], "Il s'applique au centre de gravité du corps et pointe vers le centre de la Terre.", B1, "C")
c.new(16, "F", "Quelle est la formule du poids d'un corps ?", ["P = m × g", "P = m / g", "P = m + g", "P = g / m"], "P est en newtons, m en kilogrammes et g en newtons par kilogramme.", B1, "C")
c.base(1214, en="Quel est le poids d'un objet de masse 5 kg sur Terre (g = 10 N/kg) ?", ch=["50 N", "5 N", "500 N", "0,5 N"], ex="P = m × g = 5 × 10 = 50 N.", src="Base Q1214 (modifiée)", typ="C")
c.base(1235, en="Quelle est la valeur de g à la surface de la Terre ?", ch=["Environ 9,8 N/kg", "Environ 1,6 N/kg", "Environ 98 N/kg", "Environ 0,98 N/kg"], ex="En calcul scolaire, on prend souvent g = 10 N/kg.", src="Base Q1235 (modifiée)", typ="C")
c.new(19, "M", "État dans lequel les effets de la pesanteur sont annulés, comme à bord d'une station spatiale en orbite", ["L'apesanteur", "L'inertie", "La gravitation", "La flottaison"], "Les astronautes flottent parce qu'ils tombent en permanence avec la station, pas parce que la gravité y est nulle.", "Larousse : apesanteur", "D")

c.groupe("Masse et poids : les différences")
c.base(1218, en="Laquelle de ces propriétés distingue la masse du poids ?", ch=["Masse fixe, poids variable", "Masse variable, poids fixe", "Les deux varient avec le lieu", "Les deux restent fixes"], ex="La masse, en kilogrammes, ne change pas ; le poids, en newtons, dépend de la gravité du lieu : un objet est plus léger sur la Lune.", src="Base Q1218 (modifiée)", typ="C")
c.base(1226, en="Un astronaute pèse 80 N sur Terre. Quel est son poids sur la Lune (g = 1,6 N/kg) ?", ch=["Environ 13 N", "80 N", "0 N", "160 N"], ex="Sa masse est m = 80 / 10 = 8 kg ; sur la Lune, P = 8 × 1,6 ≈ 13 N.", src="Base Q1226 (modifiée)", typ="C")

c.groupe("Le mouvement des planètes et des satellites")
c.new(31, "M", "Quelle force fait tomber une pomme et retient la Lune en orbite ?", ["La gravitation terrestre", "La force magnétique", "La poussée d'Archimède", "La force de frottement"], "C'est la même force : la Lune « tombe » sans cesse vers la Terre sans jamais l'atteindre, car elle avance aussi sur le côté.", B1 + " ; Alt. ch.1.2", "C")
c.new(32, "M", "Quelle est la forme de l'orbite d'une planète autour du Soleil ?", ["Une ellipse", "Une parabole", "Une droite", "Un carré"], "C'est la première loi de Kepler ; l'orbite de la Terre est presque un cercle.", "Alt. ch.1.2.2", "C")
c.new(33, "F", "En combien de temps la Terre fait-elle un tour complet autour du Soleil ?", ["365 jours environ", "24 heures", "30 jours", "12 ans"], "C'est sa période de révolution : une année.", "Alt. ch.1.2.2", "C")
c.new(34, "F", "Quel mouvement de la Terre produit l'alternance du jour et de la nuit ?", ["Sa rotation sur elle-même", "Sa révolution autour du Soleil", "Sa translation vers la Lune", "L'inclinaison de la Lune"], "Un tour complet sur elle-même dure environ 24 heures.", "Alt. ch.1.2.2", "C")
c.new(35, "M", "Combien de temps la Lune met-elle pour faire le tour de la Terre ?", ["Environ 27 jours", "Environ 7 jours", "Environ 365 jours", "Environ 24 heures"], "Les phases de la Lune reviennent tous les 29,5 jours, car la Terre a elle aussi avancé autour du Soleil.", "Alt. ch.1.2.3", "C")
c.new(36, "M", "Que fait un satellite géostationnaire, vu depuis la Terre ?", ["Il reste au-dessus du même point", "Il se déplace très vite", "Il tombe vers la Terre", "Il tourne autour de la Lune"], "Situé à environ 36 000 km d'altitude, il tourne avec la Terre en 24 heures ; il sert aux télécommunications et à la météorologie.", "Alt. ch.1.2.3", "C")

c.groupe("Gravitation : compléments")
c.new(41, "F", "Quel fruit, selon la légende, a fait réfléchir Newton à la gravitation ?", ["La pomme", "La mangue", "La banane", "L'orange"], "Voir tomber un fruit l'aurait conduit à relier la chute des corps sur Terre au mouvement de la Lune.", "Larousse : gravitation ; " + B1, "C")
c.new(42, "F", "La gravitation agit-elle à distance ou au contact ?", ["À distance", "Au contact seulement", "Seulement dans l'air", "Seulement sur Terre"], "Elle agit même à travers le vide de l'espace : c'est une action à distance, comme la force magnétique.", B1 + " (action à distance)", "C")
c.new(43, "D", "Si la masse d'un des deux corps double, que devient la force de gravitation entre eux ?", ["Elle double", "Elle est divisée par deux", "Elle reste la même", "Elle est multipliée par quatre"], "La force est proportionnelle à chacune des masses : F = G·m·m′/d².", B1, "C")
c.new(44, "M", "Quel phénomène sur Terre est provoqué surtout par l'attraction de la Lune ?", ["Les marées", "Les séismes", "Les cyclones", "Les éclipses"], "L'attraction de la Lune, et dans une moindre mesure du Soleil, soulève les océans deux fois par jour.", "Alt. ch.1.2.3", "C")
c.new(45, "M", "Quel savant du XVIIᵉ siècle a établi les lois du mouvement des planètes autour du Soleil ?", ["Johannes Kepler", "Nicolas Copernic", "Galilée", "Isaac Newton"], "Ses trois lois décrivent des orbites en ellipse ; Newton les a expliquées ensuite par la gravitation.", "Alt. ch.1.2.2", "C")

c.groupe("Poids et masse : compléments")
c.new(51, "M", "Comment appelle-t-on la grandeur g, exprimée en N/kg ?", ["L'intensité de la pesanteur", "La constante de gravitation", "La masse volumique", "L'accélération électrique"], "Elle indique le poids d'un kilogramme : 9,8 N/kg sur Terre.", B1, "C")
c.new(52, "M", "Comment appelle-t-on le point d'application du poids d'un corps ?", ["Son centre de gravité", "Son sommet", "Sa base", "Sa surface"], "Pour un objet homogène et symétrique, il se confond avec son centre géométrique.", B1, "C")
c.base(1238, en="Où se trouve le centre de gravité d'une sphère homogène ?", ch=["En son centre", "À sa surface", "À sa base", "Au sommet"], ex="Pour un objet homogène et symétrique (sphère, cube), le centre de gravité coïncide avec le centre géométrique.", src="Base Q1238 (modifiée)", typ="C")
c.new(54, "F", "Quel est à peu près le poids d'une masse de 100 g sur Terre ?", ["Environ 1 N", "Environ 10 N", "Environ 0,1 N", "Environ 100 N"], "P = 0,1 kg × 10 N/kg = 1 N ; c'est pourquoi 1 N correspond à peu près au poids d'une tablette de chocolat.", B1, "C")
c.new(55, "M", "Quelle est la masse d'un objet dont le poids est de 300 N (g = 10 N/kg) ?", ["30 kg", "3 kg", "300 kg", "3 000 kg"], "m = P / g = 300 / 10 = 30 kg.", B1 + " (calcul court)", "C")
c.new(56, "M", "Sur lequel de ces astres un même objet pèse-t-il le plus ?", ["Jupiter", "La Terre", "La Lune", "Mars"], "La pesanteur à la surface de Jupiter vaut environ 25 N/kg, contre 9,8 sur Terre, 3,7 sur Mars et 1,6 sur la Lune.", B1, "C")
c.new(57, "M", "Quelle fraction de son poids terrestre un objet pèse-t-il sur la Lune ?", ["Environ un sixième", "Environ un tiers", "Environ la moitié", "Le double"], "Sa masse n'a pas changé, mais la pesanteur lunaire est environ six fois plus faible.", B1, "C")

os.makedirs(S + "/out", exist_ok=True)
os.chdir(S + "/out")
c.ecrire("ns1_ch03")
