<template>
  <div id="app">
    <div id="nav">
      <!--<router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>-->
      <!-- Laisser vide et garder le texte commenté du haut -->
    </div>
    <router-view/>

  </div>
</template>
<style>
  #app {
    font-family: 'Roboto', sans-serif;
  }
  .swal2-modal {
    font-family: 'Roboto', sans-serif !important;
  }
  .darkmode--activated .swal2-modal {
    background:#16191D !important;
  }
  body {
    background:white;
  }
  html {
    width:100vw;
    overflow-x:hidden;
    scroll-behavior: smooth;
  }
  * {
    margin:0;
    padding:0;
  }
</style>
