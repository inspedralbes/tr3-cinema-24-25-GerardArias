<template>
  <div>
    <h1>Iniciar sessió</h1>
    <form @submit.prevent="handleLogin">
      <div>
        <label for="email">Correu electronic:</label>
        <input v-model="form.email" type="email" id="email" required />
      </div>
      <div>
        <label for="password">Contrasenya:</label>
        <input v-model="form.password" type="password" id="password" required />
      </div>
      <button type="submit">Iniciar sessió</button>
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
    await userStore.login(form.value) 
    console.log('Login exitoso:', userStore.getLoginInfo)
    router.push('/profile')
  } catch (error) {
    console.error('Error al iniciar sesión:', error.message)
    alert('Credenciales incorrectas')
  }
}
</script>
