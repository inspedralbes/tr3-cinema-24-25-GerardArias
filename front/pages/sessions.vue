<template>
  <div class="sessions-page">
    <h1>Sessions disponibles</h1>

    <div v-if="loading" class="loading">Carregant...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <div v-if="!loading && !error">
      <h2>Sessions d'avui</h2>
      <ul v-if="todaySessions.length > 0" class="sessions-list">
        <li v-for="session in todaySessions" :key="session.id">
          <SessionCard 
            :session="session" 
            @show-plot="showPlot"
          />
        </li>
      </ul>
      <p v-else>No hi ha sessions avui.</p>
    </div>

    <div v-if="!loading && !error">
      <h2>Properes sessions</h2>
      <ul v-if="futureSessions.length > 0" class="sessions-list">
        <li v-for="session in futureSessions" :key="session.id">
          <SessionCard 
            :session="session" 
            @show-plot="showPlot"
          />
        </li>
      </ul>
      <p v-else>No hi ha properes sessions.</p>
    </div>

    <div v-if="selectedPeli" class="modal" @click="closeModal">
      <div class="modal-content" @click.stop>
        <h2>{{ selectedPeli.title }}</h2>
        <p>{{ selectedPeli.plot }}</p>
        <button @click="closeModal" class="close-button">Tanca</button>
      </div>
    </div>
  </div>
</template>

<script setup>
const sessions = ref([]);
const loading = ref(true);
const error = ref(null);
const selectedPeli = ref(null);

const todaySessions = computed(() => {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return sessions.value.filter(session => {
    const sessionDate = new Date(session.date);
    sessionDate.setHours(0, 0, 0, 0);
    return sessionDate.getTime() === today.getTime();
  });
});

const futureSessions = computed(() => {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return sessions.value.filter(session => {
    const sessionDate = new Date(session.date);
    sessionDate.setHours(0, 0, 0, 0);
    return sessionDate.getTime() > today.getTime();
  });
});

onMounted(async () => {
  try {
    sessions.value = await CommunicationManager.getSessions();
  } catch (err) {
    error.value = 'Hi ha hagut un problema en carregar les sessions.';
  } finally {
    loading.value = false;
  }
});

const showPlot = (peli) => {
  selectedPeli.value = peli;
};

const closeModal = () => {
  selectedPeli.value = null;
};
</script>

<style scoped>
.sessions-page {
  text-align: center;
  padding: 20px;
}

h2 {
  color: #333;
  margin: 30px 0 15px;
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
  margin-bottom: 40px;
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
  background-color: #5cb85c;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.close-button:hover {
  background-color: #4cae4c;
}
</style>