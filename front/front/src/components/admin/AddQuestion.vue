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
    import DAO from "@/components/DAO";
    import Swal from 'sweetalert2/dist/sweetalert2.js'

    @Component({
        components: {
            Header,
            Menu
        },
    })

    export default class HelloWorld extends Vue {

        mounted() {
            this.checkAdmin();
            this.getThemes();
        }

        themes: object;
        selectedTheme: string;
        api = new DAO();
        constructor() {
              super();
              this.themes = [];
              this.selectedTheme = "none"
        }

        selectFile(): void {
            document.getElementById("fileQuestion").click();
        }

        async getThemes(): Promise<void> {
            await this.api.getThemes().then(datas => {
                this.themes = datas;
            })
        }

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
                .then(datas => {
                valueTitle.value = ""
                valueDoc.value = "";
                valueImg.value = "";
                valueDate.value = "";
                Toast.fire({
                  icon: 'success',
                  title: 'La question a bien été créée'
                })
                })
                .catch(error => {
                  Toast.fire({
                    icon: 'error',
                    title: "Erreur lors de la création de la question."
                  })
                });
        }

        async checkAdmin(): Promise<void> {
            await this.api.getCurrentUser().then(datas => {
                if( !(datas as Record<string,any>).isAdmin )
                    window.location.href = '/';
            })
        }


    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .main {
        background:#f8f9fe;
        max-height: 100%;
    }
    .main2 {
        display:flex;
        flex-direction: row;
    }

    .subMain {
        padding:50px;
        width:calc(100% - 220px);
        max-height:calc(100vh - 50px);
        overflow: scroll;
    }
    .main2 {
        max-height:100%;
        overflow:hidden;
    }
    .subMain > h1 {
        color:#154a85;
    }
    .form {
        display:flex;
        flex-direction: column;
    }
    .sendQuestion {
      transition:0.2s;
      border-radius: 6px;
      border: none;
      width:320px;
      height:50px;
      background-color: #76E27E;
      color: white;
      padding: 18px 70px 18px 70px;
      margin-top: 50px;
      cursor:pointer;
    }
    .sendQuestion:hover {
      transition:0.2s;
      background:#6BCE73;
    }
    .themesInput {
      margin-top: 50px;
      border : 1px solid #efefef;
      padding: 10px;
      width: 200px;
      border-radius: 5px;
      outline:none;
    }
    .chooseFile {
        transition:0.2s;
        border-radius: 6px;
        border: none;
        width:200px;
        background-color: #1965FF;
        color: white;
        padding: 12px 30px 12px 30px;
        margin-top:15px;
        cursor:pointer;
    }
    .chooseFile:hover {
        transition:0.2s;
        background:#6b94ff;
    }
    .textarea {
        transition:0.2s;
        border : 1px solid #efefef;
        padding: 15px;
        width: 300px;
        margin-top: 15px;
        border-radius: 5px;
        outline:none;
        margin-right:10px
    }
    .textarea2 {
      transition:0.2s;
      border : 1px solid #efefef;
      padding: 15px;
      min-width: 900px;
      max-width: 1300px;
      min-height:250px;
      max-height:500px;
      margin-top: 15px;
      border-radius: 5px;
      outline:none;
    }
</style>
