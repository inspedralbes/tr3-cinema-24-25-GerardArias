<template>
    <div>
        <h1>Sessions Disponibles</h1>
        <div v-if="loading">Carregant...</div>
        <div v-if="error" class="error">{{ error }}</div>
        <ul v-if="sessions.length > 0">
            <li v-for="session in sessions" :key="session.id">
                    <div class="session-card">
                    <h3>{{ session.movie.title }}</h3>
                    <p><strong>Gènere:</strong> {{ session.movie.genre }}</p>
                    <p><strong>Durada:</strong> {{ session.movie.runtime }} mins</p>
                    <p><strong>Data:</strong> {{ session.date }}</p>
                    <p><strong>Hora:</strong> {{ session.time }}</p>
                    <p><strong>Fila VIP:</strong> {{ session.vip_enabled ? 'Sí' : 'No' }}</p>
                    <p><strong>Descompte:</strong> {{ session.is_discount_day ? 'Sí' : 'No' }}</p>
                </div>
                </li>
        </ul>
            
        <div v-if="sessions.length === 0 && !loading">
            <p>No hi ha sessions disponibles.</p>
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
};

</script>

<style scoped>
.error {
    color: red;
    font-weight: bold;
}

div{
    text-align: center;
}
ul{
    list-style: none;
}

.session-card {
  border: 1px solid black;
  border-radius: 8px;
  max-width: 400px;
  margin-top: 5px;
}
</style>