<template>
    <div @click="RedirectToQuestion" class="card">
        <img v-if="this.image" v-bind:src="this.image"/>
        <img v-else src="../../assets/img/noImage.png"/>
        <h3>{{titre}}</h3>
        <div class="upvote">
            <div class="date-sujet">
                <p>{{this.fromnow}}</p>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import moment from 'moment'
    @Component
    export default class Header extends Vue {
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

        fromnow: string;
        constructor() {
            super();
            this.fromnow = "";
        }

        created() {
            moment.locale('fr');
            this.fromnow = moment(this.date).fromNow()
        }
        RedirectToQuestion(): void {
            window.location.href = '/theme/' + this.themeid + '/question/' + this.id;
        }
    }
</script>

<style scoped>
    .date-sujet p {
        margin-left:10px;
        color:#749cd7;
    }
    .card {
        width:420px;
        height:250px;
        overflow: hidden;
        border-radius: 6px;
        box-shadow: 0px 0px 25px rgba(0, 0, 0, 0.15);
        background: white;
        margin:50px 100px 50px 0;
        cursor:pointer;
    }
    .card h3 {
        padding:5px 10px 10px 10px;
        white-space: nowrap;
        overflow: hidden;
        color:#175bab;
        text-overflow: ellipsis;
        max-width: 500px;
    }
    .card .upvote {
        display:flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }
    .card .upvote div {
        display:flex;
        flex-direction: row;
        align-items: center;
        padding-right: 10px;
    }
    .card .upvote img {
        width:12px;
        height:12px;
    }
    .card .upvote p {
        font-size:14px;
        padding-top:2px;
        font-weight: bold;
        color:#749cd7;
        padding-right: 2px;
    }
    .card img {
        width:100%;
        height:180px;
        object-fit: cover;
        border-radius: 6px 6px 0 0;
    }
</style>
