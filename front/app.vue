<template>
  <div>
    <nav class="navbar">
      <div class="navbar-container">
        <div class="navbar-left">
          <router-link to="/" class="navbar-item">Inici</router-link>
          <router-link to="/peliculas" class="navbar-item">Pel·licules</router-link>
          <router-link to="/sessions" class="navbar-item">Sessions</router-link>
        </div>

        <div class="navbar-right">
          <router-link to="/login" class="navbar-item">Login</router-link>
        </div>
      </div>
    </nav>

    <NuxtPage />
  </div>
  
</template>

<script>
export default {
  data() {
    return {
      carrito: []
    };
  },
  computed: {
    carritoItems() {
      return this.carrito.length;
    }
  },
  methods: {
    agregarAlCarrito(producto) {
      this.carrito.push(producto);
    }
  }
};
</script>

<style scoped>
.navbar {
  background-color: #ffffff;
  padding: 1rem 2rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  color: #333333;
}

.navbar-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.navbar-left,
.navbar-right {
  display: flex;
  align-items: center;
}

.navbar-item {
  color: #333333;
  text-decoration: none;
  font-size: 1.2rem;
  margin-right: 20px;
  transition: all 0.3s ease;
}

.navbar-item:hover {
  text-decoration: underline;
  color: #ffa500;
}

.fa-shopping-cart {
  margin-right: 8px;
}

.navbar-right {
  justify-content: flex-end;
}
</style>

