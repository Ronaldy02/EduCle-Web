# Communication créole / Kreyòl (matiere_id 26) — Secondaire NS1 à NS4

> **Statut : proposition du 2026-10-17, en attente de validation par l'utilisateur.**

## Sources

1. **Programme officiel** : *Pwogram Kreyòl Segondè* (MENFP, dènye vèsyon 24 jiyè 2024), fichier `Programm Menfp/pwogram-kreyol_pjos2f2eucb.pdf` (même document que `Donnees/Pwogram Kominikasyon Kreyòl_Programme de Communication Créole_MENFP.pdf`, qui est un scan sans texte). 4 domaines par niveau (I. Lang ak kilti kreyòl, II. Literati an kreyòl, III. Kominikasyon ak sosyete, IV. Anviwònman ak teknoloji), 8 unités d'apprentissage (IA) par niveau. Référence notée `S1 IA5` = Segondè 1, inite aprantisaj 5. Les notions de grammaire et de vocabulaire sont dans la colonne « Resous lengwistik » de chaque IA.
2. **Manuel** : Roldan Cetoute, *Kreyòl Alèkile — Objè etid, metòd analiz ak pwosede ekriti*, « Nouvo pwogram konplè NS I & II », 2020 (sommaire scanné : `Programm Menfp/Kreyol NS1 et NS2.pdf`). Référence notée `KA I.3` = inite I, chapitre 3 ; `KA Pwen 2` = encadré « Lang ak sosyete » n° 2 ; `KA Gramè 5`, `KA Vok 4`, `KA Òtograf 2`. Le manuel couvre NS1 et NS2 ensemble : ses notions sont rattachées à NS1 + NS2 quand le programme ne les place pas ailleurs.
3. **Recherche d'autres manuels (2026-10-17)** : aucun autre sommaire de manuel de kreyòl du secondaire trouvé en ligne. Pages consultées : [islghaiti.org](https://islghaiti.org) (pages manuels pour les maths seulement), [potomitan.info — Pawòl Lakay](https://www.potomitan.info/ayiti/pawol_lakay.php) (manuel universitaire, hors cible), [UNESCO-BIE, profil Haïti](https://webarchive.unesco.org/web/20200330094018/http://www.ibe.unesco.org/sites/default/files/Haiti.pdf) (constate le manque de manuels du secondaire), [creole101.com — egzamen](https://creole101.com/index.php?mo=egzamen), [open-exam-prep.com — Bac NS4](https://open-exam-prep.com/practice/ht-bac-ns4) (questions d'entraînement non officielles : articles, réduplication, orthographe). Pas de sujets officiels du bac en ligne.
4. **Ancienne base** : 193 questions « Communication Créole / Commun » du seed Dart (`git show c2b421e:lib/services/database_helper.dart`), en français, 10 chapitres. Suppléments `scripts/supplements/v2_supp_26_creole_ns1ns2.sql` et `_ns3ns4.sql` (6 chapitres « (NSx) »). **En base (diagnostic 025, 2026-10-17) : 0 chapitre et 0 question pour la matière 26.**

## Règles d'organisation

- S1 = NS1, S2 = NS2, S3 = NS3, S4 = NS4. Le programme de kreyòl n'a pas de séries : NS3 et NS4 sont communs à toutes.
- **Union du programme 2024 et du manuel** *Kreyòl Alèkile*.
- Le programme est spiralaire (« pwogresyon sikilè ») : les mêmes notions de langue reviennent à plusieurs niveaux. Elles forment des **chapitres communs** (🔁), reliés à chaque niveau par `chapitre_niveaux`. Un chapitre est décrit dans le tableau de son niveau le plus bas ; les niveaux suivants le rappellent par une ligne « — ».
- Les unités « projet » du programme (écrire une lettre, faire un exposé, une interview…) ne donnent que leurs **notions vérifiables** : vocabulaire, structure, définitions.
- « Littérature créole et patrimoine oral » reste dans le Kreyòl, pas en Littérature (décision canonique).
- Titres des chapitres en kreyòl (la matière est enseignée en kreyòl).

---

