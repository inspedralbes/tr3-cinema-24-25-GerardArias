<template>
    <div class="session-card">
      <img :src="session.movie.poster" alt="Pel·lícula" class="card-img" />
      <div class="card-details">
        <h3>{{ session.movie.title }}</h3>
        <p><strong>Gènere:</strong> {{ session.movie.genre }}</p>
        <p><strong>Duració:</strong> {{ session.movie.runtime }} min</p>
        <p><strong>Data:</strong> {{ session.date }}</p>
        <p><strong>Hora:</strong> {{ session.time }}</p>
        <p><strong>Seients VIP:</strong> {{ session.vip_enabled ? 'Sí' : 'No' }}</p>
        <p><strong>Dia espectador:</strong> {{ session.is_discount_day ? 'Sí' : 'No' }}</p>
        <div class="button-container">
          <nuxt-link :to="`/seats/${session.id}`" class="button">Seients</nuxt-link>
          <button @click="$emit('showPlot', session.movie)" class="button">Descripció</button>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  defineProps({
    session: {
      type: Object,
      required: true
    }
  });
  </script>
  
  <style scoped>
  .session-card {
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    background-color: white;
    transition: transform 0.3s;
  }
  
  .card-img {
    width: 100%;
    height: 200px;
    object-fit: contain;
  }
  
  .card-details {
    padding: 15px;
    text-align: left;
  }
  
  .card-details h3 {
    margin: 0 0 10px 0;
    font-size: 1.5em;
    color: #333;
  }
  
  .card-details p {
    margin: 5px 0;
    font-size: 1em;
    color: #555;
  }
  
  .button-container {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
  }
  
  .button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #4caf50;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    cursor: pointer;
    border: none;
  }
  
  .button:hover {
    background-color: #45a049;
  }
  </style>