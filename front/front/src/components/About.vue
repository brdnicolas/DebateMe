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
        // Importation des composants : header & footer
        components: {
            headerComponent,
            footerComponent,
        },
    })

    export default class HelloWorld extends Vue {

        // On récupère les variables du parent
        @Prop() private msg!: string;

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.checkToken();
        }

        // On vérifie que l'utilisateur est connécté
        checkToken(): void {
            if(localStorage.token === "") {
                window.location.href = '/';
            }
        }
    }
</script>

<style scoped src="../css/About.css"/>
