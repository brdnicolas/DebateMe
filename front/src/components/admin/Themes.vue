<template>
  <div class="main">
    <Header/>
    <div class="main2">
      <Menu/>
      <div class="subMain">
        <h1>Gestion des thèmes</h1>
        <p style="color:#FF7962; margin-top: 10px;">{{error}}</p>
        <div class="form" v-if="this.part === 0">
          <div style="display:flex;flex-direction:row; align-items: center">
          <select @change="actualTheme" class="themesInput" v-model="selectedTheme">
            <option disabled value="none">Choisissez un thème</option>
            <option v-for="theme in this.themes" v-bind:key="theme.name" v-bind:value="theme.id">{{theme.name}}</option>
          </select>
            <input id="fileQuestion" style="display:none" type="file" />
            <button @click="selectFile" class="chooseFile">Choisir une image</button>
          </div>
          <div style="display:flex;flex-direction:row; align-items: center">
          <input id="titleQuestion" class="textarea" type="text" v-bind:value="this.actuTheme.name" placeholder="Titre"/>
          <input style="width:80px; height:35px;margin-top:15px; background:white; border : 1px solid #efefef; border-radius: 5px; padding:5px" type="color" id="headColor" name="head"
                 v-bind:value="this.actuTheme.color">
          </div>
          <div style="display:flex;flex-direction:row; align-items: center">
              <button @click="editTheme" class="sendQuestion">Enregistrer</button>
              <button class="editbtn3" @click="changePart(1)"><img src="../../assets/icon/admin/new.png"/></button>
              <button @click="changePart(3)" class="supprbtn"><img src="../../assets/icon/admin/delete.png"/></button>
          </div>
          </div>
          <div class="form" v-if="this.part === 1">
            <div style="display:flex;flex-direction:row; align-items: center">
              <input id="fileQuestion2" style="display:none" type="file" />
              <button @click="selectFile2" class="chooseFile2">Choisir une image</button>
            </div>
            <div style="display:flex;flex-direction:row; align-items: center">
              <input id="titleQuestion2" class="textarea" type="text" v-bind:value="this.actuTheme.name" placeholder="Titre"/>
              <input style="width:80px; height:35px;margin-top:15px; background:white; border : 1px solid #efefef; border-radius: 5px; padding:5px" type="color" id="headColor2" name="head"
                     v-bind:value="this.actuTheme.color">
            </div>
            <div style="display:flex;flex-direction:row; align-items: center">
              <button class="editbtn2" @click="changePart(0)"><img src="../../assets/icon/admin/edit.png"/></button>
              <button class="editbtn" @click="newTheme">Créer</button>
              <button @click="changePart(3)" class="supprbtn"><img src="../../assets/icon/admin/delete.png"/></button>
            </div>
        </div>
        <div class="form" v-if="this.part === 3">
          <div style="display:flex;flex-direction:row; align-items: center">
            <select @change="actualTheme" class="themesInput" v-model="selectedTheme">
              <option disabled value="none">Choisissez un thème</option>
              <option v-for="theme in this.themes" v-bind:key="theme.name" v-bind:value="theme.id">{{theme.name}}</option>
            </select>
          </div>
          <div style="display:flex;flex-direction:row; align-items: center">
            <button class="editbtn2" @click="changePart(0)"><img src="../../assets/icon/admin/edit.png"/></button>
            <button style="margin-left:23px" class="editbtn3" @click="changePart(1)"><img src="../../assets/icon/admin/new.png"/></button>
            <button style="margin-left:23px" @click="deleteTheme" class="supprbtn"><img src="../../assets/icon/admin/delete.png"/></button>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script lang="ts">
// @ts-nocheck
import { Component, Vue } from 'vue-property-decorator';
import Menu from "@/components/admin/Menu.vue";
import Header from "@/components/mini-components/header.vue";
import DAO from "@/DAO";
import Swal from 'sweetalert2/dist/sweetalert2.js'

@Component({
  components: {
    // Importation du header & du meu
    Header,
    Menu
  },
})

export default class HelloWorld extends Vue {

  // Fonction qui s'éxécute en même temps que le rendu du composant
  mounted(): void {
    this.checkAdmin();
    this.getThemes();
  }

  // Liste des thèmes
  themes: object;

  // Le thème choisi dans le selecteur
  selectedTheme: string;

