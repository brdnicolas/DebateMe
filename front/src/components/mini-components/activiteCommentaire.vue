<template>
    <div class="content">
        <div>
            <div class="text">
                <p>"</p>
                <h1>Perso je trouve ça pue quoi.</h1>
                <p>"</p>
            </div>

            <div class="bottom">
                <div class="time-comment">
                    <img src="../../assets/icon/time.png"/>
                    <p>Il y a 5 min</p>
                </div>
                <div class="commentaire-comment">
                    <img src="../../assets/icon/comment.png"/>
                    <p>595</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    @Component
    export default class Header extends Vue {
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .content div h1 {
        font-size:22px;
        margin-top:10px;
        font-weight: 500;
        color:black;
        font-style: italic;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 930px;
    }
    .content > div {
        width:100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .text {
        margin-top: 20px;
        margin-left:10px;
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .commentaire img {
        width:18px !important;
        height:18px !important;
    }
    .commentaire-comment img {
        width:15px;
        margin-top:30px;
    }
    .time-comment, .commentaire-comment{
        display:flex;
        flex-direction: row;
        align-items: center;
    }
    .time-comment p, .commentaire-comment p {
        margin-top:30px;
        margin-left:5px;
        padding-right:10px;
    }
    .time-comment img {
        width:15px;
        height:15px;
        margin-left:10px;
        margin-top:30px;
    }
    .bottom {
        display:flex;
        flex-direction: row;
        justify-content: space-between;
        width:100%;
        color:black;
        margin-bottom: 6px;
    }
    .content {
        width:100%;
        height:130px;
        background:white;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.25);
        border-radius: 6px;
        display:flex;
        flex-direction: row;
        margin-top:25px;
    }

</style>
