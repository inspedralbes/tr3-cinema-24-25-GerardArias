<template>
    <div class="container">
        <div class="seats-section">
            <h1>Asientos de la sesión</h1>
            <div v-if="loadingSeats">Cargando asientos...</div>
            <div v-if="error" class="error">{{ error }}</div>
            <div v-if="seats.length > 0">
                <h2>Asientos disponibles:</h2>
                <div class="seats-container">
                    <div v-for="seat in seats" :key="seat.id" class="seat" :class="{
                        'available': seat.status === 'Disponible' && seat.type !== 'VIP',
                        'occupied': seat.status === 'Ocupada' || (seat.type === 'VIP' && seat.status === 'Ocupada'),
                        'selected': selectedSeats.includes(seat.id) && seat.status !== 'Ocupada',
                        'vip': seat.type === 'VIP' && seat.status === 'Disponible',
                        'vip-selected': selectedSeats.includes(seat.id) && seat.type === 'VIP' && seat.status !== 'Ocupada',
                        'vip-occupied': seat.type === 'VIP' && seat.status === 'Ocupada'
                    }" @click="toggleSeatSelection(seat)">
                        {{ seat.row }}{{ seat.number }}
                    </div>
                </div>
            </div>
            <div v-if="seats.length === 0 && !loadingSeats">
                <p>No hi ha asientos disponibles para esta sesión.</p>
            </div>
        </div>
        <div class="form-section">
            <h2>Detalles de Compra</h2>
            <form @submit.prevent="handleSubmit">
                <div>
                    <label for="name">Nombre:</label>
                    <input type="text" v-model="name" placeholder="Ingresa tu nombre"/>
                </div>
                <div>
                    <label for="phone">Número de teléfono:</label>
                    <input type="tel" v-model="phone" placeholder="Ingresa tu teléfono"/>
                </div>
                <div>
                    <label for="email">Correo electrónico:</label>
                    <input type="email" v-model="email" placeholder="Ingresa tu correo"/>
                </div>
                <p>Total: {{ totalCost }} €</p>
                <button type="submit" :disabled="!selectedSeats.length || !name || !phone || !email">Comprar Entradas</button>
            </form>
        </div>
    </div>
</template>

<script>
import { useUserStore } from '@/stores/userStore'
export default {
    data() {
        return {
            seats: [],
            selectedSeats: [],
            loadingSeats: false,
            error: null,
            name: '',
            phone: '',
            email: ''
        }
    },
    computed: {
        isLoggedIn() {
            const userStore = useUserStore()
            return userStore.isLoggedIn
        },
        sessionEmail() {
            const userStore = useUserStore()
            return userStore.getLoginInfo.email
        },
        sessionName() {
            const userStore = useUserStore()
            return userStore.getLoginInfo.name
        },
        sessionPhone() {
            const userStore = useUserStore()
            return userStore.getLoginInfo.phone
        },
        totalCost() {
            return this.selectedSeats.reduce((acc, seatId) => {
                const seat = this.seats.find(s => s.id === seatId)
                return acc + (seat ? (seat.type === 'VIP' ? 8 : 6) : 0)
            }, 0)
        }
    },
    async created() {
        this.checkSession()
        const sessionId = this.$route.params.sessionId
        this.fetchSeats(sessionId)
    },
    methods: {
        async fetchSeats(sessionId) {
            this.loadingSeats = true
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/seats/session/${sessionId}`)
                const seats = await response.json()
                this.seats = seats
            } catch (error) {
                console.error('Error al obtener los asientos:', error)
                this.error = 'No se pudo obtener la información de los asientos.'
            } finally {
                this.loadingSeats = false
            }
        },
        toggleSeatSelection(seat) {
            if (this.selectedSeats.length >= 10 && !this.selectedSeats.includes(seat.id)) {
                alert('Solo puedes seleccionar un máximo de 10 asientos.')
                return
            }
            if (seat.status === 'Disponible') {
                const index = this.selectedSeats.indexOf(seat.id)
                if (index === -1) {
                    this.selectedSeats.push(seat.id)
                } else {
                    this.selectedSeats.splice(index, 1)
                }
            }
        },
        async purchaseSeats() {
            if (this.selectedSeats.length > 0) {
                const sessionId = this.$route.params.sessionId
                const firstSeat = this.seats.find(s => s.id === this.selectedSeats[0])
                const price = firstSeat ? (firstSeat.type === 'VIP' ? 8 : 6) : 6
                try {
                    const response = await fetch('http://127.0.0.1:8000/api/tickets', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            email: this.email,
                            session_id: sessionId,
                            seat_ids: this.selectedSeats,
                            price: price
                        })
                    })
                    if (!response.ok) {
                        throw new Error('Error al crear los tickets')
                    }
                    this.selectedSeats = []
                    this.fetchSeats(sessionId)
                    alert('Compra realizada y correo enviado')
                } catch (error) {
                    console.error('Error al comprar entradas:', error)
                    this.error = 'No se pudo completar la compra.'
                }
            } else {
                alert('Por favor, selecciona al menos un asiento.')
            }
        },
        checkSession() {
            if (this.isLoggedIn) {
                this.name = this.sessionName
                this.phone = this.sessionPhone
                this.email = this.sessionEmail
            }
        },
        handleSubmit() {
            this.purchaseSeats()
        }
    }
}
</script>

<style scoped>
.error {
    color: red;
    font-weight: bold;
}
.container {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin: 20px;
}
.seats-section {
    flex: 3;
}
.form-section {
    flex: 1;
    background-color: #f4f4f4;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.seats-container {
    display: grid;
    grid-template-columns: repeat(10, 50px);
    gap: 5px;
    margin-top: 20px;
    justify-items: center;
    justify-content: center;
    max-width: 600px;
    margin: 0 auto;
}
.seat {
    padding: 10px;
    background-color: #BDBDBD;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    font-size: 14px;
    width: 40px;
    height: 40px;
}
.available {
    background-color: #BDBDBD;
}
.occupied {
    background-color: #F44336;
}
.selected {
    background-color: #8BC34A;
}
.vip {
    background-color: #FFD700;
    border: 2px solid #FFC107;
}
.vip-selected {
    background-color: #76D7C4;
}
.vip-occupied {
    background-color: #F44336;
    border: 2px solid #C0392B;
}
.form-section input, .form-section button {
    width: 100%;
    margin: 10px 0;
    padding: 10px;
    font-size: 16px;
}
</style>
