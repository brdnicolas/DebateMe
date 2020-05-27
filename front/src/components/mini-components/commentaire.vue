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
        <p class="date">{{this.date}}</p>
        <p class="message">{{commentaire.content}}</p>
        <div class="bottom">
            <div class="upvote" :id="'upvote' + this.commentaire.id">
                <img src="../../assets/icon/upvote.png"/>
                <h2 @click="upVote" >Upvoted</h2>
                <p>{{commentaire.up}}</p>
            </div>
            <div class="upvoted" :id="'upvoted' + this.commentaire.id">
                <img src="../../assets/icon/upvoted.png"/>
                <h2 @click="upVote">Upvote</h2>
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
    import moment from 'moment'
    @Component
    export default class Header extends Vue {

        @Prop({default: "Attente d'informations"})
        message: string | undefined;
        @Prop({default:true})
        anonym: boolean | undefined;
        @Prop({default:{}})
        commentaire: object | undefined;
        @Prop({default:1})
        questionID: number | undefined;
        @Prop({default:{}})
        user: object | undefined;
        @Prop({default:[]})
        votes: Array<number> | undefined;

        date: string;
        voted: boolean;


        constructor() {
            super();
            this.date = "";
            this.voted = false;
        }

        created() {
            moment.locale('fr');
            if (this.commentaire)
                this.date = moment((this.commentaire as Record<string, any>).created_at).fromNow()
        }

        mounted() {
            console.log(this.votes);
            if(this.votes?.includes((this.user as Record<string,any>).id)) {
                this.voted = true;
            } else {
                this.voted = false;
            }
            this.updateVoteCSS();
        }

        // PAS QUESTION MAIS LE COMMENTAIR ID PLUTOT. DONC ENLEVER LE PROPS QUESTION ID DES DEUX COTES STP

        async upVote(): Promise<void> {
            await axios.get("https://api.hugovast.tech/posts/" + (this.commentaire as Record<string, any>).id + "/vote",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            });
            this.$emit('refresh');

            this.voted = !this.voted;
            this.updateVoteCSS();
        }

        // PROBLEME : LES UPVOTES JE SAIS PAS COMMENT LES UPDATES CAR CA SE TROUVE DE L'AUTRE COTE DU PROPS.

        updateVoteCSS(): void {
            if(this.voted) {
                const upvote = document.getElementById("upvote" + (this.commentaire as Record<string,any>).id);
                const upvoted = document.getElementById("upvoted" + (this.commentaire as Record<string,any>).id);
                if (upvote && upvoted) {
                    upvoted.style.display = "none";
                    upvote.style.display = "flex";
                }
            } else {
                const upvote = document.getElementById("upvote" + (this.commentaire as Record<string,any>).id);
                const upvoted = document.getElementById("upvoted" + (this.commentaire as Record<string,any>).id);
                if (upvote && upvoted) {
                    upvoted.style.display = "flex";
                    upvote.style.display = "none";
                }
            }
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
    .upvoted h2 {
        color:#a7a7a7;
    }
    .upvote h2 {
        color: #1864ff;
    }
</style>