  // DAO
  api = new DAO();

  // Données du thème séléctionné
  actuTheme: object;

  // Partie séléctionné ( 0 = modif , 1 : créer, 2: delete )
  part: number;

  // Erreur a afficher
  error: string;

  // On associe à chaque varialbe une valeur par défaut.
  constructor() {
    super();
    this.themes = [];
    this.selectedTheme = "none";
    this.actuTheme = {};
    this.part = 0;
    this.error = "";
  }

  // Fonctions permettants de séléctionner un fichier
  selectFile(): void {
    document.getElementById("fileQuestion").click();
  }
  selectFile2(): void {
    document.getElementById("fileQuestion2").click();
  }

  // Fonction pour récupérer la liste des thèmes
  async getThemes(): Promise<void> {
    await this.api.getThemes().then(datas => {
      this.themes = datas;
    })
  }

  // Fonction permettant de récupérer les données du thème choisi
  async actualTheme(): Promise<void> {
      if(this.selectedTheme === "none")
        return;
      await this.api.getThemeByID(this.selectedTheme).then(datas => {
          this.actuTheme = datas;
      })
  }

  // Fonction permettant de passer d'une partie à l'autre
  changePart(partID): void {
    if(partID || partID == 0)
      this.part = partID;
  }

  // Fonction qui permet de modifier les données d'un thème
  async editTheme(): Promise<void> {
    if(!this.actuTheme.id) {
      this.error = "Choisissez un thème.";
      return;
    }
    const valueTitle = document.getElementById("titleQuestion") as HTMLElement;
    const valueImg = document.getElementById("fileQuestion") as HTMLElement;
    const valueColor = document.getElementById("headColor") as HTMLElement;
    const dataform = new FormData();

    if (valueImg.files[0])
      dataform.append('logo', valueImg.files[0], valueImg.files[0].name);

    if (valueTitle)
      dataform.append('name', valueTitle.value);

    if (valueColor)
      dataform.append('color', valueColor.value);

    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
    });

    await this.api.patchTheme(this.actuTheme.id, dataform)
        .then(datas => {
          Toast.fire({
            icon: 'success',
            title: 'Le thème a bien été modifié.'
          })
        })
        .catch(error => {
          Toast.fire({
            icon: 'error',
            title: "Erreur lors de la modification."
          })
        });
  }

  // Fonction qui permet de supprimer un thème
  async deleteTheme(): Promise<void> {
    if(!this.actuTheme.id) {
      this.error = "Choisissez un thème.";
      return;
    }
    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
    });
    await this.api.deleteTheme(this.actuTheme.id)
        .then(datas => {
          Toast.fire({
            icon: 'success',
            title: 'Le thème a bien été supprimé.'
          })
        })
        .catch(error => {
          Toast.fire({
            icon: 'error',
            title: "Erreur lors de la suppression."
          })
        });
  }

  // Fonction permettant de créer un thème
  async newTheme(): Promise<void> {
    const valueTitle = document.getElementById("titleQuestion") as HTMLElement;
    const valueImg = document.getElementById("fileQuestion2") as HTMLElement;
    const valueColor = document.getElementById("headColor") as HTMLElement;
    const dataform = new FormData();

    if (valueImg.files[0])
      dataform.append('logo', valueImg.files[0], valueImg.files[0].name);
    else {
      this.error = "Il manquerai pas l'image .. ?"
      return;
    }


    if (valueTitle)
      dataform.append('name', valueTitle.value);
    else {
      this.error = "Il manquerai pas le titre .. ?"
      return;
    }

    if (valueColor)
      dataform.append('color', valueColor.value);
    else {
      this.error = "Il manquerai pas la couleur .. ?"
      return;
    }

    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
    });

    await this.api.postTheme(this.actuTheme.id, dataform)
        .then(datas => {
          Toast.fire({
            icon: 'success',
            title: 'Le thème a bien été créé.'
          })
        })
        .catch(error => {
          Toast.fire({
            icon: 'error',
            title: "Erreur lors de la création."
          })
        });
  }

  // Fonction qui vérifie si l'user est admin
  async checkAdmin(): Promise<void> {
    await this.api.getCurrentUser().then(datas => {
      if( !(datas as Record<string,any>).isAdmin )
        window.location.href = '/';
    })
  }
}
</script>

<style scoped src="../../css/admin/Themes.css"/>
