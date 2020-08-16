<template>
  <div style="text-align:center;display: flex;flex-direction: row" class="main">
    <img @click="$router.go(-1)" class="back" alt="back" src="../assets/icon/back2.png"/>
      <div class="left">
        <h1>Classique</h1>
        <h4>Gratuit</h4>
        <div class="liste">
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Thèmes de marques</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Avis expert</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Aucune publicité</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Thèmes illimités</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Possibilité de proposer un sujet / thème</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Accès au darkmode</p>
          </li>
          <li>
            <img src="../assets/icon/uncheck2.png">
            <p>Icon premium</p>
          </li>
        </div>
        <button>Choisir</button>
      </div>
      <div class="right">
        <h1 style="text-align:center;color: #E7AA5F; text-shadow: 0px 0px 6px #E7AA5F">Premium</h1>
        <div class="profits-card">
          <h4>9.99€ / mois</h4>
          <div class="liste">
            <li>
              <img src="../assets/icon/check2.png">
              <p>Thèmes de marques</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Avis expert</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Aucune publicité</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Thèmes illimités</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Possibilité de proposer un sujet / thème</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Accès au darkmode</p>
            </li>
            <li>
              <img src="../assets/icon/check2.png">
              <p>Icon premium</p>
            </li>
          </div>
          <button>Choisir</button>
        </div>
      </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import headerComponent from "@/components/mini-components/header.vue";
import footerComponent from "@/components/mini-components/footer.vue";

@Component({
  components: {
    headerComponent,
    footerComponent,
  },
})

export default class Abonnements extends Vue {

  mounted() {
    this.checkToken();
  }

  checkToken(): void {
    if(localStorage.token === "") {
      window.location.href = '/';
    }
  }


}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.back {
  z-index:800;
  transition:0.5s;
  position: absolute;
  top: 0;
  left:0;
  margin:30px;
  width:20px;
  height:20px;
  object-fit: contain;
  background:whitesmoke;
  padding:10px;
  border-radius:20px;
  -webkit-box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
  -moz-box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
  box-shadow: 0px 0px 5px 0px rgba(102,102,102,1);
  cursor:pointer;
}

.back:hover {
  transition:0.5s;
  -webkit-box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
  -moz-box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
  box-shadow: 0px 0px 5px 0px rgba(5,5,5,1);
}
.liste {
  margin-top:150px;
}
.liste p {
  margin-left:10px;
  text-align: left;
  font-size:20px;
}
.liste li {
  width:500px;

  list-style: none;
  display:flex;
  flex-direction: row;
  align-items: center;
  margin-top:20px;
  margin-bottom:20px;
  margin-left:100px;
}
.liste img {
  width:40px;
}
.profits-card {
  text-align: center;
  border-radius: 10px;
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
  font-size: 16px;
  letter-spacing: 0.05em;
  color: #F5BD76;
  padding-bottom:20px;
}

.right button {
  cursor:pointer;
  margin-top:150px;
  width:65%;
  height:50px;
  background:#E8A95F;
  box-shadow: 0px 0px 6px #E7AA5F;
  border:none;
  text-transform: uppercase;
  font-size:18px;
}

.right:hover button {
  height:60px;
}
.right:hover .liste p {
  font-size:25px;
  margin-left:60px;
}
.right:hover .liste {
  margin-left: 100px;
}



.left button {
  cursor:pointer;
  margin-top:150px;
  width:70%;
  margin-left:10%;
  height:50px;
  color:white;
  background:#171A1E;
  box-shadow: 0px 0px 6px black;
  border:none;
  text-transform: uppercase;
  font-size:18px;
}







  .main > div {
      width:50vw;
      height:100vh;
  }
  .left {
    background: white;
    display:flex;
    align-content: center;
    padding:40px;
    flex-direction: column;
  }
  .left:hover {
    width:100vw;
    z-index:2;
    -webkit-box-shadow: 3px 0px 41px 0px rgba(255,255,255,1);
    -moz-box-shadow: 3px 0px 41px 0px rgba(255,255,255,1);
    box-shadow: 3px 0px 41px 0px rgba(255,255,255,1);
  }
.left:hover .right {
  width:0vw;
}
.right:hover .left {
  width:0vw;
}
  .right:hover {
    width:100vw;
    z-index:2;
    -webkit-box-shadow: -5px 0px 41px 0px rgba(23,26,30,1);
    -moz-box-shadow: -5px 0px 41px 0px rgba(23,26,30,1);
    box-shadow: -5px 0px 41px 0px rgba(23,26,30,1);
  }

  .right {
    background:#16191D;
    color:#B4B5BE;
    display:flex;
    align-content: center;
    padding:40px;
    flex-direction: column;
  }


</style>
