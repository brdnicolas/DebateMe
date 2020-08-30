<template>
  <div id='hello'>
    <header>
      <div class="left">
        <img class="logo" src="../../assets/img/logo.png"/>
        <h3 class="name">Debate Me</h3>
      </div>
      <div class="right">
        <button id="log" class ="button" @click="showLogin(false)">
          <span class="darkmode-ignore">Connexion</span>
        </button>
        <button id="sign" class ="button" @click="showSignIn">
          <span class="inscriptionMark">Inscription</span>
        </button>

      </div>
    </header>

    <!-- POPUP -->
    <transition name ="fade" appear>
      <div v-on:click.self="hidePopUpLogin($event)" class="modal-overlayLogin" v-if="showModalLogin"  >
        <form class="logbox">
          <div class="topPop">
            <img class="logoLogin" src="../../assets/img/logo2.png" @click="showModalLogin = false"/>
            <h1>Debate Me</h1>
          </div>
          <div class="topPartError">
            <h1 id="connexion">Connexion</h1>
            <p style="margin-left:10px;color:red;padding-bottom:5px">{{error}}</p>
          </div>
          <input v-model="connexionEmail" name="email" class="textarea" id="username" type="email" placeholder="Email">
          <input v-model="connexionPassword" class="textarea" type="password" id="pass" placeholder="Mot de passe">
          <div class="logs">
            <button type="submit" class="Login" @click="ConnexionPOST($event,connexionEmail,connexionPassword)">CONNEXION</button>
            <button type="button" class="Signin" @click="ChangeToInscription($event)">INSCRIPTION</button>
          </div>
          <p class="ForgetPassword"><a href="#"> Mot de passe oublié ?</a> Nous allons vous envoyer un mail.</p>
        </form>
      </div>
    </transition>
    <!-- POPUP -->

    <div class="cover">
      <img class="background" src="../../assets/struct/homepage.png"/>
      <div class="left">
        <h3>DebateMe c'est quoi ?</h3>
        <br>
        <p>C'est une plateforme de débat et de discussions autour de différentes thématiques dans l'air du temps.
          Nous avons créé DebateMe afin de permettre aux gens de débattre sur internet dans un environnement sain et respectueux, sans risquer de recevoir des réponses insultantes ou sans intérêt.
          De ce fait, nous disposons d'une modération forte. Une partie de cette modération fonctionne grâce à une intelligence artificielle, qui va pouvoir lire, interpréter et corriger les messages publiés.
          Le reste de la modération est manuel, afin d'éviter au maximum tout désagrément.
        </p>
      </div>
      <div class="right">
        <img src="../../assets/illustrations/homepage.png"/>
      </div>
    </div>
    <div class="textcenter">
      <img alt="scroll" class="scroll" src="../../assets/icon/scroll.gif"/>
    </div>


    <div class="part1">
      <div class="left">
        <img src="../../assets/illustrations/home1.gif"/>
      </div>
      <div class="right">
        <h2>Créez <span>vous même</span> les sujets !</h2>
        <p>En effet vous pourrez nous suggérer des sujets d'actualité qui rejoindront les thématiques déjà existantes, mais vous pourrez aussi créer vos propres sujets afin d'en débattre avec qui le veut.
          Ces sujets seront évidemment validés en amont avant d'apparaitre sur notre site.</p>
      </div>
    </div>

    <div class="part2">
      <div class="left">
        <h2>Des <span>statistiques</span> pour chaque débat</h2>
        <p>Au bout d'une semaine nous estimons que le débat puisse être clos. Nous mettons à votre disposition les informations liées à la question. Chaque sujet aura donc sa page statistique. Ces données seront de plusieurs natures, telles que: le nombre de participant, le nombre de participations à ce débat en moyenne par candidat, le taux de participation par tranche d'âge, le nombre de participants anonymes, le sexe des participants etc.</p>
      </div>
      <div class="right">
        <img src="../../assets/illustrations/work.gif"/>
      </div>
    </div>


    <div class="profil-card">
      <div class="card">
        <h2><span>Votre</span> profil</h2>
        <img class="illustration-profil" src="../../assets/illustrations/work2.gif" alt="image du profil"/>
        <p>Chaque utilisateur possède un espace personnel, c'est comme votre petit jardin. Sur cette page sont regroupés plusieurs éléments, dont certains personnalisables.
          DebateMe propose aussi un système de succès, des objectifs cachés vous récompensant de badge. Pour faire la course au badge il faut utiliser toutes les fonctionnalités de Debate Me... dans certaines conditions bien sûr !</p>
        <div class="bottom">
          <img class="illustration-anonyme" src="../../assets/illustrations/anonyme.png">
          <div class="anonymetext">
            <h1>Soyez <span>Anonyme</span> !</h1>
            <p>Nous avons pensé à tout. Si vous voulez participer à un débat mais que vous avez peur que l'on vous reconnaisse ou que votre opinion ait de mauvaises répercussions sur votre vie. Nous vous permettons de participer au débat en tant qu'anonyme. Bien sûr, cela ne veut pas dire que vous pouvez faire n'importe quoi !</p>
          </div>
        </div>
      </div>
    </div>

    <div class="profits">
      <h2>Différentes façon d’en profiter !</h2>
      <div class="profits-div">
        <div class="profits-card">
          <h3>Basique</h3>
          <h4>Gratuit</h4>
          <div class="liste">
            <li>
              <img src="../../assets/icon/check.png">
              <p>Thèmes de marques</p>
            </li>
            <li>
              <img src="../../assets/icon/check.png">
              <p>Avis expert</p>
            </li>
            <li>
              <img src="../../assets/icon/uncheck.png">
              <p>Aucune publicité</p>
            </li>
            <li>
              <img src="../../assets/icon/uncheck.png">
              <p>Thèmes illimités</p>
            </li>
            <li>
              <img src="../../assets/icon/uncheck.png">
              <p>Possibilité de proposer un sujet / thème</p>
            </li>
          </div>
          <button class="choiceTarif">Choisir</button>
        </div>
        <div class="profits-card">
          <h3>Premium</h3>
          <h4>9.99€ / mois</h4>
          <div class="liste">
            <li>
              <img src="../../assets/icon/check.png">
              <p>Thèmes de marques</p>
            </li>
            <li>
              <img src="../../assets/icon/check.png">
              <p>Avis expert</p>
            </li>
            <li>
              <img src="../../assets/icon/check.png">
              <p>Aucune publicité</p>
            </li>
            <li>
              <img src="../../assets/icon/check.png">
              <p>Thèmes illimités</p>
            </li>
            <li>
              <img src="../../assets/icon/check.png">
              <p>Possibilité de proposer un sujet / thème</p>
            </li>
          </div>
          <button @click="showLogin(true)" class="choiceTarif">Choisir</button>
        </div>
      </div>
    </div>

    <footerComponent/>
  </div>
