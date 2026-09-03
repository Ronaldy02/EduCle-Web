<template>
  <div class="adm">

    <!-- ── Sidebar ─────────────────────────────────────────────────────────── -->
    <aside class="adm-nav">
      <div class="adm-brand">
        <span class="adm-brand-icon">🔑</span>
        <div class="adm-brand-text">
          <div class="adm-brand-title">EduClé</div>
          <div class="adm-brand-sub">Administration</div>
        </div>
      </div>

      <nav class="adm-nav-list">
        <button v-for="s in SECTIONS" :key="s.key"
          :class="['adm-nav-item', { active: section === s.key }]"
          @click="section = s.key"
        >
          <span class="material-symbols-outlined">{{ s.icon }}</span>
          <span class="adm-nav-label">{{ s.label }}</span>
        </button>
      </nav>

      <div class="adm-nav-foot">
        <button class="adm-nav-item" @click="$router.push('/')">
          <span class="material-symbols-outlined">arrow_back</span>
          <span class="adm-nav-label">Quitter</span>
        </button>
      </div>
    </aside>

    <!-- ── Main ────────────────────────────────────────────────────────────── -->
    <main class="adm-main">

      <!-- DASHBOARD ──────────────────────────────────────────────────────── -->
      <div v-if="section === 'dashboard'" class="adm-section">
        <div class="adm-section-header">
          <h1>Tableau de bord</h1>
          <span class="adm-date">{{ todayLabel }}</span>
        </div>

        <div class="kpi-grid" v-if="stats">
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#EEF3FE;color:#2F6FED">
              <span class="material-symbols-outlined">quiz</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.nb_questions }}</div>
              <div class="kpi-label">Questions</div>
            </div>
          </div>
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#F0FDF4;color:#10B981">
              <span class="material-symbols-outlined">library_books</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.nb_chapitres }}</div>
              <div class="kpi-label">Chapitres</div>
            </div>
          </div>
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#FFF7ED;color:#F59E0B">
              <span class="material-symbols-outlined">subject</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.nb_matieres }}</div>
              <div class="kpi-label">Matières</div>
            </div>
          </div>
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#FDF4FF;color:#A855F7">
              <span class="material-symbols-outlined">sports_esports</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.nb_parties }}</div>
              <div class="kpi-label">Parties totales</div>
            </div>
          </div>
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#EEF3FE;color:#2F6FED">
              <span class="material-symbols-outlined">military_tech</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.xp_total.toLocaleString() }}</div>
              <div class="kpi-label">XP total</div>
            </div>
          </div>
          <div class="kpi-card">
            <div class="kpi-icon" style="background:#FFF7ED;color:#D97706">
              <span class="material-symbols-outlined">monetization_on</span>
            </div>
            <div>
              <div class="kpi-value">{{ stats.pieces_total }}</div>
              <div class="kpi-label">Pièces</div>
            </div>
          </div>
        </div>

        <!-- Activity -->
        <div class="adm-card" style="margin-top:1.25rem">
          <div class="adm-card-header">
            <h3>Activité</h3>
            <div class="period-tabs">
              <button v-for="p in PERIODS" :key="p.key"
                :class="['period-tab', { active: period === p.key }]"
                @click="period = p.key">{{ p.label }}</button>
            </div>
          </div>
          <div v-if="activity">
            <div class="activity-summary">
              <span><strong>{{ activity.nb_parties }}</strong> partie{{ activity.nb_parties !== 1 ? 's' : '' }}</span>
              <span>·</span>
              <span>Taux moyen : <strong>{{ activity.avg_score }}%</strong></span>
            </div>
            <div v-if="chartData.length" class="chart-container">
              <div class="chart-bars">
                <div v-for="d in chartData" :key="d.date" class="chart-bar-wrap"
                  :title="`${d.date} · ${d.nb} partie${d.nb > 1 ? 's' : ''}`">
                  <div class="chart-bar" :style="{ height: Math.max(d.nb / chartMax * 100, 3) + '%' }"></div>
                  <span class="chart-label">{{ d.date.slice(5) }}</span>
                </div>
              </div>
            </div>
            <div v-else class="chart-empty">Aucune activité sur cette période</div>
          </div>
          <div v-else class="chart-empty">Chargement…</div>
        </div>

        <!-- Mode + matières -->
        <div class="adm-2col" style="margin-top:1rem">
          <div class="adm-card" v-if="activity?.mode_distribution?.length">
            <h3 class="adm-card-h3">Modes de jeu</h3>
            <div class="dist-list">
              <div v-for="m in activity.mode_distribution" :key="m.mode" class="dist-row">
                <span class="dist-label">{{ m.mode }}</span>
                <div class="dist-track">
                  <div class="dist-bar" :style="{ width: (m.nb / activity.nb_parties * 100) + '%' }"></div>
                </div>
                <span class="dist-count">{{ m.nb }}</span>
              </div>
            </div>
          </div>
          <div class="adm-card" v-if="activity?.top_matieres?.length">
            <h3 class="adm-card-h3">Top matières</h3>
            <div class="dist-list">
              <div v-for="m in activity.top_matieres" :key="m.nom" class="dist-row">
                <span class="dist-label">{{ m.nom }}</span>
                <div class="dist-track">
                  <div class="dist-bar dist-bar--green" :style="{ width: (m.nb / activity.top_matieres[0].nb * 100) + '%' }"></div>
                </div>
                <span class="dist-count">{{ m.nb }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- QUESTIONS ──────────────────────────────────────────────────────── -->
      <div v-else-if="section === 'questions'" class="adm-section">
        <div class="adm-section-header">
          <h1>Questions</h1>
          <button class="btn-primary" @click="openCreate">
            <span class="material-symbols-outlined">add</span> Nouvelle
          </button>
        </div>

        <div class="filters-bar">
          <div class="search-wrap">
            <span class="material-symbols-outlined search-icon">search</span>
            <input v-model="search" placeholder="Rechercher…" class="search-input" />
          </div>
          <select v-model="filterMatiere" class="filter-select" @change="filterChapitre = null">
            <option :value="null">Toutes les matières</option>
            <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
          </select>
          <select v-model="filterChapitre" class="filter-select" :disabled="!filterMatiere">
            <option :value="null">Tous chapitres</option>
            <option v-for="c in chapitresDeMatiere" :key="c.id" :value="c.id">{{ c.titre }}</option>
          </select>
          <select v-model="filterDiff" class="filter-select">
            <option value="">Toutes difficultés</option>
            <option value="Facile">Facile</option>
            <option value="Moyen">Moyen</option>
            <option value="Difficile">Difficile</option>
          </select>
          <button class="btn-ghost" @click="clearFilters">Réinitialiser</button>
        </div>

        <div class="q-table-wrap">
          <table class="q-table">
            <thead>
              <tr>
                <th class="th-n">#</th>
                <th class="th-q">Question</th>
                <th class="th-a">Bonne réponse</th>
                <th>Matière / Chapitre</th>
                <th>Diff.</th>
                <th class="th-num">Tent.</th>
                <th class="th-num">Réussite</th>
                <th class="th-num">Maîtrise</th>
                <th>Dernière util.</th>
                <th class="th-actions">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-if="questionsFiltered.length === 0">
                <td colspan="10" class="q-empty">Aucune question trouvée</td>
              </tr>
              <tr v-for="q in questionsFiltered" :key="q.id" class="q-row">
                <td class="td-n">{{ q.id }}</td>
                <td class="td-q">{{ q.enonce }}</td>
                <td class="td-a">{{ q.bonne_reponse }}</td>
                <td class="td-meta">
                  <span class="mat-badge">{{ q.matiere_nom }}</span>
                  <span class="chap-badge">{{ q.chapitre_titre }}</span>
                </td>
                <td>
                  <span class="diff-badge"
                    :style="{ background: diffColor(q.niveau_complexite) + '20', color: diffColor(q.niveau_complexite) }">
                    {{ q.niveau_complexite }}
                  </span>
                </td>
                <td class="td-num">{{ q.nb_affichee }}</td>
                <td class="td-num">
                  <span :style="{ color: reussiteColor(q.taux_reussite), fontWeight: 700 }">{{ q.taux_reussite }}%</span>
                </td>
                <td class="td-num">
                  <div class="mastery-wrap">
                    <div class="mastery-bar" :style="{ width: q.taux_reussite + '%', background: reussiteColor(q.taux_reussite) }"></div>
                  </div>
                </td>
                <td class="td-date">{{ formatDate(q.last_correct_at) }}</td>
                <td class="td-actions">
                  <button class="icon-btn" title="Voir" @click="openView(q)">
                    <span class="material-symbols-outlined">visibility</span>
                  </button>
                  <button class="icon-btn" title="Modifier" @click="openEdit(q)">
                    <span class="material-symbols-outlined">edit</span>
                  </button>
                  <button class="icon-btn" title="Dupliquer" @click="duplicateQuestion(q)">
                    <span class="material-symbols-outlined">content_copy</span>
                  </button>
                  <button class="icon-btn icon-btn--danger" title="Supprimer" @click="deleteQuestion(q.id)">
                    <span class="material-symbols-outlined">delete</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="q-count">{{ questionsFiltered.length }} question{{ questionsFiltered.length !== 1 ? 's' : '' }}</div>
      </div>

      <!-- CHAPITRES ──────────────────────────────────────────────────────── -->
      <div v-else-if="section === 'chapitres'" class="adm-section">
        <div class="adm-section-header">
          <h1>Chapitres</h1>
          <button class="btn-primary" @click="openAddChapitre">
            <span class="material-symbols-outlined">add</span> Nouveau
          </button>
        </div>
        <div class="matiere-tree">
          <div v-for="mat in chapitresParMatiere" :key="mat.id" class="matiere-group">
            <div class="matiere-header">
              <span class="material-symbols-outlined" style="color:#2F6FED">subject</span>
              <span>{{ mat.nom }}</span>
              <span class="mat-count">{{ mat.chapitres.length }} chapitre{{ mat.chapitres.length > 1 ? 's' : '' }}</span>
            </div>
            <div class="chap-list">
              <div v-for="c in mat.chapitres" :key="c.id" class="chap-row">
                <span class="material-symbols-outlined" style="color:#9CA3AF;font-size:18px">menu_book</span>
                <span class="chap-name">{{ c.titre }}</span>
                <span class="chap-nb">{{ c.nb_questions }} question{{ c.nb_questions !== 1 ? 's' : '' }}</span>
                <div class="chap-actions">
                  <button class="icon-btn" title="Modifier" @click="openEditChapitre(c)">
                    <span class="material-symbols-outlined">edit</span>
                  </button>
                  <button class="icon-btn icon-btn--danger" title="Supprimer (vide seulement)"
                    @click="deleteChapitre(c.id)"
                    :style="c.nb_questions > 0 ? { opacity: 0.35, pointerEvents: 'none' } : {}">
                    <span class="material-symbols-outlined">delete</span>
                  </button>
                </div>
              </div>
              <div v-if="mat.chapitres.length === 0" class="chap-empty">Aucun chapitre</div>
            </div>
          </div>
          <div v-if="chapitresParMatiere.length === 0" class="loading">Chargement…</div>
        </div>
      </div>

      <!-- UTILISATEURS ───────────────────────────────────────────────────── -->
      <div v-else-if="section === 'utilisateurs'" class="adm-section">
        <div class="adm-section-header"><h1>Utilisateur</h1></div>
        <div v-if="user" class="adm-2col">
          <div class="adm-card">
            <h3 class="adm-card-h3">Profil</h3>
            <div class="user-fields">
              <label class="field-group"><span>XP total</span>
                <input type="number" v-model.number="user.xp_total" class="field-input" /></label>
              <label class="field-group"><span>Pièces</span>
                <input type="number" v-model.number="user.pieces_total" class="field-input" /></label>
              <label class="field-group"><span>Cycle</span>
                <select v-model="user.niveau_scolaire" class="field-input">
                  <option value="Fondamental">Fondamental</option>
                  <option value="Secondaire">Secondaire</option>
                </select></label>
              <label class="field-group"><span>Année</span>
                <input v-model="user.annee" class="field-input" /></label>
              <label class="field-group"><span>Zone</span>
                <input v-model="user.zone" class="field-input" /></label>
            </div>
            <button class="btn-primary" @click="saveUser" style="margin-top:1rem">Enregistrer</button>
          </div>
          <div class="adm-card">
            <h3 class="adm-card-h3">Activité récente</h3>
            <div v-if="activity" class="user-stats-grid">
              <div class="ustat"><div class="ustat-val">{{ activity.nb_parties }}</div><div class="ustat-lab">Parties</div></div>
              <div class="ustat"><div class="ustat-val">{{ activity.avg_score }}%</div><div class="ustat-lab">Taux réussite</div></div>
              <div class="ustat"><div class="ustat-val">{{ user.xp_total.toLocaleString() }}</div><div class="ustat-lab">XP total</div></div>
              <div class="ustat"><div class="ustat-val">{{ user.pieces_total }}</div><div class="ustat-lab">Pièces</div></div>
            </div>
          </div>
        </div>
        <div v-else class="loading">Chargement…</div>
      </div>

      <!-- STATISTIQUES ────────────────────────────────────────────────────── -->
      <div v-else-if="section === 'statistiques'" class="adm-section">
        <div class="adm-section-header"><h1>Statistiques</h1></div>
        <div class="adm-2col">
          <div class="adm-card">
            <h3 class="adm-card-h3">Meilleures maîtrises <span class="h3-hint">(≥ 3 tentatives)</span></h3>
            <div v-if="topQuestions.length" class="stat-q-list">
              <div v-for="q in topQuestions" :key="q.id" class="stat-q-row">
                <div class="stat-q-txt">{{ q.enonce.slice(0, 90) }}{{ q.enonce.length > 90 ? '…' : '' }}</div>
                <span :style="{ color: reussiteColor(q.taux_reussite), fontWeight: 700 }">{{ q.taux_reussite }}%</span>
              </div>
            </div>
            <div v-else class="stat-empty">Pas assez de données (min. 3 tentatives)</div>
          </div>
          <div class="adm-card">
            <h3 class="adm-card-h3">Plus difficiles <span class="h3-hint">(≥ 3 tentatives)</span></h3>
            <div v-if="bottomQuestions.length" class="stat-q-list">
              <div v-for="q in bottomQuestions" :key="q.id" class="stat-q-row">
                <div class="stat-q-txt">{{ q.enonce.slice(0, 90) }}{{ q.enonce.length > 90 ? '…' : '' }}</div>
                <span :style="{ color: reussiteColor(q.taux_reussite), fontWeight: 700 }">{{ q.taux_reussite }}%</span>
              </div>
            </div>
            <div v-else class="stat-empty">Pas assez de données</div>
          </div>
        </div>
        <div class="adm-card" style="margin-top:1rem">
          <h3 class="adm-card-h3">Distribution des difficultés</h3>
          <div class="dist-list" v-if="diffDistrib.length">
            <div v-for="d in diffDistrib" :key="d.label" class="dist-row">
              <span class="diff-badge" :style="{ background: diffColor(d.label) + '20', color: diffColor(d.label) }">{{ d.label }}</span>
              <div class="dist-track">
                <div class="dist-bar" :style="{ width: d.pct + '%', background: diffColor(d.label) }"></div>
              </div>
              <span class="dist-count">{{ d.nb }} ({{ d.pct }}%)</span>
            </div>
          </div>
          <div v-else class="stat-empty">Aucune question chargée — ouvrez d'abord l'onglet Questions.</div>
        </div>
      </div>

      <!-- RÉALISATIONS ────────────────────────────────────────────────────── -->
      <div v-else-if="section === 'realisations'" class="adm-section">
        <div class="adm-section-header">
          <h1>Réalisations</h1>
          <span class="adm-date">{{ realisations.filter(r => r.debloquee).length }} / {{ realisations.length }} débloquées</span>
        </div>
        <div v-if="realisations.length" class="real-grid">
          <div v-for="r in realisations" :key="r.id"
            :class="['real-card', { 'real-card--unlocked': r.debloquee }]">
            <div class="real-header">
              <div>
                <div class="real-name">{{ r.nom }}</div>
                <div class="real-id">{{ r.id }}</div>
              </div>
              <span :class="`real-badge real-badge--${r.rarete}`">{{ rareteLabel(r.rarete) }}</span>
            </div>
            <div class="real-desc">{{ r.description }}</div>
            <div class="real-footer">
              <div class="real-progress">
                <div class="real-prog-bar" :style="{ width: Math.min(r.progres / Math.max(r.objectif, 1) * 100, 100) + '%' }"></div>
              </div>
              <span class="real-prog-label">{{ r.progres }}/{{ r.objectif }}</span>
              <span v-if="r.debloquee" class="real-check">✓</span>
              <span class="real-reward">+{{ r.recompense_pieces }}🪙</span>
            </div>
          </div>
        </div>
        <div v-else class="loading">Chargement…</div>
      </div>

      <!-- PARAMÈTRES ──────────────────────────────────────────────────────── -->
      <div v-else-if="section === 'parametres'" class="adm-section">
        <div class="adm-section-header"><h1>Paramètres système</h1></div>
        <div class="adm-card">
          <h3 class="adm-card-h3">Informations</h3>
          <div class="sys-info">
            <div class="sys-row"><span>Backend</span><code>{{ apiBase }}</code></div>
            <div class="sys-row"><span>Version</span><code>1.0.0</code></div>
            <div class="sys-row"><span>Accès admin</span><code>Quintuple clic sur le logo EduClé</code></div>
          </div>
        </div>
        <div class="adm-card" style="margin-top:1rem">
          <h3 class="adm-card-h3">Zone dangereuse</h3>
          <p style="font-size:0.85rem;color:var(--text-muted);margin:0 0 0.75rem">Supprimer tout l'historique de parties. Les questions et réalisations ne sont pas affectées.</p>
          <button class="btn-danger" @click="clearAllScores">Effacer tous les scores</button>
        </div>
      </div>

    </main>

    <!-- ── Modals ────────────────────────────────────────────────────────── -->
    <transition name="modal-fade">
      <div v-if="modal" class="modal-bg" @click.self="modal = null">
        <div class="modal-box">

          <!-- Voir question -->
          <template v-if="modal.type === 'view'">
            <div class="modal-header">
              <h2>Question #{{ modal.question.id }}</h2>
              <button class="modal-close" @click="modal = null"><span class="material-symbols-outlined">close</span></button>
            </div>
            <div class="modal-body">
              <div class="view-enonce">{{ modal.question.enonce }}</div>
              <div class="view-choices">
                <div v-for="(c, i) in modal.question.choix" :key="i"
                  :class="['view-choice', { 'view-choice--correct': c === modal.question.bonne_reponse }]">
                  <span class="view-choice-letter">{{ String.fromCharCode(65 + i) }}</span>
                  <span style="flex:1">{{ c }}</span>
                  <span v-if="c === modal.question.bonne_reponse" class="material-symbols-outlined" style="color:#10B981;font-size:18px">check_circle</span>
                </div>
              </div>
              <div v-if="modal.question.explication" class="view-expl">
                <div class="view-expl-label">Explication</div>
                {{ modal.question.explication }}
              </div>
              <div class="view-stats">
                <div class="view-stat"><span>Tentatives</span><strong>{{ modal.question.nb_affichee }}</strong></div>
                <div class="view-stat"><span>Taux de réussite</span><strong :style="{ color: reussiteColor(modal.question.taux_reussite) }">{{ modal.question.taux_reussite }}%</strong></div>
                <div class="view-stat"><span>Matière</span><strong>{{ modal.question.matiere_nom }}</strong></div>
                <div class="view-stat"><span>Chapitre</span><strong>{{ modal.question.chapitre_titre }}</strong></div>
              </div>
            </div>
            <div class="modal-footer">
              <button class="btn-ghost" @click="modal = null">Fermer</button>
              <button class="btn-primary" @click="openEdit(modal.question)">Modifier</button>
            </div>
          </template>

          <!-- Créer / Modifier question -->
          <template v-else-if="modal.type === 'create' || modal.type === 'edit'">
            <div class="modal-header">
              <h2>{{ modal.type === 'create' ? 'Nouvelle question' : 'Modifier la question' }}</h2>
              <button class="modal-close" @click="modal = null"><span class="material-symbols-outlined">close</span></button>
            </div>
            <div class="modal-body modal-form-body">
              <div class="form-row">
                <label>Matière</label>
                <select v-model="modalMatiereId" class="field-input">
                  <option :value="null">— Choisir une matière —</option>
                  <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
                </select>
              </div>
              <div class="form-row">
                <label>Chapitre</label>
                <select v-model="modalForm.chapitre_id" class="field-input">
                  <option :value="null">— Choisir un chapitre —</option>
                  <option v-for="c in chapitresDuModal" :key="c.id" :value="c.id">{{ c.titre }}</option>
                </select>
              </div>
              <div class="form-row">
                <label>Question</label>
                <textarea v-model="modalForm.enonce" class="field-input field-textarea" rows="3" placeholder="Texte de la question…"></textarea>
              </div>
              <div class="form-row">
                <label>Réponses <span class="form-hint">— cliquer sur une ligne pour désigner la bonne réponse</span></label>
                <div class="choices-grid">
                  <div v-for="(_, i) in modalForm.choix" :key="i"
                    :class="['choice-wrap', { 'choice-wrap--correct': modalForm.bonne_reponse && modalForm.bonne_reponse === modalForm.choix[i] && modalForm.choix[i] }]"
                    @click="selectCorrectAnswer(i)">
                    <span class="choice-letter">{{ String.fromCharCode(65 + i) }}</span>
                    <input v-model="modalForm.choix[i]" class="choice-input"
                      :placeholder="`Réponse ${String.fromCharCode(65 + i)}`"
                      @click.stop @focus.stop />
                    <span v-if="modalForm.bonne_reponse && modalForm.bonne_reponse === modalForm.choix[i] && modalForm.choix[i]"
                      class="material-symbols-outlined" style="color:#10B981;font-size:18px;flex-shrink:0">check_circle</span>
                  </div>
                </div>
              </div>
              <div class="form-row">
                <label>Difficulté</label>
                <div class="diff-chips">
                  <button v-for="d in ['Facile','Moyen','Difficile']" :key="d"
                    :class="['diff-chip', { active: modalForm.niveau_complexite === d }]"
                    :style="modalForm.niveau_complexite === d ? { background: diffColor(d) + '20', color: diffColor(d), borderColor: diffColor(d) } : {}"
                    @click="modalForm.niveau_complexite = d">{{ d }}</button>
                </div>
              </div>
              <div class="form-row">
                <label>Explication</label>
                <textarea v-model="modalForm.explication" class="field-input field-textarea" rows="2" placeholder="Explication de la bonne réponse…"></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button class="btn-ghost" @click="modal = null">Annuler</button>
              <button class="btn-primary" @click="submitQuestion">
                {{ modal.type === 'create' ? 'Créer' : 'Enregistrer' }}
              </button>
            </div>
          </template>

          <!-- Ajouter / Modifier chapitre -->
          <template v-else-if="modal.type === 'add-chapitre' || modal.type === 'edit-chapitre'">
            <div class="modal-header">
              <h2>{{ modal.type === 'add-chapitre' ? 'Nouveau chapitre' : 'Modifier le chapitre' }}</h2>
              <button class="modal-close" @click="modal = null"><span class="material-symbols-outlined">close</span></button>
            </div>
            <div class="modal-body">
              <div class="form-row" v-if="modal.type === 'add-chapitre'">
                <label>Matière</label>
                <select v-model="chapitreForm.matiere_id" class="field-input">
                  <option :value="null">— Choisir —</option>
                  <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
                </select>
              </div>
              <div class="form-row">
                <label>Titre</label>
                <input v-model="chapitreForm.titre" class="field-input" placeholder="Ex : Algèbre linéaire" />
              </div>
            </div>
            <div class="modal-footer">
              <button class="btn-ghost" @click="modal = null">Annuler</button>
              <button class="btn-primary" @click="submitChapitre">
                {{ modal.type === 'add-chapitre' ? 'Créer' : 'Enregistrer' }}
              </button>
            </div>
          </template>

        </div>
      </div>
    </transition>

    <!-- Toast -->
    <transition name="toast-slide">
      <div v-if="toast" class="adm-toast">{{ toast }}</div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from 'axios'

const BASE = import.meta.env.VITE_API_URL || '/api'
const api = axios.create({ baseURL: BASE })
const apiBase = BASE

const SECTIONS = [
  { key: 'dashboard',    label: 'Tableau de bord', icon: 'dashboard' },
  { key: 'questions',    label: 'Questions',        icon: 'quiz' },
  { key: 'chapitres',    label: 'Chapitres',        icon: 'library_books' },
  { key: 'utilisateurs', label: 'Utilisateurs',     icon: 'people' },
  { key: 'statistiques', label: 'Statistiques',     icon: 'bar_chart' },
  { key: 'realisations', label: 'Réalisations',     icon: 'military_tech' },
  { key: 'parametres',   label: 'Paramètres',       icon: 'settings' },
]
const PERIODS = [
  { key: 'today', label: "Auj." },
  { key: '7d',    label: '7j' },
  { key: '30d',   label: '30j' },
  { key: '90d',   label: '3m' },
  { key: 'all',   label: 'Tout' },
]

const section  = ref('dashboard')
const period   = ref('7d')
const stats    = ref(null)
const activity = ref(null)
const questions    = ref([])
const matieres     = ref([])
const user         = ref(null)
const realisations = ref([])
const chapitresList = ref([])

const search         = ref('')
const filterMatiere  = ref(null)
const filterChapitre = ref(null)
const filterDiff     = ref('')

const modal          = ref(null)
const modalForm      = ref({})
const modalMatiereId = ref(null)
const chapitreForm   = ref({ matiere_id: null, titre: '' })

const toast = ref('')
let toastTimer = null

const todayLabel = computed(() =>
  new Date().toLocaleDateString('fr-FR', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
)

function showToast(msg) {
  toast.value = msg
  clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toast.value = '' }, 2500)
}

