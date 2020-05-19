import Vue from 'vue';
import App from '../src/App.vue';
import router from './routeur';

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
