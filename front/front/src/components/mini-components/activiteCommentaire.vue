<template>
    <div class="content">
        <div>
            <p class="title">{{this.question.title}}</p>
            <div class="text">
                <p>"</p>
                <h1>{{this.message}}</h1>
                <p>"</p>
            </div>

            <div class="bottom">
                <div class="time-comment">
                    <img src="../../assets/icon/time.png"/>
                    <p>{{this.dateFrom}}</p>
                </div>
                <div class="commentaire-comment">
                    <img src="../../assets/icon/upvote.png"/>
                    <p>{{this.up}}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import moment from 'moment'
    import DAO from "@/DAO";

    @Component
    export default class Header extends Vue {
        @Prop({default: 0})
        up: number | undefined;
        @Prop({default: 0})
        question_id: number | undefined;
        @Prop({default: 0})
        theme_id: number | undefined;
        @Prop({default: ""})
        message: string | undefined;
        @Prop({default: ""})
        picture: string | undefined;
        @Prop({default: ""})
        date: string | undefined;

        question: object;
        dateFrom: string;
        api = new DAO();

        constructor() {
            super();
            this.question = [null];
            this.dateFrom = "";
        }

        mounted() {
            this.getQuestion();
        }

        created() {
            moment.locale('fr');
            if (this.date)
                this.dateFrom = moment(this.date).fromNow()
        }

        async getQuestion(): Promise<void> {
            this.api.getQuestion(this.theme_id, this.question_id).then(datas => {
              this.question = datas;
            })
        }


    }
</script>

<style scoped src="../../css/mini-components/activiteCommentaire.css"/>
