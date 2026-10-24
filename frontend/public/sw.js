// Service Worker EduClé — gestion des notifications Web Push
self.addEventListener('push', (event) => {
  if (!event.data) return
  let payload
  try { payload = event.data.json() } catch { payload = { title: 'EduClé', body: event.data.text(), url: '/defis' } }

  event.waitUntil(
    self.registration.showNotification(payload.title || 'EduClé', {
      body: payload.body || '',
      icon: '/logo/educle_cle_or.png',
      badge: '/logo/educle_cle_or.png',
      data: { url: payload.url || '/defis' },
      vibrate: [200, 100, 200],
    })
  )
})

self.addEventListener('notificationclick', (event) => {
  event.notification.close()
  const url = (event.notification.data && event.notification.data.url) || '/defis'
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((list) => {
      for (const c of list) {
        if (c.url.includes(self.location.origin) && 'focus' in c) {
          c.navigate(url)
          return c.focus()
        }
      }
      if (clients.openWindow) return clients.openWindow(url)
    })
  )
})
