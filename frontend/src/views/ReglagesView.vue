<template>
  <div class="rg-wrap fade-in">
    <div class="rg-inner">

      <h1 class="rg-titre">Réglages</h1>

      <!-- ── Nombre de questions ─────────────────────────────── -->
      <div class="rg-section-label">Nombre de questions</div>
      <div class="rg-card">
        <div class="rg-chips">
          <button v-for="n in [5, 10, 15, 20]" :key="n"
            class="rg-chip" :class="{ active: nbQuestions === n }"
            @click="setNbQuestions(n)">
            {{ n }}
          </button>
        </div>
        <div class="rg-note">
          <span class="material-symbols-outlined" style="font-size:15px;color:var(--primary)">info</span>
          Mode Bombardement : jusqu'à 30 questions aléatoires, indépendamment de ce réglage.
        </div>
      </div>

      <!-- ── Cycle d'études ──────────────────────────────────── -->
      <div class="rg-section-label">Cycle d'études</div>
      <div class="rg-card">
        <p class="rg-desc">Sélectionne ton niveau pour n'afficher que les matières correspondantes.</p>
        <div class="rg-cycles">
          <button class="rg-cycle-btn" :class="{ active: niveauScolaire === 'Fondamental' }" @click="setNiveau('Fondamental')">
            <span class="rg-cycle-label">Fondamental</span>
            <span class="rg-cycle-sub">7e à 9e AF</span>
          </button>
          <button class="rg-cycle-btn" :class="{ active: niveauScolaire === 'Secondaire' }" @click="setNiveau('Secondaire')">
            <span class="rg-cycle-label">Secondaire</span>
            <span class="rg-cycle-sub">NS1 à NS4</span>
          </button>
        </div>
      </div>

      <!-- ── Niveau / Année ──────────────────────────────────── -->
      <div class="rg-section-label">Niveau / Année</div>
      <div class="rg-card">
        <p class="rg-desc">Sélectionne ton année scolaire pour un suivi plus précis.</p>
        <div class="rg-chips" style="margin-top:0.75rem">
          <button v-for="a in anneeOptions" :key="a"
            class="rg-chip" :class="{ active: annee === a }"
            @click="setAnnee(a)">
            {{ a }}
          </button>
        </div>
      </div>

      <!-- ── Difficulté ─────────────────────────────────────── -->
      <div class="rg-section-label">Difficulté</div>
      <div class="rg-card">
        <p class="rg-desc">Filtre les questions selon leur niveau de difficulté.</p>
        <div class="rg-chips" style="margin-top:0.75rem">
          <button v-for="d in ['Toutes', 'Facile', 'Moyen', 'Difficile']" :key="d"
            class="rg-chip" :class="{ active: difficulte === d }"
            @click="setDifficulte(d)">
            {{ d }}
          </button>
        </div>
      </div>

      <!-- ── Localisation ────────────────────────────────────── -->
      <div class="rg-section-label">Localisation</div>
      <div class="rg-card">
        <p class="rg-desc">Choisis ton pays puis ta région pour le classement par zone.</p>

        <div class="rg-chips" style="margin-top:0.75rem">
          <button v-for="p in PAYS" :key="p"
            class="rg-chip" :class="{ active: pays === p }"
            @click="setPays(p)">
            {{ p }}
          </button>
        </div>

        <template v-if="regions.length">
          <div class="rg-mini-label">{{ labelRegion }}</div>
          <div class="rg-chips">
            <button v-for="r in regions" :key="r"
              class="rg-chip rg-chip-sm" :class="{ active: zone === r }"
              @click="setZone(r)">
              {{ r }}
            </button>
          </div>
        </template>
      </div>

      <!-- ── Son (S6) ───────────────────────────────────────── -->
      <div class="rg-section-label">Son</div>
      <div class="rg-card">
        <div class="rg-switch-row">
          <div>
            <p class="rg-switch-titre">Musique de fond</p>
            <p class="rg-desc">Ambiance douce sur les pages, plus rythmée pendant les quiz.</p>
          </div>
          <button class="rg-switch" :class="{ on: musiqueOn }" role="switch"
            :aria-checked="musiqueOn" aria-label="Musique de fond" @click="musiqueOn = !musiqueOn; confirmer()">
            <span class="rg-switch-knob"></span>
          </button>
        </div>
        <div class="rg-volume" :class="{ 'rg-volume--off': !musiqueOn }">
          <span class="material-symbols-outlined">music_note</span>
          <input type="range" min="0" max="1" step="0.05" v-model.number="musiqueVolume"
            :disabled="!musiqueOn" aria-label="Volume de la musique" />
          <span class="rg-volume-val">{{ Math.round(musiqueVolume * 100) }} %</span>
        </div>

        <div class="rg-divider"></div>

        <div class="rg-switch-row">
          <div>
            <p class="rg-switch-titre">Effets sonores</p>
            <p class="rg-desc">Bonnes et mauvaises réponses, chrono, séries.</p>
          </div>
          <button class="rg-switch" :class="{ on: effetsOn }" role="switch"
            :aria-checked="effetsOn" aria-label="Effets sonores" @click="effetsOn = !effetsOn; confirmer()">
            <span class="rg-switch-knob"></span>
          </button>
        </div>
        <div class="rg-volume" :class="{ 'rg-volume--off': !effetsOn }">
          <span class="material-symbols-outlined">volume_up</span>
          <input type="range" min="0" max="1" step="0.05" v-model.number="effetsVolume"
            :disabled="!effetsOn" aria-label="Volume des effets sonores" @change="essaiEffet" />
          <span class="rg-volume-val">{{ Math.round(effetsVolume * 100) }} %</span>
        </div>
      </div>

      <!-- ── Animations ─────────────────────────────────────── -->
      <div class="rg-section-label">Animations</div>
      <div class="rg-card">
        <div class="rg-switch-row">
          <div>
            <p class="rg-switch-titre">Animations et effets visuels</p>
            <p class="rg-desc">Désactive-les si le site te semble lent ou si les mouvements te gênent.</p>
          </div>
          <button class="rg-switch" :class="{ on: animationsOn }" role="switch"
            :aria-checked="animationsOn" @click="basculerAnimations">
            <span class="rg-switch-knob"></span>
          </button>
        </div>
      </div>

      <!-- ── Rappels de défis ──────────────────────────────── -->
      <div class="rg-section-label">Rappels de défis</div>
      <div class="rg-card">
        <template v-if="!notifSupport">
          <p class="rg-desc" style="padding:0.25rem 0">Les notifications push ne sont pas supportées par ce navigateur.</p>
          <p class="rg-desc" style="margin-top:0.25rem;font-size:0.78rem;color:var(--text-muted)">Sur iPhone, ajoute EduClé à l'écran d'accueil (iOS 16.4+) pour activer les notifications.</p>
        </template>
        <template v-else-if="notifBloque">
          <p class="rg-desc" style="padding:0.25rem 0">Tu as bloqué les notifications pour ce site. Pour les activer, modifie les paramètres de ton navigateur.</p>
        </template>
        <template v-else>
          <div class="rg-switch-row">
            <div>
              <p class="rg-switch-titre">Rappel du matin</p>
              <p class="rg-desc">« Tes défis du jour sont prêts. » vers 7h.</p>
            </div>
            <button class="rg-switch" :class="{ on: notifAbonne && prefDebut }" role="switch"
              :aria-checked="notifAbonne && prefDebut" @click="basculerNotif('debut')" :disabled="notifChargement">
              <span class="rg-switch-knob"></span>
            </button>
          </div>
          <div class="rg-divider"></div>
          <div class="rg-switch-row">
            <div>
              <p class="rg-switch-titre">Rappel du soir</p>
              <p class="rg-desc">« Il te reste N défi(s) aujourd'hui. » vers 18h, si des défis restent.</p>
            </div>
            <button class="rg-switch" :class="{ on: notifAbonne && prefFin }" role="switch"
              :aria-checked="notifAbonne && prefFin" @click="basculerNotif('fin')" :disabled="notifChargement">
              <span class="rg-switch-knob"></span>
            </button>
          </div>
        </template>
      </div>

      <!-- ── À propos ───────────────────────────────────────── -->
      <div class="rg-section-label">À propos</div>
      <div class="rg-card">
        <div class="rg-ligne-info">
          <span class="rg-info-lib">Application</span>
          <span class="rg-info-val">EduClé</span>
        </div>
        <div class="rg-divider"></div>
        <div class="rg-ligne-info">
          <span class="rg-info-lib">Version</span>
          <span class="rg-info-val">1.0.0</span>
        </div>
        <div class="rg-divider"></div>
        <div class="rg-ligne-info">
          <span class="rg-info-lib">Créé par</span>
          <span class="rg-info-val">Ing. Ronaldy Faustin</span>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getProfil, updateProfil, notifAbonner, notifDesabonner, notifGetPrefs, notifSetPrefs } from '../api/client.js'
