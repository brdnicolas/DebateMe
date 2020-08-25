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
    import Header from "@/components/mini-components/header.vue";
    import LineChart from './LineChart.js';
    import DAO from "@/components/DAO";
    import reportTAB from "@/components/admin/mini-components/reportTAB.vue"
    import moment from "moment"

    @Component({
        components: {
            Header,
            LineChart,
            Menu,
            reportTAB,
        },
    })



    export default class HelloWorld extends Vue {
        mounted() {
            this.checkAdmin();
            this.getReports();
        }

        redirectTo(page: string): void {
            window.location.href = '/' + page;
        }

        reports: object;
        date: string;
        api = new DAO();


      constructor() {
            super();
            this.date = "";
            this.reports = [];
            this.reportRaison = []
        }

        getDate(dateSTR) {
          moment.locale('fr');
          return moment(dateSTR).fromNow();
        }

        async getReports(): Promise<void> {
            await this.api.getReports().then(datas => {
              this.reports = datas
            })
        }

        async deletePost(idPost: number): Promise<void> {
            await this.api.deletePost(idPost).then(datas => {
                this.$router.go(0);
            })
        }

        async deleteReport(idReport: number): Promise<void> {
            await this.api.deleteReport(idReport).then(datas => {
                this.$router.go(0);
            })
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

.headerTab th {
  color : #8D8FA2;
  font-weight: bold;
  font-size:15px;
  height:30px;
}


table.blueTable {
  border: 1px solid #E5E5E5;
  width: 100%;
  text-align: left;
  border-collapse: collapse;
  margin-top:40px;
  padding-bottom:100px;
}
table.blueTable td, table.blueTable th {
  border: 2px solid #E5E5E5;
  padding: 0px 2px;
}
table.blueTable thead {
  border-bottom: 2px solid #E5E5E5;
}
table.blueTable tfoot .links {
  text-align: right;
}
table.blueTable tfoot .links a{
  display: inline-block;
  background: #1C6EA4;
  color: #FFFFFF;
  padding: 2px 8px;
  border-radius: 5px;
}










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
        max-height:calc(100vh - 220px);
        overflow: scroll;
    }
    .main2 {
        max-height:100%;
        overflow:hidden;
    }
    .subMain .graph1 h1 {
        text-align: center;
        font-weight:bold;
        color:#154a85;
        font-size: 18px;
    }
    .content ul {
        list-style: none;
        padding-bottom:100px;
    }
    .content li {
        display:flex;
        flex-direction: row;
    }
    .content li img {
        cursor:pointer;
        width:30px;
        height:30px;
        margin-top:10px;
        margin-left:10px;
    }
    .content li img:first-child {
        margin-top:40px;
    }
    .content h1 {
        color:#1072ff;
    }
    .choose {
        display: flex;
        flex-direction: column;
    }
</style>
