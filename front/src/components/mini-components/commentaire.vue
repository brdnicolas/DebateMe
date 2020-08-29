
<template>
    <div class="comment">
        <div class="top">
            <div class="left">
                <img @click="showProfil(user.username)" v-if="!commentaire.isAnonym && user.img.profile_picture" :alt="user.username" v-bind:src="this.user.img.profile_picture"/>
                <img @click="showProfil(user.username)" v-if="!commentaire.isAnonym && !user.img.profile_picture" :alt="user.username" src="../../assets/img/profile.png"/>
                <div v-if="!commentaire.isAnonym">
                    <div v-if="this.user.isPremium" style="margin-left:20px;display: flex;flex-direction: row;justify-content: center">
                        <img style="width:20px;height:20px" src="../../assets/icon/Star.png"/>
                        <h3>{{this.user.username}}</h3>
                    </div>
                    <h3 @click="showProfil(user.username)" class="username" v-else>{{this.user.username}}</h3>
                    <p class="citation">{{user.quote}}</p>
                </div>
                <img v-if="commentaire.isAnonym" :alt="user.username" src="../../assets/img/anonymous.png"/>
                <div v-if="commentaire.isAnonym">
                    <h3 class="username">Anonyme</h3>
                    <p class="citation">La célébrité n'est pas facile à assumer, je ne vois rien de pire, si peut-être, l'anonymat.</p>
                </div>
            </div>
            <div class="right">
                <img @click="sendReport" id="report" title="signaler" alt="signaler" src="../../assets/icon/report.png"/>
            </div>
        </div>
        <p class="date darkmode-ignore">{{this.date}}</p>
        <p class="message">{{commentaire.content}}</p>
        <div class="bottom">
            <div class="upvote">
                <img src="../../assets/icon/upvote.png"/>
                <h2 class="darkmode-ignore" @click="upVote" >Upvoted</h2>
              <p><span class="darkmode-ignore">{{commentaire.up}}</span></p>
            </div>
            <div>
                <img src="../../assets/icon/comment.png"/>
                <h2 class="darkmode-ignore">Comments</h2>
              <p><span class="darkmode-ignore">{{commentaire.down}}</span></p>
            </div>
            <div>
                <img src="../../assets/icon/share.png"/>
                <h2 class="darkmode-ignore">Share</h2>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    // @ts-nocheck
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import moment from 'moment'
    import Swal from 'sweetalert2/dist/sweetalert2.js'
    import DAO from "@/DAO";

    @Component
    export default class Header extends Vue {

        // Récupération des variables parentes
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

        // Date que l'on va passer au paquet moment
        date: string;

        // Si l'user à voté ou non
        voted: boolean;

        // User actuellement connécté
        currentUser: object;

        // DAO
        api = new DAO();

        // On associe à chaque varialbe une valeur par défaut.
        constructor() {
            super();
            this.date = "";
            this.voted = false;
            this.currentUser = {};
        }

        // Afficher le profil d'un utilisateur
        showProfil(username: string): void {
            window.location.href = "/profil/" + username;
        }

        // Fonction qui se lance avant le rendu d'un composant
        created(): void {
            moment.locale('fr');
            if (this.commentaire)
                this.date = moment((this.commentaire as Record<string, any>).created_at).fromNow()
        }

        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.getCurrentUser();
            console.log(this.commentaire)
        }

        // Fonction permetter de report quelqu'un
        async sendReport(): Promise<void> {

            // Style de la pop up
            this.$fire({
                title: "Choisissez la raison de votre signalement",
                showCancelButton: true,
                html:
                    '<div class="test" style="text-align:left">' +
                    '<div><input type="radio" id="choose" name="reportCause" value="aucune" checked>' +
                    '<label style="margin-left:10px;" for="choose">Aucune</label></div>' +
                    '<div><input type="radio" id="injure" name="reportCause" value="1">' +
                    "<label style='margin-left:10px;' for='injure'>Injures</label></div>" +

                    '<div><input type="radio" id="place" name="reportCause" value="2">' +
                    "<label style='margin-left:10px;' for='place'>Contenu innaproprié</label></div>" +

                    '<div><input type="radio" id="sexisme" name="reportCause" value="5">' +
                    "<label style='margin-left:10px;' for='sexisme'>Sexisme</label></div>" +

                    '<div><input type="radio" id="racisme" name="reportCause" value="4">' +
                    '<label style="margin-left:10px;" for="racisme">Racisme</label></div>' +

                    '<div><input type="radio" id="formulation" name="reportCause" value="3">' +
                    '<label style="margin-left:10px;" for="formulation">Formulation</label></div>' +

                    '</div>' +
                    '<h3 style="text-align:left;margin-top:20px">Voulez-vous préciser ?</h3>' +
                    '<textarea style="resize:none;height:100px;padding-top:10px;" id="swal-textarea1" class="swal2-input">',
                type: "warning",
                // eslint-disable-next-line @typescript-eslint/no-unused-vars
            }).then(r => {
                const radios = document.getElementsByName('reportCause');
                let type = 0;
                for (let i = 0, length = radios.length; i < length; i++) {
                    if (radios[i].checked) {
                        type = radios[i].value;
                        break;
                    }
                }
                let message = document.getElementById("swal-textarea1").value;
                if(!message)
                    message = null;


                const Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                });

                if( r.dismiss != "cancel" && r.dismiss != "esc" && r.dismiss != "backdrop") {
                    if(type == "aucune") {
                        Toast.fire({
                            icon: 'error',
                            title: "Vous n'avez aucune raison de le signaler."
                        })
                    } else {


                      const data = {
                        'post_id' : this.commentaire.id,
                        'reason_report_id' : type,
                        'message': message
                      }

                      this.api.postReport(data).then(datas => {
                          Toast.fire({
                            icon: 'success',
                            title: 'Nous avons reçu votre signalement !'
                          })
                      }).catch(error => {
                        console.log(error);
                        Toast.fire({
                          icon: 'error',
                          title: "Une erreure s'est produite lors de l'envoie.."
                        })
                      });
                    }
                }
            });
        }

        // Récupération de l'utilisateur actuellement connécté
        async getCurrentUser(): Promise<void> {
            this.api.getCurrentUser().then(datas => {
              this.currentUser = datas;
            })
            .catch(error => {
              this.deconnexion();
            })
            this.voted = !!this.votes?.includes((this.currentUser as Record<string, any>).id);
        }

        // Fonction permettant de upvoter un commentaire
        async upVote(): Promise<void> {
            await this.api.getVotes((this.commentaire as Record<string, any>).id);
            this.voted = !this.voted;
            this.$forceUpdate();
            this.$emit('refresh');
        }
    }

</script>

<style scoped src="../../css/mini-components/commentaire.css"/>
