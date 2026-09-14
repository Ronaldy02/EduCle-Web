<template>
  <div class="al-page">
    <div class="al-box">
      <div class="al-logo">
        <div class="al-logo-mark">🔑</div>
        <span class="al-logo-name">EduClé</span>
        <span class="al-badge">Administration</span>
      </div>

      <h2 class="al-title">Espace administrateur</h2>
      <p class="al-sub">Accès restreint au personnel autorisé.</p>

      <div v-if="globalErr" class="al-notice err">{{ globalErr }}</div>

      <div class="al-field">
        <label>E-mail</label>
        <input v-model="email" type="email" placeholder="admin@exemple.com"
               autocomplete="email" @keydown.enter="doLogin" :class="{ 'is-err': !!globalErr }">
      </div>

      <div class="al-field">
        <label>Mot de passe</label>
        <div class="al-input-wrap">
          <input v-model="password" :type="showPwd ? 'text' : 'password'"
                 placeholder="••••••••" autocomplete="current-password"
                 @keydown.enter="doLogin" :class="{ 'is-err': !!globalErr }">
          <button class="al-eye" @click="showPwd = !showPwd" type="button">
            <svg v-if="showPwd" width="16" height="16" viewBox="0 0 16 16" fill="none">
              <ellipse cx="8" cy="8" rx="7" ry="5" stroke="currentColor" stroke-width="1.3" fill="none"/>
              <circle cx="8" cy="8" r="2" stroke="currentColor" stroke-width="1.3" fill="none"/>
            </svg>
            <svg v-else width="16" height="16" viewBox="0 0 16 16" fill="none">
              <path d="M2 2l12 12M6.7 6.8a2 2 0 0 0 2.5 2.5M1 8s2.5-4.5 7-4.5c1.1 0 2.1.2 3 .6M15 8s-.7 1.3-2 2.5" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"/>
            </svg>
          </button>
        </div>
      </div>

      <button class="al-btn" :disabled="loading" @click="doLogin">
        <span v-if="loading" class="al-spinner"></span>
        <span v-else>Accéder au panneau</span>
      </button>

      <button class="al-back" @click="$router.push('/')">← Retour à l'application</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const BASE = import.meta.env.VITE_API_URL || ''

const email    = ref('')
const password = ref('')
const showPwd  = ref(false)
const loading  = ref(false)
const globalErr = ref('')

async function doLogin() {
  globalErr.value = ''
  if (!email.value || !password.value) {
    globalErr.value = 'Remplis tous les champs.'
    return
  }
  loading.value = true
  try {
    const { data } = await axios.post(`${BASE}/admin/login`, {
      email: email.value,
      password: password.value,
    })
    localStorage.setItem('ec_admin_token', data.access_token)
    localStorage.setItem('ec_admin_role', data.role)
    localStorage.setItem('ec_admin_pseudo', data.pseudo)
    router.push('/admin')
  } catch (e) {
    globalErr.value = e?.response?.data?.detail || 'Identifiants incorrects ou accès non autorisé.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600&display=swap');

.al-page {
  min-height: 100dvh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px 16px;
  background: #0D1B3E;
  font-family: 'DM Sans', sans-serif;
}

.al-box {
  width: 100%;
  max-width: 400px;
  background: #fff;
  border-radius: 18px;
  padding: 40px 36px 32px;
  box-shadow: 0 24px 80px rgba(0,0,0,0.35);
}

.al-logo {
  display: flex;
  align-items: center;
  gap: 9px;
  margin-bottom: 28px;
}
.al-logo-mark {
  width: 34px; height: 34px;
  background: #F59E0B;
  border-radius: 8px;
  display: flex; align-items: center; justify-content: center;
  font-size: 17px;
}
.al-logo-name {
  font-family: 'Syne', sans-serif;
  font-size: 18px; font-weight: 800;
  color: #0D1117; letter-spacing: -0.3px;
}
.al-badge {
  margin-left: 4px;
  background: #EFF4FF;
  color: #2563EB;
  font-size: 11px; font-weight: 600;
  padding: 3px 9px; border-radius: 100px;
  letter-spacing: 0.03em;
}

.al-title {
  font-family: 'Syne', sans-serif;
  font-size: 21px; font-weight: 700;
  color: #0D1117; letter-spacing: -0.3px;
  margin-bottom: 5px;
}
.al-sub { font-size: 13.5px; color: #6B7A99; margin-bottom: 26px; }

.al-notice {
  padding: 10px 14px; border-radius: 8px;
  font-size: 13px; margin-bottom: 16px;
}
.al-notice.err { background: #FEF2F2; color: #DC2626; border: 1px solid rgba(220,38,38,0.18); }

.al-field { margin-bottom: 14px; }
.al-field label {
  display: block; font-size: 13px; font-weight: 500;
  color: #3D4A62; margin-bottom: 6px;
}
.al-field input {
  width: 100%; padding: 11px 14px;
  background: #F4F6FB; border: 1.5px solid #DDE2F0;
  border-radius: 8px; color: #0D1117;
  font-family: 'DM Sans', sans-serif; font-size: 15px; outline: none;
  transition: border-color 0.15s;
}
.al-field input:focus { border-color: #2563EB; background: #fff; }
.al-field input.is-err { border-color: #DC2626; }
.al-input-wrap { position: relative; }
.al-input-wrap input { padding-right: 44px; }
.al-eye {
  position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
  background: none; border: none; cursor: pointer; color: #6B7A99; padding: 4px; line-height: 0;
}

.al-btn {
  width: 100%; padding: 13px; margin-top: 8px;
  background: #0D1B3E; color: #fff; border: none; border-radius: 12px;
  font-family: 'Syne', sans-serif; font-size: 15px; font-weight: 700;
  cursor: pointer; transition: opacity 0.15s;
  display: flex; align-items: center; justify-content: center;
}
.al-btn:hover { opacity: 0.85; }
.al-btn:disabled { opacity: 0.45; cursor: not-allowed; }

.al-spinner {
  width: 17px; height: 17px;
  border: 2px solid rgba(255,255,255,0.25);
  border-top-color: #fff;
  border-radius: 50%; animation: spin 0.7s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

.al-back {
  display: block; width: 100%; text-align: center;
  background: none; border: none; margin-top: 18px;
  font-size: 13px; color: #6B7A99; cursor: pointer;
  font-family: inherit;
}
.al-back:hover { color: #2563EB; }
</style>
