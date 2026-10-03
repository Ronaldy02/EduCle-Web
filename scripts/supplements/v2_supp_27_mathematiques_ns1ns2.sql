-- Supplement Mathématiques NS1-NS2 (matiere_id=27)
-- Objectif : porter chaque chapitre à ≥ 20 questions

DO $$
DECLARE chap_id INTEGER;
BEGIN
  SELECT id INTO chap_id FROM chapitres WHERE matiere_id = 27 AND titre = 'Algèbre : équations, inéquations et systèmes' AND niveau_v4 = 'NS1';
  IF chap_id IS NOT NULL THEN
    INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite) VALUES
    (chap_id, 'Quelle est la solution de l''équation 2x + 5 = 13 ?', '["3","4","5","6"]'::jsonb, '4', '2x = 13 - 5 = 8, donc x = 4.', 'Facile'),
    (chap_id, 'Résoudre : 3x - 7 = 2x + 1', '["x = 6","x = 7","x = 8","x = 9"]'::jsonb, 'x = 8', '3x - 2x = 1 + 7, donc x = 8.', 'Facile'),
    (chap_id, 'Quelle est l''ensemble solution de l''inéquation 2x - 3 > 5 ?', '["x > 1","x > 3","x > 4","x > 5"]'::jsonb, 'x > 4', '2x > 5 + 3 = 8, donc x > 4.', 'Facile'),
    (chap_id, 'Résoudre le système : x + y = 7 et x - y = 3', '["x=4, y=3","x=5, y=2","x=6, y=1","x=3, y=4"]'::jsonb, 'x=5, y=2', 'Addition : 2x = 10, x = 5 ; substitution : y = 7 - 5 = 2.', 'Moyen'),
    (chap_id, 'Factoriser : x² - 9', '["(x-3)(x+3)","(x-3)²","(x+3)²","(x-9)(x+1)"]'::jsonb, '(x-3)(x+3)', 'x² - 9 = x² - 3² = (x-3)(x+3), identité remarquable a²-b² = (a-b)(a+b).', 'Moyen'),
    (chap_id, 'Quelle est la valeur de x dans l''équation |2x - 4| = 6 ?', '["x = 5 seulement","x = -1 seulement","x = 5 ou x = -1","x = 1 ou x = -5"]'::jsonb, 'x = 5 ou x = -1', '2x - 4 = 6 → x = 5 ; ou 2x - 4 = -6 → x = -1.', 'Moyen'),
    (chap_id, 'Résoudre : x² - 5x + 6 = 0', '["x = 2 ou x = 3","x = -2 ou x = -3","x = 1 ou x = 6","x = 2 ou x = -3"]'::jsonb, 'x = 2 ou x = 3', 'Delta = 25 - 24 = 1 ; x = (5±1)/2, soit x = 3 ou x = 2. Vérification : (x-2)(x-3) = 0.', 'Moyen'),
    (chap_id, 'Quelle est la somme des solutions d''une équation ax² + bx + c = 0 ?', '["-b/a","b/a","c/a","-c/a"]'::jsonb, '-b/a', 'Pour ax² + bx + c = 0, la somme des racines est -b/a (formules de Viète).', 'Difficile'),
    (chap_id, 'Résoudre l''inéquation x² - 4 < 0', '["x < -2 ou x > 2","-2 < x < 2","x > 2","x < -2"]'::jsonb, '-2 < x < 2', 'x² < 4 ⟺ |x| < 2 ⟺ -2 < x < 2 ; le parabole est négative entre ses racines ±2.', 'Difficile'),
    (chap_id, 'Quel est le discriminant de 2x² - 3x + 1 = 0 ?', '["1","7","17","25"]'::jsonb, '1', 'Δ = b² - 4ac = (-3)² - 4×2×1 = 9 - 8 = 1.', 'Moyen'),
    (chap_id, 'Résoudre : 2(x+3) = 3(x-1)', '["x = 7","x = 8","x = 9","x = 10"]'::jsonb, 'x = 9', '2x + 6 = 3x - 3 → 6 + 3 = 3x - 2x → x = 9.', 'Facile'),
    (chap_id, 'Que signifie résoudre une équation dans ℝ ?', '["Trouver les entiers solutions","Trouver tous les réels qui vérifient l''équation","Trouver les solutions entières positives","Simplifier l''équation"]'::jsonb, 'Trouver tous les réels qui vérifient l''équation', 'Résoudre dans ℝ signifie trouver toutes les valeurs réelles satisfaisant l''équation.', 'Facile'),
    (chap_id, 'Quelle méthode de résolution de système utilise la substitution ?', '["On additionne les équations","On exprime une variable en fonction de l''autre et on substitue","On multiplie toutes les équations","On divise par le coefficient"]'::jsonb, 'On exprime une variable en fonction de l''autre et on substitue', 'La méthode par substitution isole une variable dans une équation, puis remplace dans l''autre.', 'Moyen');
  END IF;