async function loadStats()        { try { stats.value        = await api.get('/admin/stats').then(r => r.data) } catch {} }
async function loadMatieres()     { try { matieres.value     = await api.get('/admin/matieres').then(r => r.data) } catch {} }
async function loadUser()         { try { user.value         = await api.get('/admin/user').then(r => r.data) } catch {} }
async function loadRealisations() { try { realisations.value = await api.get('/admin/realisations').then(r => r.data) } catch {} }
async function loadChapitresList(){ try { chapitresList.value = await api.get('/admin/chapitres').then(r => r.data) } catch {} }
async function loadActivity()     { try { activity.value     = await api.get('/admin/activity', { params: { period: period.value } }).then(r => r.data) } catch {} }

async function loadQuestions() {
  const params = {}
  if (filterMatiere.value)  params.matiere_id  = filterMatiere.value
  if (filterChapitre.value) params.chapitre_id = filterChapitre.value
  if (search.value)         params.search      = search.value
  try { questions.value = await api.get('/admin/questions', { params }).then(r => r.data) } catch {}
}

onMounted(() => { loadStats(); loadActivity(); loadMatieres() })

watch(section, s => {
  if ((s === 'questions' || s === 'statistiques') && !questions.value.length) loadQuestions()
  if (s === 'utilisateurs' && !user.value) { loadUser(); if (!activity.value) loadActivity() }
  if (s === 'realisations' && !realisations.value.length) loadRealisations()
  if (s === 'chapitres'    && !chapitresList.value.length) loadChapitresList()
})

