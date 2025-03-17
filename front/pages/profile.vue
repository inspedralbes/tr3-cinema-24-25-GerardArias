<template>
  <div>
    <h1>Perfil de Usuario</h1>
    <div v-if="user">
      <p>Nombre: {{ user.name }}</p>
      <p>Apellido: {{ user.lastname }}</p>
      <p>Correo electrónico: {{ user.email }}</p>
      <p>Teléfono: {{ user.phone }}</p>
      <button @click="logout">Cerrar sesión</button>
    </div>
    <div v-else>
      <p>Cargando perfil...</p>
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
