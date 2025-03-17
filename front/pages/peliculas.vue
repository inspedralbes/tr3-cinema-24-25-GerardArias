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
            <div class="grid">
                <div v-for="peli in peliculas" :key="peli.id" class="flex justify-center">
                    <div @click="showPlot(peli)" class="peli-card">
                        <img :src="peli.poster" alt="Pelicula" class="card-img" />
                        <h3 class="text-center mt-2">{{ peli.title }}</h3>
                        <p class="text-center mt-2">{{ peli.genre }}</p>
                        <p class="text-center mt-2">{{ peli.runtime }} min</p>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="selectedPeli" class="modal" @click="closeModal">
            <div class="modal-content" @click.stop>
                <h2>{{ selectedPeli.title }}</h2>
                <p>{{ selectedPeli.plot }}</p>
                <button @click="closeModal" class="close-button">Cerrar</button>
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
const selectedPeli = ref(null);

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

const showPlot = (peli) => {
    selectedPeli.value = peli;
};

const closeModal = () => {
    selectedPeli.value = null;
};

onMounted(fetchPeliculas);
</script>

<style scoped>
body {
    overflow-x: hidden;
    margin: 0;
}

.peliculas-container {
    display: flex;
    flex-direction: column;
    align-items: center;    
    width: 100%;
    overflow-x: hidden;
}

.grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    width: 100%;
    padding: 30px;
    box-sizing: border-box;
}

.peli-card {
    background-color: #ffffff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: transform 0.3s ease;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 600px;
    overflow: hidden;
    border-radius: 8px;
}

.peli-card:hover {
    transform: scale(1.05);
}

.card-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
}

h3, p {
    margin-top: 10px;
    color: #333333;
}

h3 {
    font-size: 1.25rem;
    font-weight: 600;
}

p {
    font-size: 1rem;
}

.text-center {
    text-align: center;
}

.text-red-600 {
    color: #e74c3c;
}

.modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.modal-content {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    max-width: 600px;
    width: 80%;
}

.close-button {
    margin-top: 20px;
    padding: 10px 15px;
    background-color: #FF5733;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.close-button:hover {
    background-color: #C0392B;
}
</style>
