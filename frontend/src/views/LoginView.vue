<template>
  <div class="lv-page">
    <!-- Panneau gauche -->
    <div class="lv-brand">
      <canvas ref="canvasRef" class="lv-canvas"></canvas>
      <div class="lv-brand-inner">
        <div class="lv-logo">
          <div class="lv-logo-mark">🔑</div>
          <span class="lv-logo-name">EduClé</span>
        </div>
        <div class="lv-hero">
          <h1 class="lv-headline">La clé de ta réussite scolaire.</h1>
          <p class="lv-sub">Quiz adaptatifs, suivi de progression et défis par matière — calibrés pour ton niveau et ton programme.</p>
          <div class="lv-chips">
            <span class="lv-chip">12 matières</span>
            <span class="lv-chip">500+ questions</span>
            <span class="lv-chip">8 modes de jeu</span>
            <span class="lv-chip">🪙 Récompenses</span>
          </div>
        </div>
        <div class="lv-footer">© 2025 EduClé · Application éducative</div>
      </div>
    </div>

    <!-- Panneau droit -->
    <div class="lv-auth">
      <div class="lv-box">

        <!-- État : initial -->
        <template v-if="state === 'initial'">
          <h2 class="lv-title">Bienvenue sur EduClé</h2>
          <p class="lv-sub-auth">Connecte-toi ou crée ton compte pour continuer.</p>
          <div class="lv-oauth-stack">
            <button class="lv-btn-oauth" @click="loginGoogle">
              <GoogleIcon /> Continuer avec Google
            </button>
          </div>
          <div class="lv-divider"><span>ou</span></div>
          <button class="lv-btn-ghost" @click="state = 'email'">
            <MailIcon /> Continuer avec l'e-mail
          </button>
          <p class="lv-legal">En continuant, tu acceptes nos <a href="#">Conditions d'utilisation</a>.</p>
        </template>

        <!-- État : saisie e-mail -->
        <template v-else-if="state === 'email'">
          <button class="lv-back" @click="state = 'initial'"><ChevronIcon /> Retour</button>
          <h2 class="lv-title">Ton adresse e-mail</h2>
          <p class="lv-sub-auth">On vérifie si tu as déjà un compte avant de continuer.</p>
          <div class="lv-field">
            <label>E-mail</label>
            <input
              v-model="email"
              type="email"
              placeholder="prenom@exemple.com"
              autocomplete="email"
              @keydown.enter="checkEmail"
              :class="{ 'is-err': fieldErr }"
            >
            <span v-if="fieldErr" class="lv-err">{{ fieldErr }}</span>
          </div>
          <button class="lv-btn-primary" :disabled="loading" @click="checkEmail">
            <span v-if="loading" class="lv-spinner"></span>
            <span v-else>Continuer <ArrowRight /></span>
          </button>
        </template>

        <!-- État : connexion -->
        <template v-else-if="state === 'login'">
          <button class="lv-back" @click="state = 'email'"><ChevronIcon /> Retour</button>
          <h2 class="lv-title">Content de te revoir !</h2>
          <p class="lv-sub-auth">Compte trouvé pour <strong>{{ email }}</strong>.</p>
          <div v-if="globalErr" class="lv-notice err">{{ globalErr }}</div>
          <div class="lv-field">
            <div class="lv-field-hdr">
              <label>Mot de passe</label>
              <button class="lv-link-btn" @click="state = 'forgot'">Mot de passe oublié ?</button>
            </div>
            <div class="lv-input-wrap">
              <input
                v-model="password"
                :type="showPwd ? 'text' : 'password'"
                placeholder="••••••••"
                autocomplete="current-password"
                @keydown.enter="doLogin"
                :class="{ 'is-err': fieldErr }"
              >
              <button class="lv-eye" @click="showPwd = !showPwd" type="button">
                <EyeIcon :open="!showPwd" />
              </button>
            </div>
            <span v-if="fieldErr" class="lv-err">{{ fieldErr }}</span>
          </div>
          <button class="lv-btn-primary" :disabled="loading" @click="doLogin">
            <span v-if="loading" class="lv-spinner"></span>
            <span v-else>Se connecter</span>
          </button>
          <p class="lv-legal" style="margin-top:14px">Pas toi ? <button class="lv-link-plain" @click="email=''; state='email'">Changer d'adresse</button></p>
        </template>

        <!-- État : inscription -->
        <template v-else-if="state === 'signup'">
          <button class="lv-back" @click="state = 'email'"><ChevronIcon /> Retour</button>
          <h2 class="lv-title">Crée ton compte</h2>
          <p class="lv-sub-auth">Nouveau sur EduClé ? Bienvenue !</p>
          <div class="lv-notice info">📧 &nbsp;E-mail : <strong>{{ email }}</strong></div>
          <div class="lv-field">
            <label>Prénom</label>
            <input v-model="pseudo" type="text" placeholder="Ton prénom" autocomplete="given-name">
            <span v-if="nameErr" class="lv-err">{{ nameErr }}</span>
          </div>
          <div class="lv-field">
            <label>Mot de passe <span style="color:var(--lv-muted);font-weight:400">(8 caractères min.)</span></label>
            <div class="lv-input-wrap">
              <input
                v-model="password"
                :type="showPwd ? 'text' : 'password'"
                placeholder="••••••••"
                autocomplete="new-password"
                @keydown.enter="doRegister"
                :class="{ 'is-err': fieldErr }"
              >
              <button class="lv-eye" @click="showPwd = !showPwd" type="button">
                <EyeIcon :open="!showPwd" />
              </button>
            </div>
            <span v-if="fieldErr" class="lv-err">{{ fieldErr }}</span>
          </div>
          <button class="lv-btn-primary" :disabled="loading" @click="doRegister">
            <span v-if="loading" class="lv-spinner"></span>
            <span v-else>Créer mon compte</span>
          </button>
          <p class="lv-legal">En créant un compte, tu acceptes nos <a href="#">CGU</a>.</p>
        </template>

        <!-- État : mot de passe oublié -->
        <template v-else-if="state === 'forgot'">
          <button class="lv-back" @click="state = 'login'"><ChevronIcon /> Retour</button>
          <h2 class="lv-title">Mot de passe oublié</h2>
          <p class="lv-sub-auth">Entre ton adresse e-mail pour recevoir un lien de réinitialisation.</p>
          <div class="lv-field">
            <label>E-mail</label>
            <input v-model="email" type="email" placeholder="prenom@exemple.com" :class="{ 'is-err': fieldErr }">
            <span v-if="fieldErr" class="lv-err">{{ fieldErr }}</span>
          </div>
          <button class="lv-btn-primary" :disabled="loading" @click="doForgot">
            <span v-if="loading" class="lv-spinner"></span>
            <span v-else>Envoyer le lien</span>
          </button>
        </template>

        <!-- État : lien envoyé -->
        <template v-else-if="state === 'forgot-sent'">
          <span class="lv-big-icon">📬</span>
          <h2 class="lv-title">Vérifie ta boîte mail</h2>
          <p class="lv-sub-auth" style="margin-bottom:24px">Lien envoyé à <strong>{{ email }}</strong>. Il expire dans 15 minutes.</p>
          <button class="lv-btn-ghost" @click="state = 'login'">Retour à la connexion</button>
        </template>

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.js'

