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

    @Component({
        components: {
            // Importation du menu, du header & du graphique
            Header,
            LineChart,
            Menu
        },
    })

    export default class HelloWorld extends Vue {

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.checkAdmin();
            this.fillData();
        }

        // Données du graphique
        datacollection: object;

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
            super();
            this.datacollection = [null];
        }

        // Remplissage des données
        fillData(): void {
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

        // On vérifie que l'user est admin
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

<style scoped src="../../css/admin/Admin.css"/>
