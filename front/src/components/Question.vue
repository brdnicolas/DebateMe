<template>
    <div class="post">
        <img @click="$router.go(-1)" class="back" alt="back" src="../assets/icon/back.png"/>
        <img class="image_poste" src="../assets/tmp/corona.png"/>
        <div id="banner">
            <h1 class="titre">{{question.title}}</h1>
            <div class="icons">
                <div class="left">
                    <div @click="showDocu"><img src="../assets/icon/book.png"/> Documentation</div>
                    <div><img src="../assets/icon/comment.png"/> 532</div>
                    <div><img src="../assets/icon/share.png"/> Share</div>
                </div>
                <div class="right">
                    <p>Créé le {{this.date}}</p>
                </div>
            </div>
        </div>


        <div id="writecomment" class="writecomment">
            <p class="errorPostComment">{{this.errorPostComment}}</p>
            <textarea
                    id="message"
                    placeholder="Écrivez votre plus beau commentaire !"
            />
            <div class="bottom">
                <button @click="postComment($event)">Poster</button>
                <div>
                    <p>Anonyme</p>
                    <switch-component :switch-value="switchValue" @switchValueChanged="switchValue = !switchValue"/>
                </div>
            </div>
        </div>

        <div class="listComments">
            <commentaire v-on:refresh="getComments" v-for="item in this.posts" :votes="item.votes_id" :questionID="question.id" :commentaire="item.post"  :key="item.id" :user="item.user"/>
        </div>
        <div id="bottom"/>
        <footerComponent/>

    </div>
</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import commentaire from '@/components/mini-components/commentaire.vue'
    import axios, {AxiosError} from "axios";
    import switchComponent from "@/components/mini-components/switch.vue";
    @Component({
        components: {
            headerComponent,
            footerComponent,
            commentaire,
            switchComponent,
        },
    })
    export default class Question extends Vue {
        posts: object;
        question: object;
        date: string;
        switchValue: boolean;
        user: object;
        votesID: number;
        errorPostComment: string;

        constructor() {
            super();
            this.posts = [];
            this.question = {};
            this.date = "";
            this.switchValue = false;
            this.user = {};
            this.votesID = 0;
            this.errorPostComment = "";
        }

        created() {
            window.addEventListener('scroll', this.handleScroll);
        }
        destroyed () {
            window.removeEventListener('scroll', this.handleScroll);
        }

        handleScroll(): void {
            const banner = document.getElementById("banner");
            const padding = document.getElementById("writecomment");
            if (banner) {
                const h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
                if (window.pageYOffset > 40 * h / 100 && padding) {
                    banner.className = "sticky";
                    const px = (banner.offsetHeight + 3).toString() + "px";
                    padding.style.paddingTop = px;
                } if(window.pageYOffset <= 40 * h / 100 && padding) {
                    banner.className = "nique";
                    padding.style.paddingTop = "0px";
                }
            }
        }

        mounted() {
            this.getComments();
            this.getQuestion();
            this.checkToken();
        }

        checkToken(): void {
            if(localStorage.token === "") {
                window.location.href = '/';
            }
        }

        async postComment(): Promise<void> {
            let rep = false;
            const content = (document.getElementById("message") as HTMLInputElement);
            if(content.value.length < 50) {
                this.errorPostComment = "Veuillez écrire un texte de plus 50 charactères ..";
                return;
            }
            this.errorPostComment = "";
            let listTermes: Record<string, any> = [];
            let error = "";
            await axios.post("https://api.hugovast.tech/posts",{
                content: content.value,
                'question_id' : this.$route.params.idQuestion,
                'isAnonym':this.switchValue
            },{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = true;
                console.log(response.data[0]);
                listTermes = response.data;
                if(response.status == 206)
                    error = "Veuillez éviter les insultes, les termes comme : ";
            }).catch((err) => {
                console.log("error");
            });
            const termesMauvais: any[] = [];
            (listTermes as Record<string,any>).map(function(value: any, key: any) {
                if (!termesMauvais.includes(value.Term)) {
                    error = error + value.Term + ", ";
                    termesMauvais.push(value.Term);
                }
            });
            error = error + "sont à éviter..";
            this.errorPostComment = error;
            if(rep) {
                this.switchValue = false;
                const element = document.getElementById("message") as  HTMLInputElement;
                if(element && error == "") {
                    element.value = "";
                }
            }
            this.getComments();
        }

        showDocu(): void {
            this.$alert((this.question as Record<string, any>).documentation);
        }

        async getComments(): Promise<void> {
            //let rep = null;
            let posts = [null];

            await axios.get("https://api.hugovast.tech/questions/" + this.$route.params.idQuestion + "/posts", {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                posts = response.data;
            });
            if (posts) {
                this.posts = posts;
            }
        }
        async getQuestion(): Promise<void> {
            let rep = null;
            let date = "";
            await axios.get("https://api.hugovast.tech/themes/" + this.$route.params.idTheme + "/questions/" + this.$route.params.idQuestion, {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = response.data;
                date = response.data.created_at;
            });
            if (rep && date) {
                this.question = rep;
                this.date = date.slice(0,10)
            }
        }
    }
