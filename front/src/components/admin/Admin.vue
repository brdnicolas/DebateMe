<template>
    <div>
        <header-component/>
        

        <footer-component/>
    </div>

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import headerComponent from "@/components/mini-components/header.vue";
    import footerComponent from "@/components/mini-components/footer.vue";
    import activitePoste from "@/components/mini-components/activitePoste.vue"
    import activiteCommentaire from "@/components/mini-components/activiteCommentaire.vue"


    @Component({
        components: {
            headerComponent,
            footerComponent,
            activitePoste,
            activiteCommentaire,
        },
    })

    export default class HelloWorld extends Vue {

    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
