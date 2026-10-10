// ── A7 · Notifications (toasts) ──────────────────────────────────────────────
// toast('Réglages sauvegardés', { icon: 'check_circle', type: 'success' })

import { reactive } from 'vue'

export const toasts = reactive([])
let _id = 0

export function toast(message, { icon = 'info', type = 'info', duree = 3000 } = {}) {
  const id = ++_id
  toasts.push({ id, message, icon, type })
  setTimeout(() => fermerToast(id), duree)
  return id
}

export function fermerToast(id) {
  const i = toasts.findIndex(t => t.id === id)
  if (i !== -1) toasts.splice(i, 1)
}
