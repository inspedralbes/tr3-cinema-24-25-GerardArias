<template>
  <div>
    <!-- Navbar -->
    <nav class="navbar">
      <div class="navbar-container">
        <router-link to="/" class="navbar-item">Inicio</router-link>
        <router-link to="/sesiones" class="navbar-item">Sesiones</router-link>
        <router-link to="/peliculas" class="navbar-item">Películas</router-link>
        <router-link to="/login" class="navbar-item">Login</router-link>
        <router-link to="/carrito" class="navbar-item">
          Carrito ({{ carritoItems }})
        </router-link>
      </div>
    </nav>

    <!-- Contenido Principal -->
    <nuxt />
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
    // Computed para mostrar el número de artículos en el carrito
    carritoItems() {
      return this.carrito.length;
    }
  },
  methods: {
    // Método para añadir productos al carrito (ejemplo)
    agregarAlCarrito(producto) {
      this.carrito.push(producto);
    }
  }
};
</script>

<style scoped>
.navbar {
  background-color: #333;
  padding: 1rem;
  color: white;
}

.navbar-container {
  display: flex;
  justify-content: space-around;
}

.navbar-item {
  color: white;
  text-decoration: none;
  font-size: 1.2rem;
}

.navbar-item:hover {
  text-decoration: underline;
}
</style>
