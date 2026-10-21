import sys, os
REPO = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", ".."))
sys.path.insert(0, REPO + "/scripts/questions")
from chapitre import Chapitre

c = Chapitre("PN1_02", "Physique", "NS1 ch.2 supplément (Big Bang, système solaire et exploration de l'espace)")
PR = "Programme A1"
AL = "Alt. ch.1"

c.groupe("Histoire de l'astronomie")
c.new(71, "M", "Quelle science étudie les astres et l'Univers ?", ["L'astronomie", "L'astrologie", "La géologie", "La météorologie"], "L'astrologie, elle, prétend lire l'avenir dans le ciel : ce n'est pas une science.", PR, "C")
c.new(72, "M", "Quelle théorie plaçait la Terre au centre de l'Univers ?", ["Le géocentrisme", "L'héliocentrisme", "Le Big Bang", "La nucléosynthèse"], "Elle remonte à Ptolémée, au IIᵉ siècle, et a dominé jusqu'à la Renaissance.", PR, "C")
c.new(73, "M", "Quel savant polonais a placé le Soleil au centre du système planétaire, en 1543 ?", ["Nicolas Copernic", "Galilée", "Johannes Kepler", "Ptolémée"], "Son modèle, l'héliocentrisme, fait tourner la Terre et les autres planètes autour du Soleil.", PR, "C")
c.new(74, "M", "Qui a observé les quatre grands satellites de Jupiter avec une lunette, en 1610 ?", ["Galilée", "Copernic", "Isaac Newton", "Johannes Kepler"], "Cette découverte a montré que tous les astres ne tournent pas autour de la Terre.", PR, "C")
c.new(75, "M", "Quel instrument capte les ondes radio venues de l'espace ?", ["Un radiotélescope", "Un microscope", "Un sismographe", "Un baromètre"], "Sa grande antenne parabolique collecte les ondes émises par les étoiles et les galaxies.", PR, "C")

c.groupe("Big Bang et étoiles")
c.new(81, "D", "Comment appelle-t-on le plus ancien rayonnement observable de l'Univers, émis environ 380 000 ans après le Big Bang ?", ["Le fond diffus cosmologique", "Le rayonnement solaire", "Le vent stellaire", "Le fond sonore céleste"], "Découvert en 1964, c'est une preuve majeure du Big Bang.", PR + " (pas de définition au Larousse en ligne)", "C")
c.new(82, "F", "Quel gaz constitue l'essentiel de la matière du Soleil ?", ["L'hydrogène", "L'oxygène", "Le carbone", "L'azote"], "Le Soleil contient environ 73 % d'hydrogène et 25 % d'hélium.", PR, "C")
c.new(83, "M", "Quelle réaction produit l'énergie du Soleil ?", ["La fusion de l'hydrogène", "La fission de l'uranium", "La combustion de l'oxygène", "La décomposition de l'eau"], "Au cœur, à 15 millions de degrés, les noyaux d'hydrogène fusionnent en noyaux d'hélium.", PR, "C")
c.new(84, "M", "Quelle est la température approximative de la surface du Soleil ?", ["Environ 5 500 °C", "Environ 500 °C", "Environ 55 000 °C", "Environ 1 000 000 °C"], "Le cœur du Soleil est bien plus chaud que sa surface.", PR, "C")
c.new(85, "M", "Quelle est la couleur d'une étoile très chaude ?", ["Bleue", "Rouge", "Verte", "Jaune"], "Le Soleil, d'une température moyenne, est jaune ; les étoiles les plus froides sont rouges.", PR, "C")
c.new(86, "F", "Comment appelle-t-on un groupe d'étoiles qui dessine une figure dans le ciel ?", ["Une constellation", "Une galaxie", "Une nébuleuse", "Une orbite"], "La Grande Ourse et Orion sont des constellations connues ; les étoiles d'une constellation ne sont pas forcément proches.", PR, "C")
c.new(87, "M", "Quelle étoile indique à peu près le nord dans l'hémisphère nord ?", ["L'étoile Polaire", "Sirius", "Proxima du Centaure", "Bételgeuse"], "Elle est presque alignée avec l'axe de rotation de la Terre : elle ne bouge presque pas dans le ciel de la nuit.", PR, "C")
c.new(88, "M", "Quelle est l'étoile la plus brillante du ciel nocturne ?", ["Sirius", "L'étoile Polaire", "Proxima du Centaure", "Antarès"], "Elle se trouve à 8,6 années-lumière de la Terre.", PR, "C")
c.new(89, "M", "Comment appelle-t-on un astre dont la gravité est si forte que la lumière ne peut pas s'en échapper ?", ["Un trou noir", "Une supernova", "Une nébuleuse", "Une naine blanche"], "Il peut se former quand une étoile très massive s'effondre à la fin de sa vie.", PR + " (pas de sens astronomique au Larousse en ligne)", "C")
c.new(90, "F", "Quelle forme a la Voie lactée vue de loin ?", ["Une spirale", "Une sphère", "Un cube", "Un cône"], "Notre système solaire se trouve sur l'un des bras de cette spirale, loin du centre.", AL + ".1.8", "C")

