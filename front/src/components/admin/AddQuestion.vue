<template>
    <div class="main">
        <Header/>
        <div class="main2">
            <Menu/>
            <div class="subMain">
                <h1>Ajouter une question</h1>
                <div class="form">
                    <select class="themesInput" v-model="selectedTheme">
                      <option disabled value="none">Choisissez un thème</option>
                      <option v-for="theme in this.themes" v-bind:key="theme.name" v-bind:value="theme.id">{{theme.name}}</option>
                    </select>
                    <input id="fileQuestion" style="display:none" type="file" />
                    <button @click="selectFile" class="chooseFile">Choisir une image</button>
                    <div style="display:flex;flex-direction:row">
                      <input id="titleQuestion" class="textarea" type="text" placeholder="Titre"/>
                      <input id="dateQuestion" class="textarea" type="date" placeholder="Date de lancement"/>
                    </div>
                    <textarea id="docQuestion" class="textarea2" type="text" placeholder="Documentation"/>
                    <button @click="newQuestion" class="sendQuestion">Poser la question</button>
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
            // Importation du header & du menu
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

        // Thème séléctionné
        selectedTheme: string;

        // DAO
        api = new DAO();

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
              super();
              this.themes = [];
              this.selectedTheme = "none"
        }

        // fonction permettant de choisir un fichier
        selectFile(): void {
            document.getElementById("fileQuestion").click();
        }

        // Fonction permettant de récupérer la liste des thèmes
        async getThemes(): Promise<void> {
            await this.api.getThemes().then(datas => {
                this.themes = datas;
            })
        }

        // Requete api pour créer une nouvelle question
        async newQuestion(): Promise<void> {
            const valueTitle = document.getElementById("titleQuestion") as HTMLElement;
            const valueDoc = document.getElementById("docQuestion") as HTMLElement;
            const valueImg = document.getElementById("fileQuestion") as HTMLElement;
            const valueDate = document.getElementById("dateQuestion") as HTMLElement;
            const dataform = new FormData();

            if (valueImg.files[0] && valueTitle && valueDate && valueDoc) {
                dataform.append('image', valueImg.files[0], valueImg.files[0].name);
                dataform.append('title', valueTitle.value);
                dataform.append('documentation', valueDoc.value);
                dataform.append('start_time', valueDate.value);
            }

          const Toast = Swal.mixin({
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
            });

            await this.api.postQuestion(this.selectedTheme, dataform)
                .then(() => {
                valueTitle.value = ""
                valueDoc.value = "";
                valueImg.value = "";
                valueDate.value = "";
                Toast.fire({
                  icon: 'success',
                  title: 'La question a bien été créée'
                })
                })
                .catch(() => {
                  Toast.fire({
                    icon: 'error',
                    title: "Erreur lors de la création de la question."
                  })
                });
        }

        // On vérifie que l'utilisateur est connécté
        async checkAdmin(): Promise<void> {
            await this.api.getCurrentUser().then(datas => {
                if( !(datas as Record<string,any>).isAdmin )
                    window.location.href = '/';
            })
        }
    }
</script>

<style scoped src="../../css/admin/AddQuestion.css"/>
