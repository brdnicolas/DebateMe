<template>
    <div class="main">
        <Header/>
        <div class="main2">
            <Menu/>
            <div class="subMain">
                <h1>Ajouter une question</h1>
                <div class="form">
                    <input style="display:none" id="files" type="file" />
                    <button @click="selectFile" class="chooseFile">Choisir une image</button>
                    <input class="textarea" id="titre" type="text" placeholder="Titre"/>
                    <input class="textarea" id="doc" type="text" placeholder="Documentation"/>
                </div>
            </div>
        </div>
    </div>

</template>

<script lang="ts">
    // @ts-nocheck
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import report from "@/components/admin/mini-components/report-comp.vue";
    import Menu from "@/components/admin/Menu.vue";
    import Header from "@/components/mini-components/header.vue";
    import LineChart from './LineChart.js';
    import myAPI from "@/components/myAPI";

    @Component({

        components: {
            Header,
            Menu
        },
    })

    export default class HelloWorld extends Vue {
        mounted() {
            this.checkAdmin();
        }

        file: string;
        constructor() {
            super();
            this.file = "";
        }

        selectFile(): void {
            const element =document.getElementById("files").click();
        }

        async getThemes(): Promise<void> {
            let rep = null;
            await myAPI.get("themes/")
            .then(function(response) {
                rep = response.data;
            });
            if (rep) {
                this.reports = rep;
                console.log(rep);
            }
        }


        async checkAdmin(): Promise<void> {
            let rep = null;
            await myAPI.get("users/me/profile")
            .then(function(response) {
                rep = response.data;
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
    .chooseFile {
        transition:0.2s;
        border-radius: 6px;
        border: none;
        width:200px;
        background-color: #1965FF;
        color: white;
        padding: 12px 30px 12px 30px;
        margin-top: 50px;
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
        padding-left: 35px;
        width: 300px;
        margin-top: 15px;
        border-radius: 5px;
        outline:none;
    }
</style>
