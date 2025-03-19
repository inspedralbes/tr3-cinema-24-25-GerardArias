<template>
  <div class="sessions-page">
    <h1>Sesiones Disponibles</h1>

    <div v-if="loading" class="loading">Cargando...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <ul v-if="sessions.length > 0" class="sessions-list">
      <li v-for="session in sessions" :key="session.id">
        <div class="session-card">
          <img :src="session.movie.poster" alt="Pelicula" class="card-img" />
          <div class="card-details">
            <h3>{{ session.movie.title }}</h3>
            <p><strong>Género:</strong> {{ session.movie.genre }}</p>
            <p><strong>Duración:</strong> {{ session.movie.runtime }} mins</p>
            <p><strong>Fecha:</strong> {{ session.date }}</p>
            <p><strong>Hora:</strong> {{ session.time }}</p>
            <p><strong>Butaques VIP:</strong> {{ session.vip_enabled ? 'Sí' : 'No' }}</p>
            <p><strong>Dia espectador:</strong> {{ session.is_discount_day ? 'Sí' : 'No' }}</p>
            <div class="button-container">
              <nuxt-link :to="`/seats/${session.id}`" class="button">Asientos</nuxt-link>
              <button @click="showPlot(session.movie)" class="button">Descripción</button>
            </div>

          </div>
        </div>
      </li>
    </ul>

    <div v-if="sessions.length === 0 && !loading">
      <p>No hay sesiones disponibles.</p>
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

<script>
import CommunicationManager from '@/stores/CommunicationManager';

export default {
  data() {
    return {
      sessions: [],
      loading: true,
      error: null,
      selectedPeli: null,
    };
  },
  async created() {
    try {
      this.sessions = await CommunicationManager.getSessions();
    } catch (error) {
      this.error = 'Hubo un problema al cargar las sesiones.';
    } finally {
      this.loading = false;
    }
  },
  methods: {
    showPlot(peli) {
      this.selectedPeli = peli;
    },
    closeModal() {
      this.selectedPeli = null;
    },
  },
};
</script>

<style scoped>
.sessions-page {
  text-align: center;
  padding: 20px;
}

.loading {
  font-size: 18px;
  color: #4caf50;
}

.error {
  color: red;
  font-weight: bold;
}

.sessions-list {
  list-style: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.session-card {
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  background-color: white;
  transition: transform 0.3s;
}

.card-img {
  width: 100%;
  height: 200px;
  object-fit: contain;
}

.card-details {
  padding: 15px;
  text-align: left;
}

.card-details h3 {
  margin: 0 0 10px 0;
  font-size: 1.5em;
  color: #333;
}

.card-details p {
  margin: 5px 0;
  font-size: 1em;
  color: #555;
}

.button-container {
  display: flex;
  gap: 10px; /* Espacio entre los botones */
  justify-content: center; /* Centra los botones */
}

.button {
  display: inline-block;
  padding: 10px 20px;
  background-color: #4caf50;
  color: white;
  text-decoration: none;
  border-radius: 5px;
  cursor: pointer;
}

.button:hover {
  background-color: #45a049;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background-color: white;
  padding: 20px;
  border-radius: 10px;
  width: 80%;
  max-width: 500px;
  text-align: center;
}

.close-button {
  margin-top: 20px;
  padding: 10px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.close-button:hover {
  background-color: #45a049;
}
</style>
