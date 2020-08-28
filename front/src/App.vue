<template>
  <div id="app">
    <div id="nav">
      <!--<router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>-->
      <!-- Laisser vide et garder le texte commenté du haut -->
    </div>
    <div id="phone">
      <img alt="phone version disponible 2021" src="./assets/illustrations/phone.jpg"/>
    </div>
    <div id="rooter">
      <router-view/>
    </div>
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/darkmode-js@1.5.6/lib/darkmode-js.min.js"></script>
<script>
function addDarkmodeWidget() {
  const options = {
    time: '0.5s', // default: '0.3s'
    mixColor: '#e9e6e1', // default: '#fff'
    backgroundColor: '#fff',  // default: '#fff'
    buttonColorDark: '#100f2c',  // default: '#100f2c'
    buttonColorLight: '#fff', // default: '#fff'
    saveInCookies: true, // default: true,
    label: '🌓', // default: ''
    autoMatchOsTheme: true // default: true
  }
  if(localStorage.is_premium)
    new Darkmode(options).showWidget();
}
window.addEventListener('load', addDarkmodeWidget);
</script>

<style>
#st-1 .st-btn[data-network='sharethis'] {
  background-color: #1965FF !important;
}
.st-logo, .st-disclaimer {
  display:none;
}
  #phone {
    display:none;
  }
  #phone img {
    width:100vw;
    -webkit-user-drag: none;
  }
  @media (max-width: 750px) {
    #rooter {
      display: none;
    }
    #phone {
      display:flex;
      width:100vw;
      height:100vh;
      justify-content: center;
      align-items: center;
      background: #e8edf0;
    }
  }
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