<template>
    <div class="card">
        <img src="../../assets/tmp/corona.png"/>
        <h3>Devrons-nous tester toute la population de France pour faire disparaitre au plus vite le coronavirus?</h3>
        <div class="upvote">
            <div class="date-sujet">
                <p>1er juillet 2020</p>
            </div>
            <div>
                <p>35</p>
                <img alt="up" src="../../assets/icon/up.png"/>
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
    .date-sujet p {
        margin-left:10px;
        color:#749cd7;
    }
    .card {
        width:420px;
        height:250px;
        overflow: hidden;
        border-radius: 6px;
        box-shadow: 0px 0px 25px rgba(0, 0, 0, 0.15);
        background: white;
        margin:50px 100px 50px 0;
        cursor:pointer;
    }
    .card h3 {
        padding:5px 10px 10px 10px;
        white-space: nowrap;
        overflow: hidden;
        color:#175bab;
        text-overflow: ellipsis;
        max-width: 500px;
    }
    .card .upvote {
        display:flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }
    .card .upvote div {
        display:flex;
        flex-direction: row;
        align-items: center;
        padding-right: 10px;
    }
    .card .upvote img {
        width:12px;
        height:12px;
    }
    .card .upvote p {
        font-size:14px;
        padding-top:2px;
        font-weight: bold;
        color:#749cd7;
        padding-right: 2px;
    }
    .card img {
        width:100%;
        height:180px;
        object-fit: cover;
        border-radius: 6px 6px 0 0;
    }
</style>
