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
  actuTheme: object;
  part: number;
  error: string;

  constructor() {
    super();
    this.themes = [];
    this.selectedTheme = "none";
    this.actuTheme = {};
    this.part = 0;
    this.error = "";
  }

  selectFile(): void {
    document.getElementById("fileQuestion").click();
  }
  selectFile2(): void {
    document.getElementById("fileQuestion2").click();
  }

  async getThemes(): Promise<void> {
    await this.api.getThemes().then(datas => {
      this.themes = datas;
    })
  }

  async actualTheme(): Promise<void> {
      if(this.selectedTheme === "none")
        return;
      await this.api.getThemeByID(this.selectedTheme).then(datas => {
          this.actuTheme = datas;
      })
  }

  changePart(partID): void {
    if(partID || partID == 0)
      this.part = partID;
  }

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
  margin-top: 50px;

}
.sendQuestion {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:295px;
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
.editbtn {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:295px;
  height:50px;
  margin-left:10px;
  background-color: #F9803B;
  color: white;
  padding: 18px 70px 18px 70px;
  margin-top: 50px;
  cursor:pointer;
}
.editbtn3 {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:50px;
  height:50px;
  background-color: #F9803B;
  color: white;
  padding: 18px 18px 18px 18px;
  margin-top: 50px;
  cursor:pointer;
  display:flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-left:10px;
}
.editbtn3:hover {
  transition:0.2s;
  background:#C67342;
}
.editbtn3 img {
  width:25px;
}
.editbtn img {
  width:25px;
}
.editbtn:hover {
  transition:0.2s;
  background:#C67342;
}
.editbtn2 {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:50px;
  height:50px;
  background-color: #76E27D;
  color: white;
  padding: 18px 18px 18px 18px;
  margin-top: 50px;
  cursor:pointer;
  display:flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
}
.editbtn2 img {
  width:25px;
}
.editbtn2:hover {
  transition:0.2s;
  background:#7BBD74;
}
.supprbtn {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:50px;
  height:50px;
  background-color: #EF6359;
  color: white;
  padding: 18px 18px 18px 18px;
  margin-top: 50px;
  cursor:pointer;
  display:flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-left:10px;
}
.supprbtn img {
  width:25px;
}
.supprbtn:hover {
  transition:0.2s;
  background:#C5514A;
}
.themesInput {
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
  margin-left:15px;
  cursor:pointer;
}
.chooseFile:hover {
  transition:0.2s;
  background:#6b94ff;
}
.chooseFile2 {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:200px;
  background-color: #1965FF;
  color: white;
  padding: 12px 30px 12px 30px;
  cursor:pointer;
}
.chooseFile2:hover {
  transition:0.2s;
  background:#6b94ff;
}
.textarea {
  transition:0.2s;
  border : 1px solid #efefef;
  padding: 15px;
  width: 280px;
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
