import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/HomePage.vue';

Vue.use(Router);

export default new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/',
            name: 'home',
            component: Home,
        },
        {
            path: '/about',
            name: 'about',
            component: () => import(/* webpackChunkName: "about" */ './components/About.vue'),
        },
        {
            path: '/contactUs',
            name: 'contactUs',
            component: () => import(/* webpackChunkName: "about" */ './components/ContactUs.vue'),
        },
        {
            path: '/accueil',
            name: 'Accueil',
            component: () => import(/* webpackChunkName: "about" */ './components/Accueil.vue'),
        },

    ],
});