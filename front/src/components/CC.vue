<template>
    <div class="poste">

    </div>
</template>
<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import axios from "axios";
    @Component({
        components: {
            headerComponent,
            footerComponent,
        },
    })
    export default class ContactUs extends Vue {
        themes: Array<string>;

        constructor() {
            super();
            this.themes = [];
        }
        mounted() {
            this.getThemes();
        }

        getThemes(): void {
            axios.get('https://api.hugovast.tech/themes', {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                console.log(response.data);

            });
        }


    }
</script>
<style scoped>

</style>