c.groupe("Les planètes")
c.new(101, "F", "Quelle planète vient juste après la Terre, en s'éloignant du Soleil ?", ["Mars", "Vénus", "Jupiter", "Mercure"], "Mars est la planète la plus proche de la Terre au-delà de son orbite.", AL + ".1.3", "C")
c.new(102, "F", "Quelle est la planète la plus éloignée du Soleil ?", ["Neptune", "Uranus", "Saturne", "Pluton"], "Pluton, aujourd'hui planète naine, orbite en moyenne plus loin que Neptune.", AL + ".1.3", "C")
c.new(103, "M", "Quelle est la planète la plus chaude du système solaire ?", ["Vénus", "Mercure", "Mars", "Jupiter"], "Son atmosphère épaisse de gaz carbonique provoque un énorme effet de serre : plus de 450 °C à sa surface.", AL + ".1.3", "C")
c.new(104, "M", "Quelle planète est surnommée l'étoile du Berger ?", ["Vénus", "Mars", "Jupiter", "Mercure"], "Très brillante au lever ou au coucher du Soleil, elle est facilement prise pour une étoile.", AL + ".1.3", "C")
c.new(105, "F", "Quelle planète est la plus connue pour ses anneaux ?", ["Saturne", "Mars", "Mercure", "Vénus"], "Ses anneaux, faits de glace et de roches, sont visibles avec un petit télescope.", AL + ".1.3", "C")
c.new(106, "M", "Quelle planète porte la Grande Tache rouge, une immense tempête ?", ["Jupiter", "Saturne", "Mars", "Neptune"], "Cette tempête dure depuis plusieurs siècles et est plus large que la Terre.", AL + ".1.3", "C")
c.new(107, "D", "Quelle planète tourne couchée sur le côté, son axe étant presque dans le plan de son orbite ?", ["Uranus", "Neptune", "Mars", "Vénus"], "Son axe est incliné d'environ 98°, si bien qu'elle roule presque comme une bille autour du Soleil.", AL + ".1.3", "C")
c.new(108, "F", "Quelle planète est surnommée la planète bleue ?", ["La Terre", "Mars", "Mercure", "Vénus"], "Les océans, qui couvrent environ 70 % de sa surface, lui donnent cette couleur vue de l'espace.", AL + ".1.3", "C")
c.new(109, "M", "Quelle sorte de planètes sont Jupiter et Saturne ?", ["Des planètes géantes gazeuses", "Des planètes telluriques", "Des planètes naines", "Des exoplanètes"], "Uranus et Neptune sont aussi des planètes géantes, riches en glaces.", PR + " ; " + AL + ".1.3", "C")
c.new(110, "D", "Comment s'appelle la région de petits corps glacés située au-delà de Neptune ?", ["La ceinture de Kuiper", "La ceinture d'astéroïdes", "La Voie lactée", "La zone habitable"], "Pluton en est le plus célèbre habitant.", PR, "C")

