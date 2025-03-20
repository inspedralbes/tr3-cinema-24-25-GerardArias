<template>
  <div class="login-container">
    <form class="form" @submit.prevent="handleLogin">
      <div class="title">Benvingut,<br><span>Inicia sessió per continuar</span></div>
      <div>
        <label for="email" class="label">Correu electrònic:</label>
        <input v-model="form.email" class="input" type="email" id="email" required placeholder="Correu electrònic" />
      </div>
      <div>
        <label for="password" class="label">Contrasenya:</label>
        <input v-model="form.password" class="input" type="password" id="password" required placeholder="Contrasenya" />
      </div>
      <button type="submit" class="button-confirm">Iniciar sessió</button>
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
    console.log('Login exitós:', userStore.getLoginInfo)
    router.push('/profile')
  } catch (error) {
    console.error('Error en iniciar sessió:', error.message)
    alert('Credencials incorrectes')
  }
}
</script>

<style scoped>
  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 90vh;
    background-color: #f0f4f8;
  }

  .form {
    padding: 30px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 20px;
  }

  .title {
    color: #333;
    font-weight: 700;
    font-size: 24px;
    margin-bottom: 20px;
  }

  .title span {
    color: #666;
    font-weight: 500;
    font-size: 16px;
  }

  .label {
    font-size: 14px;
    color: #444;
    font-weight: 600;
  }

  .input {
    width: 100%;
    padding: 12px 15px;
    border-radius: 8px;
    border: 2px solid #ddd;
    background-color: #f9f9f9;
    font-size: 16px;
    font-weight: 500;
    color: #333;
    margin-top: 5px;
    outline: none;
    transition: border 0.3s;
  }

  .input:focus {
    border: 2px solid #3498db;
  }

  .button-confirm {
    margin-top: 20px;
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: none;
    background-color: #3498db;
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .button-confirm:hover {
    background-color: #2980b9;
  }

  .button-confirm:active {
    transform: translateY(2px);
  }
</style>