watch(period, loadActivity)

let searchTimer = null
watch(search, () => {
  clearTimeout(searchTimer)
  searchTimer = setTimeout(() => { if (['questions','statistiques'].includes(section.value)) loadQuestions() }, 350)
})
watch([filterMatiere, filterChapitre], () => { if (['questions','statistiques'].includes(section.value)) loadQuestions() })

// Computed
const chartData = computed(() => activity.value?.daily || [])
const chartMax  = computed(() => Math.max(...chartData.value.map(d => d.nb), 1))

const questionsFiltered = computed(() =>
  filterDiff.value ? questions.value.filter(q => q.niveau_complexite === filterDiff.value) : questions.value
)
const topQuestions = computed(() =>
  [...questions.value].filter(q => q.nb_affichee >= 3).sort((a,b) => b.taux_reussite - a.taux_reussite).slice(0,5)
)
const bottomQuestions = computed(() =>
  [...questions.value].filter(q => q.nb_affichee >= 3).sort((a,b) => a.taux_reussite - b.taux_reussite).slice(0,5)
)
const diffDistrib = computed(() => {
  const total = questions.value.length
  if (!total) return []
  return ['Facile','Moyen','Difficile'].map(d => {
    const nb = questions.value.filter(q => q.niveau_complexite === d).length
    return { label: d, nb, pct: Math.round(nb / total * 100) }
  }).filter(d => d.nb > 0)
})
const chapitresDeMatiere = computed(() => {
  const mat = matieres.value.find(m => m.id === filterMatiere.value)
  return mat ? mat.chapitres : []
})
const chapitresDuModal = computed(() => {
  const mat = matieres.value.find(m => m.id === modalMatiereId.value)
  return mat ? mat.chapitres : []
})
const chapitresParMatiere = computed(() => {
  const g = {}
  for (const c of chapitresList.value) {
    if (!g[c.matiere_id]) g[c.matiere_id] = { id: c.matiere_id, nom: c.matiere_nom, chapitres: [] }
    g[c.matiere_id].chapitres.push(c)
  }
  return Object.values(g)
})

