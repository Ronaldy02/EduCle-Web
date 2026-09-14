<template>
  <div class="ac-page">
    <div class="ac-box">
      <div v-if="error">
        <p class="ac-err">{{ error }}</p>
        <button class="ac-btn" @click="$router.replace('/admin/login')">Retour à la connexion</button>
      </div>
      <div v-else>
        <div class="ac-spinner"></div>
        <p class="ac-msg">Connexion en cours…</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const error = ref('')

onMounted(() => {
  const params = new URLSearchParams(window.location.search)
  const token = params.get('token')
  const role = params.get('role')
  const pseudo = params.get('pseudo')
  const err = params.get('error')

  if (err === 'unauthorized') {
    error.value = 'Ce compte Google n\'a pas les droits d\'administration.'
    return
  }
  if (!token || !role) {
    error.value = 'Données de connexion manquantes.'
    return
  }

  localStorage.setItem('ec_admin_token', token)
  localStorage.setItem('ec_admin_role', role)
  localStorage.setItem('ec_admin_pseudo', pseudo || '')

  router.replace('/admin')
})
</script>

<style scoped>
.ac-page {
  min-height: 100dvh;
  display: flex; align-items: center; justify-content: center;
  background: #0D1B3E;
}
.ac-box {
  background: #fff; border-radius: 16px; padding: 40px 48px;
  text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
}
.ac-spinner {
  width: 40px; height: 40px; border: 4px solid #E2E8F0;
  border-top-color: #2563EB; border-radius: 50%;
  animation: spin 0.7s linear infinite; margin: 0 auto 16px;
}
@keyframes spin { to { transform: rotate(360deg); } }
.ac-msg { color: #6B7A99; font-size: 15px; }
.ac-err { color: #DC2626; font-size: 14px; margin-bottom: 16px; }
.ac-btn {
  background: #2563EB; color: #fff; border: none;
  padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 14px;
}
</style>
