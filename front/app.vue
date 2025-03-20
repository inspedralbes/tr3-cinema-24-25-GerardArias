<template>
  <div>
    <nav class="navbar">
      <div class="navbar-container">
        <div class="navbar-left">
          <router-link to="/" class="navbar-item">Inici</router-link>
          <router-link to="/sessions" class="navbar-item">Sessions</router-link>
        </div>

        <div class="navbar-right">
          <router-link to="/login" class="navbar-item" v-if="!isLoggedIn">Login</router-link>
          <router-link to="/register" class="navbar-item" v-if="!isLoggedIn">Register</router-link>
          <router-link to="/profile" class="navbar-item" v-if="isLoggedIn">Perfil</router-link>
          
          <div v-if="isLoggedIn" class="user-info">
            <button @click="logout" class="navbar-item">Logout</button>
          </div>
        </div>
      </div>
    </nav>

    <NuxtPage />
  </div>
</template>

<script setup>
import { useUserStore } from '@/stores/userStore' 
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'

const userStore = useUserStore() 
const router = useRouter()

const isLoggedIn = computed(() => userStore.isLoggedIn)
const user = computed(() => userStore.getLoginInfo)

onMounted(() => {
  const storedLoginInfo = localStorage.getItem('loginInfo')
  if (storedLoginInfo) {
    userStore.setLoginInfo(JSON.parse(storedLoginInfo))
  }
})

function logout() {
  userStore.logout() 
  router.push('/login')  
}
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

.user-info {
  display: flex;
  align-items: center;
  font-size: 1.2rem;
}

.user-info span {
  margin-right: 10px;
}

.navbar-right {
  justify-content: flex-end;
}
button{
  border: none;
  background-color: #ffffff;
}
button:hover{
  background-color: #fad4d4;
  border-radius: 10px;
}
</style>
