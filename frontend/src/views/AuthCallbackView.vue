<template>
  <div class="cb-page">
    <div v-if="error" class="cb-error">
      <span class="cb-icon">❌</span>
      <p>{{ errorMsg }}</p>
      <button @click="$router.push('/login')">Retour à la connexion</button>
    </div>
    <div v-else class="cb-loading">
      <div class="cb-spinner"></div>
      <p>Connexion en cours…</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.js'

const router = useRouter()
const auth = useAuthStore()
const error = ref(false)
const errorMsg = ref('')

onMounted(async () => {
  const params = new URLSearchParams(window.location.search)
  const token = params.get('token')
  const err = params.get('error')

  if (err) {
    error.value = true
    errorMsg.value = err === 'google_cancelled' ? 'Connexion annulée.' : `Erreur Google : ${err}`
    return
  }

  if (!token) {
    error.value = true
    errorMsg.value = `Aucun token reçu. URL : ${window.location.href}`
    return
  }

  try {
    await auth.loginWithToken(token)
    router.replace('/')
  } catch (e) {
    error.value = true
    const status = e?.response?.status
    const detail = e?.response?.data?.detail || e?.message || String(e)
    errorMsg.value = status
      ? `Erreur ${status} : ${detail}`
      : `Erreur réseau : ${detail}`
  }
})
</script>

<style scoped>
.cb-page {
  min-height: 100dvh;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'DM Sans', sans-serif;
  background: #F4F6FB;
}
.cb-loading, .cb-error {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #3D4A62;
  font-size: 15px;
}
.cb-spinner {
  width: 36px;
  height: 36px;
  border: 3px solid rgba(37,99,235,0.2);
  border-top-color: #2563EB;
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }
.cb-icon { font-size: 36px; }
.cb-error button {
  padding: 10px 22px;
  background: #2563EB;
  color: #fff;
  border: none;
  border-radius: 10px;
  font-size: 14px;
  cursor: pointer;
}
</style>
