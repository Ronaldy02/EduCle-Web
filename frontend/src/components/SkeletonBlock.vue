<!-- A5 · Bloc de chargement « squelette » avec reflet -->
<template>
  <div class="skeleton-group" aria-busy="true" aria-label="Chargement">
    <div v-for="i in lignes" :key="i" class="skeleton"
      :style="{ height: hauteur, borderRadius: rayon }"></div>
  </div>
</template>

<script setup>
defineProps({
  lignes:  { type: Number, default: 3 },
  hauteur: { type: String, default: '64px' },
  rayon:   { type: String, default: '14px' },
})
</script>

<style>
.skeleton-group { display: flex; flex-direction: column; gap: 0.75rem; width: 100%; }
</style>
