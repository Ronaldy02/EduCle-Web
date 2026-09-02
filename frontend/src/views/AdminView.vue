<template>
  <div class="adm-wrap">

    <!-- ── Sidebar onglets ────────────────────────────────── -->
    <aside class="adm-sidebar">
      <div class="adm-brand">
        <span class="material-symbols-outlined" style="color:var(--primary)">admin_panel_settings</span>
        <span>Admin EduClé</span>
      </div>
      <nav class="adm-nav">
        <button v-for="t in TABS" :key="t.key"
          class="adm-nav-btn" :class="{ active: onglet === t.key }"
          @click="onglet = t.key">
          <span class="material-symbols-outlined">{{ t.icon }}</span>
          {{ t.label }}
        </button>
      </nav>
    </aside>

    <!-- ── Contenu ────────────────────────────────────────── -->
    <main class="adm-main">

      <!-- ═══ TABLEAU DE BORD ═══ -->
      <section v-if="onglet === 'dash'">
        <h1 class="adm-titre">Tableau de bord</h1>
        <div v-if="stats" class="adm-kpi-grid">
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.nb_questions }}</span><span class="adm-kpi-lib">Questions</span></div>
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.nb_matieres }}</span><span class="adm-kpi-lib">Matières</span></div>
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.nb_chapitres }}</span><span class="adm-kpi-lib">Chapitres</span></div>
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.nb_parties }}</span><span class="adm-kpi-lib">Parties jouées</span></div>
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.xp_total }}</span><span class="adm-kpi-lib">XP total</span></div>
          <div class="adm-kpi"><span class="adm-kpi-val">{{ stats.pieces_total }}</span><span class="adm-kpi-lib">Pièces</span></div>
        </div>

        <h2 class="adm-sous-titre" style="margin-top:2rem">Dernières parties</h2>
        <div class="adm-table-wrap">
          <table class="adm-table">
            <thead><tr><th>Date</th><th>Mode</th><th>Score</th><th>Total</th><th></th></tr></thead>
            <tbody>
              <tr v-for="s in scores" :key="s.id">
                <td>{{ s.date.slice(0,16).replace('T',' ') }}</td>
                <td><span class="adm-badge" :class="'badge-' + s.mode_nom.toLowerCase()">{{ s.mode_nom }}</span></td>
                <td><strong>{{ s.nb_correctes }}</strong>/{{ s.nb_total }}</td>
                <td>{{ Math.round(s.nb_correctes / s.nb_total * 100) }}%</td>
                <td>
                  <button class="adm-icon-btn danger" title="Supprimer" @click="supprimerScore(s.id)">
                    <span class="material-symbols-outlined">delete</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <!-- ═══ QUESTIONS ═══ -->
      <section v-else-if="onglet === 'questions'">
        <div class="adm-section-head">
          <h1 class="adm-titre">Questions</h1>
          <button class="adm-btn-primary" @click="ouvrirFormQuestion(null)">
            <span class="material-symbols-outlined">add</span> Nouvelle question
          </button>
        </div>

        <!-- Filtres -->
        <div class="adm-filtres">
          <input v-model="recherche" class="adm-input" placeholder="Rechercher une question…" style="flex:1;min-width:200px" />
          <select v-model="filtreMatiere" class="adm-select" @change="filtreChap = ''">
            <option value="">Toutes les matières</option>
            <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
          </select>
          <select v-model="filtreChap" class="adm-select" :disabled="!filtreMatiere">
            <option value="">Tous les chapitres</option>
            <option v-for="c in chapsDeLaMatiere" :key="c.id" :value="c.id">{{ c.titre }}</option>
          </select>
        </div>

        <!-- Compteur -->
        <p class="adm-count">{{ questionsFiltrees.length }} question{{ questionsFiltrees.length > 1 ? 's' : '' }}</p>

        <div class="adm-table-wrap">
          <table class="adm-table">
            <thead>
              <tr>
                <th>#</th>
                <th>Matière · Chapitre</th>
                <th>Énoncé</th>
                <th>Niveau</th>
                <th>Vues</th>
                <th>Réussite</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="q in questionsFiltrees" :key="q.id">
                <td class="adm-td-id">{{ q.id }}</td>
                <td class="adm-td-mat">
                  <span class="adm-mat-nom">{{ q.matiere_nom }}</span>
                  <span class="adm-chap-titre">{{ q.chapitre_titre }}</span>
                </td>
                <td class="adm-td-enonce">{{ q.enonce }}</td>
                <td>
                  <span class="adm-badge" :class="'badge-' + q.niveau_complexite.toLowerCase()">
                    {{ q.niveau_complexite }}
                  </span>
                </td>
                <td>{{ q.nb_affichee }}</td>
                <td>
                  <span :style="{ color: couleurTaux(q.taux_reussite) }">
                    {{ q.nb_affichee > 0 ? q.taux_reussite + '%' : '—' }}
                  </span>
                </td>
                <td class="adm-td-actions">
                  <button class="adm-icon-btn" title="Modifier" @click="ouvrirFormQuestion(q)">
                    <span class="material-symbols-outlined">edit</span>
                  </button>
                  <button class="adm-icon-btn danger" title="Supprimer" @click="supprimerQuestion(q.id)">
                    <span class="material-symbols-outlined">delete</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <!-- ═══ UTILISATEUR ═══ -->
      <section v-else-if="onglet === 'user'">
        <h1 class="adm-titre">Utilisateur</h1>
        <div v-if="userEdit" class="adm-user-grid">

          <div class="adm-card">
            <h3 class="adm-card-titre">Progression</h3>
            <div class="adm-field">
              <label>XP total</label>
              <input v-model.number="userEdit.xp_total" type="number" class="adm-input" />
            </div>
            <div class="adm-field">
              <label>Pièces</label>
              <input v-model.number="userEdit.pieces_total" type="number" class="adm-input" />
            </div>
            <button class="adm-btn-primary" style="margin-top:1rem" @click="sauvegarderUser">
              <span class="material-symbols-outlined">save</span> Sauvegarder
            </button>
          </div>

          <div class="adm-card">
            <h3 class="adm-card-titre">Profil scolaire</h3>
            <div class="adm-field">
              <label>Cycle</label>
              <select v-model="userEdit.niveau_scolaire" class="adm-select" style="width:100%">
                <option>Fondamental</option>
                <option>Secondaire</option>
              </select>
            </div>
            <div class="adm-field">
              <label>Année</label>
              <select v-model="userEdit.annee" class="adm-select" style="width:100%">
                <option v-for="a in anneeOptions" :key="a">{{ a }}</option>
              </select>
            </div>
            <div class="adm-field">
              <label>Zone</label>
              <input v-model="userEdit.zone" class="adm-input" placeholder="ex: Ouest" />
            </div>
            <button class="adm-btn-primary" style="margin-top:1rem" @click="sauvegarderUser">
              <span class="material-symbols-outlined">save</span> Sauvegarder
            </button>
          </div>

        </div>
      </section>

    </main>

    <!-- ══════ MODALE QUESTION ══════ -->
    <transition name="modal-fade">
      <div v-if="formVisible" class="adm-modal-bg" @click.self="formVisible = false">
        <div class="adm-modal">
          <div class="adm-modal-head">
            <h2>{{ formQuestion.id ? 'Modifier' : 'Nouvelle' }} question</h2>
            <button class="adm-icon-btn" @click="formVisible = false">
              <span class="material-symbols-outlined">close</span>
            </button>
          </div>

          <div class="adm-form">
            <!-- Chapitre -->
            <div class="adm-field">
              <label>Matière</label>
              <select v-model="formMatiereId" class="adm-select" style="width:100%" @change="formQuestion.chapitre_id = ''">
                <option value="" disabled>— choisir —</option>
                <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
              </select>
            </div>
            <div class="adm-field">
              <label>Chapitre</label>
              <select v-model="formQuestion.chapitre_id" class="adm-select" style="width:100%" :disabled="!formMatiereId">
                <option value="" disabled>— choisir —</option>
                <option v-for="c in chapsFormMatiere" :key="c.id" :value="c.id">{{ c.titre }}</option>
              </select>
            </div>

            <!-- Énoncé -->
            <div class="adm-field">
              <label>Énoncé</label>
              <textarea v-model="formQuestion.enonce" class="adm-input adm-textarea" rows="3" placeholder="Question…" />
            </div>

            <!-- Choix -->
            <div class="adm-field">
              <label>Choix de réponses (4)</label>
              <div v-for="(_, i) in formQuestion.choix" :key="i" class="adm-choix-row">
                <span class="adm-choix-letter">{{ ['A','B','C','D'][i] }}</span>
                <input v-model="formQuestion.choix[i]" class="adm-input" :placeholder="'Choix ' + ['A','B','C','D'][i]" />
                <button
                  class="adm-radio-btn"
                  :class="{ selected: formQuestion.bonne_reponse === formQuestion.choix[i] && formQuestion.choix[i] }"
                  type="button"
                  :title="'Marquer comme bonne réponse'"
                  @click="formQuestion.bonne_reponse = formQuestion.choix[i]">
                  <span class="material-symbols-outlined">{{ formQuestion.bonne_reponse === formQuestion.choix[i] && formQuestion.choix[i] ? 'check_circle' : 'radio_button_unchecked' }}</span>
                </button>
              </div>
              <p v-if="formQuestion.bonne_reponse" class="adm-bonne-rep-hint">
                ✓ Bonne réponse : <strong>{{ formQuestion.bonne_reponse }}</strong>
              </p>
            </div>

            <!-- Explication -->
            <div class="adm-field">
              <label>Explication</label>
              <textarea v-model="formQuestion.explication" class="adm-input adm-textarea" rows="2" placeholder="Explication de la réponse…" />
            </div>

            <!-- Niveau -->
            <div class="adm-field">
              <label>Niveau de complexité</label>
              <div class="adm-niveau-chips">
                <button v-for="n in ['Facile','Moyen','Difficile']" :key="n"
                  type="button" class="adm-niveau-chip"
                  :class="{ active: formQuestion.niveau_complexite === n }"
                  @click="formQuestion.niveau_complexite = n">{{ n }}</button>
              </div>
            </div>

            <!-- Erreur -->
            <p v-if="formErreur" class="adm-erreur">{{ formErreur }}</p>

            <!-- Boutons -->
            <div class="adm-form-actions">
              <button class="adm-btn-secondary" type="button" @click="formVisible = false">Annuler</button>
              <button class="adm-btn-primary" type="button" @click="soumettreQuestion" :disabled="formEnvoi">
                <span v-if="formEnvoi" class="material-symbols-outlined adm-spin">refresh</span>
                <span v-else class="material-symbols-outlined">save</span>
                {{ formQuestion.id ? 'Enregistrer' : 'Créer' }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Toast -->
    <transition name="toast-slide">
      <div v-if="toast" class="adm-toast" :class="toast.type">
        <span class="material-symbols-outlined">{{ toast.type === 'ok' ? 'check_circle' : 'error' }}</span>
        {{ toast.msg }}
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from 'axios'

const API = import.meta.env.VITE_API_URL ?? 'https://educle-api.onrender.com'
const api = axios.create({ baseURL: API })

// ── Onglets ───────────────────────────────────────────────────────
const TABS = [
  { key: 'dash',      label: 'Tableau de bord',  icon: 'dashboard' },
  { key: 'questions', label: 'Questions',         icon: 'quiz' },
  { key: 'user',      label: 'Utilisateur',       icon: 'person' },
]
const onglet = ref('dash')

// ── Données ───────────────────────────────────────────────────────
const stats     = ref(null)
const scores    = ref([])
const questions = ref([])
const matieres  = ref([])
const userEdit  = ref(null)

// ── Filtres ───────────────────────────────────────────────────────
const recherche   = ref('')
const filtreMatiere = ref('')
const filtreChap    = ref('')

const chapsDeLaMatiere = computed(() =>
  filtreMatiere.value
    ? (matieres.value.find(m => m.id === filtreMatiere.value)?.chapitres ?? [])
    : []
)

const questionsFiltrees = computed(() => {
  let list = questions.value
  if (filtreChap.value)    list = list.filter(q => q.chapitre_id    === filtreChap.value)
  else if (filtreMatiere.value) list = list.filter(q => q.matiere_id === filtreMatiere.value)
  if (recherche.value.trim())
    list = list.filter(q => q.enonce.toLowerCase().includes(recherche.value.toLowerCase()))
  return list
})

const anneeOptions = computed(() =>
  userEdit.value?.niveau_scolaire === 'Secondaire'
    ? ['NS1', 'NS2', 'NS3', 'NS4']
    : ['7e AF', '8e AF', '9e AF']
)

// ── Chargement ────────────────────────────────────────────────────
async function charger() {
  try {
    const [s, sc, q, m, u] = await Promise.all([
      api.get('/admin/stats'),
      api.get('/admin/scores'),
      api.get('/admin/questions'),
      api.get('/admin/matieres'),
      api.get('/admin/user'),
    ])
    stats.value     = s.data
    scores.value    = sc.data
    questions.value = q.data
    matieres.value  = m.data
    userEdit.value  = { ...u.data }
  } catch (e) {
    afficherToast('Erreur de chargement', 'err')
  }
}

onMounted(charger)

watch(onglet, (val) => {
  if (val === 'questions' && questions.value.length === 0) charger()
})

// ── Couleur taux de réussite ──────────────────────────────────────
function couleurTaux(pct) {
  if (pct < 40) return '#dc2626'
  if (pct < 70) return '#d97706'
  return '#16a34a'
}

// ── Suppression score ─────────────────────────────────────────────
async function supprimerScore(id) {
  if (!confirm('Supprimer ce score ?')) return
  await api.delete(`/admin/scores/${id}`)
  scores.value = scores.value.filter(s => s.id !== id)
  stats.value.nb_parties--
  afficherToast('Score supprimé', 'ok')
}

// ── Suppression question ──────────────────────────────────────────
async function supprimerQuestion(id) {
  if (!confirm('Supprimer cette question définitivement ?')) return
  await api.delete(`/admin/questions/${id}`)
  questions.value = questions.value.filter(q => q.id !== id)
  stats.value.nb_questions--
  afficherToast('Question supprimée', 'ok')
}

// ── Formulaire question ───────────────────────────────────────────
const formVisible  = ref(false)
const formEnvoi    = ref(false)
const formErreur   = ref('')
const formMatiereId = ref('')
const formQuestion = ref(viderForm())

function viderForm() {
  return {
    id: null,
    chapitre_id: '',
    enonce: '',
    choix: ['', '', '', ''],
    bonne_reponse: '',
    explication: '',
    niveau_complexite: 'Moyen',
  }
}

const chapsFormMatiere = computed(() =>
  formMatiereId.value
    ? (matieres.value.find(m => m.id === formMatiereId.value)?.chapitres ?? [])
    : []
)

function ouvrirFormQuestion(q) {
  formErreur.value = ''
  if (q) {
    formQuestion.value = {
      id: q.id,
      chapitre_id: q.chapitre_id,
      enonce: q.enonce,
      choix: [...q.choix],
      bonne_reponse: q.bonne_reponse,
      explication: q.explication,
      niveau_complexite: q.niveau_complexite,
    }
    formMatiereId.value = q.matiere_id
  } else {
    formQuestion.value = viderForm()
    formMatiereId.value = ''
  }
  formVisible.value = true
}

async function soumettreQuestion() {
  formErreur.value = ''
  const f = formQuestion.value

  if (!f.chapitre_id)    return (formErreur.value = 'Choisis un chapitre.')
  if (!f.enonce.trim())  return (formErreur.value = "L'énoncé est obligatoire.")
  if (f.choix.some(c => !c.trim())) return (formErreur.value = 'Remplis les 4 choix.')
  if (!f.bonne_reponse)  return (formErreur.value = 'Sélectionne la bonne réponse.')
  if (!f.explication.trim()) return (formErreur.value = "L'explication est obligatoire.")

  formEnvoi.value = true
  try {
    const payload = {
      chapitre_id: f.chapitre_id,
      enonce: f.enonce.trim(),
      choix: f.choix.map(c => c.trim()),
      bonne_reponse: f.bonne_reponse.trim(),
      explication: f.explication.trim(),
      niveau_complexite: f.niveau_complexite,
    }

    if (f.id) {
      const { data } = await api.put(`/admin/questions/${f.id}`, payload)
      const idx = questions.value.findIndex(q => q.id === f.id)
      if (idx !== -1) questions.value[idx] = data
      afficherToast('Question mise à jour', 'ok')
    } else {
      const { data } = await api.post('/admin/questions', payload)
      questions.value.unshift(data)
      if (stats.value) stats.value.nb_questions++
      afficherToast('Question créée', 'ok')
    }
    formVisible.value = false
  } catch (e) {
    formErreur.value = e.response?.data?.detail ?? 'Erreur serveur'
  } finally {
    formEnvoi.value = false
  }
}

// ── Utilisateur ───────────────────────────────────────────────────
async function sauvegarderUser() {
  try {
    const { data } = await api.patch('/admin/user', userEdit.value)
    userEdit.value = { ...data }
    afficherToast('Utilisateur mis à jour', 'ok')
  } catch {
    afficherToast('Erreur de sauvegarde', 'err')
  }
}

// ── Toast ─────────────────────────────────────────────────────────
const toast = ref(null)
let toastTimer = null
function afficherToast(msg, type = 'ok') {
  clearTimeout(toastTimer)
  toast.value = { msg, type }
  toastTimer = setTimeout(() => { toast.value = null }, 2500)
}
</script>

<style scoped>
/* ── Layout ─────────────────────────────────────────────────────── */
.adm-wrap {
  display: flex; min-height: calc(100dvh - 64px);
  background: var(--bg); color: var(--text);
}

/* ── Sidebar ────────────────────────────────────────────────────── */
.adm-sidebar {
  width: 220px; flex-shrink: 0;
  background: var(--surface); border-right: 1px solid var(--border);
  display: flex; flex-direction: column;
  padding: 1.25rem 0.75rem;
  position: sticky; top: 0; height: calc(100dvh - 64px); overflow-y: auto;
}
.adm-brand {
  display: flex; align-items: center; gap: 0.5rem;
  font-weight: 900; font-size: 0.95rem; padding: 0 0.5rem;
  margin-bottom: 1.25rem; color: var(--text);
}
.adm-nav { display: flex; flex-direction: column; gap: 0.2rem; }
.adm-nav-btn {
  display: flex; align-items: center; gap: 0.6rem;
  padding: 0.55rem 0.75rem; border-radius: 10px;
  font-size: 0.875rem; font-weight: 600; color: var(--text-muted);
  background: none; border: none; cursor: pointer; width: 100%;
  text-align: left; font-family: inherit;
  transition: background 0.12s, color 0.12s;
}
.adm-nav-btn:hover  { background: var(--primary-light-solid); color: var(--text); }
.adm-nav-btn.active { background: var(--primary-light-solid); color: var(--primary); font-weight: 700; }
.adm-nav-btn .material-symbols-outlined { font-size: 20px; }

/* ── Main ───────────────────────────────────────────────────────── */
.adm-main { flex: 1; min-width: 0; padding: 2rem 1.5rem; overflow-x: auto; }

.adm-titre { font-size: 1.5rem; font-weight: 800; margin-bottom: 1.5rem; letter-spacing: -0.015em; }
.adm-sous-titre { font-size: 1rem; font-weight: 800; color: var(--text-muted); }
.adm-section-head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; flex-wrap: wrap; gap: 0.75rem; }
.adm-count { font-size: 0.8rem; color: var(--text-muted); margin-bottom: 0.75rem; }

