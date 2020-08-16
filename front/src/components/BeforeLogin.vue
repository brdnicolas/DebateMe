<template>
  <div id='hello'>
    <header>
      <div class="left">
        <img class="logo" src="../assets/img/logo.png"/>
        <h3 class="name">Debate Me</h3>
      </div>
      <div class="right">
        <button id="log" class ="button" @click="showLogin">
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
            <img class="logoLogin" src="../assets/img/logo2.png" @click="showModalLogin = false"/>
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
      <img class="background" src="../assets/struct/homepage.png"/>
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
        <img src="../assets/illustrations/homepage.png"/>
      </div>
    </div>
    <div class="textcenter">
      <img alt="scroll" class="scroll" src="../assets/icon/scroll.gif"/>
    </div>


    <div class="part1">
      <div class="left">
        <img src="../assets/illustrations/home1.gif"/>
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
        <img src="../assets/illustrations/work.gif"/>
      </div>
    </div>


    <div class="profil-card">
      <div class="card">
        <h2><span>Votre</span> profil</h2>
        <img class="illustration-profil" src="../assets/illustrations/work2.gif" alt="image du profil"/>
        <p>Chaque utilisateur possède un espace personnel, c'est comme votre petit jardin. Sur cette page sont regroupés plusieurs éléments, dont certains personnalisables.
          DebateMe propose aussi un système de succès, des objectifs cachés vous récompensant de badge. Pour faire la course au badge il faut utiliser toutes les fonctionnalités de Debate Me... dans certaines conditions bien sûr !</p>
        <div class="bottom">
          <img class="illustration-anonyme" src="../assets/illustrations/anonyme.png">
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
              <img src="../assets/icon/check.png">
              <p>Thèmes de marques</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Avis expert</p>
            </li>
            <li>
              <img src="../assets/icon/uncheck.png">
              <p>Aucune publicité</p>
            </li>
            <li>
              <img src="../assets/icon/uncheck.png">
              <p>Thèmes illimités</p>
            </li>
            <li>
              <img src="../assets/icon/uncheck.png">
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
              <img src="../assets/icon/check.png">
              <p>Thèmes de marques</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Avis expert</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Aucune publicité</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Thèmes illimités</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Possibilité de proposer un sujet / thème</p>
            </li>
          </div>
          <button class="choiceTarif">Choisir</button>
        </div>
      </div>
    </div>

    <footerComponent/>
  </div>
</template>

