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
                    <input type="text" v-model="name" placeholder="Ingresa tu nombre" />
                </div>
                <div>
                    <label for="phone">Número de teléfono:</label>
                    <input type="tel" v-model="phone" placeholder="Ingresa tu teléfono" />
                </div>
                <div>
                    <label for="email">Correo electrónico:</label>
                    <input type="email" v-model="email" placeholder="Ingresa tu correo" />
                </div>
                <p>Total: {{ totalCost }} €</p>
                <button type="submit" :disabled="!selectedSeats.length || !name || !phone || !email">Comprar
                    Entradas</button>
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
                const sessionId = this.$route.params.sessionId;
                const firstSeat = this.seats.find(s => s.id === this.selectedSeats[0]);
                const price = firstSeat ? (firstSeat.type === 'VIP' ? 8 : 6) : 6;

                try {
                    const ticketResponse = await fetch('http://127.0.0.1:8000/api/tickets', {
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
                    });
                    if (!ticketResponse.ok) {
                        throw new Error('Error al crear los tickets');
                    }

                    const seatUpdateResponse = await fetch('http://127.0.0.1:8000/api/seats/update', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            session_id: sessionId,
                            seat_ids: this.selectedSeats,
                        }),
                    });

                    if (!seatUpdateResponse.ok) {
                        throw new Error('Error al actualizar el estado de los asientos');
                    }

                    this.selectedSeats = [];
                    this.fetchSeats(sessionId);
                    alert('Compra realizada, asientos actualizados y correo enviado');
                } catch (error) {
                    console.error('Error al comprar entradas o actualizar asientos:', error);
                    this.error = 'No se pudo completar la compra.';
                }
            } else {
                alert('Por favor, selecciona al menos un asiento.');
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
.container {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin: 20px;
    padding: 20px;
    background-color: #F5F5F5;
    color: #333;
    border-radius: 10px;
}

.seats-section {
    flex: 3;
    text-align: center;
}

h1, h2 {
    color: #444;
}

.seats-container {
    display: grid;
    grid-template-columns: repeat(10, 50px);
    gap: 8px;
    margin: 20px auto;
    justify-content: center;
    padding: 20px;
    background-color: #FFF;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.seat {
    width: 45px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    border: 2px solid transparent;
}

.available {
    background-color: #BDBDBD;
    color: white;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.occupied {
    background-color: #D32F2F;
    color: white;
    cursor: not-allowed;
    opacity: 0.5;
    border: 2px solid #B71C1C;
}

.selected {
    background-color: #26A69A;
    border: 3px solid #FF9800;
    transform: scale(1.1);
}

.vip {
    background-color: #FFD700;
    border: 2px solid #FFC107;
}

.vip-selected {
    background-color: #26A69A;
    border: 3px solid #FF6F00;
    transform: scale(1.1);
}

.vip-occupied {
    background-color: #D32F2F;
    border: 2px solid #880E4F;
    opacity: 0.5;
}

.form-section {
    flex: 1;
    background: #FFF;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-section input,
.form-section button {
    width: 100%;
    margin: 10px 0;
    padding: 12px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.form-section input {
    background: #FFF;
    color: #333;
    width: 80%;
}

.form-section button {
    background: #26A69A;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
    border: none;
}

.form-section button:hover {
    background: #1E8E82;
}

.error {
    color: #D32F2F;
    font-weight: bold;
}
</style>
