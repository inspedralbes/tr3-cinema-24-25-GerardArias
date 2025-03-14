<template>
    <div>
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

            <div v-if="selectedSeats.length > 0">
                <button @click="purchaseSeats" class="button">Comprar Entradas</button>
            </div>
        </div>

        <div v-if="seats.length === 0 && !loadingSeats">
            <p>No hi ha asientos disponibles para esta sesión.</p>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            seats: [],
            selectedSeats: [],
            loadingSeats: false,
            error: null,
        };
    },
    async created() {
        const sessionId = this.$route.params.sessionId;
        this.fetchSeats(sessionId);
    },
    methods: {
        async fetchSeats(sessionId) {
            this.loadingSeats = true;
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/seats/session/${sessionId}`);
                const seats = await response.json();
                this.seats = seats;
            } catch (error) {
                console.error('Error al obtener los asientos:', error);
                this.error = 'No se pudo obtener la información de los asientos.';
            } finally {
                this.loadingSeats = false;
            }
        },

        toggleSeatSelection(seat) {
            if (this.selectedSeats.length >= 10 && !this.selectedSeats.includes(seat.id)) {
                alert('Solo puedes seleccionar un máximo de 10 asientos.');
                return;  
            }

            if (seat.status === 'Disponible') {
                const seatIndex = this.selectedSeats.indexOf(seat.id);
                if (seatIndex === -1) {
                    this.selectedSeats.push(seat.id);
                } else {
                    this.selectedSeats.splice(seatIndex, 1);
                }
            }
        },

        async purchaseSeats() {
            if (this.selectedSeats.length > 0) {
                const sessionId = this.$route.params.sessionId;
                try {
                    const response = await fetch('http://127.0.0.1:8000/api/seats/update', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            session_id: sessionId,
                            seat_ids: this.selectedSeats,
                        }),
                    });

                    if (!response.ok) {
                        throw new Error('Error al actualizar los asientos');
                    }

                    this.selectedSeats = [];
                    this.fetchSeats(sessionId);
                    alert('Compra realizada con éxito');
                } catch (error) {
                    console.error('Error al comprar entradas:', error);
                    this.error = 'No se pudo completar la compra.';
                }
            } else {
                alert('Por favor, selecciona al menos un asiento.');
            }
        },
    },
};
</script>
<style scoped>
.error {
    color: red;
    font-weight: bold;
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

.button {
    display: inline-block;
    margin-top: 20px;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    cursor: pointer;
}
</style>
