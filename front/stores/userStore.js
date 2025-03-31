import { defineStore } from 'pinia';
import CommunicationManager from '@/stores/CommunicationManager';

export const useUserStore = defineStore('user', {
  state: () => ({
    loginInfo: {
      loggedIn: false,
      id: null,
      token: '',
      name: '',
      lastname: '',
      email: '',
      phone: '',
    },
  }),

  actions: {
    async login(credentials) {
      try {
        const data = await CommunicationManager.loginUser(credentials);
        this.setLoginInfo({
          id: data.user.id,
          loggedIn: true,
          token: data.token,
          name: data.user.name,
          lastname: data.user.lastname,
          email: data.user.email,
          phone: data.user.phone,
        });
      } catch (error) {
        throw new Error(error.message);
      }
    },

    async fetchUserProfile() {
      if (!this.loginInfo.token) return;
      try {
        const userProfile = await CommunicationManager.getUserProfile();
        this.setLoginInfo({ ...this.loginInfo, ...userProfile, loggedIn: true });
      } catch (error) {
        console.error('Error al obtener perfil de usuario:', error);
      }
    },

    logout() {
      this.loginInfo = {
        loggedIn: false,
        id: null,
        token: '',
        name: '',
        lastname: '',
        email: '',
        phone: '',
      };
      localStorage.removeItem('loginInfo');
      localStorage.removeItem('token');
    },

    setLoginInfo({ id, loggedIn, token, name, lastname, email, phone }) {
      this.loginInfo = { loggedIn, id, token, name, lastname, email, phone };
      localStorage.setItem('loginInfo', JSON.stringify(this.loginInfo));
      localStorage.setItem('token', token);
      localStorage.setItem('user', JSON.stringify({ id, name, lastname, email, phone }));
    },
  },

  getters: {
    isLoggedIn: (state) => state.loginInfo.loggedIn,
    getLoginInfo: (state) => state.loginInfo,
  },
});
