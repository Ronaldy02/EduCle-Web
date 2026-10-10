import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router/index.js'
import './assets/main.css'
import CoinIcon from './components/CoinIcon.vue'

const app = createApp(App)
app.use(createPinia())
app.use(router)
app.component('CoinIcon', CoinIcon)
app.mount('#app')
