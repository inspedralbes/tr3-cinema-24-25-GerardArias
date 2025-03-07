
const API_URL = 'http://127.0.0.1:8000/api/';

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
}
