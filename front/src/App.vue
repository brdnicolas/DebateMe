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

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'

@Component({

})
export default class Question extends Vue {
  mounted(): void {
    // eslint-disable-next-line no-undef
    //console.log(this.$route.path)
    /*if(!localStorage.token && this.$route.path != '/') {
      if(this.$route.path != '/inscription')
        //window.location.href = "/"
    }

     */
  }
}
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