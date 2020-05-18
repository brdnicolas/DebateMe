<template>
    <div class="hello">
        <h1>Coucou</h1>
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