import { animationsOn } from '../animations/motion.js'
import { musiqueOn, musiqueVolume, effetsOn, effetsVolume, volumeEffets } from '../audio/reglages.js'
import { toast, fermerToast } from '../animations/toast.js'

// ── Pays & régions ────────────────────────────────────────────
const PAYS = ['Haïti', 'Rép. Dominicaine', 'États-Unis', 'Canada', 'France', 'Belgique']
const REGIONS = {
  'Haïti': ['Artibonite', 'Centre', "Grand'Anse", 'Nippes', 'Nord', 'Nord-Est', 'Nord-Ouest', 'Ouest', 'Sud', 'Sud-Est'],
  'Rép. Dominicaine': ['Cibao Norte', 'Cibao Sur', 'Cibao Nordeste', 'Cibao Noroeste', 'Valdesia', 'Enriquillo', 'El Valle', 'Yuma', 'Higuamo', 'Ozama'],
  'États-Unis': ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'Californie', 'Caroline du Nord', 'Caroline du Sud', 'Colorado', 'Connecticut', 'Dakota du Nord', 'Dakota du Sud', 'Delaware', 'Floride', 'Géorgie', 'Hawaï', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiane', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvanie', 'Rhode Island', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginie', 'Washington', 'Virginie-Occidentale', 'Wisconsin', 'Wyoming'],
  'Canada': ['Alberta', 'Colombie-Britannique', 'Manitoba', 'Nouveau-Brunswick', 'Terre-Neuve-et-Labrador', 'Nouvelle-Écosse', 'Ontario', 'Île-du-Prince-Édouard', 'Québec', 'Saskatchewan', 'Territoires du Nord-Ouest', 'Nunavut', 'Yukon'],
  'France': ["Auvergne-Rhône-Alpes", 'Bourgogne-Franche-Comté', 'Bretagne', 'Centre-Val de Loire', 'Corse', 'Grand Est', 'Hauts-de-France', 'Île-de-France', 'Normandie', 'Nouvelle-Aquitaine', 'Occitanie', 'Pays de la Loire', "Provence-Alpes-Côte d'Azur", 'Guadeloupe', 'Martinique', 'Guyane', 'La Réunion', 'Mayotte'],
  'Belgique': ['Anvers', 'Brabant flamand', 'Brabant wallon', 'Bruxelles-Capitale', 'Flandre occidentale', 'Flandre orientale', 'Hainaut', 'Liège', 'Limbourg', 'Luxembourg', 'Namur'],
}

