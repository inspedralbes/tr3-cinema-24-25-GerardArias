<template>
    <div class="register-container">
      <form class="form" @submit.prevent="handleRegister">
        <div class="title">Registrar Usuari</div>
  
        <div>
          <label for="name" class="label">Nom:</label>
          <br />
          <input
            v-model="form.name"
            class="input"
            type="text"
            id="name"
            required
            placeholder="Nom"
          />
        </div>
  
        <div>
          <label for="lastname" class="label">Cognom:</label>
          <br />
          <input
            v-model="form.lastname"
            class="input"
            type="text"
            id="lastname"
            required
            placeholder="Cognom"
          />
        </div>
  
        <div>
          <label for="email" class="label">Correu electrònic:</label>
          <br />
          <input
            v-model="form.email"
            class="input"
            type="email"
            id="email"
            required
            placeholder="Correu electrònic"
          />
        </div>
  
        <div>
          <label for="password" class="label">Contrasenya:</label>
          <br />
          <input
            v-model="form.password"
            class="input"
            type="password"
            id="password"
            required
            placeholder="Contrasenya"
          />
        </div>
  
        <div>
          <label for="phone" class="label">Telèfon:</label>
          <br />
          <input
            v-model="form.phone"
            class="input"
            type="text"
            id="phone"
            required
            placeholder="Telèfon"
          />
        </div>
  
        <button type="submit" class="button-confirm">Registrar</button>
      </form>
      <div class="image-container">
        <img src="../assets/img/cine.jpg" alt="Cine Image" class="image" />
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import CommunicationManager from '@/stores/CommunicationManager'
  
  const form = ref({
    name: '',
    lastname: '',
    email: '',
    password: '',
    phone: ''
  })
  
  const handleRegister = async () => {
    try {
      const data = await CommunicationManager.registerUser(form.value)
      console.log('Usuari registrat:', data)
      alert('Usuari registrat exitosament')
    } catch (error) {
      console.error("Error en registrar l'usuari:", error.message)
      alert("Hi ha hagut un error en registrar l'usuari")
    }
  }
  </script>
  
  <style scoped>
  .register-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 110vh;
    background-color: #f0f4f8;
  }
  
  .form {
    padding: 30px;
    background-color: #ffffff;
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
  }
  
  .title {
    color: #333;
    font-weight: 700;
    font-size: 24px;
    margin-bottom: 20px;
  }
  
  .label {
    font-size: 14px;
    color: #444;
    font-weight: 600;
    margin-top: 10px;
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
    width: 280px;
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
  
  .image-container {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .image {
    width: 100%;
    max-width: 365px; 
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
  }
  </style>
  