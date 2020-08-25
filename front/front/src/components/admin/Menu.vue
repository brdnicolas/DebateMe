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
            </div>
        </div>
    </div>

</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator';
    import LineChart from './LineChart.js';

    @Component({
        components: {
            LineChart,
        },
    })

    export default class HelloWorld extends Vue {


        currentPage: string;
        constructor() {
            super();
            this.currentPage = "";
        }

        mounted() {
            this.currentPage = document.URL.split("/")[4];
            console.log(this.currentPage);
        }

        redirectTo(page: string): void {
            window.location.href = '/panel/' + page;
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
    .Menu {
        z-index:2;
        min-width:220px;
        max-width:220px;
        height:100%;
        min-height:calc(100vh - 76px - 30px);
        display:flex;
        flex-direction: column;
        border-right: 1px solid #ADB7CB;
        background:white;
        padding-top:30px;
    }
    .Menu div {
        padding-left:32px;
        padding-top:12px;
        padding-bottom:12px;
        text-decoration: none;
        font-weight: bold;
        color:#2f3a4f;
        font-size:17px;
        cursor:pointer;
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .Menu div a {
        margin-left:5px;
        margin-top:6px;
    }
    .Menu div:hover {
        background:rgba(15, 115, 255, 0.10);
        border-left: 4px solid #1273ff;
    }
    .currentPage {
        background:rgba(15, 115, 255, 0.10);
        border-left: 4px solid #1273ff;
    }
</style>
