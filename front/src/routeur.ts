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
            path: '/me',
            name: 'Mon profile',
            component: () => import(/* webpackChunkName: "about" */ './components/Me.vue'),
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
        },
        {
            path: '/panel',
            name: "Admin panel",
            component: () => import(/* webpackChunkName: "about" */ './components/admin/Admin.vue'),
        },
        {
            path: '/panel/reports',
            name: "Reports panel",
            component: () => import(/* webpackChunkName: "about" */ './components/admin/Reports.vue'),
        },
        {
<<<<<<< HEAD
            path: '/inscription/',
            name: "Inscription",
            component: () => import(/* webpackChunkName: "about" */ './components/Inscription.vue'),
        },

=======
            path: "*",
            component: () => import("./components/404notFound.vue")
        }
>>>>>>> e156d2cbaf946f3b03b97c029922b49b160f7787
    ],
});