## NS1

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | 🔁 Orijin ak istwa lang kreyòl ayisyen | NS1 + NS2 | S1 IA1 ; S2 IA1 (nòt sou istwa) ; KA Pwen 1, Pwen 2 | Contexte colonial de Saint-Domingue, contact de langues, pidgin, kreyolizasyon, langue de base lexicale (français), substrat africain (fon, ewe, kikongo…), mots taïnos ; premiers textes (*Lisette quitté la plaine*, vers 1757) ; kreyòl ansyen et kreyòl kontanporen (vocabulaire, pronoms, déterminants, orthographe) ; évolution de la langue |
| 2 | 🔁 Kreyòl yo nan lemonn : kreyòl Zantiy ak lòt kreyòl | NS1 + NS2 | S1 IA2 ; S2 IA1 ; KA Pwen 3 | Pays et territoires créolophones (Caraïbe, océan Indien, Afrique) ; créoles à base française (Martinique, Guadeloupe, Guyane, Louisiane, La Réunion, Maurice, Seychelles), anglaise, portugaise ; papiamento ; comparaison kreyòl ayisyen / kreyòl zantiy : lexique (ni/genyen, zòt/nou, kriye/rele), alphabet, déterminants, pronoms, syntaxe |
| 3 | 🔁 Sistèm kominikasyon : lang, langaj, chema kominikasyon | NS1 + NS4 | KA I.1 ; S1 IA4, IA7 ; S4 IA1, IA2 | Lang, langaj, kòd, pawòl ; chema kominikasyon (emetè, destinatè, mesaj, kanal, kòd, referan) ; fonksyon langaj (Jakobson) ; kominikasyon vèbal / non vèbal, oral / ekri ; NS4 : enonsiyasyon, sitiyasyon enonsiyasyon, endis enonsiyasyon (pwonon, advèb), tip enonse |
| 4 | 🔁 Rejis lang ak sitiyasyon kominikasyon fòmèl / enfòmèl | NS1 + NS2 + NS4 | S1 IA4 ; S4 IA2 ; KA Vok 7 | Rejis relache, familye (ba), kouran (estanda), soutni (wo) ; marques lexicales et grammaticales (contractions, structure interrogative) ; situation formelle / informelle ; différence langue orale / langue écrite ; vocabulaire technique, administratif, scientifique |
| 5 | 🔁 Fòmasyon mo : derivasyon, konpozisyon, anprent, sig | NS1 + NS2 + NS3 + NS4 | S1 IA4 ; S2 IA6 ; S3 IA7 ; S4 IA1 ; KA Vok 1–3 | Mo senp, mo konstwi ; afiksasyon (prefiks, sifiks : dechouke, kawoutchoumann, teyatmann), derivasyon, konpozisyon, redoublement ; siglezon, abreviyasyon ; anprent leksikal et modifications phonétiques / morphologiques des mots empruntés ; neyolojis ; origine, évolution et disparition des mots |
| 6 | 🔁 Relasyon ant mo : sinonimi, antonimi, omonimi, paronimi | NS1 + NS2 + NS4 | S1 IA8 ; S2 IA7 ; S4 IA4 ; KA Vok 4, 6 | Sinonim, antonim, omonim (omofòn, omograf), paronim ; ipèwonim / ipowonim ; mo menm fanmi |
| 7 | 🔁 Sans mo yo : sans pwòp, sans figire, polisemi, konotasyon, chan leksikal | NS1 + NS2 + NS3 + NS4 | S1 IA3, IA4 ; S2 IA3, IA7 ; S3 IA1–IA3 ; S4 IA4, IA5 ; KA Vok 5–6 | Sans pwòp / sans figire, sans kontekstyèl ; monosemi, polisemi ; denotasyon, konotasyon ; chan leksikal, chan semantik, rezo leksikal ; anbigite leksikal et sentaksik |
| 8 | 🔁 Kategori gramatikal : non, detèminan, pwonon, adjektif, advèb | NS1 + NS3 + NS4 | S1 IA3, IA5 ; S3 IA3, IA7 ; S4 IA4 ; KA Gramè 1–2 | Gramè fraz / gramè tèks ; non ; detèminan (atik defini la, a, an, lan, nan, yo ; endefini yon ; demonstratif sa a ; posesif) ; pwonon pèsonèl (fòm long / kout), demonstratif, posesif, relatif ; adjektif kalifikatif, degrés (egalite, enferyorite, siperyorite, sipèlatif) ; advèb ; prepozisyon ; konjonksyon |
| 9 | 🔁 Fonksyon nan fraz : sijè, predika, konpleman | NS1 + NS3 + NS4 | S1 IA5, IA6 ; S3 IA3 ; S4 IA5 ; KA Gramè 2, 4 | Gwoup nominal sijè, gwoup predika (vèbal, nominal, adjektival), predikatif, *se* / *ye* ; konpleman objè, konpleman sikonstansyèl (et comparaison avec le français), konpleman non ; ekstansyon gwoup nominal ak gwoup vèbal ; lòd mo nan fraz kreyòl ; reprezantasyon grafik fraz (pyebwa, bwat) |
| 10 | 🔁 Tan, mòd ak aspè | NS1 + NS3 + NS4 | S1 IA5, IA6 ; S3 IA7, IA8 ; S4 IA1, IA2, IA8 ; KA Gramè 5 | Makè tan ak aspè : te, ap, va / a / ava, pral, konn, fèk, sot, t ap, t a ; prezan, pase, fiti ; aspè akonpli / pwogresif / abityèl ; enperatif ; valeur des temps selon le type d'énoncé ; temps dominants du récit |
| 11 | 🔁 Tip ak fòm fraz | NS1 + NS2 + NS3 + NS4 | S1 IA4, IA6–IA8 ; S2 IA3 ; S3 IA2, IA8 ; S4 IA6, IA7 ; KA Gramè 3 | Tip : deklaratif, entèwogatif, eksklamatif, enperatif / enjonktif ; fòm : afimatif, negatif, anfatik ; fraz nominal / vèbal ; fraz senp / konplèks ; tip entèwogasyon (total, pasyèl ; kilès, kilè, kibò, poukisa, kouman) ; nominalizasyon |
| 12 | 🔁 Fraz konplèks : kowòdinasyon, jikstapozisyon, sibòdinasyon | NS1 + NS3 + NS4 | S1 IA6, IA8 ; S3 IA1, IA2 ; S4 IA7, IA8 ; KA Gramè 6–10 | Fraz ak pwopozisyon ; pwopozisyon endepandan, prensipal, sibòdone ; jikstapozisyon, kowòdinasyon, sibòdinasyon ; relativ, konpletiv, sikonstansyèl ; ekspresyon tan, koz, konsekans, bi, opozisyon, konsesyon, kondisyon (ipotèz) |
| 13 | 🔁 Konektè, mo lyezon ak koyerans tèks | NS1 + NS2 + NS3 + NS4 | KA I.3, I.4, I.6 ; S1 IA5–IA7 ; S2 IA4 ; S3 IA2, IA4 ; S4 IA4, IA7 | Konektè tan, lye, lojik (donk, poutan, malgre, konsa, paske, se poutèt sa…) ; koyerans, koyezyon ; tèm / pwopo, pwogresyon tematik ; repriz anaforik leksikal ak gramatikal, anafò ; paragraf, alineya |
| 14 | 🔁 Diskou rapòte | NS1 + NS2 + NS3 + NS4 | S1 IA5 ; S2 IA7 ; S3 IA7 ; S4 IA3 ; KA Gramè 11 | Diskou dirèk, endirèk, endirèk lib, narativize ; verbes introducteurs ; ponctuation (de pwen, gimè, tirè) ; transformations direct → indirect |
| 15 | 🔁 Figi estil (figi retorik) | NS1 + NS2 + NS3 + NS4 | S1 IA7, IA8 ; S2 IA7 ; S3 IA1, IA2 ; S4 IA3, IA5 ; KA Gramè 12 | Konparezon, metafò, alegori, pèsonifikasyon, iperbòl, litòt, antitèz, anafò, repetisyon, enimerasyon, gradasyon, metonimi, ironi, oksimowon, paralelis… ; procédés stylistiques |
| 16 | 🔁 Alfabè, òtograf, fonetik ak ponktiyasyon kreyòl | NS1 + NS2 + NS4 | KA Òtograf 1–4 ; S2 IA1, IA4 ; S4 IA2 | Sistèm alfabetik : grafèm, vwayèl oral ak nazal, semi-vwayèl, konsòn ; règles d'orthographe (circulaire du 31 janvier 1980) ; résolutions orthographiques de l'Akademi Kreyòl Ayisyen (2017, 2023) ; kontraksyon, asimilasyon (pale / ekri) ; mots composés, noms de pays ; tirè, apostwòf ; ponctuation ; alphabet phonétique international (API), transcription |
| 17 | 🔁 Tradiksyon : prensip ak teknik | NS1 + NS2 + NS3 | S1 IA2 ; S2 IA1 ; S3 IA1, IA6 ; KA Tradiksyon 1 | Lang sous / lang sib, fidélité au sens, traduction littérale / libre, adaptation, calque, emprunt, équivalence ; analyse contrastive kreyòl–français ; traduction des proverbes et expressions idiomatiques |
| 18 | 🔁 Literati oral : kont, pwovèb, fab, lodyans, devinèt | NS1 + NS3 | S1 IA5 ; S3 IA6 (pwovèb, ekspresyon idyomatik) ; KA III.3 | Kont (Krik ! Krak !), fab, lodyans (Maurice Sixto), pwovèb, devinèt (Tim tim ! Bwa chèch !), mit, lejand ; Bouki et Ti Malis ; moral ; Georges Sylvain, *Cric ? Crac !* (1901) et La Fontaine ; sens des proverbes courants ; ekspresyon idyomatik |
| 19 | 🔁 Istwa literati ayisyèn an kreyòl : peryòd, otè, zèv | NS1 + NS2 | S1 IA3 ; S2 IA3 ; KA III.1–2 | Trois périodes (1750–1950, 1950–1980, 1980 à nos jours) ; premiers textes (*Lisette quitté la plaine*, Oswald Durand *Choucoune*) ; Félix Morisseau-Leroy, Frankétienne, Georges Castera, Émile Célestin-Mégie, Carrié Paultre… ; courants littéraires haïtiens d'expression française et créole ; influence de l'oralité ; comparaison avec la littérature française |
| 20 | 🔁 Tèks literè, tèks non literè ak tip tèks | NS1 + NS2 | S1 IA8 ; S2 IA3, IA8 ; KA II.1–3 | Tèks literè / non literè ; jan literè ; tip tèks : naratif, deskriptif, enfòmatif, eksplikatif, agimantatif, enjonktif ; paratèks (tit, soutit, kouvèti, imaj) |
| 21 | 🔁 Resi : estrikti, chema naratif, naratè, pèsonaj | NS1 + NS2 + NS3 | S1 IA3, IA5 ; S2 IA5 ; S3 IA5 ; KA II.6 | Resi, narasyon ; chema naratif (sitiyasyon inisyal, eleman deklanchè, peripesi, sitiyasyon final) ; chema aktansyèl ; naratè, vwa narativ, fokalizasyon ; pèsonaj reyèl / fiktif ; endis espasyal ak tanporèl ; tan resi (kwonoloji, ritm) ; deskripsyon |
| 22 | 🔁 Ekri lèt ak dokiman administratif | NS1 + NS2 + NS4 | S1 IA6 ; S4 IA1 ; KA III.9 | Lettre personnelle / administrative ; parties d'une lettre (lieu et date, vedette, formule d'appel, corps, formule de politesse, signature) ; intentions (information, réclamation, félicitations, condoléances, demande) ; rapò, nòt administratif, kontrandi, pwosèvèbal, sikilè |
| 23 | 🔁 Teknik travay entelektyèl : pran nòt, rezime, kontrandi, fich lekti, ekspoze | NS1 + NS2 + NS3 + NS4 | S1 IA7 ; S2 IA7 ; S3 IA6, IA7 ; KA III.6–8, III.10, III.12 | Prise de notes (abréviations, symboles) ; résumé (idée principale, idées secondaires) ; compte rendu ; fiche de lecture ; recherche documentaire, référence bibliographique ; plan détaillé ; exposé (introduction, développement, conclusion) |
| 24 | 🔁 Pwezi | NS1 + NS2 + NS4 | S1 IA3 ; S4 IA5 ; KA III.4 | Powèm, vè, estwòf, rim, asonans, aliterasyon, ritm, kadans, anjanbman ; poésie à forme fixe / libre ; jeux grammaticaux (inversion, répétition) ; histoire de la poésie créole ; Oswald Durand, Morisseau-Leroy, Castera, Frankétienne, Philoctète… |
| 25 | 🔁 Teyat | NS1 + NS2 + NS4 | S4 IA3 ; KA III.5 | Pyès teyat, ak, sèn, entrig, dyalòg, monològ, apa, didaskali, misansèn, dekò ; komedi, trajedi, dram ; *Antigòn* (Morisseau-Leroy), *Kraze lanfè*, *Tizoute*, auteurs actuels ; théâtre et dénonciation sociale |
| 26 | Anviwònman : pwoteksyon ak vokabilè | NS1 | S1 IA8 | Champ lexical de l'environnement (polisyon, debwazman, rebwazman, ewozyon, fatra, devlopman dirab…) |