// ── Icônes inline ─────────────────────────────────────────────────────────────
const GoogleIcon = {
  template: `<svg width="17" height="17" viewBox="0 0 18 18" fill="none" style="flex-shrink:0">
    <path d="M17.64 9.205c0-.639-.057-1.252-.164-1.841H9v3.481h4.844a4.14 4.14 0 0 1-1.796 2.716v2.259h2.908c1.702-1.567 2.684-3.875 2.684-6.615Z" fill="#4285F4"/>
    <path d="M9 18c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H.957v2.332A8.997 8.997 0 0 0 9 18Z" fill="#34A853"/>
    <path d="M3.964 10.71A5.41 5.41 0 0 1 3.682 9c0-.593.102-1.17.282-1.71V4.958H.957A8.996 8.996 0 0 0 0 9c0 1.452.348 2.827.957 4.042l3.007-2.332Z" fill="#FBBC05"/>
    <path d="M9 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.463.891 11.426 0 9 0A8.997 8.997 0 0 0 .957 4.958L3.964 7.29C4.672 5.163 6.656 3.58 9 3.58Z" fill="#EA4335"/>
  </svg>`
}

const MailIcon = {
  template: `<svg width="16" height="16" viewBox="0 0 16 16" fill="none" style="flex-shrink:0">
    <rect x="1" y="3.5" width="14" height="9" rx="1.5" stroke="currentColor" stroke-width="1.3" fill="none"/>
    <path d="M1 5.5l6.2 4a1.3 1.3 0 0 0 1.6 0L15 5.5" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"/>
  </svg>`
}
const ChevronIcon = {
  template: `<svg width="15" height="15" viewBox="0 0 15 15" fill="none">
    <path d="M9.5 3L5.5 7.5l4 4.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>`
}
const ArrowRight = {
  template: `<svg width="14" height="14" viewBox="0 0 14 14" fill="none" style="display:inline">
    <path d="M3 7h8M7.5 3.5l4 3.5-4 3.5" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>`
}
const EyeIcon = {
  props: ['open'],
  template: `
    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
      <template v-if="open">
        <ellipse cx="8" cy="8" rx="7" ry="5" stroke="currentColor" stroke-width="1.3" fill="none"/>
        <circle cx="8" cy="8" r="2" stroke="currentColor" stroke-width="1.3" fill="none"/>
      </template>
      <template v-else>
        <path d="M2 2l12 12M6.7 6.8a2 2 0 0 0 2.5 2.5M1 8s2.5-4.5 7-4.5c1.1 0 2.1.2 3 .6M15 8s-.7 1.3-2 2.5" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"/>
      </template>
    </svg>`
}

