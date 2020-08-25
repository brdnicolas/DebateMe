<template>
    <div>
        <header-component/>
        <div class="top-profil">
            <img v-if="this.bannerPic" v-bind:src="this.user.img.banner"/>
            <img v-else src="../assets/tmp/couverture.png"/>
            <div class="photo-profil">
                <img class="profil_pic" v-if="this.profilPic" v-bind:src="this.user.img.profile_picture"/>
                <img class="profil_pic" v-else src="../assets/img/profile.png"/>
                <h1>{{this.user.username}}</h1>
            </div>
            <div class="profil-info">
                <div>
                    <h3>Abonnés</h3>
                    <p>0</p>
                </div>
                <div>
                    <h3>Likes</h3>
                    <p>0</p>
                </div>
                <div>
                    <h3>Abonnements</h3>
                    <p>0</p>
                </div>
            </div>
        </div>
        <div class="profil-citation">
            <img class="quoteleft" src="../assets/icon/quote_left.png"/>
            <p v-if="this.user.quote">{{this.user.quote}}</p>
            <p v-else>En panne d'inspiration ? Créez votre propre citation</p>
            <img class="quoteright" src="../assets/icon/quote_right.png"/>
        </div>
        <div class="liste-badge">
            <p v-if="this.achivments.length === 0">Aucune récompenses pour le moment..</p>
            <img v-for="item in this.user.achievements" :key="item.id" v-bind:src="item.logo" v-bind:title="item.name" />
        </div>
        <div class="activite">
            <div class="choice-categorie">
                <p id="activité"><span v-if="this.posts.length === 0">Aucune </span>Activité</p>
            </div>
            <div class="liste">
                <activiteCommentaire v-for="item2 in this.user.posts" :key="item2.id" :theme_id="item2.theme_id" :date="item2.updated_at" :question_id="item2.question_id" :message="item2.content" :up="item2.up" :picture="user.profile_pic"/>
            </div>
        </div>
        <footer-component/>
    </div>

</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/mini-components/header.vue";
    import footerComponent from "@/components/mini-components/footer.vue";
    import activiteCommentaire from "@/components/mini-components/activiteCommentaire.vue"
    import DAO from "@/DAO";

    @Component({
        components: {
            // importation des composants suivants : header, footer, liste des commentaires du user
            headerComponent,
            footerComponent,
            activiteCommentaire,
        },
    })

    export default class HelloWorld extends Vue {

        // Les informations relatives à l'utilisateur
        user: object;

        // Image de profile
        profilPic: string;

        // Bannière
        bannerPic: string;

        // Liste des badges de l'utilisateur
        achivments: Array<string>;

        // Liste des commentaires de l'utilisateur
        posts: object;

        // Le DAO
        api = new DAO();

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
            super();
            this.user = [null];
            this.profilPic = "";
            this.bannerPic = "";
            this.achivments = [""];
            this.posts = [""];
        }

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.getCurrentUser();
        }

        // Fonction qui fait un appel à l'api afin de récupérer les informations de l'uilisateur
        async getCurrentUser(): Promise<void> {

            // Récupération dans l'url, le nom du user
            const profilToFind = document.URL.split("/")[4];

            // Requete axios avec le nom d'utilisateur permettant de récupérer son id
            this.api.getUserByName(profilToFind).then(data => {
                if ( data && (data as Record<string, any>).length > 0)
                    this.userFound((data[0] as Record<string, any>).id);
            })
            // Si erreur, on retourne en arrière
            .catch(error => {
                this.$router.go(-1)
            })
        }

        // Recherche de l'utilisateur via son ID
        async userFound(userId: number): Promise<void> {
            this.api.getUserByID(userId).then(data => {
                this.user = data;
                this.profilPic = (data as Record<string,any>).img.profile_picture;
                this.bannerPic =  (data as Record<string,any>).img.banner;
                this.achivments =  (data as Record<string,any>).achievements;
                this.posts =  (data as Record<string,any>).posts;
            })
        }

    }
</script>

<style scoped src="../css/Profil.css"/>
