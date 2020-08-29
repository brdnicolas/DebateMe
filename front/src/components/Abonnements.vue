<template>
  <div style="text-align:center;display: flex;flex-direction: row" class="main" v-if="checkToken">
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
          <button @click="getSession">Choisir</button>
        </div>
      </div>
  </div>
</template>

<script lang="ts">
// @ts-nocheck
import { Component, Prop, Vue } from 'vue-property-decorator';
import headerComponent from "@/components/mini-components/header.vue";
import footerComponent from "@/components/mini-components/footer.vue";
import DAO from "@/DAO";

@Component({
  components: {
    // Importation du footer & de l'header
    headerComponent,
    footerComponent,
  },
})

export default class Abonnements extends Vue {

  stripe: any;
  api = new DAO();

  constructor() {
    super();
    // eslint-disable-next-line no-undef
    this.stripe = Stripe("pk_test_51H0icEEfP5i1LDx8esmSOroVwElbIBllJEahdjBZVbcIbDsYYmbW7yH6xGLCZPHj1OiGatEyhXeJ8J1sGh6zSGEu00jOkYNNz3");
  }

    // Fonction permettant de vérifier que l'utilisateur est connécté.
    checkToken(): boolean {
      return !!localStorage.token;
    }

  getSession(): void  {
    this.api.getStripeCheckout().then( (result) => {
      this.stripe.redirectToCheckout({sessionId: result.id})
    })
  }

}
</script>

<style scoped src="../css/Abonnements.css"/>
