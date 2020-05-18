<template>
  <div class="hello">
    <header>
      <div class="left">
          <img class="logo" src="../assets/img/logo.png"/>
          <h3 class="name">Debate Me</h3>
      </div>
      <div class="right">
        <button>
          Connexion
        </button>
        <button>
          Inscription
        </button>
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

    <footer>
      <img src="../assets/img/logo2.png"/>
      <p>Debate Me © 2020</p>
      <div class="social">
        <img src="../assets/icon/twitter.png"/>
        <img src="../assets/icon/facebook.png"/>
        <img src="../assets/icon/instagram.png"/>
      </div>
    </footer>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';

@Component
export default class HelloWorld extends Vue {
  @Prop() private msg!: string;
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.social img {
  width:22px;
  margin-left:2px;
  margin-right: 2px;
  cursor: pointer;
  margin-top:5px;
}
footer p {
  color:#3d88ee;
  margin-top:2px;
}
.social {
  margin-left:50%;
}
footer > img {
  width:50px;
}
footer {
  width:100vw;
  height:60px;
  background:#f5f8fe;
  display:flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
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
header .right button {
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
header .right button:first-child {
  color:#1864ff;
  font-weight: bold;
}
header .right button:nth-child(2) {
  color:white;
  font-weight: bold;
  background:#e6654a;
}
</style>
