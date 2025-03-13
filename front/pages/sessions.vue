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
    color: #e74c3c;
    font-weight: bold;
}

div {
    text-align: center;
    font-family: Arial, sans-serif;
    margin-top: 20px;
}

ul {
    list-style: none;
    padding: 0;
}

.session-card {
    background-color: #ffffff;
    border: 1px solid #dcdcdc;
    border-radius: 8px;
    padding: 20px;
    margin-top: 15px;
    max-width: 450px;
    margin-left: auto;
    margin-right: auto;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.session-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

h1 {
    font-size: 2rem;
    color: #333333;
    font-weight: bold;
    margin-bottom: 20px;
}

h3 {
    font-size: 1.5rem;
    font-weight: 600;
    color: #2c3e50;
}

p {
    font-size: 1rem;
    color: #555555;
    margin-top: 5px;
}

strong {
    color: #007bff;
}

ul p {
    margin-bottom: 5px;
}

p:last-child {
    margin-bottom: 0;
}

div p {
    color: #555555;
    font-size: 1.1rem;
}

</style>
