<template>
    <div>
        <header-component/>
        <div class="top-profil">
            <img v-if="this.bannerPic" v-bind:src="this.user.img.banner"/>
            <img v-else src="../assets/tmp/couverture.png"/>
            <input style="display:none" type="file"
                   id="bannerPicture" name="banner"
                   accept="image/png, image/jpeg"
                    @change="updatePicture">
            <img @click="changeBannerPicture" class="modifyBanner" src="../assets/icon/modify.png"/>
            <div class="photo-profil">
                <input style="display:none" type="file"
                       id="profilePicture" name="profilePicture"
                       accept="image/png, image/jpeg"
                       @change="updatePicture">
                <img @click="changeProfilePicture" class="profil_pic" v-if="this.profilPic" v-bind:src="this.user.img.profile_picture"/>
                <img @click="changeProfilePicture" class="profil_pic" v-else src="../assets/img/profile.png"/>
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
            <p id="citation">
                <span v-if="this.user.quote">
                {{this.user.quote}}
                </span>
                <span v-else>
                    En panne d'inspiration ? Créez votre propre citation
                </span>
            </p>
            <textarea style="display: none" id="modifyQuote" type="text"/>
            <img class="quoteright" src="../assets/icon/quote_right.png"/>
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
                <activiteCommentaire v-for="item2 in this.user.posts" :key="item2.id" :theme_id="item2.theme_id" :date="item2.updated_at" :question_id="item2.question_id" :message="item2.content" :up="item2.up" :picture="user.profile_pic"/>
            </div>
        </div>
        <footer-component/>
    </div>

</template>

<script lang="ts">
    // @ts-nocheck
    import { Component, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/mini-components/header.vue";
    import footerComponent from "@/components/mini-components/footer.vue";
    import activitePoste from "@/components/mini-components/activitePoste.vue"
    import activiteCommentaire from "@/components/mini-components/activiteCommentaire.vue"
    import Swal from 'sweetalert2/dist/sweetalert2.js'
    import DAO from "@/components/DAO"


    @Component({
        components: {
            headerComponent,
            footerComponent,
            activitePoste,
            activiteCommentaire,
        },
    })

    export default class HelloWorld extends Vue {
        showPostes: boolean;
        user: object;
        profilPic: string;
        bannerPic: string;
        achivments: Array<string>;
        posts: object;
        api = new DAO();

        constructor() {
            super();
            this.user = [null];
            this.showPostes= true;
            this.profilPic = "";
            this.bannerPic = "";
            this.achivments = [""];
            this.posts = [""];
        }

        mounted() {
            this.getCurrentUser();
        }

        changeProfilePicture(): void {
            const element = document.getElementById('profilePicture');
            if (element)
                element.click();
        }

        changeBannerPicture(): void {
            const element = document.getElementById('bannerPicture');
            if (element)
                element.click();
        }

        async getCurrentUser(): Promise<void> {
            this.api.getCurrentUser().then(data => {
                this.user = data;
                this.profilPic = (data as Record<string,any>).img.profile_picture;
                this.bannerPic = (data as Record<string,any>).img.banner;
                this.achivments = (data as Record<string,any>).achievements;
                this.posts = (data as Record<string,any>).posts;
            })
            .catch(error => {
                this.deconnexion();
            })
        }

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

        async PATCHQuote(): Promise<void> {
            const newCitation = document.getElementById("modifyQuote");
            let value = "";
            if (newCitation)
                value = (newCitation as HTMLTextAreaElement).value;

            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
            });

            const datas = {
              'quote': value
            }
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

        async updatePicture(): Promise<void> {
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

            this.api.patchChangeProfilPicture((this.user as Record<string,any>).user_id, fd).then(data => {
                location.reload();
            })

        }

        CSSRetablir() {
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

        deconnexion(): void {
            localStorage.token = "";
            sessionStorage.token = "";
            window.location.href = '/';
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    * {
      font-family: 'Roboto', sans-serif !important;
    }
    .modifyBanner {
        z-index:30 !important;
        height:20px !important;
        width:20px !important;
        position:absolute !important;
        right:20px !important;
        top:35px !important;
        padding:10px !important;
        background:white !important;
        border-radius:20px !important;
        cursor: pointer !important;
    }
    .profil_pic {
        cursor:pointer;
    }
    .liste {
        width:50vw;
        margin-left:25vw;
        padding-bottom:50px;
    }
    .choice-categorie {
        display:flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
        width: 100vw;
        padding-bottom:20px;
    }
    .choice-categorie p {
        color:#1469ff;
        font-weight: 500;
        font-size:30px;
        margin-right:15px;
        margin-left:15px;
    }
    .activite {
        display:flex;
        flex-wrap: wrap;
        margin-top:50px;
    }
    .liste-badge {
        width:65vw;
        padding:40px 17.5vw 40px 17.5vw;
        text-align: center;
        margin-top:60px;
        height:auto;
        background-color:#F9F9F9;
    }
    .liste-badge img {
        margin-left:5px;
        margin-right:5px;
        width:60px;
    }
    .quoteleft {
        width:100px;
        padding-bottom:60px;
    }
    .quoteright {
        width:100px;
        padding-top:20px;
    }
    #modifyQuote {
        width:600px;
        max-width: 50vw;
        margin-left:40px;
        margin-right:40px;
        font-size: 24px;
        padding-left:8px;
        padding-right: 8px;
        line-height: 28px;
    }
    .profil-citation > p {
        max-width:50vw;
        font-weight: 300;
        font-size: 24px;
        line-height: 28px;
        padding-left:40px;
        padding-right:40px;
    }
    .profil-citation {
        margin-top:100px;
        width:100vw;
        display:flex;
        justify-content: center;
        align-items: center;
    }
    .profil-info > div {
        display:flex;
        flex-direction: column;
        justify-content: center;
        margin-left:50px;
        margin-right:50px;
        text-align: center;
    }
    .profil-info > div > h3 {
        width:120px;
        font-size:20px;
        color:#1469ff;
    }
    .profil-info > div > p {
        margin-top:5px;
        color:#A7A7A7;
    }
    .profil-info {
        width:100vw;
        display:flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
    .top-profil > img {
        width:100vw;
        height:400px;
        object-fit: cover;
        position:absolute;
        z-index:-1;
        top:0;
        margin-top:60px;
    }
    .top-profil {
        width:500px;
    }
    .photo-profil {
        width:100vw;
        text-align: center;
        margin-top:250px;
    }
    .photo-profil img {
        width:184px;
        height:184px;
        object-fit: cover;
        border-radius: 150px;
        border: 4px solid white;
    }
    .photo-profil h1 {
        margin-top:10px;
        padding-bottom:50px;
    }
</style>