// Helpers
function diffColor(d)     { return d === 'Facile' ? '#10B981' : d === 'Difficile' ? '#EF4444' : '#F59E0B' }
function reussiteColor(p) { return p >= 70 ? '#10B981' : p >= 40 ? '#F59E0B' : '#EF4444' }
function rareteLabel(r)   { return ['','Commun','Rare','Épique','Légendaire'][r] || '?' }
function formatDate(iso)  { return iso ? iso.slice(0, 10) : '—' }
function clearFilters()   { search.value = ''; filterMatiere.value = null; filterChapitre.value = null; filterDiff.value = ''; loadQuestions() }

// Modal helpers
function openCreate() {
  modalMatiereId.value = null
  modalForm.value = { chapitre_id: null, enonce: '', choix: ['','','',''], bonne_reponse: '', explication: '', niveau_complexite: 'Moyen' }
  modal.value = { type: 'create' }
}
function openEdit(q) {
  for (const m of matieres.value) if (m.chapitres.some(c => c.id === q.chapitre_id)) { modalMatiereId.value = m.id; break }
  modalForm.value = { chapitre_id: q.chapitre_id, enonce: q.enonce, choix: [...q.choix], bonne_reponse: q.bonne_reponse, explication: q.explication, niveau_complexite: q.niveau_complexite }
  modal.value = { type: 'edit', question: q }
}
function openView(q)         { modal.value = { type: 'view', question: q } }
function openAddChapitre()   { chapitreForm.value = { matiere_id: null, titre: '' }; modal.value = { type: 'add-chapitre' } }
function openEditChapitre(c) { chapitreForm.value = { id: c.id, matiere_id: c.matiere_id, titre: c.titre }; modal.value = { type: 'edit-chapitre' } }
function selectCorrectAnswer(i) { if (modalForm.value.choix[i]) modalForm.value.bonne_reponse = modalForm.value.choix[i] }

