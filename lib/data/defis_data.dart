// Données canoniques des défis — générées depuis defis.json
// Ne pas modifier manuellement.
const List<Map<String, dynamic>> kDefisData = [
  // ── Quotidiens palier 1 ───────────────────────────────────────────────────
  {'id':'D01','type':'d','palier':1,'nom':'🌅 Réveil du cerveau','description':'Réponds à 5 questions avant midi.','metrique':'ans','cible':5,'filtres':'{"h":12}'},
  {'id':'D02','type':'d','palier':1,'nom':'🎯 Dans le mille','description':'Réussis 3 réponses d\'affilée.','metrique':'strk','cible':3},
  {'id':'D03','type':'d','palier':1,'nom':'📖 Lecteur curieux','description':'Lis 1 carte mentale en entier.','metrique':'card','cible':1},
  {'id':'D04','type':'d','palier':1,'nom':'🔍 Détective','description':'Lis l\'explication de 3 réponses en mode Révision.','metrique':'expl','cible':3,'filtres':'{"md":"rev"}'},
  {'id':'D05','type':'d','palier':1,'nom':'🧪 Petit explorateur','description':'Joue dans une matière délaissée depuis 7 jours.','metrique':'game','cible':1,'filtres':'{"sj":"stale7"}'},
  {'id':'D06','type':'d','palier':1,'nom':'🏃 Échauffement','description':'Réponds à 5 questions en mode Rush.','metrique':'ans','cible':5,'filtres':'{"md":"rush"}'},
  {'id':'D07','type':'d','palier':1,'nom':'🌙 Question du soir','description':'Réponds à 5 questions après 18 h.','metrique':'ans','cible':5,'filtres':'{"ha":18}'},
  {'id':'D08','type':'d','palier':1,'nom':'✨ Trois pour un','description':'Obtiens 3 bonnes réponses.','metrique':'ok','cible':3},
  {'id':'D09','type':'d','palier':1,'nom':'🌐 Curieux de tout','description':'Joue 1 partie en mode Tout.','metrique':'game','cible':1,'filtres':'{"sj":["tout"]}'},
  {'id':'D10','type':'d','palier':1,'nom':'🐢 Pas à pas','description':'Fais 1 partie de 5 questions en Révision.','metrique':'game','cible':1,'filtres':'{"md":"rev","n":5}'},
  {'id':'D11','type':'d','palier':1,'nom':'🥾 Mini-marathon','description':'Réponds à 8 questions.','metrique':'ans','cible':8},
  {'id':'D12','type':'d','palier':1,'nom':'🤝 Coup de pouce','description':'Réussis 1 question que tu avais ratée.','metrique':'redo','cible':1},
  {'id':'D13','type':'d','palier':1,'nom':'🪙 Petit trésor','description':'Gagne 20 XP.','metrique':'xp','cible':20},
  {'id':'D14','type':'d','palier':1,'nom':'🐓 Premier de cordée','description':'Fais une partie avant 9 h.','metrique':'game','cible':1,'filtres':'{"h":9}'},
  // ── Quotidiens palier 2 ───────────────────────────────────────────────────
  {'id':'D15','type':'d','palier':2,'nom':'⚡ Éclair','description':'Termine un Rush de 10 questions avec au moins 6 bonnes réponses.','metrique':'sc','cible':1,'filtres':'{"md":"rush","n":10,"min":6}'},
  {'id':'D16','type':'d','palier':2,'nom':'🛠️ Réparateur','description':'Réussis 3 questions que tu avais ratées.','metrique':'redo','cible':3},
  {'id':'D17','type':'d','palier':2,'nom':'🌍 Globe-trotter','description':'Réponds à 10 questions dans 2 matières différentes.','metrique':'ans','cible':10,'filtres':'{"sjn":2}'},
  {'id':'D18','type':'d','palier':2,'nom':'🔥 Flamme vive','description':'Atteins une série de 8 bonnes réponses.','metrique':'strk','cible':8},
  {'id':'D19','type':'d','palier':2,'nom':'🧠 Étudiant malin','description':'Lis une carte mentale, puis joue un quiz sur le même chapitre.','metrique':'cardgame','cible':1},
  {'id':'D20','type':'d','palier':2,'nom':'🎓 Écolier du jour','description':'Réponds à 15 questions dans ta matière préférée.','metrique':'ans','cible':15,'filtres':'{"sj":"fav"}'},
  {'id':'D21','type':'d','palier':2,'nom':'🧗 Chapitre faible','description':'Joue une partie de 10 questions sur ton chapitre le moins maîtrisé.','metrique':'game','cible':1,'filtres':'{"ch":"weak","n":10}'},
  {'id':'D22','type':'d','palier':2,'nom':'🎲 Double jeu','description':'Termine 2 parties.','metrique':'game','cible':2},
  {'id':'D23','type':'d','palier':2,'nom':'🚀 Sprint','description':'Obtiens 8 bonnes réponses en mode Rush.','metrique':'ok','cible':8,'filtres':'{"md":"rush"}'},
  {'id':'D24','type':'d','palier':2,'nom':'📘 Pro de la Révision','description':'Obtiens 8/10 ou plus en Révision.','metrique':'sc','cible':1,'filtres':'{"md":"rev","n":10,"min":8}'},
  {'id':'D25','type':'d','palier':2,'nom':'🤹 Jongleur','description':'Joue dans 3 matières différentes.','metrique':'subj','cible':3},
  {'id':'D26','type':'d','palier':2,'nom':'🧭 Éclaireur','description':'Joue sur 3 chapitres différents.','metrique':'chap','cible':3},
  {'id':'D27','type':'d','palier':2,'nom':'📚 Bonne lecture','description':'Lis 2 cartes mentales.','metrique':'card','cible':2},
  {'id':'D28','type':'d','palier':2,'nom':'⏱️ Quart d\'heure savant','description':'Gagne 60 XP.','metrique':'xp','cible':60},
  // ── Quotidiens palier 3 ───────────────────────────────────────────────────
  {'id':'D29','type':'d','palier':3,'nom':'💣 Artificier','description':'Fais au moins 18 bonnes réponses sur 30 en Bombardement.','metrique':'sc','cible':1,'filtres':'{"md":"bomb","min":18}'},
  {'id':'D30','type':'d','palier':3,'nom':'🏔️ Sans filet','description':'Termine un Rush de 10 questions sans aucune erreur.','metrique':'perf','cible':1,'filtres':'{"md":"rush","n":10}'},
  {'id':'D31','type':'d','palier':3,'nom':'🎒 Sac à dos plein','description':'Réponds à 25 questions aujourd\'hui.','metrique':'ans','cible':25},
  {'id':'D32','type':'d','palier':3,'nom':'🏆 Retour en force','description':'Bats ton dernier score dans une même matière et un même mode.','metrique':'beat','cible':1},
  {'id':'D33','type':'d','palier':3,'nom':'🧩 Trio gagnant','description':'Joue un Rush, une Révision et un Bombardement.','metrique':'mode','cible':3},
  {'id':'D34','type':'d','palier':3,'nom':'🌟 Perfection du jour','description':'Obtiens 100 % sur 10 questions en Révision.','metrique':'perf','cible':1,'filtres':'{"md":"rev","n":10}'},
  {'id':'D35','type':'d','palier':3,'nom':'🎆 Tir groupé','description':'Atteins une série de 12 bonnes réponses.','metrique':'strk','cible':12},
  {'id':'D36','type':'d','palier':3,'nom':'🔧 Trois chantiers','description':'Joue 3 chapitres faibles différents.','metrique':'chap','cible':3,'filtres':'{"ch":"weak"}'},
  {'id':'D37','type':'d','palier':3,'nom':'💨 Vitesse lumière','description':'Donne 10 bonnes réponses en moins de 3 s en Rush.','metrique':'fast','cible':10},
  {'id':'D38','type':'d','palier':3,'nom':'🦉 Studieux','description':'Obtiens 20 bonnes réponses.','metrique':'ok','cible':20},
  {'id':'D39','type':'d','palier':3,'nom':'🏁 Dernier effort','description':'Gagne 100 XP.','metrique':'xp','cible':100},
  {'id':'D40','type':'d','palier':3,'nom':'🧨 Mèche courte','description':'Fais 15 bonnes réponses ou plus en Bombardement.','metrique':'sc','cible':1,'filtres':'{"md":"bomb","min":15}'},
  // ── Hebdomadaires ─────────────────────────────────────────────────────────
  {'id':'W01','type':'w','palier':1,'nom':'🗺️ Tour d\'Haïti','description':'Joue dans 4 matières différentes.','metrique':'subj','cible':4},
  {'id':'W02','type':'w','palier':1,'nom':'📈 Grimpeur','description':'Améliore de 5 points la maîtrise de chapitres faibles.','metrique':'mast','cible':5},
  {'id':'W03','type':'w','palier':1,'nom':'🕯️ Fidèle au rendez-vous','description':'Fais le défi du jour 5 jours sur 7.','metrique':'dd','cible':5},
  {'id':'W04','type':'w','palier':1,'nom':'🧱 Bâtisseur','description':'Réponds à 100 questions.','metrique':'ans','cible':100},
  {'id':'W05','type':'w','palier':1,'nom':'🔁 Seconde chance','description':'Réussis 10 questions ratées précédemment.','metrique':'redo','cible':10},
  {'id':'W06','type':'w','palier':1,'nom':'🎢 Montagnes russes','description':'Joue chaque mode au moins 2 fois.','metrique':'game','cible':6,'filtres':'{"each":2}'},
  {'id':'W07','type':'w','palier':1,'nom':'📚 Bibliothécaire','description':'Lis 5 cartes mentales de chapitres différents.','metrique':'card','cible':5,'filtres':'{"dist":true}'},
  {'id':'W08','type':'w','palier':1,'nom':'🔥 Marathon de feu','description':'Atteins une série de 15 bonnes réponses.','metrique':'strk','cible':15},
  {'id':'W09','type':'w','palier':1,'nom':'🧭 Cap sur le faible','description':'Joue 3 chapitres faibles différents.','metrique':'chap','cible':3,'filtres':'{"ch":"weak"}'},
  {'id':'W10','type':'w','palier':1,'nom':'💎 Collectionneur d\'XP','description':'Gagne 150 XP sur 3 jours différents.','metrique':'xp','cible':150,'filtres':'{"days":3}'},
  {'id':'W11','type':'w','palier':1,'nom':'📅 Régularité','description':'Sois actif 4 jours cette semaine.','metrique':'dact','cible':4},
  {'id':'W12','type':'w','palier':1,'nom':'🏹 Tireur d\'élite','description':'Obtiens 70 bonnes réponses.','metrique':'ok','cible':70},
  {'id':'W13','type':'w','palier':1,'nom':'🕵️ Chasseur d\'explications','description':'Lis 20 explications.','metrique':'expl','cible':20},
  {'id':'W14','type':'w','palier':1,'nom':'💥 Artilleur','description':'Fais 2 Bombardements à 15 bonnes réponses ou plus.','metrique':'sc','cible':2,'filtres':'{"md":"bomb","min":15}'},
  {'id':'W15','type':'w','palier':1,'nom':'🏎️ Tour de piste','description':'Termine 5 parties Rush.','metrique':'game','cible':5,'filtres':'{"md":"rush"}'},
  {'id':'W16','type':'w','palier':1,'nom':'🧘 Révisionniste','description':'Termine 5 parties en Révision.','metrique':'game','cible':5,'filtres':'{"md":"rev"}'},
  {'id':'W17','type':'w','palier':1,'nom':'💯 Trois sans faute','description':'Obtiens 3 scores de 100 %.','metrique':'perf','cible':3},
  {'id':'W18','type':'w','palier':1,'nom':'🐆 Sprinter','description':'Réponds à 50 questions en Rush.','metrique':'ans','cible':50,'filtres':'{"md":"rush"}'},
  {'id':'W19','type':'w','palier':1,'nom':'🔗 Deux jours de suite','description':'Sois actif 2 jours consécutifs.','metrique':'dact','cible':2,'filtres':'{"consec":2}'},
  {'id':'W20','type':'w','palier':1,'nom':'⏳ Maître du temps','description':'Donne 30 bonnes réponses en moins de 3 s.','metrique':'fast','cible':30},
  {'id':'W21','type':'w','palier':1,'nom':'📖 Grand lecteur','description':'Lis 3 cartes mentales.','metrique':'card','cible':3},
  {'id':'W22','type':'w','palier':1,'nom':'🌄 Au cœur du programme','description':'Joue sur 6 chapitres différents.','metrique':'chap','cible':6},
  {'id':'W23','type':'w','palier':1,'nom':'🎁 Journée parfaite','description':'Termine les 3 défis d\'une même journée.','metrique':'dc','cible':1},
  {'id':'W24','type':'w','palier':1,'nom':'🌈 Trois jours parfaits','description':'Termine les 3 défis du jour sur 3 jours.','metrique':'dc','cible':3},
  {'id':'W25','type':'w','palier':1,'nom':'📊 Progrès mesurables','description':'Bats ton dernier score 3 fois.','metrique':'beat','cible':3},
  // ── Mensuels ──────────────────────────────────────────────────────────────
  {'id':'M01','type':'m','palier':1,'nom':'🎨 Palette complète','description':'Joue dans 8 matières différentes.','metrique':'subj','cible':8},
  {'id':'M02','type':'m','palier':1,'nom':'📚 Mille et une questions','description':'Réponds à 400 questions.','metrique':'ans','cible':400},
  {'id':'M03','type':'m','palier':1,'nom':'🔥 Chaîne de feu','description':'Sois actif 20 jours.','metrique':'dact','cible':20},
  {'id':'M04','type':'m','palier':1,'nom':'🏰 Chapitres conquis','description':'Amène 3 chapitres à 70 % de maîtrise.','metrique':'chapm','cible':3,'filtres':'{"min":70}'},
  {'id':'M05','type':'m','palier':1,'nom':'🗂️ Collectionneur de savoirs','description':'Lis 20 cartes mentales différentes.','metrique':'card','cible':20,'filtres':'{"dist":true}'},
  {'id':'M06','type':'m','palier':1,'nom':'🏅 Tour de force','description':'Fais le défi du jour 15 fois.','metrique':'dd','cible':15},
  {'id':'M07','type':'m','palier':1,'nom':'☔ Pluie d\'XP','description':'Gagne 800 XP.','metrique':'xp','cible':800},
  {'id':'M08','type':'m','palier':1,'nom':'♻️ Revanche en série','description':'Réussis 40 questions ratées précédemment.','metrique':'redo','cible':40},
  {'id':'M09','type':'m','palier':1,'nom':'🧯 Artificier en chef','description':'Fais 5 Bombardements à 20 bonnes réponses ou plus.','metrique':'sc','cible':5,'filtres':'{"md":"bomb","min":20}'},
  {'id':'M10','type':'m','palier':1,'nom':'🌩️ Éclair de génie','description':'Fais 5 Rush de 10 avec au moins 8 bonnes réponses.','metrique':'sc','cible':5,'filtres':'{"md":"rush","n":10,"min":8}'},
  {'id':'M11','type':'m','palier':1,'nom':'🐉 Série monstre','description':'Atteins une série de 25 bonnes réponses.','metrique':'strk','cible':25},
  {'id':'M12','type':'m','palier':1,'nom':'💎 Perfectionniste','description':'Obtiens 8 scores de 100 %.','metrique':'perf','cible':8},
  {'id':'M13','type':'m','palier':1,'nom':'🧭 Explorateur du programme','description':'Joue sur 20 chapitres différents.','metrique':'chap','cible':20},
  {'id':'M14','type':'m','palier':1,'nom':'🗣️ Polyglotte','description':'Réponds à 40 questions en français, espagnol et anglais.','metrique':'ans','cible':40,'filtres':'{"sj":["fr","es","en"]}'},
  {'id':'M15','type':'m','palier':1,'nom':'🔬 Esprit scientifique','description':'Réponds à 60 questions en maths, sciences, chimie et physique.','metrique':'ans','cible':60,'filtres':'{"sj":["math","sci","chim","phys"]}'},
  {'id':'M16','type':'m','palier':1,'nom':'🏛️ Citoyen éclairé','description':'Réponds à 40 questions en sciences sociales, histoire, géographie et EC.','metrique':'ans','cible':40,'filtres':'{"sj":["soc","hist","geo","ec"]}'},
  {'id':'M17','type':'m','palier':1,'nom':'🎛️ Maître des modes','description':'Termine 30 parties, dont 8 dans chaque mode.','metrique':'game','cible':30,'filtres':'{"each":8}'},
  {'id':'M18','type':'m','palier':1,'nom':'🌱 Progression visible','description':'Gagne 25 points de maîtrise sur des chapitres faibles.','metrique':'mast','cible':25},
  {'id':'M19','type':'m','palier':1,'nom':'🗓️ Quatre semaines, quatre victoires','description':'Termine 4 défis hebdomadaires.','metrique':'wk','cible':4},
  {'id':'M20','type':'m','palier':1,'nom':'⚡ Réflexes d\'acier','description':'Donne 100 bonnes réponses en moins de 3 s.','metrique':'fast','cible':100},
  {'id':'M21','type':'m','palier':1,'nom':'💡 Lecteur assidu','description':'Lis 80 explications.','metrique':'expl','cible':80},
  {'id':'M22','type':'m','palier':1,'nom':'🏡 Retour aux sources','description':'Rejoue 4 matières délaissées depuis 14 jours.','metrique':'game','cible':4,'filtres':'{"sj":"stale14"}'},
  // ── Spéciaux ──────────────────────────────────────────────────────────────
  {'id':'S01','type':'s','palier':1,'nom':'🇭🇹 Fête de l\'Indépendance','description':'Réussis 10 questions sur l\'indépendance d\'Haïti.','metrique':'spk','cible':10,'filtres':'{"pk":"P_INDEP"}','date_spe':'01-01'},
  {'id':'S02','type':'s','palier':1,'nom':'🕊️ Jour des Aïeux','description':'Réussis 10 questions sur les héros et ancêtres de la nation.','metrique':'spk','cible':10,'filtres':'{"pk":"P_HEROS"}','date_spe':'01-02'},
  {'id':'S03','type':'s','palier':1,'nom':'🎓 Journée de l\'éducation','description':'Réussis 10 questions sur l\'éducation et l\'école.','metrique':'spk','cible':10,'filtres':'{"pk":"P_EDU"}','date_spe':'01-24'},
  {'id':'S04','type':'s','palier':1,'nom':'🗨️ Langue maternelle','description':'Réussis 10 questions sur la langue créole.','metrique':'spk','cible':10,'filtres':'{"pk":"P_CREOLE"}','date_spe':'02-21'},
  {'id':'S05','type':'s','palier':1,'nom':'🎭 Carnaval','description':'Réussis 15 questions sur la culture et le folklore haïtiens.','metrique':'spk','cible':15,'filtres':'{"pk":"P_CULTURE"}','date_spe':'02-01/03-15'},
  {'id':'S06','type':'s','palier':1,'nom':'👩🏾 Journée des femmes','description':'Réussis 10 questions sur des Haïtiennes marquantes.','metrique':'spk','cible':10,'filtres':'{"pk":"P_FEMMES"}','date_spe':'03-08'},
  {'id':'S07','type':'s','palier':1,'nom':'🥧 Jour de Pi','description':'Réussis 10 questions sur π, cercles et géométrie.','metrique':'spk','cible':10,'filtres':'{"pk":"P_PI"}','date_spe':'03-14'},
  {'id':'S08','type':'s','palier':1,'nom':'🥖 Francophonie','description':'Réussis 10 questions sur le monde francophone.','metrique':'spk','cible':10,'filtres':'{"pk":"P_FRANCO"}','date_spe':'03-20'},
  {'id':'S09','type':'s','palier':1,'nom':'💧 Journée de l\'eau','description':'Réussis 10 questions sur l\'eau et son cycle.','metrique':'spk','cible':10,'filtres':'{"pk":"P_EAU"}','date_spe':'03-22'},
  {'id':'S10','type':'s','palier':1,'nom':'🩺 Journée de la santé','description':'Réussis 10 questions sur la santé et le corps humain.','metrique':'spk','cible':10,'filtres':'{"pk":"P_SANTE"}','date_spe':'04-07'},
  {'id':'S11','type':'s','palier':1,'nom':'🌎 Journée panaméricaine','description':'Réussis 10 questions sur les Amériques.','metrique':'spk','cible':10,'filtres':'{"pk":"P_AMERIQUES"}','date_spe':'04-14'},
  {'id':'S12','type':'s','palier':1,'nom':'🏯 Patrimoine mondial','description':'Réussis 10 questions sur le patrimoine d\'Haïti.','metrique':'spk','cible':10,'filtres':'{"pk":"P_PATRIMOINE"}','date_spe':'04-18'},
  {'id':'S13','type':'s','palier':1,'nom':'🌍 Jour de la Terre','description':'Réussis 10 questions sur l\'environnement.','metrique':'spk','cible':10,'filtres':'{"pk":"P_ENV"}','date_spe':'04-22'},
  {'id':'S14','type':'s','palier':1,'nom':'📕 Journée du livre','description':'Réussis 10 questions sur la littérature haïtienne.','metrique':'spk','cible':10,'filtres':'{"pk":"P_LIT"}','date_spe':'04-23'},
  {'id':'S15','type':'s','palier':1,'nom':'🌾 Agriculture et travail','description':'Réussis 10 questions sur l\'agriculture et le travail.','metrique':'spk','cible':10,'filtres':'{"pk":"P_TRAVAIL"}','date_spe':'05-01'},
  {'id':'S16','type':'s','palier':1,'nom':'🚩 Jour du drapeau','description':'Réussis 10 questions sur le drapeau et les symboles nationaux.','metrique':'spk','cible':10,'filtres':'{"pk":"P_DRAPEAU"}','date_spe':'05-18'},
  {'id':'S17','type':'s','palier':1,'nom':'🌳 Journée de l\'environnement','description':'Réussis 15 questions sur la nature et le reboisement.','metrique':'spk','cible':15,'filtres':'{"pk":"P_ENV"}','date_spe':'06-05'},
  {'id':'S18','type':'s','palier':1,'nom':'🎶 Fête de la musique','description':'Réussis 10 questions sur la musique haïtienne.','metrique':'spk','cible':10,'filtres':'{"pk":"P_CULTURE"}','date_spe':'06-21'},
  {'id':'S19','type':'s','palier':1,'nom':'☀️ Vacances studieuses','description':'Réponds à 150 questions pendant les vacances.','metrique':'ans','cible':150,'date_spe':'07-01/08-31'},
  {'id':'S20','type':'s','palier':1,'nom':'🔥 Bois-Caïman','description':'Réussis 10 questions sur Bois-Caïman et le début de la révolution.','metrique':'spk','cible':10,'filtres':'{"pk":"P_BOISCAIMAN"}','date_spe':'08-14'},
  {'id':'S21','type':'s','palier':1,'nom':'🎒 Rentrée scolaire','description':'Joue dans 5 matières pendant les premières semaines.','metrique':'subj','cible':5,'date_spe':'09-01/10-15'},
  {'id':'S22','type':'s','palier':1,'nom':'🔤 Journée de l\'alphabétisation','description':'Réussis 10 questions de lecture et de langue.','metrique':'spk','cible':10,'filtres':'{"pk":"P_ALPHA"}','date_spe':'09-08'},
  {'id':'S23','type':'s','palier':1,'nom':'🧑🏾‍🏫 Journée des enseignants','description':'Réussis 10 questions sur l\'éducation et les grands pédagogues.','metrique':'spk','cible':10,'filtres':'{"pk":"P_EDU"}','date_spe':'10-05'},
  {'id':'S24','type':'s','palier':1,'nom':'⚔️ Dessalines','description':'Réussis 10 questions sur Jean-Jacques Dessalines.','metrique':'spk','cible':10,'filtres':'{"pk":"P_DESSALINES"}','date_spe':'10-17'},
  {'id':'S25','type':'s','palier':1,'nom':'🗣️ Journée du créole','description':'Réussis 10 questions sur la langue et la littérature créoles.','metrique':'spk','cible':10,'filtres':'{"pk":"P_CREOLE"}','date_spe':'10-28'},
  {'id':'S26','type':'s','palier':1,'nom':'🧪 Journée de la science','description':'Réussis 10 questions de physique et chimie.','metrique':'spk','cible':10,'filtres':'{"pk":"P_SCIENCE"}','date_spe':'11-10'},
  {'id':'S27','type':'s','palier':1,'nom':'🛡️ Vertières','description':'Réussis 15 questions sur la bataille de Vertières.','metrique':'spk','cible':15,'filtres':'{"pk":"P_VERTIERES"}','date_spe':'11-18'},
  {'id':'S28','type':'s','palier':1,'nom':'⛵ Découverte d\'Haïti','description':'Réussis 10 questions sur 1492 et la période coloniale.','metrique':'spk','cible':10,'filtres':'{"pk":"P_DECOUV"}','date_spe':'12-05'},
  {'id':'S29','type':'s','palier':1,'nom':'📝 Révisions d\'examens','description':'Revois 15 questions ratées avant les examens.','metrique':'redo','cible':15},
];

// IDs par type pour l'algorithme de rotation
const List<String> kDefisQuotidiensIds = [
  // Interleaved palier 1/2/3 — chaque slot mélange les difficultés
  'D01','D15','D29','D02', // slot 0
  'D16','D30','D03','D17', // slot 1
  'D31','D04','D18','D32', // slot 2
  'D05','D19','D33','D06', // slot 3
  'D20','D34','D07','D21', // slot 4
  'D35','D08','D22','D36', // slot 5
  'D09','D23','D37','D10', // slot 6
  'D24','D38','D11','D25', // slot 7
  'D39','D12','D26','D40', // slot 8
  'D13','D27','D14','D28', // slot 9
];

const List<String> kDefisHebdoIds = [
  'W01','W02','W03','W04','W05','W06','W07','W08','W09','W10',
  'W11','W12','W13','W14','W15','W16','W17','W18','W19','W20',
  'W21','W22','W23','W24','W25',
];

const List<String> kDefisMensuelsIds = [
  'M01','M02','M03','M04','M05','M06','M07','M08','M09','M10',
  'M11','M12','M13','M14','M15','M16','M17','M18','M19','M20',
  'M21','M22',
];
