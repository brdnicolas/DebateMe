import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

if(!localStorage.token && document.URL.split("/")[3] != '')
    window.location.href = "/"

export default new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/home',
            name: 'Home',
            component: () => import(/* webpackChunkName: "about" */ './components/user/Home.vue'),
        },
        {
            path: '/',
            name: 'LandingPage',
            component: () => import(/* webpackChunkName: "about" */ './components/user/BeforeLogin.vue'),
        },
        {
            path: '/About',
            name: 'About',
            component: () => import(/* webpackChunkName: "about" */ './components/user/About.vue'),
        },
        {
            path: '/me',
            name: 'Mon profile',
            component: () => import(/* webpackChunkName: "about" */ './components/user/Me.vue'),
        },
        {
            path: '/Contact',
            name: 'Contact',
            component: () => import(/* webpackChunkName: "about" */ './components/user/ContactUs.vue'),
        },
        {
            path: '/Profil/:name',
            name: 'Profil',
            component: () => import(/* webpackChunkName: "about" */ './components/user/Profil.vue'),
        },
        {
            path: '/Theme/:idTheme/Question/:idQuestion/',
            name: "Question",
            component: () => import(/* webpackChunkName: "about" */ './components/user/Question.vue'),
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
            path: '/abonnement',
            name: "Abonnements",
            component: () => import(/* webpackChunkName: "about" */ './components/user/Abonnements.vue'),
        },
        {
            path: '/inscription/',
            name: "Inscription",
            component: () => import(/* webpackChunkName: "about" */ './components/user/Inscription.vue'),
        },
        {
            path: '/panel/debats',
            name: "Debats",
            component: () => import(/* webpackChunkName: "about" */ './components/admin/AddQuestion.vue'),
        },
        {
            path: '/panel/themes',
            name: "Themes",
            component: () => import(/* webpackChunkName: "about" */ './components/admin/Themes.vue'),
        },
        {
            path: "*",
            component: () => import("./components/user/404notFound.vue")
        },
        {
            path: "/FAQ",
            component: () => import("./components/user/FAQ.vue")
        },
        {
            path: "/equipe",
            component: () => import("./components/user/Equipe.vue")
        }
    ],
});
