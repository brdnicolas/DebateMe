<template>
    <div class="contactUs">
        <headerComponent />
        <div class="contact">
            <div class="card">
                <h1>Ecrivez-nous une petite ligne</h1>
                <h3>Comment pouvons-nous vous aider ?</h3>
                <form>
                    <div class="left">
                        <h4>Nom</h4>
                        <input type="text" placeholder="Entrez votre nom"/>
                        <h4>Message</h4>
                        <textarea type="text" placeholder="Entrez vos plus belles phrases"/>
                    </div>
                    <div class="right">
                        <h4>Email</h4>
                        <input type="email" placeholder="Entrez votre email"/>
                        <h4>Raison de votre message</h4>
                        <select v-model="selectRaison">
                            <option disabled>{{selectRaison}}</option>
                            <option>Je veux signaler un problème 😥</option>
                            <option>C'est un message d'amour 👉🏼👈🏼</option>
                            <option>Je veux me plaindre ! 😡</option>
                            <option>Autre 🕵🏼‍♂️</option>
                        </select>
                        <button type="submit">Envoyer</button>
                    </div>
                </form>
            </div>
        </div>
        <footerComponent style=" background:#F6FAFF;"/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    @Component({
        // Importation des composants : header & footer
        components: {
            headerComponent,
            footerComponent
        },
      data () {
        return {
          selectRaison:"Veuillez choisir une raison"
        }
      }
    })
    export default class HelloWorld extends Vue {

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.checkToken();
        }

        // Fonction vérifiant si l'utilisateur est connécté.
        checkToken(): void {
            if(localStorage.token === "") {
                window.location.href = '/';
            }
        }

    }
</script>

<style scoped src="../css/ContactUs.css"/>