/* ── KPI ────────────────────────────────────────────────────────── */
.adm-kpi-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(130px, 1fr)); gap: 0.75rem; }
.adm-kpi {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1.1rem 1rem;
  display: flex; flex-direction: column; gap: 0.2rem;
}
.adm-kpi-val { font-size: 1.8rem; font-weight: 900; color: var(--primary); line-height: 1; }
.adm-kpi-lib { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-muted); }

/* ── Filtres ────────────────────────────────────────────────────── */
.adm-filtres { display: flex; flex-wrap: wrap; gap: 0.6rem; margin-bottom: 0.75rem; }

/* ── Table ──────────────────────────────────────────────────────── */
.adm-table-wrap { overflow-x: auto; border: 1px solid var(--border); border-radius: 12px; margin-top: 0.75rem; }
.adm-table {
  width: 100%; border-collapse: collapse; font-size: 0.85rem;
  background: var(--surface);
}
.adm-table th {
  text-align: left; padding: 0.65rem 1rem;
  font-size: 0.72rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.06em; color: var(--text-muted);
  background: var(--bg); border-bottom: 1px solid var(--border);
}
.adm-table td { padding: 0.65rem 1rem; border-bottom: 1px solid var(--border); vertical-align: middle; }
.adm-table tr:last-child td { border-bottom: none; }
.adm-table tr:hover td { background: var(--primary-light-solid); }

