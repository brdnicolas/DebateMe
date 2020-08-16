<template>
    <div class="main">
        <Header/>
        <div class="main2">
            <Menu/>
            <div class="subMain">
                <div class="content">
                    <h1>Signalements</h1>
                    <ul>
                        <li v-for="item in this.reports" :key="item.id">
                            <report :type="item.reason_report_id" :post_id="item.post_id" :message="item.message" :date="item.created_at"/>
                            <div class="choose">
                                <img @click="deletePost(item.post_id)" alt="delete" src="../../assets/icon/admin/croix.png"/>
                                <img @click="deleteReport(item.id)" alt="keep" src="../../assets/icon/admin/check.png"/>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator';
    import report from "@/components/admin/mini-components/report-comp.vue";
    import Menu from "@/components/admin/Menu.vue";
    import Header from "@/components/mini-components/header.vue";
    import LineChart from './LineChart.js';
    import DAO from "@/components/DAO";

    /*
    <div style="width:500px;height:500px;">
        <line-chart :chart-data="datacollection"></line-chart>
    </div>
    */

    @Component({
        components: {
            Header,
            LineChart,
            report,
            Menu
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
        api = new DAO();


      constructor() {
            super();
            this.reports = [];
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
