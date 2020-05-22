<template>
    <div class="content">
        <img alt="corona" src="../../assets/tmp/pq.jpg"/>
        <div>
            <h1>Que pensez-vous de la pénurie du papier toilette dans les supermarchés ?Que pensez-vous de la pénurie du papier toilette dans les supermarchés ?Que pensez-vous de la pénurie du papier toilette dans les supermarchés ?Que pensez-vous de la pénurie du papier toilette dans les supermarchés ?</h1>
            <div class="bottom">
                <div class="time">
                    <img src="../../assets/icon/time.png"/>
                    <p>Il y a 5 min</p>
                </div>
                <div class="commentaire">
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
    .time, .commentaire {
        display:flex;
        flex-direction: row;
        align-items: center;
        padding-left:10px;
        padding-right: 10px;
        margin-top:70px;
    }
    .bottom {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }
    .bottom img {
        width:15px;
        height:15px;
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
    .content > img {
        width:250px;
        height:100%;
        object-fit: cover;
        border-radius: 6px 0 0 6px;
    }
    .content > div {
        width:100%;
    }
    .content > div > h1 {
        font-size:22px;
        margin-top:10px;
        margin-left:10px;
        font-weight: 500;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 650px;
        color:#175bab;
    }
</style>
