<template>
    <div class="backgroundImage">
        <div class="container">
            <div class="leftSide">
                <div class="logo">
                    <img src="../../assets/img/logo.png"/>
                    <p>Debate me</p>
                </div>
                <h1>Bienvenue chez nous !</h1>
                <p>Inscrivez-vous pour ne manquer aucun débat ! Nous savons à quel point donner son avis importe alors n'hésitez pas.</p>
                <p>Oh mais attendez... Vous êtes peut-être déjà inscrit ?</p>
                <p class="darkmode-ignore">{{errorConnexion}}</p>
                <input class="textarea2" id="username" type="text" v-model="connexionEmail" placeholder="Email"/>
                <input class="textarea2" id="pass" type="text" v-model="connexionPassword" placeholder="Mot de passe"/>
                <button type="submit" class="connexion" @click="ConnexionPOST($event,connexionEmail,connexionPassword)"><b>CONNEXION</b></button>
            </div>
            <div class ="rightSide">
                <form>
                    <h1 class="darkmode-ignore">Créez votre compte</h1>
                    <p class="darkmode-ignore" style="color:red !important;margin-bottom:40px !important;">{{this.error}}</p>
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
    import { Vue } from 'vue-property-decorator'
    import DAO from "@/DAO";

    export default class Inscription extends Vue {


        // Fonction qui s'éxécute en même temps que le rendu du composant
        mounted(): void {
            this.checkToken();
        }

        // Adresse email de connexion
        connexionEmail: string;

        // Mot de passe de connexion
        connexionPassword: string;

        // Email d'inscription
        inscriptionEmail: string;

        // Mot de passe d'inscription
        inscriptionPassword: string;

        // Mot de passe de vérification d'inscription
        inscriptionPasswordRe: string;

        // Pseudo d'inscription
        inscriptionPseudo: string;

        // Prénom d'inscription
        inscriptionFirstName: string;

        // Nom d'inscription
        inscriptionLastName: string;

        // Erreur à afficher lors de l'inscription
        error: string;

        // Erreur à afficher lors de la connexion
        errorConnexion: string;

        // DAO
        api = new DAO();

      // On associe à chaque varialbe une valeur par défaut.
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
            this.errorConnexion = "";
        }

        // On vérifie que l'utilisateur soit connécté
        checkToken(): void {
            if (localStorage.token != "") {
                window.location.href = '/home';
            }
        }

        // Fonction permettant la connexion de l'utilisateur
        ConnexionPOST(e: Event, email: string,password: string): void {

          // Eviter de reload la page
          e.preventDefault();

          // Vérification : Si il y a pas de mdp ou de pseudo on dit qu'il manque qlque chose
          if (!email || !password) {
            this.errorConnexion = "Vous avez oublié quelque chose là ..";
            this.$forceUpdate();
            return;
          }

          // Verification par regex que l'adresse mail entré en est bien une
          const regexEmail = '[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}'
          if (email.search(regexEmail) < 0) {
            this.errorConnexion = "Veuillez entrer une adresse email valide."
            this.$forceUpdate();
            return;
          }

          // données envoyées lors de la requete api
          const datas = {
            email : email,
            password: password
          }

          // requete api
          this.api.postConnexion(datas).then(datas => {
            localStorage.token = (datas as Record<string, any>).auth_token;
            window.location.href = '/home';
          })
              .catch(error => {
                this.errorConnexion = "Email ou mot de passe invalide."
                this.$forceUpdate();
              });
        }

        // Fonction permettant l'inscription d'un nouvel utilisateur
        InscriptionPost(e: Event, email: string,password: string, repassword: string, username: string, firstname: string, lastname: string): void {
            // On évite le reload de la page
            e.preventDefault();

            // Vérification : Si l'utilisateur n'a pas mis deux fois le même mdp on écrit l'erreur
            if (password !== repassword) {
                this.error = "Les mots de passe ne sont pas identiques.";
                this.$forceUpdate();
                return;
            }


          // Vérification : si il manque un champ on le notifie
            if (!email || !password || !repassword || !username || !firstname || !lastname ) {
              this.$forceUpdate();
              this.error = "Vous avez oublier quelque chose là ..";
              this.$forceUpdate();
              return;
            }


          // On vérifie par regex que l'email entrée en est bien une
            const regexEmail = '[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}'
            if (email.search(regexEmail) < 0) {
              this.error = "Veuillez entrer une adresse email valide."
              this.$forceUpdate();
              return;
            }


          // données envoyées lors de la requete api
            const datas = {
              email: email,
              password: password,
              username: username,
              firstname: firstname,
              lastname: lastname,
              // eslint-disable-next-line @typescript-eslint/camelcase
              password_confirmation: repassword,
            }

            // requete api
            this.api.postInscription(datas).then(data => {
              localStorage.token = (data as Record<string, any>).auth_token;
              window.location.href = '/home';
            })
            .catch(error => {
              this.error = "Une erreur s'est produite."
              this.$forceUpdate();
            });
        }
    }
</script>

<style scoped src="../../css/user/Inscription.css"/>
