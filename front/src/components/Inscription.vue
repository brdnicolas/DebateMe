<template>
    <div class="backgroundImage">
        <div class="container">
            <div class="leftSide">
                <div class="logo">
                    <img src="../assets/img/logo.png"/>
                    <p>Debate me</p>
                </div>
                <h1>Bienvenue chez nous !</h1>
                <p>Inscrivez-vous pour ne manquer aucun débat ! Nous savons à quel point donner son avis importe alors n'hésitez pas.</p>
                <p>Oh mais attendez... Vous êtes peut-être déjà inscrit ?</p>
                <input class="textarea2" id="username" type="text" v-model="connexionEmail" placeholder="Email"/>
                <input class="textarea2" id="pass" type="text" v-model="connexionPassword" placeholder="Mot de passe"/>
                <button type="submit" class="connexion"><b>CONNEXION</b></button>
            </div>
            <div class ="rightSide">
                <form>
                    <h1>Créez votre compte</h1>
                    <p style="color:red;margin-bottom:40px;">{{error}}</p>
                    <input class="textarea" id="nom" type="text" v-model="inscriptionLastName" placeholder="Nom"/>
                    <input class="textarea" id="prenom" type="text" v-model="inscriptionFirstName" placeholder="Prénom"/>
                    <input class="textarea" id="email" type="email" v-model="inscriptionEmail" placeholder="Email"/>
                    <input class="textarea" id="pseudo" type="text" v-model="inscriptionPseudo" placeholder="Pseudo"/>
                    <input class="textarea" id="password"   type="password" v-model="inscriptionPassword" placeholder="Mot de passe"/>
                    <input class="textarea" id="Cpassword" type="password" v-model="inscriptionPasswordRe" placeholder="Confirmez votre mot de passe"/>
                    <button type="submit" class="inscription" @click="InscriptionPost($event,inscriptionEmail,inscriptionPassword,inscriptionPasswordRe,inscriptionPseudo,inscriptionFirstName,inscriptionLastName)"><b>INSCRIPTION</b></button>
                </form>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import myAPI from "@/components/myAPI";
    @Component({
        components: {
            headerComponent,
            footerComponent,
        },
    })
    export default class Inscription extends Vue {
        mounted() {
            this.checkToken();
        }

        connexionEmail: string;
        connexionPassword: string;
        inscriptionEmail: string;
        inscriptionPassword: string;
        inscriptionPasswordRe: string;
        inscriptionPseudo: string;
        inscriptionFirstName: string;
        inscriptionLastName: string;
        error: string;

        constructor() {
            super();
            this.error = "";
            this.connexionEmail = "";
            this.connexionPassword = "";
            this.inscriptionEmail = "";
            this.inscriptionPassword = "";
            this.inscriptionPasswordRe = "";
            this.inscriptionPseudo = "";
            this.inscriptionFirstName = "";
            this.inscriptionLastName = "";
        }

        checkToken(): void {
            if (localStorage.token != "") {
                window.location.href = '/home';
            }
        }
        InscriptionPost(e: Event, email: string,password: string, repassword: string, username: string, firstname: string, lastname: string): void {
            e.preventDefault();
            if (password !== repassword) {
                this.error = "Les mots de passe ne sont pas identiques.";
                return;
            }
            if (!email || !password || !repassword || !username || !firstname || !lastname ) {
                this.error = "Vous avez oublier quelque chose là ..";
                return;
            }

            const regexEmail = '[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}'
            if (email.search(regexEmail) < 0) {
              this.error = "Veuillez entrer une adresse email valide."
              return;
            }

            myAPI.post("auth/register", {
                email: email,
                password: password,
                username: username,
                firstname: firstname,
                lastname: lastname,
                // eslint-disable-next-line @typescript-eslint/camelcase
                password_confirmation: repassword,
            }).then((response: { data: any}) =>  {
                localStorage.token = response.data.auth_token;
                window.location.href = '/home';
            } )
                .catch(error => {
                    this.error = "Une erreur s'est produite."
                });
        }
    }
</script>

