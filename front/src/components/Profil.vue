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
            <p v-if="this.user.achievements.length === 0">Aucune récompenses pour le moment..</p>
            <img v-for="item in this.user.achievements" :key="item.id" v-bind:src="item.logo" v-bind:title="item.name" />
        </div>
        <div class="activite">
            <div class="choice-categorie">
                <p id="activité"><span v-if="this.user.posts.length === 0">Aucune </span>Activité</p>
            </div>
            <div class="liste">
                <activiteCommentaire v-for="item2 in this.user.posts" :key="item2.id" :theme_id="item2.theme_id" :date="item2.updated_at" :question_id="item2.question_id" :message="item2.content" :up="item2.up" :picture="user.profile_pic"/>
            </div>
        </div>
        <footer-component/>
    </div>

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/mini-components/header.vue";
    import footerComponent from "@/components/mini-components/footer.vue";
    import activitePoste from "@/components/mini-components/activitePoste.vue"
    import activiteCommentaire from "@/components/mini-components/activiteCommentaire.vue"
    import myAPI from "@/components/myAPI";


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

        constructor() {
            super();
            this.user = [null];
            this.showPostes= true;
            this.profilPic = "";
            this.bannerPic = "";
        }

        mounted() {
            this.getCurrentUser();
        }

        async getCurrentUser(): Promise<void> {
            const profilToFind = document.URL.split("/")[4];
            let rep = null;
            await myAPI.get("users/search/" + profilToFind).then((response: { data: any}) =>  {
                rep = response.data;
            }).catch(error => {
                this.$router.go(-1)
            });
            if (rep && (rep as Record<string,any>).length > 0)
                this.userFound((rep[0] as Record<string,any>).id);
        }

        async userFound(userId: number): Promise<void> {
            let rep = null;
            await myAPI.get("users/" + userId).then((response: { data: any}) =>  {
                rep = response.data;
            }).catch(error => {
                //this.$router.go(-1)
                console.log(error);
            });
            if (rep) {
                this.user = rep;
                this.profilPic = (rep as Record<string,any>).img.profile_picture;
                this.bannerPic = (rep as Record<string,any>).img.banner;
            }
        }

    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
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