## NS2

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | 🔁 Lang ak sosyete : bilengwis, diglosi, estati kreyòl ak fransè | NS2 + NS4 | S2 IA1 ; S4 IA1 ; KA Pwen 4 | Situation linguistique d'Haïti ; bilinguisme, diglossie, langues officielles (Constitution de 1987, art. 5), réforme Bernard (1979), Akademi Kreyòl Ayisyen (2014) ; place des langues à l'école, dans l'économie ; anglais et espagnol en Haïti ; alternance de code ; politique linguistique |
| 2 | 🔁 Varyasyon lengwistik ak entèferans | NS2 + NS4 | S2 IA2 ; S4 IA1 ; KA Pwen 5 | Variétés régionales (Nord, Sud, Ouest) ; variation lexicale, syntaxique, phonologique ; mots empruntés ; interférences du français et de l'anglais ; faux amis (frekan / fréquent, kale / caler) ; correction de phrases avec interférence |
| 3 | Nouvèl | NS2 | S2 IA5 | Caractéristiques de la nouvelle ; différence nouvelle / roman / fable / poésie ; auteurs de nouvelles en kreyòl |
| 4 | Vwayaj, migrasyon ak deplasman | NS2 | S2 IA4, IA6 | Vocabulaire du voyage et des transports ; documents de voyage (paspò, viza, biyè) ; migration, exil ; itinéraire ; chansons sur l'exil |
| — | Rappels | | | 🔁 #1, 2, 4, 5, 6, 7, 11, 13, 14, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25 de NS1 |

