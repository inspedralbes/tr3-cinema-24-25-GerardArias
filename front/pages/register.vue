<template>
    <div>
        <h1>Registrar Usuario</h1>
        <form @submit.prevent="handleRegister">
            <div>
                <label for="name">Nombre:</label>
                <input v-model="form.name" type="text" id="name" required />
            </div>
            <div>
                <label for="lastname">Apellido:</label>
                <input v-model="form.lastname" type="text" id="lastname" required />
            </div>
            <div>
                <label for="email">Correo electrónico:</label>
                <input v-model="form.email" type="email" id="email" required />
            </div>
            <div>
                <label for="password">Contraseña:</label>
                <input v-model="form.password" type="password" id="password" required />
            </div>
            <div>
                <label for="phone">Teléfono:</label>
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
        console.log('Usuario registrado:', data)
        alert('Usuario registrado exitosamente')
    } catch (error) {
        console.error('Error al registrar el usuario:', error.message)
        alert('Hubo un error al registrar el usuario')
    }
}
</script>