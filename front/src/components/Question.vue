<template>
    <div class="post" v-if="localStorage.token">
        <img @click="$router.go(-1)" class="back" alt="back" src="../assets/icon/back.png"/>
        <img v-if="question.image" class="image_poste" v-bind:src="question.image"/>
        <img v-else class="image_poste" src="../assets/img/noImage.png"/>
        <div id="banner">

                <h1 @click="scrollToGoodComment('commentairen3')" class="titre darkmode-ignore">{{question.title}}</h1>

            <div class="icons">

                <div class="left">
                    <div class="darkmode-ignore" @click="showDocu"><img src="../assets/icon/book.png"/> Documentation</div>
                    <div class="darkmode-ignore"><img src="../assets/icon/comment.png"/> 532</div>
                    <div class="sharethis-inline-share-buttons"></div>
                </div>
                <div class="right">
                    <p class="darkmode-ignore">Créé le {{this.date}}</p>
                </div>
            </div>
        </div>
        <div id="writecomment" class="writecomment">
            <p class="errorPostComment darkmode-ignore">{{this.errorPostComment}}</p>
            <textarea
                    id="message"
                    placeholder="Écrivez votre plus beau commentaire !"
            />
            <div class="bottom">
                <button class="darkmode-ignore" @click="postComment($event)">Poster</button>
                <div>
                    <p class="darkmode-ignore">Anonyme</p>
                    <switch-component :switch-value="switchValue" @switchValueChanged="switchValue = !switchValue"/>
                </div>
            </div>
        </div>
        <div class="listComments">
            <commentaire v-on:refresh="getComments" v-for="item in this.posts" v-bind:id="idGenerator(item.post.id)" :votes="item.votes_id" :questionID="question.id" :commentaire="item.post"  :key="item.id" :user="item.user"/>
        </div>
        <div id="bottom"/>
    </div>
</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import commentaire from '@/components/mini-components/commentaire.vue'
    import switchComponent from "@/components/mini-components/switch.vue";
    import DAO from "@/DAO";

    @Component({
      // Components : header, footer & les commentaires
        components: {
            headerComponent,
            commentaire,
            switchComponent,
        },
    })
    export default class Question extends Vue {

        // tous les commentaires
        posts: object;

        // La question du débat
        question: object;

        // La date pour la changer avec moment
        date: string;

        // Le switcher d'anonyme à user
        switchValue: boolean;

        // Récupération des données du user
        user: object;

        // Savoir si il a déjà voté ou non
        votesID: number;

        // Erreur à afficher si il y a un problème
        errorPostComment: string;

        // DAO api
        api = new DAO();

        // Assigniation d'une valeur par défaut
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

        // Fonction s'éxécutant au moment de la création de la vue, avant son montage
        created(): void {
            window.addEventListener('scroll', this.handleScroll);
        }

        // Fonction qui s'execute après le rendu.
        updated(): void {
            const scrollTo = document.URL.split("#")[1];
            console.log(scrollTo);
            this.scrollToGoodComment(scrollTo);
        }

        // Fonction qui permet de généer un id de commentaire
        idGenerator(id: number): string {
            return "commentairen" + id;
        }

        scrollToGoodComment(id: string): void {
            const element = document.getElementById(id);
            console.log(element);
            if(element) {
                const offsets = element.getBoundingClientRect();
                const top = offsets.top;
                const left = offsets.left;
                console.log(element);
                window.scrollTo(left,top - 200)
            }
        }

        // Llors de la déstruction de la vue ( quand on part )
        destroyed(): void {
            window.removeEventListener('scroll', this.handleScroll);
        }

        // Fonction permettant de faire un effet de banderole au scroll
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

        // Lors du montage de la vue ( la fonction s'éxécute en même temps que le rendu se fait )
        mounted(): void {
            // On appelle ces fonctions pour : avoir les commentaires, la question et vérifier si l'utilisateur est connécté.
            this.getComments();
            this.getQuestion();
        }

        // Fonction qui gère l'envoie d'un nouveau commentaire.
        async postComment(): Promise<void> {
            // Récupération de l'élément html du textarea
            const content = (document.getElementById("message") as HTMLInputElement);

            // Si le commentaire fait moins de 50 charactères : refus
            if(content.value.length < 50) {
                this.errorPostComment = "Veuillez écrire un texte de plus 50 charactères ..";
                return;
            }

            // On affiche aucune erreur
            this.errorPostComment = "";

            // Liste des termes injurieux présents dans le commentaire
            // eslint-disable-next-line
            let listTermes: Record<string, any> = [];

            // Boolean si il y a une erreur
            let probleme = false;

            // données à envoyé à l'API
            const datas = {
              content: content.value,
              'question_id' : this.$route.params.idQuestion,
              'isAnonym':this.switchValue
            }

            // Requete axios à l'API via le DAO
            await this.api.postComment(datas).then(data => {
                const response = data as unknown as Record<string, any>;
                listTermes = response.data
                if(response.status == 206) {
                    probleme = true;
                }
            })

            // Si il y a un problème, une erreur s'affiche expliquant pourquoi
            if (probleme) {
                let error = "Les termes comme : ";
                const termesMauvais: any[] = [];
                (listTermes as Record<string,any>).map(function(value: any, key: any) {
                    if (!termesMauvais.includes(value.Term)) {
                        error = error + value.Term + ", ";
                        termesMauvais.push(value.Term);
                    }
                });
                error = error + "sont à éviter..";
                this.errorPostComment = error;
            }

            // Si il n'y a pas de problème, alors on vide le textarea.
            if(listTermes && !probleme) {
                this.switchValue = false;
                const element = document.getElementById("message") as  HTMLInputElement;
                if(element) {
                    element.value = "";
                }
            }

            // On récupère les commentaires pour mettre à jour.
            await this.getComments();
        }

        // Popup pour montrer la documentation de la question
        showDocu(): void {
            this.$alert((this.question as Record<string, any>).documentation);
        }

        // Fonction permettant de récupérer les commentaires
        async getComments(): Promise<void> {
            this.api.getComments(this.$route.params.idQuestion).then(response => {
                this.posts = response;
            })
        }

        // Fonction permettant de récupérer la question posée.
        async getQuestion(): Promise<void> {
            this.api.getQuestion(this.$route.params.idTheme, this.$route.params.idQuestion).then(response => {
                this.question = response;
                document.title = (response as Record<string,any>).title;
                this.date = (response as Record<string, any>).created_at.slice(0, 10);
            })
        }
    }
</script>

<style scoped src="../css/Question.css"/>