// Actions
async function submitQuestion() {
  const id = modal.value.question?.id
  try {
    if (modal.value.type === 'create') { await api.post('/admin/questions', modalForm.value); showToast('Question créée') }
    else { await api.put(`/admin/questions/${id}`, modalForm.value); showToast('Question mise à jour') }
    modal.value = null; loadQuestions(); loadStats()
  } catch (e) { showToast(e.response?.data?.detail || 'Erreur lors de la sauvegarde') }
}

async function deleteQuestion(id) {
  if (!confirm('Supprimer cette question définitivement ?')) return
  try { await api.delete(`/admin/questions/${id}`); questions.value = questions.value.filter(q => q.id !== id); showToast('Question supprimée'); loadStats() } catch {}
}

async function duplicateQuestion(q) {
  try { await api.post('/admin/questions', { chapitre_id: q.chapitre_id, enonce: q.enonce + ' (copie)', choix: [...q.choix], bonne_reponse: q.bonne_reponse, explication: q.explication, niveau_complexite: q.niveau_complexite }); showToast('Question dupliquée'); loadQuestions(); loadStats() } catch {}
}

async function submitChapitre() {
  try {
    if (modal.value.type === 'add-chapitre') {
      const c = await api.post('/admin/chapitres', chapitreForm.value).then(r => r.data)
      chapitresList.value.push(c); showToast('Chapitre créé')
    } else {
      const c = await api.put(`/admin/chapitres/${chapitreForm.value.id}`, { titre: chapitreForm.value.titre }).then(r => r.data)
      const idx = chapitresList.value.findIndex(x => x.id === c.id)
      if (idx >= 0) chapitresList.value[idx] = c; showToast('Chapitre modifié')
    }
    modal.value = null
  } catch (e) { showToast(e.response?.data?.detail || 'Erreur') }
}

