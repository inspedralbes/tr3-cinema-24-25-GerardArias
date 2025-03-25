<template>
    <div class="container">
        <div class="seats-section">
            <h1>Seients de la sessió</h1>
            <div v-if="loadingSeats">Carregant seients...</div>
            <div v-if="error" class="error">{{ error }}</div>
            <div v-if="seats.length > 0">
                <h2>Seients disponibles:</h2>
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
                <p>No hi ha seients disponibles per a aquesta sessió.</p>
            </div>
        </div>
        <div class="form-section">
            <h2>Detalls de la compra</h2>
            <form @submit.prevent="handleSubmit">
                <div>
                    <label for="name">Nom:</label>
                    <input type="text" v-model="name" placeholder="Introdueix el teu nom" />
                </div>
                <div>
                    <label for="phone">Número de telèfon:</label>
                    <input type="tel" v-model="phone" placeholder="Introdueix el teu telèfon" />
                </div>
                <div>
                    <label for="email">Correu electrònic:</label>
                    <input type="email" v-model="email" placeholder="Introdueix el teu correu" />
                </div>
                <p>Total: {{ totalCost }} €</p>
                <button type="submit" :disabled="!selectedSeats.length || !name || !phone || !email">Comprar Entrades</button>
            </form>

            <!-- Ticket de compra -->
            <div class="ticket" v-if="selectedTicketSeats.length">
                <h3>Ticket de compra</h3>
                <ul>
                    <li v-for="seat in selectedTicketSeats" :key="seat.id">
                        Butaca: {{ seat.row }}{{ seat.number }} - 
                        Preu: {{ seat.type === 'VIP' ? '8€ (VIP)' : '6€' }}
                    </li>
                </ul>
                <p><strong>Total: {{ totalCost }} €</strong></p>
            </div>
        </div>
    </div>
</template>

<script>
import { useUserStore } from '@/stores/userStore';
import CommunicationManager from '@/stores/CommunicationManager';

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
        };
    },
    computed: {
        isLoggedIn() {
            const userStore = useUserStore();
            return userStore.isLoggedIn;
        },
        sessionEmail() {
            const userStore = useUserStore();
            return userStore.getLoginInfo.email;
        },
        sessionName() {
            const userStore = useUserStore();
            return userStore.getLoginInfo.name;
        },
        sessionPhone() {
            const userStore = useUserStore();
            return userStore.getLoginInfo.phone;
        },
        totalCost() {
            return this.selectedSeats.reduce((acc, seatId) => {
                const seat = this.seats.find(s => s.id === seatId);
                return acc + (seat ? (seat.type === 'VIP' ? 8 : 6) : 0);
            }, 0);
        },
        // Propiedad computada para obtener la info de las butacas seleccionadas
        selectedTicketSeats() {
            return this.seats.filter(seat => this.selectedSeats.includes(seat.id));
        }
    },
    async created() {
        this.checkSession();
        const sessionId = this.$route.params.sessionId;
        this.fetchSeats(sessionId);
    },
    methods: {
        async fetchSeats(sessionId) {
            this.loadingSeats = true;
            try {
                this.seats = await CommunicationManager.getSeats(sessionId);
            } catch (error) {
                console.error('Error en obtenir els seients:', error);
                this.error = 'No s\'ha pogut obtenir la informació dels seients.';
            } finally {
                this.loadingSeats = false;
            }
        },
        toggleSeatSelection(seat) {
            if (this.selectedSeats.length >= 10 && !this.selectedSeats.includes(seat.id)) {
                alert('Només pots seleccionar un màxim de 10 seients.');
                return;
            }
            if (seat.status === 'Disponible') {
                const index = this.selectedSeats.indexOf(seat.id);
                if (index === -1) {
                    this.selectedSeats.push(seat.id);
                } else {
                    this.selectedSeats.splice(index, 1);
                }
            }
        },
        async purchaseSeats() {
            if (this.selectedSeats.length > 0) {
                const sessionId = this.$route.params.sessionId;
                const firstSeat = this.seats.find(s => s.id === this.selectedSeats[0]);
                const price = firstSeat ? (firstSeat.type === 'VIP' ? 8 : 6) : 6;

                try {
                    await CommunicationManager.purchaseTickets({
                        email: this.email,
                        session_id: sessionId,
                        seat_ids: this.selectedSeats,
                        price: price
                    });

                    await CommunicationManager.updateSeatStatus(sessionId, this.selectedSeats);

                    this.selectedSeats = [];
                    this.fetchSeats(sessionId);
                    alert('Compra realitzada, seients reservats i entrades enviades al correu.');
                } catch (error) {
                    console.error('Error en comprar entrades o actualitzar seients:', error);
                    this.error = 'No s\'ha pogut completar la compra.';
                }
            } else {
                alert('Si us plau, selecciona almenys un seient.');
            }
        },
        checkSession() {
            if (this.isLoggedIn) {
                this.name = this.sessionName;
                this.phone = this.sessionPhone;
                this.email = this.sessionEmail;
            }
        },
        handleSubmit() {
            this.purchaseSeats();
        }
    }
};
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

h1,
h2 {
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

.ticket {
    margin-top: 20px;
    padding: 15px;
    background-color: #E0F7FA;
    border: 1px solid #26A69A;
    border-radius: 8px;
}

.ticket h3 {
    margin-bottom: 10px;
}

.ticket ul {
    list-style: none;
    padding: 0;
    margin-bottom: 10px;
}

.ticket li {
    margin-bottom: 5px;
    font-weight: bold;
}

.error {
    color: #D32F2F;
    font-weight: bold;
}
</style>
