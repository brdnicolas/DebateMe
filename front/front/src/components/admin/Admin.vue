<template>
    <div class="main">
        <Header/>
        <div class="main2">
            <Menu/>
            <div class="subMain">
                <div class="graph1">
                    <h1>Visiteurs maximum - minimum selon les jours</h1>
                    <line-chart :chart-data="datacollection"></line-chart>
                </div>
            </div>
        </div>
    </div>

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import axios from "axios"
    import Header from "@/components/mini-components/header.vue";
    import Menu from "@/components/admin/Menu.vue";
    import LineChart from './LineChart.js';

    /*
    <div style="width:500px;height:500px;">
        <line-chart :chart-data="datacollection"></line-chart>
    </div>
    */

    @Component({
        components: {
            Header,
            LineChart,
            Menu
        },
    })

    export default class HelloWorld extends Vue {
        mounted() {
            this.checkAdmin();
            this.fillData();
        }

        datacollection: object;

        constructor() {
            super();
            this.datacollection = [null];
        }

        fillData () {
            this.datacollection = {
                labels: ['Lundi', 'Mardi','Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'],
                datasets: [
                    {
                        label: 'Visiteurs max',
                        backgroundColor: '#f87979',
                        data: [40, 20, 12, 39, 10, 40, 39]
                    }, {
                        label: 'Visiteurs min',
                        backgroundColor: '#1072ff',
                        data: [2, 10, 30, 39, 6, 45, 23]
                    }
                ]
            }
        }

        async checkAdmin(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/users/me/profile",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
                console.log(rep);
            });
            if (rep) {
               if( !(rep as Record<string,any>).isAdmin )
                   window.location.href = '/';
            }
        }


    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .main {
        background:#f8f9fe;
    }
    .main2 {
        display:flex;
        flex-direction: row;
    }


    .subMain {
        padding:50px;
        width:calc(100% - 220px);
    }
    .subMain .graph1 {
        padding:20px;
        width:35%;
        background:white;
        box-shadow:
                0 0px 5.3px rgba(0, 0, 0, 0.02),
                0 0px 17.9px rgba(0, 0, 0, 0.03),
                0 0px 80px rgba(0, 0, 0, 0.05)
        ;
        border-radius:5px;
    }
    .subMain .graph1 h1 {
        text-align: center;
        font-weight:bold;
        color:#154a85;
        font-size: 18px;
    }
</style>
