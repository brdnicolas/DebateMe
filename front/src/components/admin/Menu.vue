<template>
    <div class="main">
        <div class="main2">
            <div class="Menu">
                <div v-bind:class="{'currentPage': !this.currentPage}" @click="redirectTo('')">
                    <img style="width:20px" src="../../assets/icon/home.png"/>
                    <a>Dashboard</a>
                </div>
                <div v-bind:class="{'currentPage': this.currentPage === 'reports'}" @click="redirectTo('reports')">
                    <img style="width:20px" src="../../assets/icon/reports.png"/>
                    <a>Signalements</a>
                </div>
                <div v-bind:class="{'currentPage': this.currentPage === 'debats'}" @click="redirectTo('debats')">
                    <img style="width:20px" src="../../assets/icon/question.png"/>
                    <a>Debats</a>
                </div>
              <div v-bind:class="{'currentPage': this.currentPage === 'themes'}" @click="redirectTo('themes')">
                <img style="width:20px" src="../../assets/icon/admin/themes.png"/>
                <a>Thèmes</a>
              </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator';
    @Component({
    })

    export default class HelloWorld extends Vue {

      // Page actuelle
      currentPage: string;

      // On associe à chaque varialbe une valeur par défaut.
      constructor() {
            super();
            this.currentPage = "";
        }

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.currentPage = document.URL.split("/")[4];
            console.log(this.currentPage)
        }

        // Fonction qui redirige vers une autre page du admin panel
        redirectTo(page: string): void {
            window.location.href = '/panel/' + page;
        }
    }
</script>

<style scoped src="../../css/admin/Menu.css"/>
