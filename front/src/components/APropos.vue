<template>
    <div>
        <header-component/>
        <div class="APropos">
            <div>
                <h1>Support</h1>
                <p>Si vous rencontrez un quelconque problème avec la plateforme Debate Me, n’hésitez pas à nous contacter à notre adresse mail : <span>support@debate.me</span> ou sur twitter <span>@SupportDebateMe</span><br><br>
                    Afin de rendre votre expérience de débat plus seine et agréable, nous avons mis au point une IA qui va régulariser les débats afin d’éviter les disputes inutiles ou les insultes.

                </p>
            </div>
            <div>
                <h1>À propos</h1>
                <p>Nous sommes <span>Debate Me</span>, une plateforme où tu pourras <span>débatre tranquillement</span>, sereinement et sans risques de te faire insulter. Cette plateforme à été créée afin que chacun puisse donner son avis ainsi que l’exposer sans embûches.<br><br>
                    Nous fonctionnons en catégories, un pannel large de catégories existe et chaque semaine un nouveau <span>“sujet de la semaine”</span> apparait par catégorie. Vous êtes <span>libres de choisir</span> vous même vos catégories préférées afin d’améliorer votre éxpérience !




                </p>
            </div>
        </div>
        <footer-component/>
    </div>

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/mini-components/header.vue";
    import footerComponent from "@/components/mini-components/footer.vue";

    @Component({
        components: {
            headerComponent,
            footerComponent,
        },
    })

    export default class HelloWorld extends Vue {
        @Prop() private msg!: string;
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .APropos {
        display:flex;
        flex-direction: row;
        justify-content: center;
        width:100vw;
        height:calc(100vh - 60px - 60px - 5px);
        background:#f6f9ff;
    }
    .APropos div {
        width:550px;
        margin-left:50px;
        margin-right: 50px;
        padding-top:25vh;
    }

    .APropos div h1 {
        font-weight: bold;
        font-size: 35px;
    }

    .APropos div p {
        font-weight: 300;
        font-size: 16px;
        line-height: 24px;
        margin-top:30px;
    }
    .APropos div span {
        color: #0D78FF;
        font-weight: 500;
    }
</style>
