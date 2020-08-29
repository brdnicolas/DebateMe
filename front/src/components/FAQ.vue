<template>
  <div class="FAQ">
    <ul id="example-1">
      <li v-for="item in this.QandR" :key="item">
        {{ item.question }}
        {{ item.reponse }}
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import headerComponent from '@/components/mini-components/header.vue'
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
        }
    ]
  }

}
</script>

<style scoped src="../css/Question.css"/>
