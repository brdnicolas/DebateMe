<template>
    <div class="main">
        <Header/>
        <div class="main2">
            <Menu/>
            <div class="subMain">
                <div class="content">
                    <h1>Signalements</h1>
                  <table class="blueTable">
                    <thead>
                    <tr class="headerTab">
                      <th style="padding: 5px 10px 5px 10px; width:100px">Date</th>
                      <th style="padding: 5px 10px 5px 10px; width:150px;">Raison</th>
                      <th style="padding: 5px 10px 5px 10px;width:150px">Pseudo signalé</th>
                      <th style="padding: 5px 10px 5px 10px; width: 300px;">Post</th>
                      <th style="padding: 5px 10px 5px 10px; width:180px">Pseudo du signaleur</th>
                      <th style="padding: 5px 10px 5px 10px;width:180px;">Message</th>
                      <th style="padding: 5px 10px 5px 10px; width:120px">Garder</th>
                      <th style="padding: 5px 10px 5px 10px; width:120px">Supprimer</th>
                    </tr>
                    </thead>
                    <tbody>
                    <report-t-a-b v-for="item in this.reports" :reasonID="item.reason_report_id" :message="item.message" :userWhoReported="item.user_id" :key="item.id" :reportID="item.id" :postID="item.post_id" :date="getDate(item.created_at)"></report-t-a-b>
                    </tbody>
                  </table>
                </div>
            </div>
        </div>
    </div>

</template>

<script lang="ts">
    // @ts-nocheck
    import { Component, Vue } from 'vue-property-decorator';
    import Menu from "@/components/admin/Menu.vue";
    import Header from "@/components/user/mini-components/header.vue";
    import DAO from "@/DAO";
    import reportTAB from "@/components/admin/mini-components/reportTAB.vue"
    import moment from "moment"

    @Component({
        components: {
            // Importation du header, du menu & du tableau report
            Header,
            Menu,
            reportTAB,
        },
    })

    export default class HelloWorld extends Vue {

      // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.checkAdmin();
            this.getReports();
        }

        // liste des reports
        reports: object;

        // Date à modif via moment
        date: string;

        // DAO
        api = new DAO();

      // On associe à chaque varialbe une valeur par défaut.
      constructor() {
            super();
            this.date = "";
            this.reports = [];
            this.reportRaison = []
        }

        // Ex : Il y a 2min
        getDate(dateSTR): string {
          moment.locale('fr');
          return moment(dateSTR).fromNow();
        }

        // Fonction qui récupère les reports
        async getReports(): Promise<void> {
            await this.api.getReports().then(datas => {
              this.reports = datas
            })
        }

        // Fonction qui supprime un poste
        async deletePost(idPost: number): Promise<void> {
            await this.api.deletePost(idPost).then(datas => {
                this.$router.go(0);
            })
        }

        // Fonction qui permet de supprimer un report
        async deleteReport(idReport: number): Promise<void> {
            await this.api.deleteReport(idReport).then(datas => {
                this.$router.go(0);
            })
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

<style scoped src="../../css/admin/Reports.css"/>
