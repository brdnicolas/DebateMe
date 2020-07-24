<template>
  <div id='hello'>
    <header>
      <div class="left">
        <img class="logo" src="../assets/img/logo.png"/>
        <h3 class="name">Debate Me</h3>
      </div>
      <div class="right">
        <button id="log" class ="button" @click="showLogin">
          Connexion
        </button>
        <button id="sign" class ="button" @click="showSignIn">
          Inscription
        </button>

      </div>
    </header>

    <!-- POPUP -->
    <transition name ="fade" appear>
      <div v-on:click.self="hidePopUpLogin($event)" class="modal-overlayLogin" v-if="showModalLogin"  >

        <form class="logbox">
          <img class="logoLogin" src="../assets/img/logo2.png" @click="showModalLogin = false"/>
          <p style="margin-left:52px;color:red;">{{error}}</p>
          <h1>EMAIL</h1>
          <input v-model="connexionEmail" name="email" class="textarea" type="email">
          <h1>MOT DE PASSE</h1>
          <input v-model="connexionPassword" class="textarea" type="password">
          <div class="logs">
            <button type="submit" class="Login" @click="ConnexionPOST($event,connexionEmail,connexionPassword)">CONNEXION</button>
            <button type="button" class="Signin" @click="ChangeToInscription($event)">INSCRIPTION</button>
          </div>
          <p class="ForgetPassword"><a href="#"> Mot de passe oublié ?</a> Nous allons vous envoyer un mail.</p>
        </form>
      </div>
    </transition>

    <transition name ="fade" appear>
      <div v-on:click.self="hidePopUpSignIn($event)" class="modal-overlayLogin" v-if="this.showModalSignin"  >

        <form class="logboxSignIn">
          <img class="logoLogin" src="../assets/img/logo2.png" @click="showModalLogin = false"/>
          <p style="margin-left:52px;color:red;">{{error}}</p>
          <h1>EMAIL</h1>
          <input v-model="inscriptionEmail" class="textarea" type="email">
          <h1>MOT DE PASSE</h1>
          <input v-model="inscriptionPassword" class="textarea" type="password">
          <h1>CONFIRMATION MOT DE PASSE</h1>
          <input v-model="inscriptionPasswordRe" class="textarea" type="password">
          <h1>PSEUDO</h1>
          <input v-model="inscriptionPseudo" class="textarea" type="text">
          <h1>PRÉNOM</h1>
          <input v-model="inscriptionFirstName" class="textarea" type="text">
          <h1>NOM</h1>
          <input v-model="inscriptionLastName" class="textarea" type="text">
          <div class="logs">
            <button type="submit" class="Signin" @click="InscriptionPost($event,inscriptionEmail,inscriptionPassword,inscriptionPasswordRe,inscriptionPseudo,inscriptionFirstName,inscriptionLastName)">S'INSCRIRE</button>
            <button type="button" class="Login" @click="ChangeToLogin($event)">CONNEXION</button>
          </div>
        </form>
      </div>
    </transition>
    <!-- POPUP -->

    <div class="cover">
      <img class="background" src="../assets/struct/homepage.png"/>
      <div class="left">
        <h3>Debate Me C'est quoi ?</h3>
        <br>
        <p>C'est une plateforme de débat et de discussions autour de différentes thématique actuelle. Nous avons créer Debate me afin de permettre au gens de débattre sur internet dans un environnement sain
          et respectueux, sans risquer de recevoir des réponses insultantes ou sans intéret et sans non plus tomber dans la censure. En effet, nous disposons d'une modération forte, qui fonctionne graçe à une intelligence artificielle et une modération manuel plus classique afin d'éviter ce genre de désagréments.
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
        <p>En effet vous pourrez nous suggérer des sujets d'actualité qui rejoindrons nos propres sujets d'actualité, mais vous pourrez aussi créer vos propre sujets afin d'en débattre avec qui le veux. Ces sujets seront evidement d'abord validé avant d'apparaitre sur notre site.</p>
      </div>
    </div>

    <div class="part2">
      <div class="left">
        <h2>Des <span>statistiques</span> pour chaque débat</h2>
        <p>Au bout d'une semaine nous metterons a votre disposition des statistiques que nous aurons récupérer sur les débats. Chaque sujet aura sa page statistique, ces données seront variée tel que: le nombre de participant, le nombre de participation a ce débat en moyenne par candidat, le taux de participation par tranche d'âge, le nombre de participants anonyme, le sexe des participants etc...   </p>
      </div>
      <div class="right">
        <img src="../assets/illustrations/work.gif"/>
      </div>
    </div>


    <div class="profil-card">
      <div class="card">
        <h2><span>Votre</span> profil</h2>
        <img class="illustration-profil" src="../assets/illustrations/work2.gif"/>
        <p>Votre profil est votre petit jardin, c'est ici que vous pourrez voir vos abonnée et vos abonnement ainsi que les commentaires que vous avez liké. C'est aussi ici que seront affiché vos magnifiques badges gagné à la sueur de votre front.</p>
        <div class="bottom">
          <img class="illustration-anonyme" src="../assets/illustrations/anonyme.png">
          <div class="anonymetext">
            <h1>Soyez <span>Anonyme !</span></h1>
            <p>Nous avons pensez à tous, si vous voulez participer à un débat mais que vous avez peur que l'on vous reconaisse et que vos opinions ai des mauvaises répercussion dur votre vie. Nous vous permettons de participer au débat en tant qu'anonyme. </p>
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
              <img src="../assets/icon/uncheck.png">
              <p>Raison 1</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 2</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 3</p>
            </li>
            <li>
              <img src="../assets/icon/uncheck.png">
              <p>Raison 4</p>
            </li>
          </div>
          <button>Choisir</button>
        </div>
        <div class="profits-card">
          <h3>Premium</h3>
          <h4>10€ / mois</h4>
          <div class="liste">
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 1</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 2</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 3</p>
            </li>
            <li>
              <img src="../assets/icon/check.png">
              <p>Raison 4</p>
            </li>
          </div>
          <button>Choisir</button>
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
  import myAPI from "@/components/myAPI";
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
        this.error = "Veuillez remplir tous les champs.";
        return;
      }

      myAPI.post("auth/login", {
        email : email,
        password: password
      }).then((response: { data: any}) =>  {
        localStorage.token = response.data.auth_token;
        window.location.href = '/home';
      } );
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
  .cover .background {
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
    width:80px;
    height:80px;
  }
  header .left {
    display:flex;
    flex-direction: row;
    align-items: center;
    padding-left:50px;
  }
  header .left .name {
    font-size:30px;
    color:white;
    font-weight: 300;
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
  button:hover {
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
  .logboxSignIn {
    background: #FCFCFC;
    border: 1px solid #FFFFFF;
    box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.25);
    border-radius: 5px;
    z-index: 99;
    width: 480px;
    height: 740px;
    display: flex;
    flex-direction: column;
  }
  .logoLogin {
    width: 80px;
    min-width: 50px;
    margin:22px 40px 5px 40px;
  }

  .logs {
    display: flex ;
    flex-direction: row;
    margin-top:25px;
    align-items: center;
  }
  .logs button {
    transition:0.3s;
    margin-left:54px;
    width:150px;
    height:35px;
    font-weight: 600;
    letter-spacing: 2px;
    padding-top:1px;
    margin-top:15px;
    outline:none;
    box-shadow: none;
    cursor:pointer;
  }
  .logs button:hover {
    transition:0.3s;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.40);
  }
  .logs button:first-child {
    border:none;
    background:#408dfe;
    color:white;
    border-radius: 20px;
  }
  .logs button:nth-child(2) {
    background:white;
    color:#408dfe;
    border:2px solid #408dfe;
    border-radius: 20px;
  }
  .remember h2 {
    color:#a7a7a7;
    font-size:12px;
    margin-top:6px;
    margin-left:5px;
    font-weight: 500;
  }

  .textarea {
    border: none;
    border-bottom: 1px solid #A7A7A7;
  }

  input, select {
    width: 350px;
    height: 40px;
    font-size:20px;
    margin-top: 10px;
    color:#0e3c99;
    background-color: #FCFCFC ;
    margin-left:54px;
    outline:none;
  }

  .checkbox {
    width: 15px;
    margin-top:5px;
    cursor:pointer;
  }

  .logbox h1, .logboxSignIn h1 {
    font-weight: 500;
    font-size: 18px;
    line-height: 14px;
    letter-spacing: 0.05em;
    color: #A7A7A7;
    margin-top: 25px;
    margin-left:54px;
  }

  .ForgetPassword {
    margin-left:54px;
    font-weight: 400;
    font-size: 13px;
    line-height: 12px;
    letter-spacing: 0.05em;
    color: #A7A7A7;
    margin-top:20px;
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
