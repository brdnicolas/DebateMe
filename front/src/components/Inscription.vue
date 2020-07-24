<template>
    <div class="backgroundImage">
        <div class="container">
            <div class="leftSide">
                <div class="logo">
                    <img src="../assets/img/logo.png"/>
                    <p>Debate me</p>
                </div>
                <h1> Bienvenue chez nous</h1>
                <p>J'espere que vous allez bien</p>
            </div>
            <div class ="rightSide">
                <form>
                    <p style="position:absolute;color:red;top:100px;">{{error}}</p>
                    <h1>Créez votre compte</h1>
                    <input class="textarea" id="email" type="email" v-model="inscriptionEmail" placeholder="Email"/>
                    <input class="textarea" id="password"   type="password" v-model="inscriptionPassword" placeholder="Mot de passe"/>
                    <input class="textarea" id="Cpassword" type="password" v-model="inscriptionPasswordRe" placeholder="Confirmez votre mot de passe"/>
                    <input class="textarea" id="pseudo" type="text" v-model="inscriptionPseudo" placeholder="Pseudo"/>
                    <input class="textarea" id="prenom" type="text" v-model="inscriptionFirstName" placeholder="Prénom"/>
                    <input class="textarea" id="nom" type="text" v-model="inscriptionLastName" placeholder="Nom"/>
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
                this.error = "Veuillez remplir tous les champs.";
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
        background-image: url('../assets/img/backgroundBlue.jpg');
        background-repeat:no-repeat;
        background-size:cover;
        display: flex;
        justify-content: center;
        height: 800px;
    }
    .container {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        width: 1000px;
        height: 700px;
        margin-top: 50px;
        background-color: #1965FF;
        border-radius: 30px 30px;
    }
    .leftSide {
        flex: 2;
        display: flex;
        flex-direction: column;
        align-items: center;
        border-radius: 30px 0px 0px 30px;
        color: white;
    }
    .logo {
        display: flex;
        flex-direction: row;
    }
    .logo img {
        width: 40px;
    }
    .rightSide {
        flex: 3;
        background-color: white;
        display: flex;
        align-items: center;
        flex-direction: column;
        border-radius: 0px 30px 30px 0px;

    }
    .rightSide form {
        height: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
    }
    .textarea {
        border: none;
        background-color: #F4F8F7;
        padding: 15px;
        padding-left: 35px;
        width: 300px;
        margin-top: 10px;
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
        border-radius: 40px;
        border: none;
        background-color: #1965FF;
        color: white;
        padding: 20px 70px 20px 70px;
        margin-top: 50px;
    }
    .rightSide form > h1 {
        color: #1965FF;
        margin-top: 20px;
        margin-bottom: 50px;
    }
    .logo {
        align-self: flex-start;
        margin-left: 20px;
        margin-top: 20px;
    }
    .logo p {
        margin-top: 12px;
        margin-left: 5px;
        color: white;
    }
    .leftSide h1 {
        margin-top: 200px;
    }
    .leftSide p {
        margin-top: 10px;
    }
</style>