async function deleteChapitre(id) {
  if (!confirm('Supprimer ce chapitre ?')) return
  try { await api.delete(`/admin/chapitres/${id}`); chapitresList.value = chapitresList.value.filter(c => c.id !== id); showToast('Chapitre supprimé') }
  catch (e) { showToast(e.response?.data?.detail || 'Impossible: des questions existent dans ce chapitre') }
}

async function saveUser() {
  try { user.value = await api.patch('/admin/user', { xp_total: user.value.xp_total, pieces_total: user.value.pieces_total, niveau_scolaire: user.value.niveau_scolaire, annee: user.value.annee, zone: user.value.zone }).then(r => r.data); showToast('Utilisateur mis à jour') } catch {}
}

async function clearAllScores() {
  if (!confirm('Effacer TOUS les scores ? Cette action est irréversible.')) return
  try {
    const scores = await api.get('/admin/scores', { params: { limit: 10000 } }).then(r => r.data)
    await Promise.all(scores.map(s => api.delete(`/admin/scores/${s.id}`)))
    showToast(`${scores.length} score(s) effacé(s)`); loadStats(); loadActivity()
  } catch { showToast('Erreur lors de la suppression') }
}
</script>

<style scoped>
.adm { display: flex; min-height: 100dvh; background: var(--bg); font-family: inherit; }

/* Sidebar */
.adm-nav { width: 220px; min-width: 220px; height: 100dvh; position: sticky; top: 0; background: var(--surface); border-right: 1px solid var(--border); display: flex; flex-direction: column; overflow-y: auto; flex-shrink: 0; }
.adm-main { flex: 1; min-width: 0; overflow-y: auto; }

.adm-brand { padding: 1.25rem 1rem; display: flex; align-items: center; gap: 0.65rem; border-bottom: 1px solid var(--border); }
.adm-brand-icon { font-size: 1.4rem; flex-shrink: 0; }
.adm-brand-title { font-size: 0.95rem; font-weight: 800; color: var(--primary); }
.adm-brand-sub { font-size: 0.63rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--text-muted); font-weight: 600; margin-top: 0.1rem; }

.adm-nav-list { flex: 1; padding: 0.5rem; display: flex; flex-direction: column; gap: 0.1rem; }
.adm-nav-item { display: flex; align-items: center; gap: 0.6rem; padding: 0.5rem 0.75rem; border-radius: 8px; font-size: 0.875rem; font-weight: 600; color: var(--text-muted); background: none; border: none; cursor: pointer; text-align: left; width: 100%; transition: background 0.12s, color 0.12s; }
.adm-nav-item:hover { background: var(--primary-light-solid); color: var(--text); }
.adm-nav-item.active { background: var(--primary-light-solid); color: var(--primary); }
.adm-nav-item.active .material-symbols-outlined { color: var(--primary); }
.adm-nav-label { flex: 1; }
.adm-nav-foot { padding: 0.75rem 0.5rem; border-top: 1px solid var(--border); }

/* Section */
.adm-section { padding: 1.5rem; max-width: 1400px; }
.adm-section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.25rem; }
.adm-section-header h1 { font-size: 1.35rem; font-weight: 800; color: var(--text); margin: 0; }
.adm-date { font-size: 0.8rem; color: var(--text-muted); }

/* KPI */
.kpi-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(155px, 1fr)); gap: 0.75rem; }
.kpi-card { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; padding: 0.9rem 1rem; display: flex; align-items: center; gap: 0.75rem; }
.kpi-icon { width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.kpi-icon .material-symbols-outlined { font-size: 22px; }
.kpi-value { font-size: 1.25rem; font-weight: 800; color: var(--text); }
.kpi-label { font-size: 0.7rem; color: var(--text-muted); font-weight: 600; margin-top: 0.1rem; }

/* Card */
.adm-card { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; padding: 1rem 1.25rem; }
.adm-card-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.75rem; }
.adm-card-header h3 { font-size: 0.9rem; font-weight: 700; margin: 0; }
.adm-card-h3 { font-size: 0.88rem; font-weight: 700; margin: 0 0 0.75rem; color: var(--text); }
.h3-hint { font-size: 0.7rem; font-weight: 400; color: var(--text-muted); }

/* Period tabs */
.period-tabs { display: flex; gap: 0.15rem; background: var(--bg); border: 1px solid var(--border); border-radius: 8px; padding: 2px; }
.period-tab { padding: 0.2rem 0.55rem; font-size: 0.78rem; font-weight: 600; border-radius: 6px; border: none; background: none; cursor: pointer; color: var(--text-muted); }
.period-tab.active { background: var(--primary); color: white; }

