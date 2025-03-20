<template>
    <div>
        <h1>Registrar Usuari</h1>
        <form @submit.prevent="handleRegister">
            <div>
                <label for="name">Nom:</label>
                <input v-model="form.name" type="text" id="name" required />
            </div>
            <div>
                <label for="lastname">Cognom:</label>
                <input v-model="form.lastname" type="text" id="lastname" required />
            </div>
            <div>
                <label for="email">Correu electrònic:</label>
                <input v-model="form.email" type="email" id="email" required />
            </div>
            <div>
                <label for="password">Contrasenya:</label>
                <input v-model="form.password" type="password" id="password" required />
            </div>
            <div>
                <label for="phone">Telèfon:</label>
                <input v-model="form.phone" type="text" id="phone" required />
            </div>
            <button type="submit">Registrar</button>
        </form>
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
