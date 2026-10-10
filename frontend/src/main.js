import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router/index.js'
import './assets/main.css'
import './animations/motion.css'
import './animations/motion.js'
import { installerAnimations } from './animations/directives.js'
import CoinIcon from './components/CoinIcon.vue'
import SkeletonBlock from './components/SkeletonBlock.vue'

const app = createApp(App)
app.use(createPinia())
app.use(router)
installerAnimations(app)
app.component('CoinIcon', CoinIcon)
app.component('SkeletonBlock', SkeletonBlock)
app.mount('#app')
