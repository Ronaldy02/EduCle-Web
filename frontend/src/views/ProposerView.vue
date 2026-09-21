<template>
  <div class="prop-wrap fade-in">
    <div class="prop-inner">

      <div class="prop-header">
        <h1 class="prop-titre">Proposer une question</h1>
        <p class="prop-sous">Tu as une bonne question à soumettre ? Elle sera examinée par l'équipe EduClé avant publication.</p>
      </div>

      <!-- Formulaire -->
      <form class="prop-form" @submit.prevent="soumettre">

        <!-- Ton nom -->
        <div class="field">
          <label class="field-label">Ton nom (facultatif)</label>
          <input v-model="form.nom_proposant" type="text" class="field-input" placeholder="Anonyme" maxlength="100" />
        </div>

        <!-- Matière -->
        <div class="field">
          <label class="field-label">Matière <span class="req">*</span></label>
          <select v-model="form.matiere_id" class="field-select" @change="onMatiereChange" required>
            <option :value="null" disabled>Choisir une matière…</option>
            <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
          </select>
        </div>

        <!-- Chapitre -->
        <div class="field" v-if="chapitres.length">
          <label class="field-label">Chapitre (facultatif)</label>
          <select v-model="form.chapitre_id" class="field-select">
            <option :value="null">— Pas de chapitre spécifique —</option>
            <option v-for="c in chapitres" :key="c.id" :value="c.id">{{ c.titre }}</option>
          </select>
        </div>

        <!-- Énoncé -->
        <div class="field">
          <label class="field-label">Énoncé de la question <span class="req">*</span></label>
          <textarea v-model="form.enonce" class="field-textarea" rows="3"
            placeholder="Ex. : Quel est le symbole chimique de l'or ?" required maxlength="1000"></textarea>
        </div>

        <!-- Choix -->
        <div class="field">
          <label class="field-label">Propositions de réponse <span class="req">*</span></label>
          <div class="choix-list">
            <div v-for="(_, i) in form.choix" :key="i" class="choix-row">
              <span class="choix-lettre">{{ 'ABCD'[i] }}</span>
              <input v-model="form.choix[i]" type="text" class="field-input" :placeholder="`Option ${i + 1}`" required />
            </div>
          </div>
        </div>

        <!-- Bonne réponse -->
        <div class="field">
          <label class="field-label">Bonne réponse <span class="req">*</span></label>
          <select v-model="form.bonne_reponse" class="field-select" required>
            <option value="" disabled>Choisir la bonne réponse…</option>
            <option v-for="(c, i) in form.choix.filter(x => x.trim())" :key="i" :value="c">{{ c }}</option>
          </select>
        </div>

        <!-- Explication -->
        <div class="field">
          <label class="field-label">Explication (facultatif)</label>
          <textarea v-model="form.explication" class="field-textarea" rows="2"
            placeholder="Explique pourquoi c'est la bonne réponse…" maxlength="1000"></textarea>
        </div>

        <!-- Difficulté -->
        <div class="field">
          <label class="field-label">Difficulté</label>
          <div class="diff-chips">
            <button v-for="d in ['Facile', 'Moyen', 'Difficile']" :key="d" type="button"
              class="diff-chip" :class="{ active: form.niveau_complexite === d }"
              @click="form.niveau_complexite = d">{{ d }}</button>
          </div>
        </div>

        <!-- Erreur -->
        <p v-if="erreur" class="prop-erreur">{{ erreur }}</p>

        <!-- Submit -->
        <button type="submit" class="prop-submit" :disabled="envoi">
          <span v-if="envoi">Envoi…</span>
          <span v-else>Envoyer la proposition</span>
        </button>

      </form>

      <!-- Succès -->
      <div v-if="succes" class="prop-succes">
        <div class="succes-icon">✓</div>
        <h2>Merci !</h2>
        <p>Ta question a été envoyée. L'équipe EduClé l'examinera prochainement.</p>
        <button class="prop-submit" style="margin-top:1.25rem" @click="reset">Proposer une autre question</button>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { getMatieres, getMatiere } from '../api/client.js'
import axios from 'axios'

const api = axios.create({ baseURL: import.meta.env.VITE_API_URL || '/api' })

const matieres  = ref([])
const chapitres = ref([])
const envoi     = ref(false)
const erreur    = ref('')
const succes    = ref(false)

const form = reactive({
  nom_proposant:    '',
  matiere_id:       null,
  chapitre_id:      null,
  enonce:           '',
  choix:            ['', '', '', ''],
  bonne_reponse:    '',
  explication:      '',
  niveau_complexite: 'Moyen',
})