</template>

<script lang="ts">
  import { Component, Vue } from 'vue-property-decorator'
  import headerComponent from '@/components/user/mini-components/header.vue'
  import footerComponent from '@/components/user/mini-components/footer.vue'
  import DAO from "@/DAO";

  @Component({
    components: {
      // Importation du header & du footer
      headerComponent,
      footerComponent,
    },
  })
  export default class HomePage extends Vue {

    // Fonction qui s'éxécute en même temps que le rendu du composant
    mounted(): void {
      this.checkToken();
    }

    // Boolean activant ou non la pop up de connexion
    showModalLogin: boolean;

    // données de connexion
    connexionEmail: string;
    connexionPassword: string;

    // erreur a afficher
    error: string;

    // DAO
    api = new DAO();

    // On associe à chaque varialbe une valeur par défaut.
    constructor() {
      super();
      this.error = "";
      this.showModalLogin= false;
      this.connexionEmail = "";
      this.connexionPassword = "";
    }

    // On vérifie que l'utilisateur est connécté
    checkToken(): void {
      if(localStorage.token != "") {
        window.location.href = '/home';
      }
    }

    // On affiche la pop up connexion
    showLogin(cookie = false): void {
      if(cookie)
        document.cookie = "abbo";
      window.scrollTo(0,0);
      const ele = document.getElementById("html");
      this.showModalLogin = true;
      if (ele) {
        ele.style.overflow = 'hidden'
      }
    }

    // Redirection vers inscription
    ChangeToInscription(e: Event): void {
      this.hidePopUpLogin(e);
      this.showSignIn();
    }

    // Redirection vers inscription
    showSignIn(): void {
      const ele = document.getElementById("html");
      window.location.href = '/inscription';
    }

    // On range la pop up login
    hidePopUpLogin(e: Event): void {
      e.stopPropagation();
      this.showModalLogin = false;
      const ele = document.getElementById("html");
      if (ele)
        ele.style.overflowY = "auto"
    }

    // Fonction permettant à l'utilisateur de se connécter
    ConnexionPOST(e: Event, email: string,password: string): void {

      // On ne reload pas la page
      e.preventDefault();

      // Vérification : Si l'utilisateur n'a rien entré
      if (!email || !password) {
        this.error = "Vous avez oublié quelque chose là ..";
        return;
      }

      // Vérification regex si l'utilisateur a bien entré une adresse email
      const regexEmail = '[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}'
      if (email.search(regexEmail) < 0) {
        this.error = "Veuillez entrer une adresse email valide."
        return;
      }

      // données envoyées lors de la requete api
      const datas = {
        email : email,
        password: password
      }

      // requete api pour se connecter
      this.api.postConnexion(datas).then(datas => {
          localStorage.token = (datas as Record<string, any>).auth_token;
          window.location.href = '/home';
      })
      .catch(error => {
        this.error = "Email ou mot de passe invalide."
      });
    }
  }
</script>

<style scoped src="../../css/user/BeforeLogin.css"/>
