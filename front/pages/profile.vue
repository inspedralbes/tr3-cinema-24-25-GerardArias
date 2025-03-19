<template>
  <div class="profile-container">
    <div class="profile-card">
      <h1>Perfil de Usuario</h1>
      <div v-if="user">
        <p><strong>Nombre:</strong> {{ user.name }}</p>
        <p><strong>Apellido:</strong> {{ user.lastname }}</p>
        <p><strong>Correo electrónico:</strong> {{ user.email }}</p>
        <p><strong>Teléfono:</strong> {{ user.phone }}</p>
        <button @click="logout">Cerrar sesión</button>
      </div>
      <div v-else class="loading">
        <p>Cargando perfil...</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/userStore'

const router = useRouter()
const userStore = useUserStore()

const user = ref(null)

const fetchUserProfile = async () => {
  if (userStore.isLoggedIn) {
    user.value = userStore.getLoginInfo
  } else {
    router.push('/login')
  }
}

const logout = () => {
  userStore.logout()
  router.push('/login')
}

onMounted(() => {
  fetchUserProfile()
})
</script>

<style scoped>
.profile-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 90vh;
  background: #f8f9fa;
}

.profile-card {
  background: #ffffff;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  text-align: center;
  width: 350px;
}

h1 {
  color: #333;
  font-size: 24px;
  margin-bottom: 20px;
}

p {
  font-size: 16px;
  color: #555;
  margin: 10px 0;
}

button {
  background: #ff5252;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  margin-top: 20px;
  transition: background 0.3s ease-in-out, transform 0.2s;
}

button:hover {
  background: #d32f2f;
  transform: scale(1.05);
}

.loading p {
  font-style: italic;
  color: #888;
}
</style>
