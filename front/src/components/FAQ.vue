<template>
  <div v-if="checkToken">
    <header-component/>
    <div class="FAQ">
      <h1>F.A.Q - Questions les plus souvent posées</h1>
      <ul>
        <li v-for="(item, index) in this.QandR" :key="item.question">
          <div class="question">
            <h3 @click="toggleResponse($event)">Q{{index + 1}}. {{ item.question }}</h3>
            <img style="display:block" @click="toggleResponse($event)" src="../assets/icon/plus.png"/>
            <img style="display:none" @click="toggleResponse($event)" src="../assets/icon/minus.png"/>
          </div>
          <p class="reponse">{{ item.reponse }}</p>
        </li>
      </ul>
    </div>
    <footer-component/>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import headerComponent from '@/components/mini-components/header.vue'
import footerComponent from '@/components/mini-components/footer.vue'
import commentaire from '@/components/mini-components/commentaire.vue'
import switchComponent from "@/components/mini-components/switch.vue";
import DAO from "@/DAO";
import $ from 'jquery'

@Component({
  // Components : header, footer & les commentaires
  components: {
    headerComponent,
    commentaire,
    switchComponent,
    footerComponent
  },
})
export default class Question extends Vue {

  // Liste des questions & réponses
  QandR: Record<string, any>;

  // Assigniation d'une valeur par défaut
  constructor() {
    super();
    this.QandR = [
        {
          question : "Comment fonctionne la modération forte de DebateMe ?",
          reponse : "Premièrement, il y a une analyse de votre commentaire avant qu'il soit envoyé pour être sûr qu'il ne comporte pas de mots interdits. Ensuite, nous avons un système de report afin de garantir une modération humaine derrirèe tout cela.",
        },
        {
          question : "Y'a t-il un respect des données privées ?",
          reponse : "Oui, nous ne stockons pas vos données personnelles. Pour plus d'informations, n'hésitez pas à lire la politique de confidentialité",
        },
        {
          question : "Pourquoi DebateMe et pas un autre ?",
          reponse : "Tout simplement parce que nous garantissons un débat sain et sans encombres."
        },
      {
        question : "Avons nous des aventages a rester sur cette plateforme ?",
        reponse : "Oui ! Plus vous participez, plus vous gagnez des badges et de l'expertise."
      },
      {
        question : "D'où est né ce projet ?",
        reponse : "Ce projet vient de notre école où en première année nous avons dû créer un projet libre et innovant."
      }
    ]
  }

  checkToken(): boolean {
    return !!localStorage.token;
  }

  toggleResponse(e): void {
    const minus = e.target.parentNode.childNodes[2];
    const plus = e.target.parentNode.childNodes[1];
    console.log(e.target.parentNode.childNodes);
    const reponse = e.target.parentNode.parentNode.childNodes[1];
    $(reponse).slideToggle( "slow");
    $(minus).toggle();
    $(plus).toggle();
  }

}
</script>

<style scoped src="../css/FAQ.css"/>