// ── State ─────────────────────────────────────────────────────────────────────
const router = useRouter()
const auth = useAuthStore()

const state    = ref('initial')
const email    = ref('')
const password = ref('')
const pseudo   = ref('')
const showPwd  = ref(false)
const loading  = ref(false)
const fieldErr = ref('')
const nameErr  = ref('')
const globalErr = ref('')

function clearErr() { fieldErr.value = ''; globalErr.value = ''; nameErr.value = '' }

function loginGoogle() {
  window.location.href = `${import.meta.env.VITE_API_URL || ''}/auth/google`
}

// ── Actions ───────────────────────────────────────────────────────────────────
async function checkEmail() {
  clearErr()
  if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
    fieldErr.value = 'Adresse e-mail invalide.'
    return
  }
  loading.value = true
  try {
    const exists = await auth.checkEmail(email.value)
    state.value = exists ? 'login' : 'signup'
    password.value = ''
    showPwd.value = false
  } catch {
    fieldErr.value = 'Erreur réseau. Réessaie.'
  } finally {
    loading.value = false
  }
}

async function doLogin() {
  clearErr()
  if (!password.value) { fieldErr.value = 'Entre ton mot de passe.'; return }
  loading.value = true
  try {
    await auth.login(email.value, password.value)
    router.push('/')
  } catch (e) {
    const msg = e?.response?.data?.detail || 'E-mail ou mot de passe incorrect.'
    globalErr.value = msg
  } finally {
    loading.value = false
  }
}

