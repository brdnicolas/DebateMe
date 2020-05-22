<template>
    <div>
        <header-component/>
        <div class="top-profil">
            <img src="../assets/tmp/couverture.png"/>
            <div class="photo-profil">
                <img src="../assets/tmp/profil.jpg"/>
                <h1>{{$route.params.name}}</h1>
            </div>
            <div class="profil-info">
                <div>
                    <h3>Abonnés</h3>
                    <p>53</p>
                </div>
                <div>
                    <h3>Likes</h3>
                    <p>568</p>
                </div>
                <div>
                    <h3>Abonnements</h3>
                    <p>2</p>
                </div>
            </div>
        </div>
        <div class="profil-citation">
            <img class="quoteleft" src="../assets/icon/quote_left.png"/>
            <p>La citation la plus longue sur « putes » est : « Putain même crier, j'arrive plus. J'en ai marre, j'en peux plus, j'étouffe. J'me sens étriquée dans ce monde. C'est pas possible c'qu'on nous balance en pleine face tous les jours.</p>
            <img class="quoteright" src="../assets/icon/quote_right.png"/>
        </div>
        <div class="liste-badge">
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
            <img title="badge de la gentillesse" alt="badge de la gentillesse" src="../assets/tmp/badge.png"/>
        </div>
        <div class="activite">
            <div class="choice-categorie">
                <p id="postes" @click="goToPostes">Postes</p>
                <p>|</p>
                <p id="activité" @click="goToActivities">Activités</p>
            </div>
            <div v-if="showPostes === true" class="liste">
                <activite-poste/>
                <activite-poste/>
                <activite-poste/>
            </div>
            <div v-else class="liste">
                <activite-commentaire/>
                <activite-commentaire/>
                <activite-commentaire/>
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

        constructor() {
            super();
            this.showPostes= true;
        }
        goToActivities(): void {
            this.showPostes = false;
            const element = document.getElementById("activité");
            const element2 = document.getElementById("postes");
            if (element != null && element2 != null) {
                element.style.color = "#1469ff";
                element2.style.color = "#9eb9ea";
            }
        }
        goToPostes(): void {
            this.showPostes = true;
            const element = document.getElementById("activité");
            const element2 = document.getElementById("postes");
            if (element != null && element2 != null) {
                element.style.color = "#9eb9ea";
                element2.style.color = "#1469ff";
            }
        }
        mounted() {
            this.goToPostes();
        }


    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
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
        font-size:25px;
        margin-right:15px;
        margin-left:15px;
    }
    .choice-categorie p:nth-child(1), .choice-categorie p:nth-child(3) {
        cursor: pointer;
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
    }
    .quoteleft {
        width:100px;
        opacity: 40%;
        padding-bottom:60px;
    }
    .quoteright {
        width:100px;
        opacity: 40%;
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
