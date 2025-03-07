<template>
  <div>
    <nav class="navbar">
      <div class="navbar-container">
        <div class="navbar-left">
          <router-link to="/" class="navbar-item">Inici</router-link>
          <router-link to="/peliculas" class="navbar-item">Pel·liculas</router-link>
          <router-link to="/sessions" class="navbar-item">Sessions</router-link>
        </div>

        <div class="navbar-right">
          <router-link to="/carrito" class="navbar-item">
            <i class="fa fa-shopping-cart">Carret</i> ({{ carritoItems }})
          </router-link>
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
  background-color: #323b32;
  padding: 1rem;
  color: white;
}

.navbar-container {
  display: flex;
  justify-content: space-between; 
  align-items: center;
}

.navbar-left, .navbar-right {
  display: flex;
  align-items: center;
}

.navbar-item {
  color: white;
  text-decoration: none;
  font-size: 1.2rem;
  margin-right: 20px;
}

.navbar-item:hover {
  text-decoration: underline;
}

.fa-shopping-cart {
  margin-right: 8px; 
}

.navbar-right {
  justify-content: flex-end; 
}
</style>