getMatieres().then(data => { matieres.value = data })

async function onMatiereChange() {
  form.chapitre_id = null
  chapitres.value = []
  if (!form.matiere_id) return
  try {
    const detail = await getMatiere(form.matiere_id)
    chapitres.value = detail.chapitres || []
  } catch {}
}

async function soumettre() {
  erreur.value = ''
  const choixRemplis = form.choix.filter(c => c.trim())
  if (choixRemplis.length < 2) { erreur.value = 'Remplis au moins 2 propositions de réponse.'; return }
  if (!form.bonne_reponse) { erreur.value = 'Sélectionne la bonne réponse.'; return }
  if (!choixRemplis.includes(form.bonne_reponse)) { erreur.value = 'La bonne réponse doit être l\'une des propositions.'; return }

  envoi.value = true
  try {
    await api.post('/proposals/', {
      nom_proposant:    form.nom_proposant.trim() || 'Anonyme',
      matiere_id:       form.matiere_id,
      chapitre_id:      form.chapitre_id,
      enonce:           form.enonce.trim(),
      choix:            choixRemplis,
      bonne_reponse:    form.bonne_reponse,
      explication:      form.explication.trim(),
      niveau_complexite: form.niveau_complexite,
    })
    succes.value = true
  } catch (e) {
    erreur.value = e.response?.data?.detail || 'Une erreur est survenue. Réessaie.'
  } finally {
    envoi.value = false
  }
}

function reset() {
  succes.value = false
  Object.assign(form, { nom_proposant: '', matiere_id: null, chapitre_id: null,
    enonce: '', choix: ['', '', '', ''], bonne_reponse: '', explication: '', niveau_complexite: 'Moyen' })
  chapitres.value = []
}
</script>

<style scoped>
.prop-wrap { min-height: calc(100dvh - 64px); background: var(--bg); }
.prop-inner { max-width: 640px; margin: 0 auto; padding: 2rem 1.25rem 4rem; }

.prop-header { margin-bottom: 2rem; }
.prop-titre { font-size: 1.5rem; font-weight: 800; margin-bottom: 0.4rem; }
.prop-sous { font-size: 0.9rem; color: var(--text-muted); line-height: 1.5; }

.prop-form { display: flex; flex-direction: column; gap: 1.25rem; }

.field { display: flex; flex-direction: column; gap: 0.4rem; }
.field-label { font-size: 0.85rem; font-weight: 700; color: var(--text); }
.req { color: #e04040; }
.field-input,
.field-select,
.field-textarea {
  border: 1.5px solid var(--border);
  border-radius: var(--radius);
  padding: 0.6rem 0.85rem;
  font-family: inherit;
  font-size: 0.9rem;
  background: var(--surface);
  color: var(--text);
  outline: none;
  transition: border-color 0.15s;
  width: 100%;
  box-sizing: border-box;
}
.field-input:focus,
.field-select:focus,
.field-textarea:focus { border-color: var(--primary); }
.field-textarea { resize: vertical; }

.choix-list { display: flex; flex-direction: column; gap: 0.5rem; }
.choix-row { display: flex; align-items: center; gap: 0.5rem; }
.choix-lettre { font-weight: 800; font-size: 0.9rem; color: var(--primary); min-width: 1.2rem; }

.diff-chips { display: flex; gap: 0.5rem; flex-wrap: wrap; }
.diff-chip { padding: 0.3rem 0.9rem; border-radius: 99px; border: 1.5px solid var(--border); font-size: 0.8rem; font-weight: 600; background: var(--surface); color: var(--text-muted); cursor: pointer; transition: all 0.15s; }
.diff-chip.active { background: var(--primary); border-color: var(--primary); color: #fff; }

.prop-erreur { color: #e04040; font-size: 0.85rem; padding: 0.5rem 0.75rem; background: #fff0f0; border-radius: 6px; }

.prop-submit {
  margin-top: 0.5rem; padding: 0.85rem; border-radius: var(--radius);
  background: var(--primary); color: #fff; border: none; font-weight: 700;
  font-size: 1rem; cursor: pointer; transition: opacity 0.15s;
}
.prop-submit:disabled { opacity: 0.6; cursor: not-allowed; }
.prop-submit:hover:not(:disabled) { opacity: 0.88; }

.prop-succes { text-align: center; padding: 3rem 1rem; }
.succes-icon { font-size: 3rem; color: #2fa84f; margin-bottom: 0.75rem; }
.prop-succes h2 { font-size: 1.5rem; font-weight: 800; margin-bottom: 0.5rem; }
.prop-succes p { color: var(--text-muted); font-size: 0.9rem; }
</style>