c.groupe("Satellites naturels")
c.new(121, "F", "Combien de satellites naturels la Terre possède-t-elle ?", ["Un", "Deux", "Aucun", "Trois"], "Il s'agit de la Lune, située à environ 384 000 km de la Terre.", AL + ".1.1.4", "C")
c.new(122, "M", "À quelle distance moyenne la Lune se trouve-t-elle de la Terre ?", ["Environ 384 000 km", "Environ 38 400 km", "Environ 3 840 000 km", "Environ 150 millions de km"], "La distance Terre-Soleil, 150 millions de km, est environ 400 fois plus grande.", AL + ".1.1.4", "C")
c.new(123, "D", "Quel est le plus grand satellite naturel du système solaire ?", ["Ganymède", "Titan", "La Lune", "Europe"], "Ganymède, satellite de Jupiter, est plus gros que la planète Mercure.", AL + ".1.1.4", "C")
c.new(124, "D", "Quels sont les deux satellites naturels de Mars ?", ["Phobos et Déimos", "Titan et Encelade", "Io et Europe", "Triton et Charon"], "Ce sont deux petits corps de forme irrégulière.", AL + ".1.1.4", "C")
c.new(125, "D", "Quel satellite naturel de Saturne possède une épaisse atmosphère ?", ["Titan", "Europe", "Io", "Triton"], "Il est plus gros que la planète Mercure et présente des lacs de méthane liquide.", AL + ".1.1.4", "C")

c.groupe("Exploration de l'espace")
c.new(131, "M", "Comment appelle-t-on un engin construit par l'homme et placé en orbite autour de la Terre ?", ["Un satellite artificiel", "Une sonde spatiale", "Un météore", "Une comète"], "Ils servent aux télécommunications, à la météorologie et à la navigation (GPS).", PR + " (pas de sens spatial au Larousse en ligne)", "C")
c.new(132, "F", "Quelle station spatiale est habitée en permanence en orbite autour de la Terre ?", ["La Station spatiale internationale", "Hubble", "Spoutnik", "Apollo"], "Elle orbite à environ 400 km d'altitude et fait le tour de la Terre en 90 minutes environ.", PR + " (exploration de l'espace)", "C")
c.new(133, "M", "Quel télescope spatial, lancé en 2021, observe l'Univers dans l'infrarouge ?", ["James Webb", "Hubble", "Spoutnik", "Kepler"], "Il observe les premières galaxies formées après le Big Bang.", PR + " (exploration de l'espace)", "C")
c.new(134, "M", "Quel animal a été le premier être vivant en orbite autour de la Terre, en 1957 ?", ["La chienne Laïka", "Le singe Ham", "Un chimpanzé", "Une souris"], "Elle a voyagé à bord de Spoutnik 2, un mois après Spoutnik 1.", PR + " (exploration de l'espace)", "C")
c.new(135, "D", "Qui a été la première femme dans l'espace, en 1963 ?", ["Valentina Terechkova", "Sally Ride", "Mae Jemison", "Svetlana Savitskaïa"], "Elle a fait 48 tours de la Terre à bord de Vostok 6.", PR + " (exploration de l'espace)", "C")
c.new(136, "D", "Quel robot mobile de la NASA s'est posé sur Mars en 2012 ?", ["Curiosity", "Voyager", "Hubble", "Spoutnik"], "Il étudie le sol de Mars pour savoir si la planète a pu abriter de la vie.", PR + " (exploration de l'espace)", "C")
c.new(137, "D", "Quelle sonde a survolé Pluton en 2015 ?", ["New Horizons", "Voyager 2", "Cassini", "Curiosity"], "Lancée en 2006, elle a envoyé les premières images détaillées de Pluton.", PR + " (exploration de l'espace)", "C")

here = os.path.dirname(os.path.abspath(__file__))
os.chdir(here)
c.ecrire("ns1_ch02b")
