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
  import CommunicationManager from '@/stores/CommunicationManager'
  
  const user = ref(null)
  const router = useRouter()
  
  const fetchUserProfile = async () => {
    try {
      const data = await CommunicationManager.getUserProfile()
      user.value = data
    } catch (error) {
      console.error('Error al obtener el perfil:', error.message)
      router.push('/login') 
    }
  }
  
  const logout = () => {
    localStorage.removeItem('token') 
    router.push('/login')  
  }
  
  onMounted(() => {
    fetchUserProfile() 
  })
  </script>
  