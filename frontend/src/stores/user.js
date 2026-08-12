import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getNiveau, getProfil } from '../api/client.js'

export const useUserStore = defineStore('user', () => {
  const profil = ref(null)
  const niveau = ref(null)

  async function charger() {
    const [p, n] = await Promise.all([getProfil(), getNiveau()])
    profil.value = p
    niveau.value = n
  }

  return { profil, niveau, charger }
})
