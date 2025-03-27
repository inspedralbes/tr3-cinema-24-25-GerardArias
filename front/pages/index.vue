<template>
  <div class="peliculas-container p-4">
    <h1 class="title">Pel·licules</h1>
    <div v-if="loading" class="text-center">Carregant...</div>
    <div v-else-if="error" class="text-center text-red-600">{{ error }}</div>
    <div v-else>
      <div class="imagenes-container-nomobile">
        <div v-for="(peli, index) in peliculas.slice(currentIndex, currentIndex + 5)" :key="index" class="peli-item">
          <p class="text-center font-semibold">{{ peli.title }}</p>
          <img :src="peli.poster" alt="Poster de la película" class="poster-img" />
        </div>
      </div>
      <div class="imagenes-container-mobile">
        <div v-for="(peli, index) in peliculas.slice(currentIndex, currentIndex + 4)" :key="index" class="peli-item">
          <p class="text-center font-semibold">{{ peli.title }}</p>
          <img :src="peli.poster" alt="Poster de la película" class="poster-img" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import CommunicationManager from '@/stores/CommunicationManager';

const peliculas = ref([]);
const loading = ref(false);
const error = ref(null);
const currentIndex = ref(0);

const fetchPeliculas = async () => {
  loading.value = true;
  error.value = null;
  try {
    const peliculasData = await CommunicationManager.getMovies();
    peliculas.value = peliculasData;
  } catch (err) {
    error.value = 'Error al carregar les pel·licules.';
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const changeMovie = () => {
  currentIndex.value = (currentIndex.value + 1) % (peliculas.value.length - 4);
};

onMounted(() => {
  fetchPeliculas();
  setInterval(changeMovie, 2000);
});
</script>

<style scoped>
.peliculas-container {
  padding: 2rem 1.5rem;
  text-align: center;
  background-color: #f9f9f9;
  height: 100vh;
}

.title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #444444;
}

.peli-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: white;
  padding: 10px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  transition: opacity 0.5s ease-in-out;
  width: 180px;
}

.poster-img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.text-center {
  font-size: 1.2rem;
  font-weight: 600;
  color: #444444;
}

.text-red-600 {
  color: #e74c3c;
}

.imagenes-container-nomobile {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.imagenes-container-mobile {
  display: none;
}

@media (max-width: 768px) {
  .peliculas-container {
  padding: 2rem 1.5rem;
  text-align: center;
  background-color: #f9f9f9;
  min-height: 100vh;
}
.title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #444444;
}
.text-center {
  font-size: 1.2rem;
  font-weight: 600;
  color: #444444;
}
.text-red-600 {
  color: #e74c3c;
}
.imagenes-container-mobile {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}
.imagenes-container-nomobile {
  display: none;
}
.peli-item {
  background-color: white;
  padding: 10px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 135px;

}
.poster-img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  transition: all 0.3s ease;
}
}
</style>
