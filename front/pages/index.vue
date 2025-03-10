<template>
  <div class="peliculas-container p-4">
    <h1 class="text-3xl font-bold mb-6">Llistat de Pel·lcules</h1>

    <div v-if="loading" class="text-center">
      Carregant...
    </div>

    <div v-else-if="error" class="text-center text-red-600">
      {{ error }}
    </div>

    <div v-else>
      <div class="">
        <div v-for="peli in peliculas.slice(0, 10)" :key="peli.id" class="flex justify-center">
          <p class="text-center font-semibold">{{ peli.title }}</p>
          <img :src="peli.poster" alt="Poster de la película" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import CommunicationManager from '@/stores/CommunicationManager';
import Peli from './peli.vue';

const peliculas = ref([]);
const loading = ref(false);
const error = ref(null);

const fetchPeliculas = async () => {
  loading.value = true;
  error.value = null;
  try {
    const peliculasData = await CommunicationManager.getMovies();
    peliculas.value = peliculasData;
  } catch (err) {
    error.value = 'Error al cargar las películas.';
    console.error(err);
  } finally {
    loading.value = false;
  }
};

onMounted(fetchPeliculas);
</script>

<style scoped>
.peliculas-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.peli-card {
  background-color: #f9f9f9;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
</style>
