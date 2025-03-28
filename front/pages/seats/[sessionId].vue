<template>
  <div class="container">
    <div class="seats-section">
      <h1>Seients de la sessió</h1>
      <div v-if="loadingSeats">Carregant seients...</div>
      <div v-if="error" class="error">{{ error }}</div>
      <div v-if="seats.length > 0">
        <h2>Seients disponibles:</h2>
        <div class="seats-grid">
          <div class="corner"></div>
          <div class="column-labels">
            <div v-for="n in 10" :key="n" class="column-label">{{ n }}</div>
          </div>
          <div class="rows">
            <div v-for="row in rows" :key="row" class="row">
              <div class="row-label">{{ row }}</div>
              <div class="row-seats">
                <div
                  v-for="seat in getSeatsByRow(row)"
                  :key="seat.id"
                  class="seat"
                  :class="{
                    'available': seat.status === 'Disponible' && seat.type !== 'VIP',
                    'occupied': seat.status === 'Ocupada' || (seat.type === 'VIP' && seat.status === 'Ocupada'),
                    'selected': selectedSeats.includes(seat.id) && seat.status !== 'Ocupada',
                    'vip': seat.type === 'VIP' && seat.status === 'Disponible',
                    'vip-selected': selectedSeats.includes(seat.id) && seat.type === 'VIP' && seat.status !== 'Ocupada',
                    'vip-occupied': seat.type === 'VIP' && seat.status === 'Ocupada'
                  }"
                  @click="toggleSeatSelection(seat)"
                ></div>
              </div>
            </div>
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
      <div class="ticket" v-if="selectedTicketSeats.length">
        <h3>Ticket de compra</h3>
        <ul>
          <li v-for="seat in selectedTicketSeats" :key="seat.id">
            Butaca: {{ seat.row }}{{ seat.number }} - Preu: {{ seat.type === 'VIP' ? '8€ (VIP)' : '6€' }}
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
    rows() {
      return 'ABCDEFGHIJKL'.split('');
    },
    totalCost() {
      return this.selectedSeats.reduce((acc, seatId) => {
        const seat = this.seats.find(s => s.id === seatId);
        return acc + (seat ? (seat.type === 'VIP' ? 8 : 6) : 0);
      }, 0);
    },
    selectedTicketSeats() {
      return this.seats.filter(seat => this.selectedSeats.includes(seat.id));
    }
  },
  methods: {
    getSeatsByRow(row) {
      return this.seats.filter(seat => seat.row === row).sort((a, b) => a.number - b.number);
    },
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
      const userStore = useUserStore();
      if (userStore.isLoggedIn) {
        this.name = userStore.getLoginInfo.name;
        this.phone = userStore.getLoginInfo.phone;
        this.email = userStore.getLoginInfo.email;
      }
    },
    handleSubmit() {
      this.purchaseSeats();
    }
  },
  async created() {
    this.checkSession();
    const sessionId = this.$route.params.sessionId;
    this.fetchSeats(sessionId);
  }
};
</script>

<style scoped>
html, body {
  margin: 0;
  padding: 0;
  max-width: 100vw;
  max-height: 100vh;
  overflow-x: hidden;
  font-family: sans-serif;
}

.container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  gap: 10px;
  margin: 10px;
  padding: 10px;
  background-color: #F5F5F5;
  color: #333;
  border-radius: 5px;
  max-width: 100vw;
  max-height: 100vh;
  box-sizing: border-box;
}

/* Vista escritorio */
.seats-section {
  flex: 3;
  text-align: center;
  overflow: auto;
}
.form-section {
  flex: 1;
  background: #FFF;
  padding: 10px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: auto;
}

/* Grilla de asientos */
.seats-grid {
  display: grid;
  grid-template-columns: 30px auto;
  grid-template-rows: 30px auto;
  gap: 3px;
  margin: 10px auto;
  justify-content: center;
}
.corner {
  grid-column: 1 / 2;
  grid-row: 1 / 2;
}
.column-labels {
  grid-column: 2 / 3;
  grid-row: 1 / 2;
  display: grid;
  grid-template-columns: repeat(10, 30px);
}
.column-label {
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 0.7rem;
}
.rows {
  grid-column: 1 / 3;
  grid-row: 2 / 3;
  display: grid;
  grid-auto-rows: 30px;
  gap: 3px;
}
.row {
  display: grid;
  grid-template-columns: 30px auto;
  align-items: center;
}
.row-label {
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 0.7rem;
}
.row-seats {
  display: grid;
  grid-template-columns: repeat(10, 30px);
  gap: 3px;
}
.seat {
  width: 30px;
  height: 30px;
  background-color: #BDBDBD;
  -webkit-mask-image: url('../../assets/img/butaca.png');
  mask-image: url('../../assets/img/butaca.png');
  -webkit-mask-size: contain;
  mask-size: contain;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  cursor: pointer;
  transition: background-color 0.3s ease-in-out, transform 0.3s ease-in-out;
  box-sizing: border-box;
}
.available {
  background-color: #BDBDBD;
}
.occupied {
  background-color: #D32F2F;
  cursor: not-allowed;
  opacity: 0.5;
  border: 1px solid #B71C1C;
}
.selected {
  background-color: #26A69A;
  transform: scale(1.05);
}
.vip {
  background-color: #FFD700;
}
.vip-selected {
  background-color: #26A69A;
  transform: scale(1.05);
}
.vip-occupied {
  background-color: #D32F2F;
  border: 1px solid #880E4F;
  opacity: 0.5;
}
.form-section input,
.form-section button {
  width: 100%;
  margin: 5px 0;
  padding: 8px;
  font-size: 0.8rem;
  border-radius: 3px;
  border: 1px solid #ccc;
  box-sizing: border-box;
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
  margin-top: 10px;
  padding: 10px;
  background-color: #E0F7FA;
  border: 1px solid #26A69A;
  border-radius: 5px;
  font-size: 0.8rem;
}
.ticket h3 {
  margin-bottom: 5px;
}
.ticket ul {
  list-style: none;
  padding: 0;
  margin-bottom: 5px;
}
.ticket li {
  margin-bottom: 3px;
  font-weight: bold;
}
.error {
  color: #D32F2F;
  font-weight: bold;
}

/* Media query para pantallas muy pequeñas */
@media (max-width: 480px) {
  .container {
    flex-direction: column;
    padding: 5px;
    margin: 5px;
  }
  .seats-grid {
    grid-template-columns: 25px auto;
    grid-template-rows: 25px auto;
    gap: 2px;
  }
  .column-labels {
    grid-template-columns: repeat(10, 25px);
  }
  .row {
    grid-template-columns: 25px auto;
  }
  .row-seats {
    grid-template-columns: repeat(10, 25px);
  }
  .seat {
    width: 25px;
    height: 25px;
  }
  .column-label,
  .row-label {
    font-size: 0.6rem;
  }
  .form-section input,
  .form-section button {
    padding: 6px;
    font-size: 0.7rem;
  }
  .ticket {
    font-size: 0.7rem;
  }
}
</style>
