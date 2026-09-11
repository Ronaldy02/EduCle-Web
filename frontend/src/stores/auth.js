import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authCheckEmail, authLogin, authRegister, authMe } from '../api/client.js'

const TOKEN_KEY = 'ec_token'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem(TOKEN_KEY) || null)
  const user = ref(null)

  const isAuthenticated = computed(() => !!token.value)

  function _setToken(t) {
    token.value = t
    if (t) localStorage.setItem(TOKEN_KEY, t)
    else localStorage.removeItem(TOKEN_KEY)
  }

  async function checkEmail(email) {
    const { exists } = await authCheckEmail(email)
    return exists
  }

  async function login(email, password) {
    const data = await authLogin(email, password)
    _setToken(data.access_token)
    user.value = data.user
  }

  async function register(email, password, pseudo) {
    const data = await authRegister(email, password, pseudo)
    _setToken(data.access_token)
    user.value = data.user
  }

  async function chargerUser() {
    if (!token.value) return
    try {
      user.value = await authMe()
    } catch {
      logout()
    }
  }

  function logout() {
    _setToken(null)
    user.value = null
  }

  return { token, user, isAuthenticated, checkEmail, login, register, chargerUser, logout }
})
