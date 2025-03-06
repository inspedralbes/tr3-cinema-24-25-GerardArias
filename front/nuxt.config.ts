// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  css: [
    'normalize.css',  // Agregamos normalize.css globalmente
    '~/assets/css/main.css'  // Puedes agregar tus propios estilos globales aquí
  ]
})