END $$;

DO $$
DECLARE chap_id INTEGER;
BEGIN
  SELECT id INTO chap_id FROM chapitres WHERE matiere_id = 27 AND titre = 'Fonctions : analyse et représentation graphique' AND niveau_v4 = 'NS1';
  IF chap_id IS NOT NULL THEN
    INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite) VALUES
    (chap_id, 'Quelle est la pente d''une droite d''équation y = 3x - 5 ?', '["5","3","-5","-3"]'::jsonb, '3', 'Dans y = ax + b, a est la pente (coefficient directeur) et b est l''ordonnée à l''origine.', 'Facile'),
    (chap_id, 'Quelle est l''image de x = 2 par la fonction f(x) = x² - 3x + 1 ?', '["-1","0","1","2"]'::jsonb, '-1', 'f(2) = 4 - 6 + 1 = -1.', 'Facile'),
    (chap_id, 'Une fonction f est paire si et seulement si ?', '["f(-x) = f(x) pour tout x","f(-x) = -f(x) pour tout x","f est croissante","f(0) = 0"]'::jsonb, 'f(-x) = f(x) pour tout x', 'Une fonction paire est symétrique par rapport à l''axe des ordonnées (ex : f(x) = x²).', 'Moyen'),
    (chap_id, 'Quel est le sommet de la parabole y = (x-3)² + 2 ?', '["(-3, 2)","(3, -2)","(3, 2)","(-3, -2)"]'::jsonb, '(3, 2)', 'La forme y = (x-h)² + k a son sommet en (h, k), ici (3, 2).', 'Moyen'),
    (chap_id, 'Quelle est la période de la fonction sinus sin(x) ?', '["π","2π","π/2","4π"]'::jsonb, '2π', 'La fonction sinus a une période de 2π : sin(x + 2π) = sin(x).', 'Facile'),
    (chap_id, 'La fonction f(x) = 1/x est-elle définie en x = 0 ?', '["Oui, f(0) = 0","Oui, f(0) = 1","Non, division par zéro","Non, logarithme négatif"]'::jsonb, 'Non, division par zéro', '1/0 est indéfini ; le domaine de f(x) = 1/x est ℝ \ {0}.', 'Facile'),
    (chap_id, 'Que représente le taux de variation moyen d''une fonction sur [a,b] ?', '["La dérivée en a","(f(b)-f(a))/(b-a)","f(a) × f(b)","La valeur moyenne de f"]'::jsonb, '(f(b)-f(a))/(b-a)', 'Le taux de variation moyen est la pente de la corde reliant (a, f(a)) et (b, f(b)).', 'Moyen'),
    (chap_id, 'Quelle transformation déplace le graphe de f(x) de 3 unités vers la droite ?', '["f(x) + 3","f(x) - 3","f(x + 3)","f(x - 3)"]'::jsonb, 'f(x - 3)', 'f(x - h) translat le graphe de h unités vers la droite (remplacement de x par x-h).', 'Moyen'),
    (chap_id, 'Pour la fonction f(x) = 2x + 1, que vaut f⁻¹(x) ?', '["(x-1)/2","(x+1)/2","2x-1","x/2 + 1"]'::jsonb, '(x-1)/2', 'On résout y = 2x + 1 pour x : x = (y-1)/2, donc f⁻¹(x) = (x-1)/2.', 'Moyen'),
    (chap_id, 'Quel est le domaine de définition de f(x) = √(x - 4) ?', '["ℝ","x ≥ 0","x ≥ 4","x > 4"]'::jsonb, 'x ≥ 4', 'La racine carrée exige x - 4 ≥ 0, donc x ≥ 4.', 'Moyen'),
    (chap_id, 'Une fonction est croissante sur [a,b] si ?', '["f(a) > f(b)","Pour tout x₁ < x₂ dans [a,b], f(x₁) < f(x₂)","f est positive","La dérivée est négative"]'::jsonb, 'Pour tout x₁ < x₂ dans [a,b], f(x₁) < f(x₂)', 'Une fonction croissante associe des images de plus en plus grandes à des antécédents croissants.', 'Facile'),
    (chap_id, 'Quel est l''ensemble image de la fonction f(x) = x² sur ℝ ?', '["ℝ","ℝ⁺","[-1, 1]","[0, +∞["]'::jsonb, '[0, +∞[', 'x² ≥ 0 pour tout réel x, et toute valeur positive est atteinte, donc l''image est [0, +∞[.', 'Moyen'),
    (chap_id, 'Qu''est-ce qu''un zéro (racine) d''une fonction f ?', '["La valeur minimale de f","Un x tel que f(x) = 0","La dérivée de f","L''image de 0 par f"]'::jsonb, 'Un x tel que f(x) = 0', 'Les zéros de f sont les antécédents de 0, c''est-à-dire les abscisses des intersections avec l''axe des x.', 'Facile');
  END IF;
