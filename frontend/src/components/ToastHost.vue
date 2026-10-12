<template>
  <TransitionGroup name="toast" tag="div" class="toast-host" aria-live="polite">
    <div v-for="t in toasts" :key="t.id" class="toast" :class="`toast--${t.type}`" @click="fermerToast(t.id)">
      <span class="material-symbols-outlined">{{ t.icon }}</span>
      {{ t.message }}
    </div>
  </TransitionGroup>
</template>

<script setup>
import { toasts, fermerToast } from '../animations/toast.js'
</script>

<style>
.toast-host {
  position: fixed; top: 1rem; left: 50%; transform: translateX(-50%);
  z-index: 300; display: flex; flex-direction: column; align-items: center; gap: 0.5rem;
  pointer-events: none;
}
.toast {
  pointer-events: auto; cursor: pointer;
  display: flex; align-items: center; gap: 0.5rem;
  background: var(--text); color: #fff;
  padding: 0.65rem 1.1rem; border-radius: 99px;
  font-size: 0.875rem; font-weight: 600;
  box-shadow: 0 8px 24px rgba(0,0,0,0.18);
  white-space: nowrap;
}
.toast .material-symbols-outlined { font-size: 18px; }
.toast--success .material-symbols-outlined { color: #4ADE80; }
.toast--error   .material-symbols-outlined { color: #F87171; }

/* Arrivée depuis le haut avec rebond, départ vers le haut */
.toast-enter-active { transition: transform var(--dur-normal) var(--ease-spring), opacity var(--dur-normal) ease; }
.toast-leave-active { transition: transform var(--dur-normal) var(--ease-in), opacity var(--dur-normal) ease; position: absolute; }
.toast-enter-from   { transform: translateY(-140%); opacity: 0; }
.toast-leave-to     { transform: translateY(-140%); opacity: 0; }
.toast-move         { transition: transform var(--dur-normal) var(--ease-out); }
</style>
