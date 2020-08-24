<template>
    <div @click="RedirectToQuestion" class="card">
        <img v-if="this.image" v-bind:src="this.image"/>
        <img v-else src="../../assets/img/noImage.png"/>
        <h3 class="darkmode-ignore">{{titre}}</h3>
        <div class="upvote">
            <div class="date-sujet">
                <p class="darkmode-ignore">{{this.fromnow}}</p>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import moment from 'moment'
    @Component
    export default class Header extends Vue {

        // Récupération des variables parents
        @Prop({default: "Attente d'informations"})
        titre: string | undefined;
        @Prop({default: "Attente d'informations"})
        date: string | undefined;
        @Prop({default: 1})
        id: number | undefined;
        @Prop({default: 1})
        themeid: number | undefined;
        @Prop({default: "../../assets/img/noImage.png"})
        image: string | undefined;

        // Ex: Il y a 5min
        fromnow: string;

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
            super();
            this.fromnow = "";
        }

        // Fonction appelée avant le rendu d'un composant
        created(): void {
            moment.locale('fr');
            this.fromnow = moment(this.date).fromNow()
        }

        // Fonction qui redirige une carte vers sa page
        RedirectToQuestion(): void {
            window.location.href = '/theme/' + this.themeid + '/question/' + this.id;
        }
    }
</script>

<style scoped src="../../css/mini-components/card.css"/>
