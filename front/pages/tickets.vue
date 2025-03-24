<template>
    <div class="container">
        <h1 class="title">Cercar Entrades</h1>

        <form @submit.prevent="searchTickets" class="search-form">
            <input v-model="email" type="email" placeholder="Introdueix el correu electrònic" required class="input" />
            <button type="submit" class="button">Cercar</button>
        </form>

        <div v-if="tickets.length > 0" class="results">
            <h2>Resultats:</h2>
            <table class="tickets-table">
                <thead>
                    <tr>
                        <th>Sessió</th>
                        <th>Seient</th>
                        <th>Preu</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="ticket in tickets" :key="ticket.id">
                        <td>{{ ticket.session_id }} - {{ ticket.movie_name }}</td>
                        <td>{{ ticket.seat_id }}</td>
                        <td>{{ ticket.price }}€</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div v-if="errorMessage" class="error-message">
            <p>{{ errorMessage }}</p>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import CommunicationManager from '@/stores/CommunicationManager'

const email = ref('')
const tickets = ref([])
const errorMessage = ref('')

const searchTickets = async () => {
    try {
        errorMessage.value = ''
        tickets.value = await CommunicationManager.getUserTickets(email.value)
    } catch (error) {
        errorMessage.value = error.message
        tickets.value = []
    }
}
</script>

<style scoped>
.container {
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.title {
    text-align: center;
    color: #333;
    font-size: 2rem;
    margin-bottom: 20px;
}

.search-form {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 30px;
}

.input {
    padding: 10px;
    width: 60%;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
}

.button {
    padding: 10px 20px;
    background-color: #5cb85c;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s ease;
}

.button:hover {
    background-color: #4cae4c;
}

.results {
    margin-top: 20px;
}

.tickets-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.tickets-table th, .tickets-table td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

.tickets-table th {
    background-color: #4CAF50;
    color: white;
}

.tickets-table tr:nth-child(even) {
    background-color: #f2f2f2;
}

.error-message {
    color: red;
    text-align: center;
    font-size: 1.2rem;
    margin-top: 20px;
}
</style>
