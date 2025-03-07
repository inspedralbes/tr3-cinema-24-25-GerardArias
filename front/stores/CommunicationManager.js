// stores/CommunicationManager.js

const API_URL = 'http://127.0.0.1:8000/api/movies';

export default class CommunicationManager {
  // Método para obtener todas las películas
  static async getMovies() {
    try {
      const response = await fetch(API_URL);
      if (!response.ok) {
        throw new Error('Error al obtener las películas');
      }
      return await response.json();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