## NS3

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | 🔁 Idantite ak patrimwàn kiltirèl ayisyen | NS2 + NS3 | S3 IA1 ; S2 IA8 | Patrimoine matériel / immatériel ; sites historiques ; fèt chanpèt, kanaval, rara, konbit, lakou ; cuisine (soup joumou, patrimoine UNESCO 2021) ; *La Dessalinienne* (versions créole et française) ; comparaison avec la Caraïbe |
| 2 | Mizik ak chan tradisyonèl | NS3 | S3 IA2 | Genres musicaux haïtiens (rasin, konpa, twoubadou, rara, mereng, rap kreyòl…) ; chants traditionnels ; groupes et artistes majeurs ; modalizasyon (souzantandi, presipoze) |
| 3 | Biyografi, otobiyografi, pòtre, otopòtre | NS3 | S3 IA3, IA7 | Définitions et caractéristiques ; pronoms dominants ; œuvres (*Tijak* de Carrié Paultre, *Tifi* de Saïka Céus, *Agase Lesperans* de Lyonel Trouillot) |
| 4 | 🔁 Agimantasyon ak deba | NS1 + NS2 + NS3 | S3 IA4, IA7 ; KA II.9–10 | Tèz, antitèz, agiman, egzanp ; konvenk / pèsyade ; types d'arguments ; tip rezònman (endiktif, dediktif, konsesif, analojik) ; règles du débat ; réfutation |
| 5 | Woman an kreyòl | NS3 | S3 IA5 | Caractéristiques du roman ; *Dezafi* (Frankétienne, 1975), *Tijak*, *Lanmou pa gen baryè*, *Bèbè gòlgota*, *Nan lonbray inosans*… ; auteurs et thèmes |
| 6 | Viv ansanm : dwa moun ak demokrasi | NS3 | S3 IA4, IA6 | Vocabulaire de la démocratie, de la solidarité et des droits ; Déclaration de 1789, Déclaration universelle de 1948 ; pledwaye |
| 7 | Entènèt ak rezo sosyal | NS3 | S3 IA8 | Vocabulaire d'internet et des réseaux sociaux ; feknyouz, cyberharcèlement, bon usage |
| 8 | 🔁 Disètasyon ak kòmantè literè | NS2 + NS3 + NS4 | S2 IA5, IA7 ; S3 IA5, IA7 ; S4 IA7 ; KA III.11 | Disètasyon : sijè, pwoblematik, tip plan (dyalektik, tematik, analitik), entwodiksyon (amòs, pozisyon pwoblèm, anons plan), devlopman, konklizyon ; kòmantè : lekti lineyè, lekti analitik |
| — | Rappels | | | 🔁 #5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 21, 23 de NS1 |