END $$;

DO $$
DECLARE chap_id INTEGER;
BEGIN
  SELECT id INTO chap_id FROM chapitres WHERE matiere_id = 27 AND titre = 'Géométrie analytique et trigonométrie' AND niveau_v4 = 'NS2';
  IF chap_id IS NOT NULL THEN
    INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite) VALUES
    (chap_id, 'Quelle est la distance entre les points A(1,2) et B(4,6) ?', '["3","5","6","7"]'::jsonb, '5', 'd = √((4-1)² + (6-2)²) = √(9+16) = √25 = 5.', 'Moyen'),
    (chap_id, 'Dans un triangle rectangle, sin(α) est égal à ?', '["adjacent/hypothénuse","opposé/adjacent","opposé/hypothénuse","hypothénuse/opposé"]'::jsonb, 'opposé/hypothénuse', 'SOH : Sinus = Opposé/Hypothénuse ; CAH : Cosinus = Adjacent/Hypothénuse ; TOA : Tangente = Opposé/Adjacent.', 'Facile'),
    (chap_id, 'Quelle est la valeur de cos(60°) ?', '["√3/2","1/2","√2/2","1"]'::jsonb, '1/2', 'cos(60°) = 1/2 est une valeur trigonométrique de référence à connaître.', 'Facile'),
    (chap_id, 'Quelle est l''équation d''un cercle de centre O(2,3) et de rayon 5 ?', '["(x-2)²+(y-3)²=5","(x-2)²+(y-3)²=25","(x+2)²+(y+3)²=25","x²+y²=25"]'::jsonb, '(x-2)²+(y-3)²=25', 'L''équation d''un cercle de centre (a,b) et rayon r est (x-a)²+(y-b)²=r².', 'Moyen'),
    (chap_id, 'Que vaut tan(45°) ?', '["0","1","√2","1/2"]'::jsonb, '1', 'tan(45°) = sin(45°)/cos(45°) = (√2/2)/(√2/2) = 1.', 'Facile'),
    (chap_id, 'Quelle est l''identité trigonométrique fondamentale ?', '["sin²x + cos²x = 0","sin²x + cos²x = 1","sin²x - cos²x = 1","tan²x + 1 = sin²x"]'::jsonb, 'sin²x + cos²x = 1', 'Cette identité fondamentale découle du théorème de Pythagore appliqué au cercle trigonométrique.', 'Facile'),
    (chap_id, 'Quelle est la pente d''une droite perpendiculaire à y = 2x + 1 ?', '["-1/2","2","-2","1/2"]'::jsonb, '-1/2', 'Si la pente est m, la perpendiculaire a une pente -1/m = -1/2.', 'Moyen'),
    (chap_id, 'Que vaut sin(30°) ?', '["√3/2","1/2","√2/2","1"]'::jsonb, '1/2', 'sin(30°) = 1/2 est une valeur trigonométrique fondamentale.', 'Facile'),
    (chap_id, 'Comment convertit-on 180° en radians ?', '["π/2","π","2π","3π/2"]'::jsonb, 'π', '180° correspond à π radians, la conversion est angle_rad = angle_deg × π/180.', 'Facile'),
    (chap_id, 'Quelle est la formule du produit scalaire de deux vecteurs u(a,b) et v(c,d) ?', '["ac + bd","ad + bc","ac - bd","a/c + b/d"]'::jsonb, 'ac + bd', 'Le produit scalaire u⃗·v⃗ = ac + bd = ||u⃗|| × ||v⃗|| × cos(θ).', 'Moyen'),
    (chap_id, 'Deux vecteurs sont perpendiculaires si leur produit scalaire est ?', '["1","-1","0","Infini"]'::jsonb, '0', 'u⃗⊥v⃗ ⟺ u⃗·v⃗ = 0, car cos(90°) = 0.', 'Moyen'),
    (chap_id, 'Quelle formule donne la longueur de l''arc d''un cercle de rayon r pour un angle θ (en radians) ?', '["θ/r","r/θ","rθ","πr²θ"]'::jsonb, 'rθ', 'La longueur d''arc est l = rθ, où θ est mesuré en radians.', 'Moyen'),
    (chap_id, 'Quel est le milieu du segment [AB] avec A(1,3) et B(5,7) ?', '["(2,5)","(3,5)","(4,6)","(6,10)"]'::jsonb, '(3,5)', 'Milieu M = ((1+5)/2, (3+7)/2) = (3,5).', 'Facile');
  END IF;
END $$;

