<template>
    <div class="ContactUs">
        <header>
            <div class="left">
                <img src="../../assets/img/logo.png"/>
                <a href="/home">Debate Me</a>
            </div>
            <div class="right">
                <a>Accueil</a>
                <a>Message</a>
                <img class="search-icon" src="../../assets/icon/loupe.png"/>
                <img class="profil-icon" src="../../assets/icon/profil.png">
                <p class="notif_nb">5</p>
            </div>
        </header>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';

    @Component
    export default class Header extends Vue {
        @Prop() private msg!: string;
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
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
    .left > *, .right * {
        cursor:pointer;
    }
    header {
        background: rgb(24,100,255);
        background: linear-gradient(180deg, rgba(24,100,255,1) 0%, rgba(0,147,255,1) 100%);
        width:100vw;
        height:60px;
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
        color:white;
        margin: 0 25px 0 25px;
    }
    .left {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    .right {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    .left a {
        font-weight: 400;
        font-size: 30px;
        color:white;
        text-decoration: none;
        margin:0;
    }
    img{
        width:67px;
    }
</style>
