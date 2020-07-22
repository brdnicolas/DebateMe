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
                    <a href="/contact" v-bind:class="{'current': this.currentPage === 'contact'}">Contact</a>
                </div>
            </div>
            <div class="rightHeader">
                <a v-bind:class="{'current': this.currentPage === 'profil'}" href="/profil/Nico">{{this.user.username}}</a>
                <img v-if="this.user.profile_pic" src="../../assets/tmp/profil.jpg"/>
                <img v-else src="../../assets/img/profile.png"/>
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
        constructor() {
            super();
            this.currentPage = "";
            this.user = [null];
        }

        mounted() {
            this.getCurrentUser();
            this.currentPage = document.URL.split("/")[3];
        }

        async getCurrentUser(): Promise<void> {
            let rep = null;
            await myAPI.get("users/me/profile").then((response: { data: any}) =>  {
                rep = response.data;
                console.log(rep);
            });
            if (rep)
                this.user = rep;
        }
    }
</script>

<style scoped>

    * {
        font-family: 'Roboto', sans-serif;
    }
    .notif_nb {
        background:white;
        color:blue;
        border-radius:50px;
        padding:3px 6px 3px 6px;
        font-size:12px;
        font-weight: bold;
        margin-bottom:25px;
        margin-right:20px;
    }
    .profil-icon {
        width:25px;
        margin: 0 5px 0 15px;
    }
    .leftHeader > *, .rightHeader * {
        cursor:pointer;
    }
    header {
        background: #ffffff;
        width:100vw;
        height:60px;
        padding-bottom: 5px;
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }
    .search-icon {
        width:20px;
        margin-left:10px;
        margin-right:15px;
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
    .rightHeader img {
        width:30px;
        height:30px;
        margin-top:8px;
        border-radius: 40px;
    }
    .rightHeader a {
        color:#3f3e42;
        font-weight: bold;
        font-size:14px;
        margin-right:20px;
        margin-left:20px;
        margin-top:8px;
        text-decoration: none;
    }
    .leftHeader .nav {
        margin-top:8px;
        margin-left: 65px;
    }
    .leftHeader .nav a {
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
        margin: 8px 0 0;
        text-decoration: none;
    }
    .leftHeader img{
        margin-left:20px;
        width:35px;
    }
    .current {
        color:#1072ff !important;
        font-weight: bold !important;
    }
</style>
