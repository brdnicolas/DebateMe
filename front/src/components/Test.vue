<template>
  <div id='hello'>
    <header>
      <div class="left">
        <img class="logo" src="../assets/img/logo.png"/>
        <h3 class="name">Debate Me</h3>
      </div>
      <div class="right">
        <button id="log" class ="button" onclick="this.showModalLogin = true" @click="disableScroll">
          Connexion
        </button>
        <div v-on:click.self="hidePopUp" class="modal-overlayLogin" v-if="showModalLogin">

        </div>
        <transition name ="fade" appear>
          <div v-on:click.self="hidePopUp" class="modal-overlayLogin" v-if="showModalLogin"  >

            <form class="logbox">
              <img class="logoLogin" src="../assets/img/logo2.png" @click="showModalLogin = false"/>
              <h1>EMAIL</h1>
              <input class="textarea" type="email">
              <h1>PASSWORD</h1>
              <input class="textarea" type="password">
              <div class="remember">
                <input class="checkbox" type="checkbox">
                <h2>REMEMBER ME</h2>
              </div>
              <div class="logs">
                <button type="submit" class="Login">CONNEXION</button>
                <button type="button" class="Signin">INSCRIPTION</button>
              </div>
              <p class="ForgetPassword"><a href="#"> Mot de passe oublié ?</a> Nous allons vous envoyer un mail.</p>
            </form>
          </div>
        </transition>
        <button id="sign" class ="button" @click="showModalSignin = true">
          Inscription
        </button>
        <transition name ="fade" appear>
          <div class="modal-overlaySignin" v-if="showModalSignin" @click="showModalSignin = false"></div>
        </transition>
      </div>
    </header>

    <div class="cover">
      <img class="background" src="../assets/struct/homepage.png"/>
      <div class="left">
        <h3>Debate Me C'est quoi ?</h3>
        <br>
        <p>Concevoir des design web et mobiles n'est pas une mince affaire ! Il faut sans cesse se renouveler pour satisfaire des utilisateurs de plus en plus exigeants. Besoin d'inspiration ? Adimeo suit pour vous les nouvelles tendances UI/UX pour toujours avoir un coup d'avance...

          L'expérience utilisateur prend une place de plus en plus importante dans la stratégie digitale des organisations. Une expérience interactive de haute qualité sur votre plateforme digitale est la garantie de transformer un simple visiteur en un client fidèle, voire un ambassadeur.

          Il est indispensable de suivre les nouvelles tendances en matière de design UI/UX pour répondre aux besoins d'utilisateurs toujours plus exigeants.

          Pour notre studio, la veille est primordiale dans le processus de création. Et elle doit se faire chaque jour ! Il va sans dire que notre travail créatif ne serait pas le même sans cet apport.

          Notre studio a choisi pour vous une sélection des meilleurs sites et blogs pour trouver l'inspiration ! Grâce à ces sites, nous pouvons challenger nos idées et trouver l'inspiration pour sublimer le travail déjà réalisé.</p>
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
        <p>Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente </p>
      </div>
    </div>

    <div class="part2">
      <div class="left">
        <h2>Créez <span>vous même</span> les sujets !</h2>
        <p>Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente </p>
      </div>
      <div class="right">
        <img src="../assets/illustrations/work.gif"/>
      </div>
    </div>


    <div class="profil-card">
      <div class="card">
        <h2><span>Votre</span> profil</h2>
        <img class="illustration-profil" src="../assets/illustrations/work2.gif"/>
        <p>Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente </p>
        <div class="bottom">
          <img class="illustration-anonyme" src="../assets/illustrations/anonyme.png">
          <div class="anonymetext">
            <h1>Soyez <span>Anonyme !</span></h1>
            <p>Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le livre spécimen de polices de texte. Il n'a pas fait que survivre cinq.</p>
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
  @Component({
    components: {
      headerComponent,
      footerComponent,
    },
  })
  export default class HomePage extends Vue {
    showModalLogin: boolean;

    constructor() {
      super();
      this.showModalLogin= false;
    }
    data() {
      return {
        showModalSignin: false
      };
    }
    disableScroll(): void {
        const ele = document.getElementById("html");
        this.showModalLogin = true;
        if (ele) {
          ele.style.overflow = 'hidden'
        }
    }
    hidePopUp(e: CustomEvent): void {
      e.stopPropagation();
      this.showModalLogin = false;
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
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
  .logoLogin {
    width: 80px;
    min-width: 50px;
    margin:22px 40px 5px 40px;
  }

  .remember, .logs {
    display: flex ;
    flex-direction: row;
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

  .logbox h1 {
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
