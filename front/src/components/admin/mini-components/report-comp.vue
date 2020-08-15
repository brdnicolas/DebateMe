<template>
    <div class="report">
        <h2>{{this.typeAfter}}</h2>
        <h4>Poste :</h4>
        <p>{{this.postMessage}}</p>
        <p>{{this.message}}</p>
        <p>{{this.dateAfter}}</p>
    </div>
</template>

<script lang="ts">
    // @ts-nocheck

    import { Component, Prop, Vue } from 'vue-property-decorator';
    import axios from "axios";
    import moment from 'moment'


    @Component({
        components: {
        },
    })

    export default class HelloWorld extends Vue {
        @Prop({default: "Pas de message"})
        message: string | undefined;
        @Prop({default: ""})
        date: string | undefined;
        @Prop({default: "Aucun"})
        type: string | undefined;
        @Prop({default: "0"})
        post_id: number | undefined;

        dateAfter: string;
        typeAfter: string;
        postMessage: string;

        constructor() {
            super();
            this.dateAfter = "";
            this.typeAfter = "";
            this.postMessage = "Introuvable..";
        }

        created() {
            moment.locale('fr');
            if (this.date)
                this.dateAfter = moment(this.date).fromNow();
            this.getType();
            this.getPostMessage(this.post_id);
        }

        async getType(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/reports_reasons",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
            });
            if (rep) {
                rep.forEach(element => {
                    if(element.id == this.type)
                        this.typeAfter = element.reason;
                });
            }
        }

        async getPostMessage(postId): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/posts/" + postId,{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
            });
            if (rep) {
                this.postMessage = rep.content;
            }
        }
    }
</script>

<style scoped>
    .report {
        display: flex;
        flex-direction: column;
        cursor:pointer;
        background:white;
        width:50vw;
        padding:15px;
        border-radius: 5px;
        -webkit-box-shadow: 0px 0px 5px 0px rgba(158,158,158,1);
        -moz-box-shadow: 0px 0px 5px 0px rgba(158,158,158,1);
        box-shadow: 0px 0px 5px 0px rgba(158,158,158,1);
        margin-top:30px;
        margin-bottom:30px;
    }
    .report h2 {
        margin-bottom:10px;
    }

    .report > p {
        word-break: break-word;
        max-width: 100%;
        width:100%;
    }

    .report p:nth-child(3) {
        padding-bottom:20px;
        border-bottom: 1px solid #D8D8D8;
    }

    .report > p:last-child {
        font-style: italic;
        color:#C1C1C1;
    }
    .report > p:nth-child(4) {
        margin-top:20px;
        margin-bottom:10px;
    }
</style>
