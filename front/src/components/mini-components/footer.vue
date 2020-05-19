<template>
    <div class="Footer">
        <footer>
            <img src="../../assets/img/logo2.png"/>
            <p>Debate Me © 2020</p>
            <div class="social">
                <img src="../../assets/icon/twitter.png"/>
                <img src="../../assets/icon/facebook.png"/>
                <img src="../../assets/icon/instagram.png"/>
            </div>
        </footer>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    export default class Header extends Vue {
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
        border-top:0.5px solid #faf9f9;
    }
</style>