## NS4

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | 🔁 Medya, enfòmasyon ak ekriti jounalistik | NS1 + NS2 + NS4 | S4 IA4 ; KA II.3–4 | Médias (radio, télévision, presse écrite, journal numérique) ; genres journalistiques (atik, repòtaj, editoryal, entèvyou) ; 5 questions (kilès, kisa, kilè, kibò, poukisa) ; titre, nominalisation ; objectivité |
| 2 | 🔁 Kesyonè ak entèvyou | NS3 + NS4 | S3 IA8 ; S4 IA6 | Questionnaire, questions ouvertes / fermées, interview ; étapes ; reformulation |
| 3 | Pwogrè teknolojik ak vokabilè syantifik | NS4 | S4 IA8 | Terminologie scientifique et technique en kreyòl ; travaux de l'Akademi Kreyòl Ayisyen ; formulation d'hypothèses |
| — | Rappels | | | 🔁 #3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 22, 23, 24, 25 de NS1 ; #1, 2 de NS2 ; #8 de NS3 |

---

## Total : 41 chapitres distincts

| Niveau | Chapitres décrits au niveau | Chapitres reliés au niveau |
|---|---|---|
| NS1 | 26 | 26 + agimantasyon, medya |
| NS2 | 4 | 4 + 19 de NS1 + patrimwàn, agimantasyon, disètasyon, medya |
| NS3 | 8 | 8 + 14 de NS1 + kesyonè |
| NS4 | 3 | 3 + 18 de NS1 + 2 de NS2 + disètasyon |

## Anciennes questions (193, en français)

| Ancien chapitre | Va surtout dans |
|---|---|
| Istwa lang kreyòl ayisyen ak fonoloji (NS1) | NS1 #1, #16 ; NS2 #1 |
| Gramè kreyòl ayisyen : mòfoloji ak sentaks (NS1) | NS1 #8–#11 |
| Orthographe et phonologie du créole haïtien | NS1 #16, #8, #10 (beaucoup de questions de traduction « Comment dit-on… » : à écarter) |
| Literati oral ayisyen / Littérature créole et patrimoine oral | NS1 #18, #19 ; NS3 #1 |
| Lekti ak analiz tèks kreyòl : Frankétienne ak lòt (NS2) | NS3 #5 ; NS1 #15, #7 |
| Communication orale et écrite / Production écrite et orale | NS1 #3, #13, #22, #23 |
| Analiz diskoutif : agimantasyon ak debat (NS3) | NS3 #4 |
| Politique lingwistik ak kreyòl (NS4) | NS2 #1 |
