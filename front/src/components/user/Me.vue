<template>
    <div v-if="checkToken">
        <header-component/>
        <div class="top-profil">
            <img v-if="this.bannerPic" v-bind:src="this.user.img.banner"/>
            <img v-else src="../../assets/tmp/couverture.png"/>
            <input style="display:none" type="file"
                   id="bannerPicture" name="banner"
                   accept="image/png, image/jpeg"
                    @change="updatePicture">
            <img @click="changeBannerPicture" class="modifyBanner" src="../../assets/icon/modify.png"/>
            <div class="photo-profil">
                <input style="display:none" type="file"
                       id="profilePicture" name="profilePicture"
                       accept="image/png, image/jpeg"
                       @change="updatePicture">
                <img @click="changeProfilePicture" class="profil_pic" v-if="this.profilPic" v-bind:src="this.user.img.profile_picture"/>
                <img @click="changeProfilePicture" class="profil_pic" v-else src="../../assets/img/profile.png"/>
                <div v-if="this.user.isPremium" style="margin-left:20px;display: flex;flex-direction: row;justify-content: center">
                  <h1>{{this.user.username}}</h1>
                  <img style="width:20px;height:20px" src="../../assets/icon/Star.png"/>
                </div>
                <h1 v-else>{{this.user.username}}</h1>
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
            <img class="quoteleft" src="../../assets/icon/quote_left.png"/>
            <p id="citation">
                <span v-if="this.user.quote">
                {{this.user.quote}}
                </span>
                <span v-else>
                    En panne d'inspiration ? Créez votre propre citation
                </span>
            </p>
            <textarea style="display: none" id="modifyQuote" type="text"/>
            <img class="quoteright" src="../../assets/icon/quote_right.png"/>
        </div>
        <div style="display:flex;flex-direction: row;justify-content: center">
            <p @click="CSSModifyQuote" id="modifyBtn" style="text-align: center;color:#C1C1C1;text-decoration: underline;cursor:pointer">Modifier la citation</p>
            <p @click="PATCHQuote" id="validerBtn" style="display:none;margin-left:5px;margin-right:5px;text-align: center;color:#80DF96;text-decoration: underline;cursor:pointer">Valider</p>
            <p @click="CSSRetablir" id="annulerBtn" style="display:none;margin-left:5px;margin-right:5px;text-align: center;color:#EE6262;text-decoration: underline;cursor:pointer" >Annuler</p>
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
                <activiteCommentaire v-for="item2 in this.user.posts" :key="item2.id" :id="item2.id" :theme_id="item2.theme_id" :date="item2.updated_at" :question_id="item2.question_id" :message="item2.content" :up="item2.up" :picture="user.profile_pic"/>
            </div>
        </div>
        <footer-component/>
    </div>

</template>