DO $$
DECLARE chap_id INTEGER;
BEGIN
  SELECT id INTO chap_id FROM chapitres WHERE matiere_id = 27 AND titre = 'Calcul différentiel et intégral' AND niveau_v4 = 'NS2';
  IF chap_id IS NOT NULL THEN
    INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite) VALUES
    (chap_id, 'Quelle est la dérivée de f(x) = x³ ?', '["x²","3x²","3x","2x³"]'::jsonb, '3x²', 'Règle de puissance : (xⁿ)'' = nxⁿ⁻¹, donc (x³)'' = 3x².', 'Facile'),
    (chap_id, 'Quelle est la dérivée de f(x) = sin(x) ?', '["-sin(x)","cos(x)","-cos(x)","sin(x)"]'::jsonb, 'cos(x)', 'La dérivée du sinus est le cosinus : (sin x)'' = cos x.', 'Facile'),
    (chap_id, 'Que représente la dérivée f''(a) géométriquement ?', '["L''aire sous la courbe","La pente de la tangente à la courbe en x=a","La valeur maximale","La concavité de la courbe"]'::jsonb, 'La pente de la tangente à la courbe en x=a', 'f''(a) est le coefficient directeur de la droite tangente à la courbe au point d''abscisse a.', 'Moyen'),
    (chap_id, 'Quelle est la dérivée de f(x) = eˣ ?', '["x·eˣ","eˣ","eˣ⁻¹","ln(x)"]'::jsonb, 'eˣ', 'La fonction exponentielle est sa propre dérivée : (eˣ)'' = eˣ.', 'Facile'),
    (chap_id, 'Quel est le signe de f''(x) sur un intervalle où f est croissante ?', '["Négatif","Nul","Positif","Variable"]'::jsonb, 'Positif', 'f est croissante sur I ⟺ f''(x) ≥ 0 pour tout x dans I.', 'Facile'),
    (chap_id, 'Comment calcule-t-on ∫₀² x dx ?', '["1","2","4","6"]'::jsonb, '2', '∫x dx = x²/2 ; [x²/2]₀² = 4/2 - 0 = 2.', 'Moyen'),
    (chap_id, 'Que représente ∫ₐᵇ f(x) dx géométriquement pour f(x) ≥ 0 ?', '["La dérivée de f","L''aire sous la courbe entre x=a et x=b","La valeur moyenne de f","Le maximum de f"]'::jsonb, 'L''aire sous la courbe entre x=a et x=b', 'L''intégrale définie calcule l''aire algébrique entre la courbe et l''axe des abscisses.', 'Moyen'),
    (chap_id, 'Quelle est la dérivée du produit f(x)·g(x) ?', '["f''(x)·g''(x)","f(x)·g''(x) + f''(x)·g(x)","f''(x)/g(x)","f(x)/g''(x)"]'::jsonb, 'f(x)·g''(x) + f''(x)·g(x)', 'La règle du produit (Leibniz) : (fg)'' = fg'' + f''g.', 'Moyen'),
    (chap_id, 'Quelle est la primitive de f(x) = 2x + 3 ?', '["x² + 3x + C","2x² + 3x + C","x² + 3 + C","2 + C"]'::jsonb, 'x² + 3x + C', '∫(2x+3)dx = 2x²/2 + 3x + C = x² + 3x + C.', 'Facile'),
    (chap_id, 'Un extremum local de f se trouve aux valeurs de x où ?', '["f''(x) est maximale","f''(x) = 0 (et changement de signe de f'')","f(x) = 0","f''(x) > 0"]'::jsonb, 'f''(x) = 0 (et changement de signe de f'')', 'Un extremum local existe quand f'' s''annule et change de signe (condition nécessaire et suffisante).', 'Moyen'),
    (chap_id, 'Quelle est la dérivée de la fonction composée f(g(x)) ?', '["f''(x)·g(x)","f''(g(x))·g''(x)","f(g''(x))","f''(g''(x))"]'::jsonb, 'f''(g(x))·g''(x)', 'La règle de la chaîne : (f∘g)''(x) = f''(g(x))·g''(x).', 'Difficile'),
    (chap_id, 'Quel théorème relie dérivée et intégrale ?', '["Théorème de Pythagore","Théorème fondamental du calcul (Théorème de Newton-Leibniz)","Théorème de Thalès","Théorème de Bayes"]'::jsonb, 'Théorème fondamental du calcul (Théorème de Newton-Leibniz)', 'Ce théorème établit que dérivation et intégration sont des opérations inverses.', 'Difficile'),
    (chap_id, 'Que vaut lim(x→0) sin(x)/x ?', '["0","1","∞","Indéterminé"]'::jsonb, '1', 'Cette limite fondamentale (règle de L''Hôpital ou développement limité) vaut 1.', 'Difficile');
  END IF;
END $$;