// ── Notifications Web Push ────────────────────────────────────
const notifSupport    = ref('Notification' in window && 'serviceWorker' in navigator && 'PushManager' in window)
const notifBloque     = ref(notifSupport.value && Notification.permission === 'denied')
const notifAbonne     = ref(false)
const notifChargement = ref(false)
const prefDebut       = ref(true)
const prefFin         = ref(true)
let _swReg            = null

async function _getSwReg() {
  if (!notifSupport.value) return null
  if (_swReg) return _swReg
  try { _swReg = await navigator.serviceWorker.ready } catch { return null }
  return _swReg
}

async function _subActuelle() {
  const reg = await _getSwReg()
  if (!reg) return null
  return reg.pushManager.getSubscription()
}

function _subVersPayload(sub) {
  const json = sub.toJSON()
  return { endpoint: json.endpoint, cle_p256dh: json.keys.p256dh, cle_auth: json.keys.auth }
}

async function basculerNotif(type) {
  if (notifChargement.value) return
  notifChargement.value = true
  try {
    const sub = await _subActuelle()
    if (!notifAbonne.value || !sub) {
      // Activer
      if (Notification.permission === 'denied') { notifBloque.value = true; return }
      const perm = await Notification.requestPermission()
      if (perm !== 'granted') { notifBloque.value = perm === 'denied'; return }
      const reg = await _getSwReg()
      const vapidKey = import.meta.env.VITE_VAPID_PUBLIC_KEY
      if (!vapidKey) { console.warn('VITE_VAPID_PUBLIC_KEY absent'); return }
      const newSub = await reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: vapidKey,
      })
      await notifAbonner(_subVersPayload(newSub))
      await notifSetPrefs({ rappel_debut: type === 'debut' ? true : prefDebut.value, rappel_fin: type === 'fin' ? true : prefFin.value })
      notifAbonne.value = true
      const prefs = await notifGetPrefs()
      prefDebut.value = prefs.rappel_debut
      prefFin.value   = prefs.rappel_fin
    } else {
      // Mettre à jour préférence ou désabonner si les deux sont à false
      const prochainDebut = type === 'debut' ? !prefDebut.value : prefDebut.value
      const prochaineFin  = type === 'fin'   ? !prefFin.value   : prefFin.value
      if (!prochainDebut && !prochaineFin) {
        await notifDesabonner(_subVersPayload(sub))
        await sub.unsubscribe()
        notifAbonne.value = false
      } else {
        await notifSetPrefs({ rappel_debut: prochainDebut, rappel_fin: prochaineFin })
        prefDebut.value = prochainDebut
        prefFin.value   = prochaineFin
      }
    }
  } catch (e) {
    console.error('Notif erreur', e)
  } finally {
    notifChargement.value = false
  }
}