async function doRegister() {
  clearErr()
  if (!pseudo.value.trim()) { nameErr.value = 'Entre ton prénom.'; return }
  if (password.value.length < 8) { fieldErr.value = 'Au moins 8 caractères.'; return }
  loading.value = true
  try {
    await auth.register(email.value, password.value, pseudo.value.trim())
    router.push('/')
  } catch (e) {
    const msg = e?.response?.data?.detail || 'Erreur lors de la création du compte.'
    globalErr.value = msg
  } finally {
    loading.value = false
  }
}

async function doForgot() {
  clearErr()
  if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
    fieldErr.value = 'Adresse e-mail invalide.'
    return
  }
  loading.value = true
  await new Promise(r => setTimeout(r, 800)) // TODO: vrai endpoint reset
  loading.value = false
  state.value = 'forgot-sent'
}

// ── Constellation canvas ──────────────────────────────────────────────────────
const canvasRef = ref(null)
let _animId = null

onMounted(() => {
  const canvas = canvasRef.value
  if (!canvas) return
  const ctx = canvas.getContext('2d')
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  let W, H, nodes

  function resize() {
    W = canvas.width  = canvas.parentElement.offsetWidth
    H = canvas.height = canvas.parentElement.offsetHeight
  }
  function init() {
    nodes = Array.from({ length: 38 }, () => ({
      x: Math.random() * W, y: Math.random() * H,
      vx: (Math.random() - 0.5) * 0.28, vy: (Math.random() - 0.5) * 0.28,
      r: Math.random() * 1.8 + 0.8,
    }))
  }
  function tick() {
    ctx.clearRect(0, 0, W, H)
    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const dx = nodes[i].x - nodes[j].x, dy = nodes[i].y - nodes[j].y
        const d = Math.sqrt(dx * dx + dy * dy)
        if (d < 120) {
          ctx.beginPath()
          ctx.strokeStyle = `rgba(255,255,255,${0.12 * (1 - d / 120)})`
          ctx.lineWidth = 0.6
          ctx.moveTo(nodes[i].x, nodes[i].y)
          ctx.lineTo(nodes[j].x, nodes[j].y)
          ctx.stroke()
        }
      }
    }
    nodes.forEach(n => {
      ctx.beginPath(); ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2)
      ctx.fillStyle = 'rgba(255,255,255,0.3)'; ctx.fill()
      if (!reduced) { n.x += n.vx; n.y += n.vy; if (n.x < 0 || n.x > W) n.vx *= -1; if (n.y < 0 || n.y > H) n.vy *= -1 }
    })
    if (!reduced) _animId = requestAnimationFrame(tick)
  }
  resize(); init(); tick()
  new ResizeObserver(() => { resize(); init() }).observe(canvas.parentElement)
})

onUnmounted(() => { if (_animId) cancelAnimationFrame(_animId) })
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600&display=swap');

.lv-page {
  display: flex;
  min-height: 100dvh;
  font-family: 'DM Sans', -apple-system, sans-serif;
  --lv-brand:    #2563EB;
  --lv-amber:    #F59E0B;
  --lv-ink:      #0D1117;
  --lv-ink2:     #3D4A62;
  --lv-muted:    #6B7A99;
  --lv-ground:   #F4F6FB;
  --lv-surface:  #FFFFFF;
  --lv-border:   #DDE2F0;
  --lv-danger:   #DC2626;
  --lv-info-bg:  #EFF4FF;
}