<script lang="ts">
  import { Component, Vue } from 'vue-property-decorator'
  import headerComponent from '@/components/mini-components/header.vue'
  import footerComponent from '@/components/mini-components/footer.vue'
  import DAO from "@/components/DAO";

  @Component({
    components: {
      headerComponent,
      footerComponent,
    },
  })
  export default class HomePage extends Vue {
    mounted() {
      this.checkToken();
    }
    showModalLogin: boolean;
    showModalSignin: boolean;
    connexionEmail: string;
    connexionPassword: string;
    inscriptionEmail: string;
    inscriptionPassword: string;
    inscriptionPasswordRe: string;
    inscriptionPseudo: string;
    inscriptionFirstName: string;
    inscriptionLastName: string;
    error: string;
    api = new DAO();

    constructor() {
      super();
      this.error = "";
      this.showModalLogin= false;
      this.showModalSignin= false;
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
      if(localStorage.token != "") {
        window.location.href = '/home';
      }
    }

    showLogin(): void {
      const ele = document.getElementById("html");
      this.showModalLogin = true;
      if (ele) {
        ele.style.overflow = 'hidden'
      }
    }
    ChangeToInscription(e: Event): void {
      this.hidePopUpLogin(e);
      this.showSignIn();
    }
    ChangeToLogin(e: Event): void {
      this.hidePopUpSignIn(e);
      this.showLogin();
    }
    showSignIn(): void {
      const ele = document.getElementById("html");
      window.location.href = '/inscription';
    }
    hidePopUpLogin(e: Event): void {
      e.stopPropagation();
      this.showModalLogin = false;
      const ele = document.getElementById("html");
      if (ele) {
        ele.style.overflowY = "auto"

      }
    }
    hidePopUpSignIn(e: Event): void {
      e.stopPropagation();
      this.showModalSignin = false;
      const ele = document.getElementById("html");
      if (ele) {
        ele.style.overflowY = "auto"
      }
    }
    ConnexionPOST(e: Event, email: string,password: string): void {
      e.preventDefault();
      if (!email || !password) {
        this.error = "Vous avez oublié quelque chose là ..";
        return;
      }

      const regexEmail = '[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}'
      if (email.search(regexEmail) < 0) {
        this.error = "Veuillez entrer une adresse email valide."
        return;
      }

      const datas = {
        email : email,
        password: password
      }
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

<style scoped>
  .darkmode--activated #sign {
    background: #1bb1f3 !important;
  }
  .darkmode--activated .logbox {
      background: #16191d !important;
  }
  .darkmode--activated .logbox input {
      background: #17191D;
  }
  .darkmode--activated .inscriptionMark {
    color : #651f00 !important;
  }
  .darkmode--activated header {
      background: #faab12 !important;
  }
  .darkmode--activated .background {
      mix-blend-mode: difference;
  }
  .profits-card button {
    width: 125px;
    height: 35px;
    color:white;
    font-style: normal;
    font-weight: 500;
    font-size: 18px;
    background:#3d88ee;
    border:none;
    border-radius: 5px;
    margin-top:25px;
    cursor: pointer;
  }
  .liste {
    width:100%;
    margin-top:20px;
  }
  .liste p {
    margin-left:10px;
    text-align: left;
  }
  .liste li {
    list-style: none;
    display:flex;
    flex-direction: row;
    align-items: center;
    margin-top:20px;
    margin-bottom:20px;
  }
  .profits-div {
    width:100vw;
    background: #FAF9F9;
    display:flex;
    flex-direction: row;
    justify-content: center;
    margin-top:50px;
    margin-bottom:90px;
  }
  .profits-card {
    padding:30px 50px 30px 50px;
    width:200px;
    background:white;
    text-align: center;
    border-radius: 10px;
    margin:90px 25px 90px 25px;
    box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.2);
  }
  .profits-card h3 {
    font-style: normal;
    text-transform: uppercase;
    font-weight: 300;
    font-size: 28px;
    line-height: 33px;
    letter-spacing: 0.05em;
    color: #000000;
  }
  .profits-card h4 {
    font-style: normal;
    font-weight: 300;
    font-size: 20px;
    letter-spacing: 0.05em;
    color: #3D88EE;
    padding-bottom:20px;
  }
  .profits {
    width:100vw;
    text-align: center;
    margin-top:200px;
  }
  .profits h2 {
    font-style: normal;
    font-weight: 500;
    font-size: 40px;
    line-height: 47px;
    letter-spacing: 0.05em;

    color: #3D88EE;
  }
  .illustration-anonyme {
    width:150px;
  }
  .anonymetext {
    text-align: left;
    padding-left:70px;
  }
  .anonymetext p {
    font-style: normal;
    font-weight: 300;
    font-size: 18px;
    line-height: 28px;
    letter-spacing: 0.05em;
  }
  .anonymetext h1 {
    font-weight: 300;
    color:#ff8d3d;
  }
  .anonymetext span {
    font-weight: normal
  }
  .profil-card .bottom {
    margin-top:100px;
    display:flex;
    flex-direction: row;
    padding-left:12.5%;
    padding-right: 12.5%;
    align-items: center;
  }
  .profil-card .bottom h1 {
  }
  .profil-card .bottom p {
  }
  .card > p {
    width:75%;
    text-align: left;
    margin-left:12.5%;
    font-style: normal;
    font-weight: 300;
    font-size: 24px;
    line-height: 28px;
    letter-spacing: 0.05em;
  }
  .illustration-profil {
    width:65%;
  }
  .profil-card .card h2 span {
    font-weight: normal;
  }
  .profil-card .card h2 {
    color:#f4a640;
    font-size: 48px;
    font-weight: 300;
    margin-top:50px;
  }
  .profil-card .card {
    width:840px;
    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
    border-radius: 6px;
    overflow:hidden;
    text-align: center;
    background: #fbfbfb;
    padding-bottom: 50px;
    margin-top:250px;
  }
  .profil-card {
    display:flex;
    justify-content: center;
  }
  .scroll {
    margin-top:100px;
    width:150px;
  }
  .textcenter {
    width:100%;
    text-align: center;
  }
  .part2 .left h2 {
    color:#52c1c4;
    font-size:48px;
    font-weight: 300;
  }
  .part2 .left h2 span {
    font-weight: 400;
  }
  .part2 .left p {
    margin-top:50px;
    font-size:24px;
  }
  .part2 .left {
    margin-left: 150px;
    width:900px;
  }
  .part2 .right {
    margin-right:50px;
  }
  .part2 {
    margin-top:200px;
    display:flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
  }
  .part1 .right h2 {
    color:#9494ff;
    font-size:48px;
    font-weight: 300;
  }
  .part1 .right h2 span {
    font-weight: 400;
  }
  .part1 .right p {
    margin-top:50px;
    font-size:24px;
  }
  .part1 .right {
    margin-right: 150px;
    width:900px;
  }
  .part1 {
    margin-top:200px;
    display:flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
  }
  .cover .left {
    margin-left:70px;
    width:40%;
    font-size:20px;
    color:white;
    padding-top:60px;

  }
  .cover .left h3 {
    color:antiquewhite;
    font-size:35px;
  }
  .cover .left p {
    font-weight:300;
  }
  .cover .right {
    padding-top:60px;

  }

  .cover .right img {
    width: 800px;
  }
  .cover {
    width:100vw;
    display:flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }
  .topPartError {
    display:flex;
    flex-direction: row;
    align-items: center;
  }
  .cover .background {
    isolation: isolate !important;
    width:100vw;
    height:900px;
    position: absolute;
    z-index: -5;
  }
  header {
    height:80px;
    width:100vw;
    background:#1864ff;
    display:flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
  }
  .logo {
    width:50px;
    height:50px;
  }
  header .left {
    display:flex;
    flex-direction: row;
    align-items: center;
    padding-left:50px;
  }
  header .left .name {
    font-size:26px;
    color:white;
    font-weight: bold;
    margin-top:20px;
    margin-left:10px;
  }
  header .right {
    display:flex;
    flex-direction: row;
    align-items: center;
    padding-right:40px;
  }
  .button {
    appearance: none;
    outline: none;
    border: none;
    cursor: pointer;
    color: #ffffff;
    font-size: 18px;
    font-weight: bold;
    border-radius: 8px;
    box-shadow: 3px 3px rgba(0, 0, 0, 0.4);
    transition: 0.4s ease-out;
  }
  .choiceTarif {
    transition: 0.5s;
  }
  .choiceTarif:hover {
    transition: 0.5s;
    background:#3E68B4;
  }
  .button:hover {
    box-shadow: 6px 6px rgba(0, 0, 0, 0.6);
  }
  #log {
    color:#1864ff;
    margin-left:10px;
    margin-right:10px;
    width:140px;
    height:40px;
    border-radius: 5px;
    border:none;
    font-size:17px;
    cursor:pointer;
    outline:none;
  }
  #connexion {
    margin-left:30px;
    margin-top:20px;
    font-size:25px;
    color:#154a85;
  }
  #sign {
    color:white;
    background:#e6654a;
    margin-left:10px;
    margin-right:10px;
    width:140px;
    height:40px;
    border-radius: 5px;
    border:none;
    font-size:17px;
    cursor:pointer;
    outline:none;
  }
  .modal-overlaySignin {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 98;
    background-color: rgba(0, 0, 0, 0.4);
  }
  .modal-overlayLogin {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 98;
    background-color: rgba(0, 0, 0, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .logbox {
    background: #FCFCFC;
    border: 1px solid #FFFFFF;
    box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.25);
    border-radius: 5px;
    z-index: 99;
    width: 480px;
    height: 440px;
    display: flex;
    flex-direction: column;
  }
  .logoLogin {
    width: 50px;
    height:50px;
    margin-left:30px;
  }
  .topPop h1 {
    margin: 0;
    margin-top:20px;
    margin-left:10px;
    font-size:20px;
    color:#1072ff;
  }

  .logs button {
    transition:0.2s;
    margin-left:30px;
    width:190px;
    height:40px;
    font-weight: 600;
    letter-spacing: 2px;
    padding-top:1px;
    margin-top:30px;
    outline:none;
    box-shadow: none;
    cursor:pointer;
  }
  .logs button:first-child {
    border:none;
    background:#1965ff;
    color:white;
    border-radius: 20px;
  }
  .logs button:first-child:hover {
    transition:0.2s;
    background:#6b94ff;
  }
  .logs button:nth-child(2) {
    background:white;
    color:#1965ff;
    border:2px solid #1965ff;
    border-radius: 20px;
  }
  .logs button:nth-child(2):hover {
    transition:0.2s;
    background:#cfdfff;
    color:#1965ff;
  }
  .topPop {
    display:flex;
    flex-direction: row;
    align-items: center;
    margin-top:30px;
  }
  .textarea {
    border : 1px solid #efefef;
    padding: 15px;
    padding-left: 35px;
    width: 360px;
    margin-top: 15px;
    border-radius: 5px;
    height: auto;
    margin-left:30px;
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
  .ForgetPassword {
    margin-left:32px;
    font-weight: 400;
    font-size: 13px;
    line-height: 12px;
    letter-spacing: 0.05em;
    color: #A7A7A7;
    margin-top:50px;
  }

  .ForgetPassword a {
    text-decoration: none;
    color:#A7A7A7;
    font-weight: 500;
  }

  .ForgetPassword a:hover {
    border-bottom:1px solid grey;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }

  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

</style>