</script>

<style scoped>
    .errorPostComment {
        color:#FF8F86;
        padding-bottom:10px;
    }
    #banner {
        background:white;
    }
    .sticky {
        position: fixed;
        top: 0;
        width: 100vw;
    }
    .back {
        transition:0.5s;
        position: absolute;
        top: 0;
        left:0;
        margin:30px;
        width:20px;
        height:20px;
        object-fit: contain;
        background:whitesmoke;
        padding:10px;
        border-radius:20px;
        -webkit-box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
        -moz-box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
        box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
        cursor:pointer;
    }

    .back:hover {
        transition:0.5s;
        -webkit-box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
        -moz-box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
        box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
    }

    .listComments {
        padding-bottom:50px;
    }
    .bottom div {
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .bottom div p {
        margin-right:10px;
        color:#1864ff;
        font-weight: 600;
    }
    .bottom {
        display:flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }
    .writecomment {
        width:80vw;
        margin-left:10vw;
        margin-top:50px;
        padding-bottom:40px;
    }
    .writecomment textarea {
        width:100%;
        border: 2px solid #EFEFEF;
        box-sizing: border-box;
        border-radius: 5px;
        padding:10px;
        height:200px;
        resize:none;
        font-weight: 800;
    }
    .writecomment button {
        width: 200px;
        height:40px;
        background: #1864FF;
        border-radius: 5px;
        margin-top:10px;
        border:none;
        cursor:pointer;
        color: #F7F9FF;
        font-weight: 500;
        font-size: 18px;
        text-transform: uppercase;
    }
    .post .image_poste {
        width:100vw;
        height:40vh;
        object-fit: cover;
    }
    .right p {
        color:#A2C1FF;
        font-style: italic;
        font-size:18px;
    }
    .left, .right {
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .left div:first-child {
        cursor: pointer;
    }
    .right {
        margin-right:60px;
    }
    .post .titre {
        font-weight: 500;
        font-size: 36px;
        color: #185BAB;
        margin:30px;
        padding-right:30px;
    }
    .post .icons {
        display:flex;
        flex-direction: row;
        font-size:20px;
        color:#1864ff;
        font-weight:500;
        justify-content: space-between;
        -webkit-box-shadow: 0px 9px 8px -5px rgba(168,168,168,1);
        -moz-box-shadow: 0px 9px 8px -5px rgba(168,168,168,1);
        box-shadow: 0px 9px 8px -5px rgba(168,168,168,1);
        padding-bottom:20px;
    }
    .post .icons div {
        margin-left:17px;
    }
    .post .icons img {
        width:15px;
        height:15px;
    }
</style>