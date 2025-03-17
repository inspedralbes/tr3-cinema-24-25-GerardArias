<template>
  <div>
    <h1>Iniciar sesión</h1>
    <form @submit.prevent="handleLogin">
      <div>
        <label for="email">Correo electrónico:</label>
        <input v-model="form.email" type="email" id="email" required />
      </div>
      <div>
        <label for="password">Contraseña:</label>
        <input v-model="form.password" type="password" id="password" required />
      </div>
      <button type="submit">Iniciar sesión</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useUserStore } from '@/stores/userStore'
import { useRouter } from 'vue-router'

const form = ref({
  email: '',
  password: ''
})

const router = useRouter()
const userStore = useUserStore()

const handleLogin = async () => {
  try {
    await userStore.login(form.value) // Guarda la info de usuario en el store solo después de login
    console.log('Login exitoso:', userStore.getLoginInfo) // Puedes ver los datos en la consola
    router.push('/profile')
  } catch (error) {
    console.error('Error al iniciar sesión:', error.message)
    alert('Credenciales incorrectas')
  }
}
</script>
