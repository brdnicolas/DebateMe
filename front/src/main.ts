import Vue from 'vue';
import App from '../src/App.vue';
import router from './routeur';
import VueSimpleAlert from "vue-simple-alert";

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
Vue.use(VueSimpleAlert);
