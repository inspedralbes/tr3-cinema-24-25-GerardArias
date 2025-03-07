<template>
  <div class="peli-card border p-2 mb-4 rounded-md">
    <h3 class="text-lg font-semibold">{{ peli.title }}</h3>
    <p class="text-sm"><strong>Género:</strong> {{ peli.genre }}</p>
    <p class="text-sm"><strong>Duración:</strong> {{ peli.runtime }} minutos</p>
    <!-- <p class="text-sm"><strong>Resumen:</strong> {{ peli.plot }}</p> -->
    <!-- Imagen más pequeña -->
    <img :src="peli.poster" alt="Poster de la película"/>
  </div>
</template>

<script setup>
defineProps({
  peli: {
    type: Object,
    required: true
  }
});
</script>

<style scoped>
.peli-card {
  background-color: #f9f9f9;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  max-width: 300px;
  max-height: 500px;
}

.peli-card img {
  width: 300px;
  height: 300px;
}
</style>
