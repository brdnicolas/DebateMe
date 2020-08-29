<template>
  <div v-if="localStorage.token">
    <header-component/>
    <div class="Equipage">
      <div class="Personne" v-for="item in this.equipage" :key="item.nom">
        <img v-bind:src="item.image"/>
        <h2>{{ item.nom }}</h2>
        <p class="role">{{ item.role }}</p>
        <p class="citation">{{ item.parole }}</p>
      </div>
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

  // Liste de l'équipe
  equipage: Record<string, any>;

  // Assigniation d'une valeur par défaut
  constructor() {
    super();
    this.equipage = [
      {
        image : require("@/assets/equipe/nico1.png"),
        nom : "Nicolas Brouard",
        role : "Développeur front & Designer UX UI",
        parole : 'Je gère toute la partie design du site web !'
      },
      {
        image : require("../assets/equipe/hugo.png"),
        nom : "Hugo Vast",
        role : "Développeur Back",
        parole : "Je gère la caché du site, je travaille dans l'ombre."
      },
      {
        image : require("../assets/equipe/nico2.png"),
        nom : "Nicolas Tiennot",
        role : "Développeur Back",
        parole : "J'ai assisté au développement de la partie submergé de DebateMe."
      },
      {
        image : require("../assets/equipe/ulysse.png"),
        nom : "Ulysse Duclos",
        role : "Développeur front",
        parole : "J'ai assisté à la charte graphique du site."
      },

    ]
  }

  mounted(): void {
    if(!localStorage.token)
      window.location.href = "/"
  }

}
</script>

<style scoped src="../css/Equipe.css"/>