<style scoped>
    .backgroundImage {
        background-image: url('../assets/img/background.png');
        background-repeat:no-repeat;
        background-size:cover;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        width:100vw;
    }
    .container {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        width: 1000px;
        height: 700px;
        background-color: #1965FF;
        border-radius: 10px 10px;
        -webkit-box-shadow: 0px 0px 5px 0px rgba(138,138,138,1);
        -moz-box-shadow: 0px 0px 5px 0px rgba(138,138,138,1);
        box-shadow: 0px 0px 5px 0px rgba(138,138,138,1);
    }
    .leftSide {
        display: flex;
        flex-direction: column;
        width:360px;
        padding-left:20px;
        padding-right:20px;
        align-items: center;
        overflow: hidden;
        border-radius: 10px 0px 0px 10px;
        color: white;
    }
    .logo {
        display: flex;
        flex-direction: row;
    }
    .logo img {
        width: 35px;
        height:35px;
    }
    .rightSide {
        flex: 3;
        background-color: white;
        display: flex;
        align-items: center;
        flex-direction: column;
        border-radius: 0px 10px 10px 0px;

    }
    .rightSide form {
        height: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
    }
    .textarea {
         transition:0.2s;
        border : 1px solid #efefef;
        padding: 15px;
        padding-left: 35px;
        width: 300px;
        margin-top: 15px;
        border-radius: 5px;
        outline:none;
    }
    .textarea2 {
         transition:0.2s;
        border: none;
        border : 1px solid #efefef;
        padding: 15px;
        padding-left: 35px;
        width: 270px;
        margin-top: 15px;
        border-radius: 5px;
        outline:none;
    }
    .textarea:focus {
        transition:0.2s;
        -webkit-box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
        -moz-box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
        box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
    }
    .textarea2:hover {
        transition:0.2s;
        -webkit-box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
        -moz-box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
        box-shadow: 0px 0px 3px -1px rgba(138,138,138,1);
    }
    #username {
        background-image: url(../assets/icon/user.png);
        background-position: 10px 13px;
        background-repeat: no-repeat;
        background-size: 15px;
    }
    #pass {
        background-image: url(../assets/icon/password.png);
        background-position: 10px 13px;
        background-repeat: no-repeat;
        background-size: 15px;
    }
    .connexion {
        transition:0.2s;
        border-radius: 40px;
        border: none;
        background-color: white;
        color: #1965ff;
        padding: 18px 70px 18px 70px;
        margin-top: 50px;
        cursor:pointer;
    }
    .connexion:hover {
        transition:0.2s;
        background:#CFDFFF;
    }
    #email {
        background-image: url(../assets/icon/email.png);
        background-position: 10px 16px;
        background-repeat: no-repeat;
        background-size: 15px;
    }
    #password, #Cpassword {
        background-image: url(../assets/icon/password.png);
        background-position: 10px 13.5px;
        background-repeat: no-repeat;
        background-size: 15px;
    }
    #prenom, #nom, #pseudo {
        background-image: url(../assets/icon/user.png);
        background-position: 10px 13px;
        background-repeat: no-repeat;
        background-size: 15px;
    }
    .inscription {
        transition:0.2s;
        border-radius: 40px;
        border: none;
        background-color: #1965FF;
        color: white;
        padding: 18px 70px 18px 70px;
        margin-top: 50px;
        cursor:pointer;
    }
    .inscription:hover {
        transition:0.2s;
        background:#6b94ff;
    }
    .rightSide form > h1 {
        color: #154a85;
        margin-top: 20px;
        margin-bottom: 10px;
    }
    .logo {
        align-self: flex-start;
        margin-left: 20px;
        margin-top: 20px;
    }
    .logo p {
        margin-left: 5px;
        margin-top:10px;
        color: white;
        font-size:22px;
    }
    .leftSide h1 {
        margin-top: 100px;
    }
    .leftSide p {
        margin-top: 10px;
        margin-left:10px;
    }
    .leftSide > p {
        margin-left:20px;
        margin-top:40px;
    }
    .leftSide p:nth-child(4) {
        padding-bottom:54px;
    }
</style>
