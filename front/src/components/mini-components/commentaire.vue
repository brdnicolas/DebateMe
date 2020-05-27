<template>
    <div class="comment">
        <div class="top">
            <div class="left">
                <img v-if="!commentaire.isAnonym" :alt="user.username" src="../../assets/categories/nature.jpg"/>
                <div v-if="!commentaire.isAnonym">
                    <h3 class="username">{{user.username}}</h3>
                    <p class="citation">Vendeur de tapis</p>
                </div>
                <img v-if="commentaire.isAnonym" :alt="user.username" src="../../assets/img/anonymous.png"/>
                <div v-if="commentaire.isAnonym">
                    <h3 class="username">Anonyme</h3>
                    <p class="citation">La célébrité n'est pas facile à assumer, je ne vois rien de pire, si peut-être, l'anonymat.</p>
                </div>
            </div>
            <div class="right">
                <p>...</p>
            </div>
        </div>
        <p class="date">Posté le 10 juin</p>
        <p class="message">{{commentaire.content}}</p>
        <div class="bottom">
            <div>
                <img src="../../assets/icon/upvote.png"/>
                <h2>Upvote</h2>
                <p>{{commentaire.up}}</p>
            </div>
            <div>
                <img src="../../assets/icon/comment.png"/>
                <h2>Comments</h2>
                <p>{{commentaire.down}}</p>
            </div>
            <div>
                <img src="../../assets/icon/share.png"/>
                <h2>Share</h2>
            </div>
        </div>

    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import axios from "axios";
    @Component
    export default class Header extends Vue {

        @Prop({default: "Attente d'informations"})
        username: string | undefined;
        @Prop({default: "Attente d'informations"})
        message: string | undefined;
        @Prop({default:true})
        anonym: boolean | undefined;
        @Prop({default:{}})
        commentaire: object | undefined;
        user: object;

        constructor() {
            super();
            this.user = {};
        }

        created() {
            this.getUser(this.username);
        }

        async getUser(user: string|undefined): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/users/search/" + user, {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = response.data[0];
            });
            if (rep)
                this.user = rep;
        }
    }
</script>

<style scoped>
    .date {
        font-size:13px;
        color:#749cd7;
        margin-left:20px;
        margin-top:20px;
        font-weight: 500;
    }
    .bottom img {
        width:15px;
        height:15px;
        cursor:pointer;
    }
    .bottom, .bottom div {
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .bottom div {
        margin-right:80px;
    }
    .bottom {
        margin-left:20px;
        margin-top:20px;
        padding-bottom:20px;
    }

    .bottom p {
        margin-left:4px;
        background: #f1f1f1;
        font-size:12px;
        font-weight: 700;
        color:#1864ff;
        padding:5px;
        border-radius: 3px;
        height:15px;
    }

    .bottom h2 {
        font-size:12px;
        color:#1864ff;
        margin-left:2px;
        cursor:pointer;
    }
    .message {
        margin-left:20px;
        margin-top:10px;
        font-weight: 500;
        padding-right:20px;
    }
    .comment {
        width:80vw;
        margin-left:10vw;
        -webkit-box-shadow: 0px 0px 5px 0px rgba(217,217,217,1);
        -moz-box-shadow: 0px 0px 5px 0px rgba(217,217,217,1);
        box-shadow: 0px 0px 5px 0px rgba(217,217,217,1);
        margin-top:20px;
    }

    .top {
        display:flex;
        flex-direction: row;
        padding: 20px 0 0 20px;
        justify-content: space-between;
    }

    .left {
        display:flex;
        flex-direction: row;
    }
    .right {
        padding-right:20px;
        font-weight: 800;
        color:#1864ff;
        cursor:pointer;
    }

    .top img {
        width:60px;
        height:60px;
        object-fit: cover;
        border-radius: 50px;
    }
    .username {
        font-weight: 500;
        margin-left:10px;
        font-size:20px;
    }
    .citation {
        color:#a7a7a7;
        font-size:13px;
        font-weight: 400;
        margin-left:10px;
        margin-top:3px;
    }
</style>
