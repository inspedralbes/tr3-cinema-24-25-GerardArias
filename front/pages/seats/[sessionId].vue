<template>
    <div>
        <h1>Asientos de la sesión</h1>
        <div v-if="loadingSeats">Cargando asientos...</div>
        <div v-if="error" class="error">{{ error }}</div>

        <div v-if="seats.length > 0">
            <h2>Asientos disponibles:</h2>
            <div class="seats-container">
                <div v-for="seat in seats" :key="seat.id" class="seat" :class="{
                    'available': seat.status === 'Disponible',
                    'occupied': seat.status === 'Ocupada',
                    'selected': selectedSeats.includes(seat.id)
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
        }
    },
};
</script>

<style scoped>
.error {
    color: red;
    font-weight: bold;
}

.seats-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin-top: 20px;
}

.seat {
    margin: 5px;
    padding: 10px;
    background-color: #ccc;
    border-radius: 4px;
    cursor: pointer;
}

.available {
    background-color: #8BC34A;
}

.occupied {
    background-color: #F44336;
}

.selected {
    background-color: #FFEB3B;
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