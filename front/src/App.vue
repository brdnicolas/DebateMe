<template>
  <div id="app">
    <HelloWorld msg="Welcome to Your Vue.js + TypeScript App"/>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import HelloWorld from './components/HelloWorld.vue';

@Component({
  components: {
    HelloWorld,
  },
})
export default class App extends Vue {}
</script>

<style>
#app {
  font-family: 'Roboto', sans-serif;
}
body {
  background:white;
}
html {
  width:100vw;
  overflow-x:hidden;
}
* {
  margin:0;
  padding:0;
}
</style>