// ── État local ────────────────────────────────────────────────
const nbQuestions   = ref(10)
const niveauScolaire = ref('Fondamental')
const annee         = ref('7e AF')
const difficulte    = ref('Toutes')
const pays          = ref('Haïti')
const zone          = ref('')
let toastId         = null

const anneeOptions = computed(() =>
  niveauScolaire.value === 'Secondaire'
    ? ['NS1', 'NS2', 'NS3', 'NS4']
    : ['7e AF', '8e AF', '9e AF']
)

const regions = computed(() => REGIONS[pays.value] ?? [])

const labelRegion = computed(() => {
  if (pays.value === 'Haïti') return 'Département'
  if (pays.value === 'États-Unis') return 'État'
  if (pays.value === 'Canada') return 'Province / Territoire'
  return 'Région'
})

// ── Chargement ────────────────────────────────────────────────
onMounted(async () => {
  // localStorage (préférences locales)
  nbQuestions.value  = Number(localStorage.getItem('educle_nb_questions') ?? 10)
  difficulte.value   = localStorage.getItem('educle_difficulte') ?? 'Toutes'
  pays.value         = localStorage.getItem('educle_pays') ?? 'Haïti'

  // Backend (profil)
  try {
    const profil = await getProfil()
    if (profil.niveau_scolaire) niveauScolaire.value = profil.niveau_scolaire
    if (profil.annee)           annee.value          = profil.annee
    if (profil.zone)            zone.value           = profil.zone
  } catch {}

  // État notifications
  if (notifSupport.value && Notification.permission !== 'denied') {
    try {
      const sub = await _subActuelle()
      if (sub) {
        notifAbonne.value = true
        const prefs = await notifGetPrefs()
        prefDebut.value = prefs.rappel_debut
        prefFin.value   = prefs.rappel_fin
      }
    } catch {}
  }
})

// ── Setters avec sauvegarde ───────────────────────────────────
function setNbQuestions(n) {
  nbQuestions.value = n
  localStorage.setItem('educle_nb_questions', n)
  confirmer()
}

function setDifficulte(d) {
  difficulte.value = d
  localStorage.setItem('educle_difficulte', d)
  confirmer()
}

function setPays(p) {
  pays.value  = p
  zone.value  = ''
  localStorage.setItem('educle_pays', p)
  confirmer()
}

async function setZone(r) {
  zone.value = r
  await saveBackend({ zone: r })
  confirmer()
}

async function setNiveau(n) {
  niveauScolaire.value = n
  // Reset l'année si elle n'appartient plus au nouveau cycle
  const opts = n === 'Secondaire' ? ['NS1', 'NS2', 'NS3', 'NS4'] : ['7e AF', '8e AF', '9e AF']
  if (!opts.includes(annee.value)) annee.value = opts[0]
  await saveBackend({ niveau_scolaire: n, annee: annee.value })
  confirmer()
}

async function setAnnee(a) {
  annee.value = a
  await saveBackend({ annee: a })
  confirmer()
}

async function saveBackend(data) {
  try { await updateProfil(data) } catch {}
}

// Petit son d'essai quand on relâche le curseur des effets
const _sonEssai = new Audio('/sounds/bonne_reponse.mp3')
function essaiEffet() {
  const s = _sonEssai.cloneNode()
  s.volume = volumeEffets()
  s.play().catch(() => {})
}

function basculerAnimations() {
  animationsOn.value = !animationsOn.value
  confirmer()
}

function confirmer() {
  if (toastId) fermerToast(toastId)
  toastId = toast('Réglages sauvegardés', { icon: 'check_circle', type: 'success', duree: 2000 })
}
</script>

<style scoped>
.rg-wrap { min-height: calc(100dvh - 64px); background: var(--bg); padding-bottom: 3rem; }
.rg-inner { max-width: 680px; margin: 0 auto; padding: 2rem 1.25rem; }

