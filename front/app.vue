<template>
  <div>
    <!-- Navbar -->
    <nav class="navbar">
      <div class="navbar-container">
        <div class="navbar-left">
          <router-link to="/" class="navbar-item">Inicio</router-link>
          <router-link to="/peliculas" class="navbar-item">Películas</router-link>
          <router-link to="/sesiones" class="navbar-item">Sesiones</router-link>
        </div>

        <div class="navbar-right">
          <router-link to="/carrito" class="navbar-item">
            <i class="fa fa-shopping-cart"></i> ({{ carritoItems }})
          </router-link>
          <router-link to="/login" class="navbar-item">Login</router-link>
        </div>
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
  background-color: #173317;
  padding: 1rem;
  color: white;
}

.navbar-container {
  display: flex;
  justify-content: space-between; /* Separamos los elementos entre izquierda y derecha */
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
  margin-right: 20px; /* Espaciado entre los elementos */
}

.navbar-item:hover {
  text-decoration: underline;
}

.fa-shopping-cart {
  margin-right: 8px; /* Espaciado entre el ícono y el texto */
}

.navbar-right {
  justify-content: flex-end; /* Alinea el login y el carrito a la derecha */
}
</style>