/* Brand panel */
.lv-brand {
  width: 42%;
  min-height: 100dvh;
  background: linear-gradient(148deg, #030C1F 0%, #0A1F44 40%, #122F6A 75%, #1B3E96 100%);
  position: relative;
  overflow: hidden;
  display: flex;
  flex-shrink: 0;
}
.lv-canvas { position: absolute; inset: 0; width: 100%; height: 100%; display: block; }
.lv-brand-inner {
  position: relative; z-index: 1; display: flex; flex-direction: column;
  width: 100%; min-height: 100dvh; padding: 44px 48px; justify-content: space-between;
}
.lv-logo { display: flex; align-items: center; gap: 11px; }
.lv-logo-mark {
  width: 38px; height: 38px; background: var(--lv-amber); border-radius: 9px;
  display: flex; align-items: center; justify-content: center; font-size: 19px;
}
.lv-logo-name { font-family: 'Syne', sans-serif; font-size: 22px; font-weight: 800; color: #fff; letter-spacing: -0.5px; }
.lv-hero { flex: 1; display: flex; flex-direction: column; justify-content: center; padding: 40px 0; }
.lv-headline {
  font-family: 'Syne', sans-serif; font-size: clamp(26px, 2.8vw, 40px); font-weight: 700;
  color: #fff; line-height: 1.18; text-wrap: balance; margin-bottom: 18px; letter-spacing: -0.5px;
}
.lv-sub { font-size: 15px; color: rgba(255,255,255,0.58); line-height: 1.65; max-width: 280px; }
.lv-chips { display: flex; flex-wrap: wrap; gap: 7px; margin-top: 28px; }
.lv-chip {
  background: rgba(255,255,255,0.09); border: 1px solid rgba(255,255,255,0.13);
  color: rgba(255,255,255,0.78); font-size: 11.5px; font-weight: 500;
  padding: 5px 13px; border-radius: 100px; backdrop-filter: blur(4px); letter-spacing: 0.02em;
}
.lv-footer { font-size: 11.5px; color: rgba(255,255,255,0.28); }

/* Auth panel */
.lv-auth {
  flex: 1; display: flex; align-items: center; justify-content: center;
  padding: 48px 32px; background: var(--lv-ground);
}
.lv-box { width: 100%; max-width: 390px; color: var(--lv-ink); }

.lv-title {
  font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 700;
  color: var(--lv-ink); letter-spacing: -0.4px; text-wrap: balance; margin-bottom: 6px;
}
.lv-sub-auth { font-size: 14px; color: var(--lv-muted); line-height: 1.55; margin-bottom: 30px; }

/* OAuth */
.lv-oauth-stack { display: flex; flex-direction: column; gap: 9px; margin-bottom: 18px; }
.lv-btn-oauth {
  display: flex; align-items: center; justify-content: center; gap: 10px;
  width: 100%; padding: 12px 18px; background: var(--lv-surface);
  border: 1.5px solid var(--lv-border); border-radius: 12px; color: var(--lv-ink);
  font-family: 'DM Sans', sans-serif; font-size: 14px; font-weight: 500; cursor: pointer;
  transition: border-color 0.15s, background 0.12s;
}
.lv-btn-oauth:not(:disabled):hover { border-color: var(--lv-brand); background: var(--lv-info-bg); }
.lv-btn-oauth:disabled { opacity: 0.45; cursor: not-allowed; }

/* Divider */
.lv-divider {
  display: flex; align-items: center; gap: 12px; margin: 16px 0;
  color: var(--lv-muted); font-size: 11.5px; letter-spacing: 0.06em; text-transform: uppercase;
}
.lv-divider::before, .lv-divider::after { content: ''; flex: 1; height: 1px; background: var(--lv-border); }

/* Ghost button */
.lv-btn-ghost {
  display: flex; align-items: center; justify-content: center; gap: 8px; width: 100%;
  padding: 12px 18px; background: transparent; border: 1.5px solid var(--lv-border);
  border-radius: 12px; color: var(--lv-ink2); font-family: 'DM Sans', sans-serif;
  font-size: 14px; font-weight: 500; cursor: pointer; transition: border-color 0.15s, color 0.12s;
}
.lv-btn-ghost:hover { border-color: var(--lv-brand); color: var(--lv-brand); }

/* Back */
.lv-back {
  display: inline-flex; align-items: center; gap: 5px; background: none; border: none;
  padding: 0; color: var(--lv-muted); font-family: 'DM Sans', sans-serif;
  font-size: 13px; cursor: pointer; margin-bottom: 26px; transition: color 0.12s;
}
.lv-back:hover { color: var(--lv-brand); }

/* Fields */
.lv-field { margin-bottom: 14px; }
.lv-field label { display: block; font-size: 13px; font-weight: 500; color: var(--lv-ink2); margin-bottom: 6px; }
.lv-field-hdr { display: flex; align-items: center; justify-content: space-between; margin-bottom: 6px; }
.lv-field input {
  width: 100%; padding: 11px 14px; background: var(--lv-surface);
  border: 1.5px solid var(--lv-border); border-radius: 8px;
  color: var(--lv-ink); font-family: 'DM Sans', sans-serif; font-size: 15px; outline: none;
  transition: border-color 0.15s;
}
.lv-field input:focus { border-color: var(--lv-brand); }
.lv-field input.is-err { border-color: var(--lv-danger); }
.lv-err { display: block; font-size: 12px; color: var(--lv-danger); margin-top: 5px; }
.lv-input-wrap { position: relative; }
.lv-input-wrap input { padding-right: 44px; }
.lv-eye {
  position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
  background: none; border: none; cursor: pointer; color: var(--lv-muted);
  padding: 4px; display: flex; line-height: 0; transition: color 0.12s;
}
.lv-eye:hover { color: var(--lv-ink); }

/* Primary button */
.lv-btn-primary {
  display: flex; align-items: center; justify-content: center; gap: 8px;
  width: 100%; padding: 13px 20px; background: var(--lv-brand); color: #fff;
  border: none; border-radius: 12px; font-family: 'Syne', sans-serif;
  font-size: 15px; font-weight: 600; letter-spacing: -0.2px; cursor: pointer;
  transition: opacity 0.15s; margin-top: 20px;
}
.lv-btn-primary:hover { opacity: 0.88; }
.lv-btn-primary:disabled { opacity: 0.45; cursor: not-allowed; }

/* Spinner */
.lv-spinner {
  width: 17px; height: 17px; border: 2px solid rgba(255,255,255,0.25);
  border-top-color: rgba(255,255,255,0.9); border-radius: 50%; animation: lv-spin 0.7s linear infinite;
}
@keyframes lv-spin { to { transform: rotate(360deg); } }

/* Notice */
.lv-notice {
  padding: 11px 14px; border-radius: 8px; font-size: 13px; line-height: 1.5; margin-bottom: 16px;
}
.lv-notice.info { background: var(--lv-info-bg); color: var(--lv-brand); border: 1px solid rgba(37,99,235,0.18); }
.lv-notice.err { background: #FEF2F2; color: var(--lv-danger); border: 1px solid rgba(220,38,38,0.18); }

/* Misc */
.lv-link-btn {
  background: none; border: none; padding: 0; font-family: 'DM Sans', sans-serif;
  font-size: 12.5px; color: var(--lv-brand); cursor: pointer;
}
.lv-link-btn:hover { text-decoration: underline; }
.lv-link-plain {
  background: none; border: none; color: var(--lv-brand); font-size: 11.5px;
  cursor: pointer; font-family: inherit; padding: 0; text-decoration: underline;
}
.lv-big-icon { display: block; font-size: 40px; margin-bottom: 20px; }
.lv-legal {
  font-size: 11.5px; color: var(--lv-muted); text-align: center;
  line-height: 1.6; margin-top: 18px;
}
.lv-legal a { color: var(--lv-ink2); text-decoration: underline; }

/* Mobile */
@media (max-width: 720px) {
  .lv-page { flex-direction: column; }
  .lv-brand { width: 100%; min-height: auto; }
  .lv-brand-inner { min-height: auto; padding: 28px 24px; }
  .lv-hero { padding: 24px 0; }
  .lv-footer { display: none; }
  .lv-auth { padding: 32px 20px; align-items: flex-start; }
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation-duration: 0.001ms !important; transition-duration: 0.001ms !important; }
}
</style>
