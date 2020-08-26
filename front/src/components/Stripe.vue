<template>
    <button v-on:click="getSession">Pay ${{10000 / 100}}</button>
</template>

<script>

import DAO from "@/DAO";

  export default {
    data() {
      return {
        stripe: null,
        api: null
      };
    },
    mounted() {
      // eslint-disable-next-line no-undef
      this.stripe = Stripe("pk_test_51H0icEEfP5i1LDx8esmSOroVwElbIBllJEahdjBZVbcIbDsYYmbW7yH6xGLCZPHj1OiGatEyhXeJ8J1sGh6zSGEu00jOkYNNz3");
      this.api = new DAO();
    },
    methods: {
      getSession:function ()  {
          this.api.getStripeCheckout().then( (result) => {
            this.stripe.redirectToCheckout({sessionId: result.id})
          })
      }
    }
  };
</script>

