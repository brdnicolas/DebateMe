<template>
    <tr>
      <td>{{ date }}</td>
      <td>{{ type }}</td>
      <td>{{ pseudoSignale }}</td>
      <td>{{ contentPost }}</td>
      <td>{{pseudoReporteur}}</td>
      <td>{{ message }}</td>
      <td><button @click="garder" class="garder">Garder</button></td>
      <td><button @click="supprimer" class="supprimer">Supprimer</button></td>
    </tr>
</template>

<script lang="ts">
// @ts-nocheck
import {Component, Prop, Vue} from 'vue-property-decorator';
import Menu from "@/components/admin/Menu.vue";
import Header from "@/components/user/mini-components/header.vue";
import DAO from "@/DAO";

@Component({
  components: {
    // Importation du menu & du header
    Header,
    Menu
  },
})

export default class HelloWorld extends Vue {

  // Fonction qui s'éxécute en même temps que le rendu du composant
  mounted(): void {
    this.getRaisonReport();
    this.getPost();
    this.getUserWhoReport();
  }

  // Type de report
  type: string;

  // Post reporté
  contentPost: string;

  // Pseudo de la personne qui a report
  pseudoReporteur: string;

  // Pseudo de la personne signalée
  pseudoSignale: string;

  // DAO
  api = new DAO();

  // On récupère les variables parentes
  @Prop({default: ""})
  date: string | undefined;
  @Prop({default: 0})
  reportID: number | undefined;
  @Prop({default: 0})
  postID: number | undefined;
  @Prop({default: 0})
  userWhoReported: number | undefined;
  @Prop({default: "Aucun"})
  message: string | undefined;
  @Prop({default: 0})
  reasonID: number | undefined;

  // On associe à chaque varialbe une valeur par défaut.
  constructor() {
    super();
    this.type = "";
    this.contentPost = "";
    this.pseudoReporteur = "";
    this.pseudoSignale = "";
  }

  // Fonction pour récupérer la raison du report
  async getRaisonReport() {
      this.api.getRaisonReport().then(datas => {
          datas.forEach(element => {
            if(element.id == this.reasonID)
              this.type = element.reason;
          });
      })
  }

  // Fonction permettant de récupérer le poste reporté
  async getPost() {
    await this.api.getPostByID(this.postID).then(datas => {
        this.contentPost = datas.content;
        this.getUserReported(datas.user_id);
    })
  }

  // Fonction permettant de garder le poste et supprimer le report
  async garder(): Promise<void> {
    await this.api.deleteReport(this.reportID).then(datas => {
      this.$router.go(0);
    })
  }

  // Fonction permettant de supprimer le post reporté
  async supprimer(): Promise<void> {
    await this.api.deletePost(this.postID).then(datas => {
      this.$router.go(0);
    })
  }

  // Fonction permettant de récupérer les infos sur l'user qui a report
  async getUserWhoReport() {
      await this.api.getUserByID(this.userWhoReported).then( datas => {
            this.pseudoReporteur = datas.username;
      })
  }


  // Fonction permettant de récupérer les infos sur l'user reporté
  async getUserReported(userID) {
    await this.api.getUserByID(userID).then( datas => {
      this.pseudoSignale = datas.username;
    })
  }
}
</script>

<style scoped src="../../../css/admin/mini-components/reportTAB.css"/>
