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
    import myAPI from "@/components/myAPI";
    import moment from 'moment'
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
            let rep = null;

            await myAPI.get("themes/" + this.theme_id + "/questions/" + this.question_id).then((response) =>  {
                rep = response.data;
            });

            if (rep)
                this.question = rep;
        }


    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .title {
        margin:15px;
        color:#185bab;
        font-size:22px;
        font-weight: bolder;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 97%;
    }
    .content div h1 {
        font-size:16px;
        font-weight: 500;
        color:black;
        font-style: italic;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 97%;
    }
    .content > div {
        width:100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .text {
        margin-left:10px;
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .commentaire img {
        width:18px !important;
        height:18px !important;
    }
    .commentaire-comment img {
        width:15px;
        margin-top:30px;
    }
    .time-comment, .commentaire-comment{
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .time-comment p, .commentaire-comment p {
        margin-top:30px;
        margin-left:5px;
        padding-right:10px;
    }
    .time-comment img {
        width:15px;
        height:15px;
        margin-left:10px;
        margin-top:30px;
    }
    .bottom {
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        width:100%;
        color:black;
        margin-bottom: 6px;
    }
    .content {
        width:100%;
        height:130px;
        background:white;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.25);
        border-radius: 6px;
        display:flex;
        flex-direction: row;
        margin-top:25px;
    }

</style>
