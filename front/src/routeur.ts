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
            name: 'Landing Page',
            component: Home,
        },
        {
            path: '/APropos',
            name: 'A Propos',
            component: () => import(/* webpackChunkName: "about" */ './components/APropos.vue'),
        },
        {
            path: '/Contact',
            name: 'Contactez Nous',
            component: () => import(/* webpackChunkName: "about" */ './components/ContactUs.vue'),
        },
        {
            path: '/Accueil',
            name: 'Accueil',
            component: () => import(/* webpackChunkName: "about" */ './components/Accueil.vue'),
        },
        {
            path: '/Profil/:name',
            name: 'Profil',
            component: () => import(/* webpackChunkName: "about" */ './components/Profil.vue'),
        },
        {
            path: '/Theme/:idTheme/Question/:idQuestion',
            name: "Question",
            component: () => import(/* webpackChunkName: "about" */ './components/Question.vue'),
        }
    ],
});