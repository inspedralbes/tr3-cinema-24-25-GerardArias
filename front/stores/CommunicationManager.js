// URL local
const API_URL = 'http://127.0.0.1:8000/api/';
// URL produccion 
// const API_URL = 'http://a23gerarimarcineback.daw.inspedralbes.cat/api/';

export default class CommunicationManager {
  static async getMovies() {
    try {
      const response = await fetch(`${API_URL}movies`);
      if (!response.ok) {
        throw new Error('Error al obtener las películas');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async getSessions() {
    try {
      const response = await fetch(`${API_URL}sessions`);
      if (!response.ok) {
        throw new Error('Error al obtener las sesiones');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async getSeats(sessionId) {
    try {
      const response = await fetch(`${API_URL}seats/session/${sessionId}`);
      if (!response.ok) {
        throw new Error('Error al obtener las butacas');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async updateSeatStatus(sessionId, seatIds) {
    try {
      const response = await fetch(`${API_URL}seats/update`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          session_id: sessionId,
          seat_ids: seatIds,
        }),
      });
      if (!response.ok) {
        throw new Error('Error al actualizar el estado de la butaca');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async purchaseTickets(data) {
    try {
      const response = await fetch(`${API_URL}tickets`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });
      if (!response.ok) {
        throw new Error('Error al comprar los tickets');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async registerUser(userData) {
    try {
      const response = await fetch(`${API_URL}register`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
      if (!response.ok) {
        throw new Error('Error al registrar el usuario');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async loginUser(credentials) {
    try {
      const response = await fetch(`${API_URL}login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(credentials),
      });
      if (!response.ok) {
        throw new Error('Credenciales incorrectas');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async getUserProfile() {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        throw new Error('No autorizado');
      }
      const response = await fetch(`${API_URL}users`, {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      if (!response.ok) {
        throw new Error('No se pudo obtener el perfil');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  static async getUserTickets(email) {
    try {
      const response = await fetch(`${API_URL}tickets/${email}`);
      if (!response.ok) {
        throw new Error('Error al obtener los tickets del usuario');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
