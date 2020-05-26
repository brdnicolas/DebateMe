<template>
    <div class="post">
        <h1>Question : {{question.title}}</h1>
        <h3>Docu : {{question.documentation}}</h3>
        <h4>Créé le : {{question.created_at.slice(0,10)}}</h4>
        <div v-for="item in this.posts" :key="item.id">
            <p style="color:red;">{{item.username}}</p>
            <p>{{item.content}}</p>
        </div>
        <textarea
                id="message"
                placeholder="Postez votre avis !"
        />
        <button @click="this.postComment">Post</button>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import axios from "axios";
    @Component({
        components: {
            headerComponent,
            footerComponent,
        },
    })
    export default class Question extends Vue {
        posts: object;
        question: object;

        constructor() {
            super();
            this.posts = {};
            this.question = {};
        }
        mounted() {
            this.getComments();
            this.getQuestion();
        }

        async postComment(): Promise<void> {
            console.log("test");
            await axios.post("https://api.hugovast.tech/posts",{
                content: (document.getElementById("message") as HTMLInputElement).value,
                'question_id' : this.$route.params.idQuestion,
            },{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            });
            this.getComments();

        }

        async getComments(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/questions/" + this.$route.params.idQuestion + "/posts", {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = response.data;
            })
                /*.catch(function (error) {
            })*/
            ;
            if (rep)
                this.posts = rep;
        }
        async getQuestion(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/themes/" + this.$route.params.idTheme + "/questions/" + this.$route.params.idQuestion, {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = response.data;
            })
            /*.catch(function (error) {
        })*/
            ;
            if (rep)
                this.question = rep;
        }
    }
</script>

<style scoped>

</style>