.adm-td-id { color: var(--text-muted); font-size: 0.78rem; width: 44px; }
.adm-td-mat { min-width: 140px; }
.adm-mat-nom  { display: block; font-weight: 800; font-size: 0.82rem; color: var(--text); }
.adm-chap-titre { display: block; font-size: 0.76rem; color: var(--text-muted); }
.adm-td-enonce { max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.adm-td-actions { display: flex; gap: 0.25rem; }

/* ── Badges ─────────────────────────────────────────────────────── */
.adm-badge {
  display: inline-block; padding: 0.2rem 0.65rem; border-radius: 99px;
  font-size: 0.7rem; font-weight: 800; text-transform: capitalize;
  background: var(--border); color: var(--text-muted);
}
.badge-facile, .badge-rush       { background: #dcfce7; color: #15803d; }
.badge-moyen, .badge-révision    { background: #fef3c7; color: #d97706; }
.badge-difficile, .badge-bombardement { background: #fee2e2; color: #dc2626; }

/* ── Boutons ────────────────────────────────────────────────────── */
.adm-btn-primary {
  display: inline-flex; align-items: center; gap: 0.4rem;
  background: var(--primary); color: #fff;
  border: none; border-radius: 10px; padding: 0.55rem 1rem;
  font-size: 0.875rem; font-weight: 700; cursor: pointer;
  font-family: inherit; transition: opacity 0.12s;
}
.adm-btn-primary:hover:not(:disabled) { opacity: 0.85; }
.adm-btn-primary:disabled { opacity: 0.5; cursor: default; }
.adm-btn-secondary {
  display: inline-flex; align-items: center; gap: 0.4rem;
  background: var(--bg); color: var(--text-muted);
  border: 1.5px solid var(--border); border-radius: 10px;
  padding: 0.55rem 1rem; font-size: 0.875rem; font-weight: 700;
  cursor: pointer; font-family: inherit;
}
.adm-icon-btn {
  background: none; border: none; cursor: pointer;
  padding: 0.3rem; border-radius: 8px; color: var(--text-muted);
  display: flex; align-items: center; transition: background 0.1s, color 0.1s;
}
.adm-icon-btn:hover        { background: var(--primary-light-solid); color: var(--primary); }
.adm-icon-btn.danger:hover { background: #fee2e2; color: #dc2626; }
.adm-icon-btn .material-symbols-outlined { font-size: 18px; }

/* ── Inputs ─────────────────────────────────────────────────────── */
.adm-input, .adm-select {
  background: var(--bg); border: 1.5px solid var(--border);
  border-radius: 8px; padding: 0.5rem 0.75rem;
  font-size: 0.875rem; color: var(--text); font-family: inherit;
  outline: none; transition: border-color 0.12s;
}
.adm-input:focus, .adm-select:focus { border-color: var(--primary); }
.adm-textarea { resize: vertical; min-height: 72px; width: 100%; }
.adm-select { appearance: auto; cursor: pointer; }

/* ── Form ───────────────────────────────────────────────────────── */
.adm-field { display: flex; flex-direction: column; gap: 0.35rem; margin-bottom: 1rem; }
.adm-field label { font-size: 0.8rem; font-weight: 700; color: var(--text-muted); }
.adm-field .adm-input, .adm-field .adm-select { width: 100%; box-sizing: border-box; }

.adm-choix-row { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.4rem; }
.adm-choix-letter {
  width: 24px; height: 24px; flex-shrink: 0; border-radius: 6px;
  background: var(--border); font-size: 0.78rem; font-weight: 800;
  display: flex; align-items: center; justify-content: center; color: var(--text-muted);
}
.adm-choix-row .adm-input { flex: 1; }
.adm-radio-btn {
  background: none; border: none; cursor: pointer; padding: 0.2rem;
  display: flex; align-items: center; color: var(--border); transition: color 0.12s;
}
.adm-radio-btn.selected { color: #16a34a; }
.adm-radio-btn .material-symbols-outlined { font-size: 22px; }
.adm-bonne-rep-hint { font-size: 0.8rem; color: #16a34a; font-weight: 700; margin-top: 0.25rem; }

.adm-niveau-chips { display: flex; gap: 0.5rem; margin-top: 0.25rem; }
.adm-niveau-chip {
  padding: 0.4rem 1rem; border-radius: 99px;
  border: 1.5px solid var(--border); background: var(--bg);
  font-size: 0.82rem; font-weight: 700; color: var(--text-muted);
  cursor: pointer; transition: all 0.12s; font-family: inherit;
}
.adm-niveau-chip.active { background: var(--primary); border-color: var(--primary); color: #fff; }

.adm-erreur { color: #dc2626; font-size: 0.82rem; font-weight: 700; margin-bottom: 0.5rem; }
.adm-form-actions { display: flex; justify-content: flex-end; gap: 0.6rem; padding-top: 0.5rem; border-top: 1px solid var(--border); }

.adm-spin { animation: spin 0.8s linear infinite; display: inline-block; }
@keyframes spin { to { transform: rotate(360deg); } }

/* ── Utilisateur ────────────────────────────────────────────────── */
.adm-user-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1rem; }
.adm-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 16px; padding: 1.25rem;
}
.adm-card-titre { font-size: 1rem; font-weight: 800; margin-bottom: 1rem; }

/* ── Modale ─────────────────────────────────────────────────────── */
.adm-modal-bg {
  position: fixed; inset: 0; z-index: 200;
  background: rgba(0,0,0,0.4); backdrop-filter: blur(3px);
  display: flex; align-items: center; justify-content: center; padding: 1rem;
}
.adm-modal {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 20px; width: min(600px, 100%); max-height: 90dvh;
  overflow-y: auto; box-shadow: 0 16px 48px rgba(0,0,0,0.18);
}
.adm-modal-head {
  display: flex; justify-content: space-between; align-items: center;
  padding: 1.25rem 1.5rem; border-bottom: 1px solid var(--border);
  position: sticky; top: 0; background: var(--surface); z-index: 1;
}
.adm-modal-head h2 { font-size: 1.1rem; font-weight: 800; }
.adm-form { padding: 1.25rem 1.5rem; }

.modal-fade-enter-active { transition: opacity 0.2s; }
.modal-fade-enter-from   { opacity: 0; }
.modal-fade-leave-active { transition: opacity 0.15s; }
.modal-fade-leave-to     { opacity: 0; }

/* ── Toast ──────────────────────────────────────────────────────── */
.adm-toast {
  position: fixed; bottom: 1.5rem; left: 50%; transform: translateX(-50%);
  display: flex; align-items: center; gap: 0.5rem;
  padding: 0.65rem 1.25rem; border-radius: 99px;
  font-weight: 700; font-size: 0.875rem;
  box-shadow: 0 4px 16px rgba(0,0,0,0.18); z-index: 300; white-space: nowrap;
}
.adm-toast.ok  { background: #16a34a; color: #fff; }
.adm-toast.err { background: #dc2626; color: #fff; }
.toast-slide-enter-active { transition: opacity 0.2s, transform 0.2s; }
.toast-slide-enter-from   { opacity: 0; transform: translateX(-50%) translateY(8px); }
.toast-slide-leave-active { transition: opacity 0.2s; }
.toast-slide-leave-to     { opacity: 0; }

/* ── Responsive ─────────────────────────────────────────────────── */
@media (max-width: 640px) {
  .adm-sidebar { width: 56px; }
  .adm-nav-btn span:not(.material-symbols-outlined) { display: none; }
  .adm-brand span:last-child { display: none; }
  .adm-main { padding: 1.25rem 0.75rem; }
}
</style>
