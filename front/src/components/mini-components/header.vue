<template>
    <div class="ContactUs">
        <header>
            <div class="leftHeader">
                <img src="../../assets/img/logo2.png"/>
                <a href="/home">Debate Me</a>
                <div class="nav">
                    <a href="/home" v-bind:class="{'current': this.currentPage === 'home'}">Accueil</a>
                    <a href="/message" v-bind:class="{'current': this.currentPage === 'message'}">Message</a>
                    <a href="/about" v-bind:class="{'current': this.currentPage === 'about'}">A propos</a>
                    <a href="/notifications" v-bind:class="{'current': this.currentPage === 'notifications'}">Notifications (53)</a>
                    <a v-if="this.user.isAdmin" style="color:#EFA1A1" href="/panel" v-bind:class="{'currentAdmin': this.currentPage === 'panel'}">Modération</a>
                </div>
            </div>
            <div class="rightHeader">
                <a v-bind:class="{'current': this.currentPage === 'profil'}" href="/profil/Nico">{{this.user.username}}</a>
                <img class="profil_pic" v-if="this.user.profile_pic" src="../../assets/tmp/profil.jpg"/>
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
                        <a>Paramètre</a>
                    </li>
                    <li>
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
    import myAPI from "@/components/myAPI";

    @Component
    export default class Header extends Vue {
        @Prop() private msg!: string;

        currentPage: string;
        user: object;
        visibleMenu: boolean;
        constructor() {
            super();
            this.currentPage = "";
            this.user = [null];
            this.visibleMenu = false;
        }

        mounted() {
            this.getCurrentUser();
            this.currentPage = document.URL.split("/")[3];
        }

        async getCurrentUser(): Promise<void> {
            let rep = null;
            await myAPI.get("users/me/profile").then((response: { data: any}) =>  {
                rep = response.data;
            }).catch(error => {
                this.deconnexion();
            });
            if (rep)
                this.user = rep;
        }

        redirectTo(page: string): void {
            window.location.href = '/' + page;
        }

        deconnexion(): void {
            localStorage.token = "";
            sessionStorage.token = "";
            window.location.href = '/';
        }

    }
</script>

<style scoped>
    .Menuicon:hover path {
        transition:0.2s;
        fill:#1864ff;
    }
    path {
        transition:0.2s;
        fill:#3f3e48;
    }
    * {
        font-family: 'Roboto', sans-serif;
    }
    .dropdown {
        -webkit-animation-name: fadeInDown;
        animation-name: fadeInDown;
        -webkit-animation-duration: 0.5s;
        animation-duration: 0.5s;
        -webkit-animation-fill-mode: both;
        animation-fill-mode: both;
    }
    @-webkit-keyframes fadeInDown {
        0% {
            opacity: 0;
            -webkit-transform: translate3d(0, -20%, 0);
            transform: translate3d(0, -20%, 0);
        }
        100% {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }
    @keyframes fadeInDown {
        0% {
            opacity: 0;
            -webkit-transform: translate3d(0, -20%, 0);
            transform: translate3d(0, -20%, 0);
        }
        100% {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }
    .dropdown {
        z-index: 500000;
        background:white;
        cursor:auto;
        position:absolute;
        margin-top:70px;
        margin-right:32px;
        right:0;
        top:0;
        border:2px solid #dadce0;
        border-radius: 6px 0 0 6px;
        list-style: none;
    }
    .dropdown li {
        display:flex;
        flex-direction: row;
        align-items: center;
        padding:12px 20px 12px 20px;
        border-radius: 0 90px 90px 0;
        margin-right:20px;
        margin-top:10px;
        margin-bottom:10px;
    }
    .dropdown li:hover {
        background:rgba(15, 115, 255, 0.10);
    }
    .dropdown li:hover a{
        color:#1072ff;
    }
    .dropdown li:hover img {
        fill: red;
    }
    .dropdown li img {
        width:25px;
        height:25px;
    }
    .dropdown li p {
        color:#666666;
        margin-left:20px;
        font-size:16px
    }
    .leftHeader > *, .rightHeader * {
        cursor:pointer;
    }
    header {
        padding-left:10px;
        padding-top:8px;
        padding-bottom:8px;
        background: #ffffff;
        width:100vw;
        height:60px;
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        -webkit-box-shadow: 0px 8px 16px -5px rgba(214,214,214,1);
        -moz-box-shadow: 0px 8px 16px -5px rgba(214,214,214,1);
        box-shadow: 0px 8px 16px -5px rgba(214,214,214,1);
    }
    header a  {
        font-style: normal;
        font-weight: 400;
        font-size: 22px;
        color:blue;
        margin: 0 25px 0 25px;
    }
    .leftHeader {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    .rightHeader {
        display: flex;
        flex-direction: row;
        align-items: center;
        margin-right:60px;
    }
    .rightHeader .profil_pic {
        width:22px;
        height:22px;
        margin-top:7px;
        border-radius: 40px;
    }
    .rightHeader a {
        color:#3f3e42;
        font-weight: bold;
        font-size:14px;
        margin-right:20px;
        margin-left:20px;
        margin-top:7px;
        text-decoration: none;
    }
    .leftHeader .nav {
        margin-top:7px;
        margin-left: 65px;
    }
    .leftHeader .nav a {
        transition: 0.2s;
        color:#cacbd4;
        text-transform: uppercase;
        font-size:14px;
        margin-right:20px;
        margin-left:20px;
    }
    .leftHeader a {
        font-weight: 500;
        font-size: 20px;
        color:#1072ff;
        margin: 7px 0 0;
        text-decoration: none;
    }
    .leftHeader img{
        margin-left:20px;
        width:30px;
    }
    .current {
        color:#1072ff !important;
        font-weight: bold !important;
    }
    .currentAdmin {
        color:#FC4444 !important;
        font-weight: bold !important;
    }
    .nav a:hover {
        transition: 0.2s;
        color:#BDC1EB;
    }
</style>
