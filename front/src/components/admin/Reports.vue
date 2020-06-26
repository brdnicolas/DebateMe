<template>
    <div class="main">
        <div class="menu">
            <div id="logo">
                <img alt="logo" src="../../assets/img/logo2.png"/>
            </div>
            <div>
                <img alt="dashboard" src="../../assets/icon/admin/dashboard.png"/>
                <a href="/panel">Dashboard</a>
            </div>
            <div>
                <img alt="report" src="../../assets/icon/admin/report.png"/>
                <a href="/panel/reports">Signalements</a>
            </div>
        </div>
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

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import axios from "axios"
    import report from '@/components/admin/mini-components/report-comp.vue'



    @Component({
        components: {
            report
        },
    })

    export default class HelloWorld extends Vue {
        reports: object;

        constructor() {
            super();
            this.reports = [];
        }

        mounted() {
            this.checkAdmin();
            this.getReports();
        }

        async getReports(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/reports/",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
                console.log(rep);
            });
            if (rep) {
                this.reports = rep;
            }
        }

        async deletePost(idPost: number): Promise<void> {
            let reponse = null;
            await axios.delete("https://api.hugovast.tech/posts/" + idPost,{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(rep) {
                reponse = 1;
            });
            if(reponse)
                this.$router.go(0);
        }

        async deleteReport(idReport: number): Promise<void> {
            let reponse = null;
            await axios.delete("https://api.hugovast.tech/reports/" + idReport,{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(rep) {
                reponse = 1;
            });
            if(reponse)
                this.$router.go(0);
        }

        async checkAdmin(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/users/me/profile",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
            });
            if (rep) {
               if( !(rep as Record<string,any>).isAdmin )
                   window.location.href = '/';
            }
        }


    }
</script>

<style scoped>
    .content ul {
        list-style: none;
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
        padding:100px;
        color:#009EFF;
    }
    .choose {
        display: flex;
        flex-direction: column;
    }
    .content {
        min-height:100vh;
        width: calc(100vw - 200px);
        background:#f8f9fe;
    }
    .main {
        display: flex;
        flex-direction: row;
        height:100%;
    }
    #logo {
        display:flex;
        align-items: center;
        justify-content: center;
    }
    #logo img{
        width:130px;
        height:130px;
    }
    .menu {
        z-index:10;
        display:flex;
        flex-direction: column;
        width:200px;
        min-height: 100vh;
        background:white;
        padding:10px 10px 10px 20px;
    }

    .menu a {
        text-decoration: none;
        color:black;
    }

    .menu > div {
        display:flex;
        flex-direction: row;
        align-items: center;
        margin-top:15px;
        margin-bottom:5px;
        cursor:pointer;
    }

    .menu > div > img {
        width:20px;
        height:20px;
        margin-right:10px;
    }

</style>
