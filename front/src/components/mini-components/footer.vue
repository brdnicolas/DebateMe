<template>
    <div class="Footer">
        <footer>
            <div class="footerTop">
                <div>
                    <h1>Legal</h1>
                    <a class="souligne" href="https://download1584.mediafire.com/1bfdfs6hdc5g/fvhue7n6772a1uc/politique+de+confidentialit%C3%A9.pdf">Politique de confidentialité</a>
                    <p>Termes & conditions</p>
                </div>
                <div>
                    <h1>Informations</h1>
                    <p>Contactez-nous : <a href="mailto:support@debate.me" style="color:#1c8eff;text-decoration: underline">support@debate.me</a></p>
                    <p>F.A.Q</p>
                    <p>Equipe</p>
                </div>
                <div>
                    <h1>Services</h1>
                    <p>Abonnement</p>
                    <p>Email marketing : <a href="mailto:marketing@debat.me" style="color:#e6654a;text-decoration: underline">marketing@debat.me</a></p>
                </div>
                <div>
                    <h1>Actualités</h1>
                    <input placeholder="Email" type="text"/>
                    <button>OK</button>
                </div>
            </div>
            <div class="footerBottom">
                <p>DebateMe © 2020 - Projet Libre & Innovant</p>
            </div>


        </footer>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    export default class Header extends Vue {
        @Prop() private msg!: string;
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .souligne {
        text-decoration: underline;
    }
    footer * {
        font-family: 'Quicksand', sans-serif;
    }
    a {
        text-decoration: none;
        font-weight: normal;
        margin-top:15px;
        margin-bottom:15px;
        color:#8c8c90;
    }
    footer {
        width:80vw;
        margin-left:10vw;
        height:60px;
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        flex-wrap: wrap;
        padding-bottom:200px;
    }
    .footerTop {
        width:100%;
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        flex-wrap: wrap;
        padding-bottom:20px;
        border-bottom: 1px solid #ebecf0;
    }
    .footerBottom {
        width:100%;
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        flex-wrap: wrap;
        padding-top:10px;
        padding-bottom:20px;
    }
    h1 {
        font-weight: bold;
        color:#252a35;
        font-size:18px;
        margin-bottom:30px;
    }
    p {
        font-weight: normal;
        margin-top:15px;
        margin-bottom:15px;
        color:#8c8c90;
    }

    input {
        width:170px;
        height:30px;
        border:2px solid #ebecf0;
        padding-left: 7px;
        padding-right: 7px;
        border-radius: 4px;
    }
    button {
        height:32px;
        width:32px;
        margin-left:10px;
        background: #1c8eff;
        color:white;
        border:1px solid #1475e8;
        cursor: pointer;
        border-radius: 4px;
    }
</style>
