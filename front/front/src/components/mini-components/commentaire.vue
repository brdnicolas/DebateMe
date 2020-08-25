
<template>
    <div class="comment">
        <div class="top">
            <div class="left">
                <img @click="showProfil(user.username)" v-if="!commentaire.isAnonym && user.img.profile_picture" :alt="user.username" v-bind:src="this.user.img.profile_picture"/>
                <img @click="showProfil(user.username)" v-if="!commentaire.isAnonym && !user.img.profile_picture" :alt="user.username" src="../../assets/img/profile.png"/>
                <div v-if="!commentaire.isAnonym">
                    <h3 @click="showProfil(user.username)" class="username">{{user.username}}</h3>
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
    import DAO from "@/components/DAO";

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
        currentUser: object;
        api = new DAO();

        constructor() {
            super();
            this.date = "";
            this.voted = false;
            this.currentUser = {};
        }

        showProfil(username: string): void {
            window.location.href = "/profil/" + username;
        }

        created() {
            moment.locale('fr');
            if (this.commentaire)
                this.date = moment((this.commentaire as Record<string, any>).created_at).fromNow()
        }

        mounted() {
            this.getCurrentUser();
        }

        async sendReport(): Promise<void> {
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

        async getCurrentUser(): Promise<void> {
            this.api.getCurrentUser().then(datas => {
              this.currentUser = datas;
            })
            .catch(error => {
              this.deconnexion();
            })
            this.voted = !!this.votes?.includes((this.currentUser as Record<string, any>).id);
        }

        async upVote(): Promise<void> {
            await this.api.getVotes((this.commentaire as Record<string, any>).id);
            this.voted = !this.voted;
            this.$forceUpdate();
            this.$emit('refresh');
        }
    }

</script>

<style scoped>
    #report {
        width:20px;
        height:20px;
        border-radius: 0;
    }
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
        cursor:pointer;
    }
    .username {
        font-weight: 500;
        margin-left:10px;
        font-size:20px;
        cursor:pointer;
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