.rg-titre {
  font-size: 1.6rem; font-weight: 800; color: var(--text);
  margin-bottom: 1.75rem; letter-spacing: -0.015em;
}

/* Section label */
.rg-section-label {
  font-size: 0.7rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; color: var(--text-muted);
  margin-bottom: 0.6rem; margin-top: 1.75rem;
}
.rg-section-label:first-of-type { margin-top: 0; }

/* Card */
.rg-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 16px; padding: 1.1rem 1.25rem;
}

.rg-desc { font-size: 0.83rem; color: var(--text-muted); line-height: 1.5; margin-bottom: 0; }

/* Chips */
.rg-chips { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 0.75rem; }
.rg-chip {
  padding: 0.5rem 1rem; border-radius: 99px;
  background: var(--bg); border: 1.5px solid var(--border);
  font-weight: 700; font-size: 0.83rem; color: var(--text-muted);
  cursor: pointer; transition: all 0.12s;
}
.rg-chip:hover:not(.active) { border-color: var(--primary); color: var(--text); }
.rg-chip.active { background: var(--primary); border-color: var(--primary); color: #fff; }
.rg-chip-sm { font-size: 0.78rem; padding: 0.4rem 0.8rem; }

/* Cycle buttons */
.rg-cycles { display: flex; gap: 0.75rem; margin-top: 0.75rem; }
.rg-cycle-btn {
  flex: 1; display: flex; flex-direction: column; align-items: center;
  padding: 0.85rem 0.75rem; border-radius: 12px;
  background: var(--bg); border: 1.5px solid var(--border);
  cursor: pointer; transition: all 0.12s;
}
.rg-cycle-btn:hover:not(.active) { border-color: var(--primary); }
.rg-cycle-btn.active { background: var(--primary); border-color: var(--primary); }
.rg-cycle-label { font-weight: 800; font-size: 0.9rem; color: var(--text); }
.rg-cycle-btn.active .rg-cycle-label { color: #fff; }
.rg-cycle-sub { font-size: 0.72rem; color: var(--text-muted); margin-top: 0.15rem; }
.rg-cycle-btn.active .rg-cycle-sub { color: rgba(255,255,255,0.75); }

/* Mini label (région) */
.rg-mini-label {
  font-size: 0.68rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.05em; color: var(--text-muted); margin-top: 1.1rem; margin-bottom: 0.5rem;
}

/* Note info */
.rg-note {
  display: flex; align-items: flex-start; gap: 0.5rem;
  margin-top: 0.85rem; background: var(--primary-light-solid);
  border-radius: 10px; padding: 0.65rem 0.85rem;
  font-size: 0.8rem; color: var(--primary); line-height: 1.45;
}

/* À propos */
.rg-ligne-info { display: flex; justify-content: space-between; align-items: center; padding: 0.15rem 0; }
.rg-info-lib { font-size: 0.875rem; color: var(--text-muted); }
.rg-info-val { font-size: 0.875rem; font-weight: 700; color: var(--text); }
.rg-divider  { height: 1px; background: var(--border); margin: 0.75rem 0; }

/* Volume (son) */
.rg-volume { display: flex; align-items: center; gap: 0.75rem; margin-top: 0.85rem; transition: opacity var(--dur-normal); }
.rg-volume--off { opacity: 0.4; }
.rg-volume .material-symbols-outlined { font-size: 20px; color: var(--primary); }
.rg-volume input[type="range"] { flex: 1; accent-color: var(--primary); cursor: pointer; }
.rg-volume input[type="range"]:disabled { cursor: not-allowed; }
.rg-volume-val { font-size: 0.8rem; font-weight: 700; color: var(--text-muted); min-width: 3rem; text-align: right; }

/* Interrupteur animations */
.rg-switch-row { display: flex; align-items: center; justify-content: space-between; gap: 1rem; }
.rg-switch-titre { font-size: 0.9rem; font-weight: 700; color: var(--text); margin-bottom: 0.2rem; }
.rg-switch {
  position: relative; flex-shrink: 0;
  width: 50px; height: 28px; border-radius: 99px; padding: 0;
  background: var(--border);
  transition: background var(--dur-normal);
}
.rg-switch.on { background: var(--primary); }
.rg-switch-knob {
  position: absolute; top: 3px; left: 3px;
  width: 22px; height: 22px; border-radius: 50%; background: #fff;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  transition: transform var(--dur-normal) var(--ease-spring);
}
.rg-switch.on .rg-switch-knob { transform: translateX(22px); }
</style>
