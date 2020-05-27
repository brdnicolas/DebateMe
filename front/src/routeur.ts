import Vue from 'vue';
import Router from 'vue-router';
import BeforeLogin from './components/BeforeLogin.vue';

Vue.use(Router);

export default new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/home',
            name: 'Home',
            component: () => import(/* webpackChunkName: "about" */ './components/Home.vue'),
        },
        {
            path: '/',
            name: 'LandingPage',
            component: BeforeLogin,
        },
        {
            path: '/About',
            name: 'About',
            component: () => import(/* webpackChunkName: "about" */ './components/About.vue'),
        },
        {
            path: '/Contact',
            name: 'Contact',
            component: () => import(/* webpackChunkName: "about" */ './components/ContactUs.vue'),
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