/* Chart */
.activity-summary { font-size: 0.82rem; color: var(--text-muted); margin-bottom: 0.75rem; display: flex; gap: 0.5rem; }
.activity-summary strong { color: var(--text); }
.chart-container { width: 100%; overflow: hidden; }
.chart-bars { display: flex; align-items: flex-end; gap: 2px; height: 130px; padding-bottom: 20px; }
.chart-bar-wrap { flex: 1; display: flex; flex-direction: column; align-items: center; position: relative; cursor: default; }
.chart-bar { width: 100%; background: var(--primary); border-radius: 3px 3px 0 0; min-height: 3px; transition: background 0.12s; }
.chart-bar-wrap:hover .chart-bar { background: #1D5FDF; }
.chart-label { font-size: 0.58rem; color: var(--text-muted); position: absolute; bottom: -18px; white-space: nowrap; text-align: center; }
.chart-empty { padding: 1.5rem; text-align: center; color: var(--text-muted); font-size: 0.85rem; }
.loading { padding: 2rem; text-align: center; color: var(--text-muted); font-size: 0.85rem; }

/* 2-col */
.adm-2col { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }

/* Distribution */
.dist-list { display: flex; flex-direction: column; gap: 0.5rem; }
.dist-row { display: flex; align-items: center; gap: 0.5rem; font-size: 0.82rem; }
.dist-label { width: 120px; flex-shrink: 0; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.dist-track { flex: 1; height: 8px; background: var(--border); border-radius: 99px; overflow: hidden; }
.dist-bar { height: 100%; background: var(--primary); border-radius: 99px; min-width: 2px; transition: width 0.4s; }
.dist-bar--green { background: #10B981; }
.dist-count { width: 30px; text-align: right; color: var(--text-muted); font-variant-numeric: tabular-nums; font-size: 0.78rem; }

/* Filters */
.filters-bar { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 0.75rem; align-items: center; }
.search-wrap { position: relative; flex: 1; min-width: 180px; }
.search-icon { position: absolute; left: 0.55rem; top: 50%; transform: translateY(-50%); font-size: 18px; color: var(--text-muted); pointer-events: none; }
.search-input { width: 100%; box-sizing: border-box; padding: 0.42rem 0.75rem 0.42rem 2.1rem; border: 1px solid var(--border); border-radius: 8px; font-size: 0.875rem; background: var(--bg); color: var(--text); outline: none; }
.search-input:focus { border-color: var(--primary); }
.filter-select { padding: 0.42rem 0.6rem; border: 1px solid var(--border); border-radius: 8px; font-size: 0.82rem; background: var(--bg); color: var(--text); outline: none; cursor: pointer; }

/* Buttons */
.btn-primary { display: inline-flex; align-items: center; gap: 0.35rem; padding: 0.42rem 0.9rem; background: var(--primary); color: white; border: none; border-radius: 8px; font-size: 0.875rem; font-weight: 600; cursor: pointer; }
.btn-primary:hover { background: #1D5FDF; }
.btn-ghost { padding: 0.42rem 0.9rem; background: none; border: 1px solid var(--border); border-radius: 8px; font-size: 0.875rem; font-weight: 600; cursor: pointer; color: var(--text-muted); }
.btn-ghost:hover { background: var(--primary-light-solid); color: var(--text); }
.btn-danger { padding: 0.42rem 0.9rem; background: #FEE2E2; border: 1px solid #FECACA; border-radius: 8px; font-size: 0.875rem; font-weight: 600; cursor: pointer; color: #DC2626; }
.btn-danger:hover { background: #FECACA; }

/* Question table */
.q-table-wrap { overflow-x: auto; border: 1px solid var(--border); border-radius: 10px; }
.q-table { width: 100%; border-collapse: collapse; font-size: 0.82rem; }
.q-table th { padding: 0.55rem 0.75rem; text-align: left; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-muted); background: var(--bg); border-bottom: 1px solid var(--border); white-space: nowrap; }
.q-table td { padding: 0.55rem 0.75rem; vertical-align: top; border-bottom: 1px solid var(--border); }
.q-table tbody tr:last-child td { border-bottom: none; }
.q-row:hover { background: var(--bg); }
.q-empty { text-align: center; padding: 2rem; color: var(--text-muted); }
.q-count { font-size: 0.75rem; color: var(--text-muted); margin-top: 0.4rem; }
.th-n { width: 38px; } .th-q { min-width: 240px; } .th-a { min-width: 170px; } .th-num { width: 68px; text-align: right; } .th-actions { width: 115px; }
.td-n { color: var(--text-muted); font-variant-numeric: tabular-nums; font-size: 0.78rem; }
.td-q { max-width: 280px; line-height: 1.4; } .td-a { max-width: 200px; color: #10B981; font-weight: 600; line-height: 1.4; }
.td-num { text-align: right; font-variant-numeric: tabular-nums; }
.td-date { white-space: nowrap; color: var(--text-muted); font-size: 0.75rem; }
.td-meta { min-width: 120px; }
.mat-badge { display: block; font-size: 0.7rem; font-weight: 700; color: var(--primary); }
.chap-badge { display: block; font-size: 0.7rem; color: var(--text-muted); }
.diff-badge { display: inline-block; padding: 0.12rem 0.45rem; border-radius: 99px; font-size: 0.7rem; font-weight: 700; }
.mastery-wrap { width: 56px; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.mastery-bar { height: 100%; border-radius: 99px; min-width: 2px; }
.icon-btn { background: none; border: none; cursor: pointer; padding: 0.2rem; border-radius: 6px; color: var(--text-muted); display: inline-flex; align-items: center; }
.icon-btn:hover { background: var(--primary-light-solid); color: var(--text); }
.icon-btn--danger:hover { background: #FEE2E2; color: #EF4444; }
.icon-btn .material-symbols-outlined { font-size: 18px; }
.td-actions { white-space: nowrap; }

/* Chapitres */
.matiere-tree { display: flex; flex-direction: column; gap: 0.75rem; }
.matiere-group { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; overflow: hidden; }
.matiere-header { display: flex; align-items: center; gap: 0.5rem; padding: 0.7rem 1rem; background: var(--bg); border-bottom: 1px solid var(--border); font-weight: 700; font-size: 0.88rem; }
.mat-count { margin-left: auto; font-size: 0.72rem; color: var(--text-muted); font-weight: 500; }
.chap-list { padding: 0.4rem; display: flex; flex-direction: column; gap: 0.2rem; }
.chap-row { display: flex; align-items: center; gap: 0.5rem; padding: 0.45rem 0.75rem; border-radius: 8px; }
.chap-row:hover { background: var(--bg); }
.chap-name { flex: 1; font-size: 0.875rem; }
.chap-nb { font-size: 0.72rem; color: var(--text-muted); white-space: nowrap; }
.chap-actions { display: flex; gap: 0.2rem; }
.chap-empty { padding: 0.5rem 0.75rem; font-size: 0.82rem; color: var(--text-muted); font-style: italic; }

/* Utilisateur */
.user-fields { display: flex; flex-direction: column; gap: 0.65rem; }
.field-group { display: flex; flex-direction: column; gap: 0.2rem; font-size: 0.8rem; font-weight: 600; color: var(--text-muted); }
.field-input { padding: 0.42rem 0.65rem; border: 1px solid var(--border); border-radius: 8px; font-size: 0.875rem; background: var(--bg); color: var(--text); outline: none; }
.field-input:focus { border-color: var(--primary); }
.field-textarea { resize: vertical; font-family: inherit; }
.user-stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem; }
.ustat { background: var(--bg); border: 1px solid var(--border); border-radius: 10px; padding: 0.75rem; text-align: center; }
.ustat-val { font-size: 1.25rem; font-weight: 800; color: var(--text); }
.ustat-lab { font-size: 0.7rem; color: var(--text-muted); font-weight: 600; margin-top: 0.1rem; }

/* Stats */
.stat-q-list { display: flex; flex-direction: column; gap: 0.4rem; }
.stat-q-row { display: flex; align-items: center; gap: 0.5rem; padding: 0.45rem 0.5rem; border-radius: 8px; background: var(--bg); font-size: 0.8rem; }
.stat-q-txt { flex: 1; color: var(--text); line-height: 1.3; }
.stat-empty { color: var(--text-muted); font-size: 0.82rem; }

/* Réalisations */
.real-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(270px, 1fr)); gap: 0.75rem; }
.real-card { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; padding: 1rem; display: flex; flex-direction: column; gap: 0.5rem; }
.real-card--unlocked { border-color: #10B981; }
.real-header { display: flex; align-items: flex-start; justify-content: space-between; gap: 0.5rem; }
.real-name { font-weight: 700; font-size: 0.88rem; }
.real-id { font-size: 0.68rem; color: var(--text-muted); font-family: monospace; margin-top: 0.1rem; }
.real-desc { font-size: 0.8rem; color: var(--text-muted); line-height: 1.4; }
.real-badge { padding: 0.12rem 0.45rem; border-radius: 99px; font-size: 0.68rem; font-weight: 700; color: white; flex-shrink: 0; }
.real-badge--1 { background: #6B7280; } .real-badge--2 { background: #3B82F6; } .real-badge--3 { background: #8B5CF6; } .real-badge--4 { background: #F59E0B; }
.real-footer { display: flex; align-items: center; gap: 0.5rem; margin-top: auto; padding-top: 0.25rem; }
.real-progress { flex: 1; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.real-prog-bar { height: 100%; background: var(--primary); border-radius: 99px; }
.real-prog-label { font-size: 0.7rem; color: var(--text-muted); white-space: nowrap; }
.real-check { font-size: 0.72rem; color: #10B981; font-weight: 700; }
.real-reward { font-size: 0.72rem; color: var(--text-muted); margin-left: auto; }

/* Paramètres */
.sys-info { display: flex; flex-direction: column; gap: 0.5rem; }
.sys-row { display: flex; align-items: flex-start; gap: 1rem; font-size: 0.85rem; }
.sys-row span { color: var(--text-muted); width: 90px; flex-shrink: 0; padding-top: 0.1rem; }
.sys-row code { background: var(--bg); border: 1px solid var(--border); border-radius: 6px; padding: 0.2rem 0.5rem; font-size: 0.78rem; word-break: break-all; }

/* Modal */
.modal-bg { position: fixed; inset: 0; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; z-index: 100; padding: 1rem; }
.modal-box { background: var(--surface); border: 1px solid var(--border); border-radius: 16px; width: 100%; max-width: 600px; max-height: 90dvh; display: flex; flex-direction: column; overflow: hidden; }
.modal-header { display: flex; align-items: center; justify-content: space-between; padding: 1rem 1.25rem; border-bottom: 1px solid var(--border); flex-shrink: 0; }
.modal-header h2 { font-size: 1rem; font-weight: 700; margin: 0; }
.modal-close { background: none; border: none; cursor: pointer; color: var(--text-muted); display: flex; padding: 0; }
.modal-close:hover { color: var(--text); }
.modal-body { flex: 1; overflow-y: auto; padding: 1.25rem; display: flex; flex-direction: column; gap: 0.75rem; }
.modal-footer { padding: 0.75rem 1.25rem; border-top: 1px solid var(--border); display: flex; justify-content: flex-end; gap: 0.5rem; flex-shrink: 0; }

.view-enonce { font-size: 0.95rem; font-weight: 600; line-height: 1.5; color: var(--text); }
.view-choices { display: flex; flex-direction: column; gap: 0.35rem; }
.view-choice { display: flex; align-items: flex-start; gap: 0.5rem; padding: 0.55rem 0.75rem; border-radius: 8px; border: 1px solid var(--border); background: var(--bg); font-size: 0.875rem; }
.view-choice--correct { border-color: #10B981; background: #F0FDF4; color: #065F46; }
.view-choice-letter { font-weight: 700; flex-shrink: 0; width: 16px; }
.view-expl { background: var(--bg); border: 1px solid var(--border); border-radius: 8px; padding: 0.65rem 0.75rem; font-size: 0.82rem; color: var(--text-muted); }
.view-expl-label { font-weight: 700; color: var(--text); margin-bottom: 0.2rem; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.05em; }
.view-stats { display: grid; grid-template-columns: 1fr 1fr; gap: 0.4rem; }
.view-stat { background: var(--bg); border: 1px solid var(--border); border-radius: 8px; padding: 0.45rem 0.65rem; }
.view-stat span { display: block; font-size: 0.68rem; color: var(--text-muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 0.1rem; }
.view-stat strong { font-size: 0.88rem; }

.form-row { display: flex; flex-direction: column; gap: 0.25rem; }
.form-row > label { font-size: 0.8rem; font-weight: 600; color: var(--text-muted); }
.form-hint { font-weight: 400; font-size: 0.72rem; }
.choices-grid { display: flex; flex-direction: column; gap: 0.35rem; }
.choice-wrap { display: flex; align-items: center; gap: 0.5rem; padding: 0.32rem 0.55rem; border: 1px solid var(--border); border-radius: 8px; cursor: pointer; transition: border-color 0.12s; }
.choice-wrap:hover { border-color: var(--primary); }
.choice-wrap--correct { border-color: #10B981; background: #F0FDF4; }
.choice-letter { font-weight: 700; color: var(--text-muted); width: 16px; flex-shrink: 0; font-size: 0.82rem; }
.choice-input { flex: 1; border: none; background: transparent; font-size: 0.875rem; color: var(--text); outline: none; cursor: pointer; }
.diff-chips { display: flex; gap: 0.4rem; }
.diff-chip { padding: 0.32rem 0.8rem; border: 1px solid var(--border); border-radius: 8px; font-size: 0.82rem; font-weight: 600; cursor: pointer; background: none; color: var(--text-muted); }
.diff-chip.active { font-weight: 700; }

/* Toast */
.adm-toast { position: fixed; bottom: 1.5rem; left: 50%; transform: translateX(-50%); background: #1E293B; color: white; padding: 0.55rem 1.25rem; border-radius: 10px; font-size: 0.875rem; font-weight: 600; z-index: 200; box-shadow: 0 4px 12px rgba(0,0,0,0.18); white-space: nowrap; }

/* Transitions */
.modal-fade-enter-active, .modal-fade-leave-active { transition: opacity 0.15s; }
.modal-fade-enter-from, .modal-fade-leave-to { opacity: 0; }
.toast-slide-enter-active, .toast-slide-leave-active { transition: opacity 0.2s, transform 0.2s; }
.toast-slide-enter-from, .toast-slide-leave-to { opacity: 0; transform: translateX(-50%) translateY(0.5rem); }

/* Responsive */
@media (max-width: 900px) { .adm-2col { grid-template-columns: 1fr; } }
@media (max-width: 768px) {
  .adm-nav { width: 54px; min-width: 54px; }
  .adm-nav-label { display: none; }
  .adm-brand-text { display: none; }
  .adm-brand { justify-content: center; padding: 1rem 0; }
  .adm-nav-item { justify-content: center; padding: 0.6rem; }
  .adm-section { padding: 1rem; }
  .kpi-grid { grid-template-columns: repeat(2, 1fr); }
  .q-table th:nth-child(4), .q-table td:nth-child(4),
  .q-table th:nth-child(8), .q-table td:nth-child(8),
  .q-table th:nth-child(9), .q-table td:nth-child(9) { display: none; }
}
</style>