<script lang="ts">
    // @ts-nocheck
    import { Component, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/user/mini-components/header.vue";
    import footerComponent from "@/components/user/mini-components/footer.vue";
    import activiteCommentaire from "@/components/user/mini-components/activiteCommentaire.vue"
    import Swal from 'sweetalert2/dist/sweetalert2.js'
    import DAO from "@/DAO"

    // Importation des composants : header, footer, commentaires
    @Component({
        components: {
            headerComponent,
            footerComponent,
            activiteCommentaire,
        },
    })

    export default class HelloWorld extends Vue {

        // Informations de l'utilisateur
        user: object;

        // Image de profil
        profilPic: string;

        // Bannière
        bannerPic: string;

        // Liste des badges
        achivments: Array<string>;

        // Liste des commentaires
        posts: object;

        // DAO
        api = new DAO();

        // On assigne une valeur par défaut à chaque variable
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

        // Fonction permettant de vérifier que l'utilisateur est connécté.
        checkToken(): boolean {
          return !!localStorage.token;
        }

        // Fonction permettant de choisir un fichier lors du clique sur l'image de profil
        changeProfilePicture(): void {
            const element = document.getElementById('profilePicture');
            if (element)
                element.click();
        }

      // Fonction permettant de choisir un fichier lors du clique sur la bannière
        changeBannerPicture(): void {
            const element = document.getElementById('bannerPicture');
            if (element)
                element.click();
        }

        // Fonction permettant de récupérer des informations sur l'utilisateur actuellement connécté.
        async getCurrentUser(): Promise<void> {
            this.api.getCurrentUser().then(data => {
                this.user = data;
                this.profilPic = (data as Record<string,any>).img.profile_picture;
                this.bannerPic = (data as Record<string,any>).img.banner;
                this.achivments = (data as Record<string,any>).achievements;
                this.posts = (data as Record<string,any>).posts;
                console.log(this.user.posts)
            })
            .catch(error => {
                this.deconnexion();
            })
        }

        // Fonction permettant de gérer le css lors de la modification de la citation
        CSSModifyQuote(): void {
            console.log("nice");
            const citation = document.getElementById("citation");
            const areaCitation = document.getElementById("modifyQuote");
            const btnModify = document.getElementById("modifyBtn");
            const btnValider = document.getElementById("validerBtn");
            const btnAnnuler = document.getElementById("annulerBtn");

            if(citation && areaCitation && btnModify && btnValider && btnAnnuler) {
                console.log("fuck");
                areaCitation.style.display = "block";
                areaCitation.value = this.user.quote ? this.user.quote : "En panne d'inspiration ? Créez votre propre citation";
                citation.style.display = "none";
                btnModify.style.display = "none";
                btnValider.style.display = "block";
                btnAnnuler.style.display = "block";
            }
        }

        // Fonction permettant de changer de citation via un call api
        async PATCHQuote(): Promise<void> {

            // Récupération du textarea
            const newCitation = document.getElementById("modifyQuote");

            // Valeur du textarea
            let value = "";
            if (newCitation)
                value = (newCitation as HTMLTextAreaElement).value;

            // Pop en haut a droite permettant de dire que ça a bien été pris en compte
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
            });

            // donnée envoyée à l'api
            const datas = {
              'quote': value
            }

            // Requete au DAO
            this.api.patchChangeQuote((this.user as Record<string,any>).user_id, datas).then(data => {
              this.CSSRetablir();
              location.reload();
              Toast.fire({
                icon: 'success',
                title: "Citation modifiée."
              });
            })
            .catch(error => {
                console.log(error);
                this.CSSRetablir();
                Toast.fire({
                  icon: 'error',
                  title: "Un problème est survenu."
                })
            })
        }

        // Fonction permettant de changer d'image de profile ou de bannière
        async updatePicture(): Promise<void> {

            // Récupération des images
            const banner = document.getElementById('bannerPicture');
            const profilePicture = document.getElementById('profilePicture');
            const fd = new FormData();
            if (banner.files[0]) {
                fd.append('banner', banner.files[0]);
                banner.value = null;
            }
            if (profilePicture.files[0]) {
                fd.append('profile_picture', profilePicture.files[0]);
                profilePicture.value = null;
            }

            // Requete API pour changer les images.
            this.api.patchChangeProfilPicture((this.user as Record<string,any>).user_id, fd).then(data => {
                location.reload();
            })
        }

        // Fonction permettant de remettre le CSS en ordre pour la citation
        CSSRetablir(): void {
            const citation = document.getElementById("citation");
            const areaCitation = document.getElementById("modifyQuote");
            const btnModify = document.getElementById("modifyBtn");
            const btnValider = document.getElementById("validerBtn");
            const btnAnnuler = document.getElementById("annulerBtn");
            if(citation && areaCitation && btnModify && btnValider && btnAnnuler) {
                areaCitation.style.display = "none";
                citation.style.display = "block";
                btnModify.style.display = "block";
                btnValider.style.display = "none";
                btnAnnuler.style.display = "none";
            }
        }

        // Fonction pour déconnecter l'utilisateur.
        deconnexion(): void {
            localStorage.token = "";
            sessionStorage.token = "";
            window.location.href = '/';
        }
    }
</script>

<style scoped src="../../css/user/Me.css"/>
