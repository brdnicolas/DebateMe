<template>
    <div class="ContactUs">
        <header>
            <div class="leftHeader">
                <img src="../../assets/img/logo2.png"/>
                <a href="/home" class="darkmode-ignore">Debate Me</a>
                <div class="nav">
                    <a class="darkmode-ignore" href="/home" v-bind:class="{'current darkmode-ignore': this.currentPage === 'home'}">Accueil</a>
                    <a class="darkmode-ignore" href="/message" v-bind:class="{'current darkmode-ignore': this.currentPage === 'message'}">Messages</a>
                    <a class="darkmode-ignore" href="/about" v-bind:class="{'current darkmode-ignore': this.currentPage === 'about'}">A propos</a>
                    <a class="darkmode-ignore" href="/notifications" v-bind:class="{'current darkmode-ignore': this.currentPage === 'notifications'}">Notifications (53)</a>
                    <a class="darkmode-ignore" v-if="this.user.isAdmin" style="color:#EFA1A1" href="/panel" v-bind:class="{'currentAdmin': this.currentPage === 'panel'}">Modération</a>
                </div>
            </div>
            <div class="rightHeader">
                <a v-bind:class="{'current': this.currentPage === 'profil'}" href="/me">{{this.user.username}}</a>
                <img class="profil_pic" v-if="this.profilPic" v-bind:src="this.profilPic"/>
                <img class="profil_pic" v-else src="../../assets/img/profile.png"/>
                <button @click="visibleMenu=!visibleMenu" style="width:25px;height:22px;background:none;border:none;outline:none;margin-left:15px">
                    <svg viewBox="0 0 20 20" class="Menuicon">
                        <title>Menu</title>
                        <path fill="#3f3e48" d="M6,8c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM12,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM6,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM6,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM12,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM16,6c0,1.1 0.9,2 2,2s2,-0.9 2,-2 -0.9,-2 -2,-2 -2,0.9 -2,2zM12,8c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM18,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM18,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2z" />
                    </svg>
                </button>
                <ul class="dropdown" v-if="this.visibleMenu">
                    <li @click="redirectTo('me')">
                        <img src="../../assets/icon/Menu/user.png"/>
                        <a>Mon Compte</a>
                    </li>
                    <li>
                        <img src="../../assets/icon/Menu/params.png"/>
                        <a>Paramètres</a>
                    </li>
                    <li @click="redirectTo('abonnement')">
                        <img src="../../assets/icon/Menu/prix.png"/>
                        <a>Abonnement</a>
                    </li>
                    <li @click="deconnexion">
                        <img src="../../assets/icon/Menu/deco.png"/>
                        <a>Deconnexion</a>
                    </li>
                </ul>
            </div>
        </header>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import DAO from "@/DAO";

    @Component
    export default class Header extends Vue {

        // Url de la page actuelle
        currentPage: string;

        // Informations de l'utilisateur
        user: object;

        // Affichage du menu ou non
        visibleMenu: boolean;

        // Photo de profil
        profilPic: string;

        // DAO
        api = new DAO();

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
            super();
            this.currentPage = "";
            this.user = [null];
            this.profilPic = "";
            this.visibleMenu = false;
        }

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.getCurrentUser();
            this.currentPage = document.URL.split("/")[3];
        }

        // Requete api pour récupérer les infos de l'utilisateur connécté
        async getCurrentUser(): Promise<void> {
            this.api.getCurrentUser().then(datas => {
                this.user = datas;
                this.profilPic = (datas as Record<string,any>).img.profile_picture;
                localStorage.premium = (datas as Record<string,any>).is_premium;
            })
            .catch(error => {
                this.deconnexion();
            })
        }

        // Fonction pour rediriger vers une autre page
        redirectTo(page: string): void {
            window.location.href = '/' + page;
        }

        // Fonction pour déconnecter l'user
        deconnexion(): void {
            localStorage.token = "";
            sessionStorage.token = "";
            window.location.href = '/';
        }
    }
</script>

<style scoped src="../../css/mini-components/header.css"/>
