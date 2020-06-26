<template>
    <div class="main">
        <div class="menu">
            <div id="logo">
                <img alt="logo" src="../../assets/img/logo2.png"/>
            </div>
            <div>
                <img alt="dashboard" src="../../assets/icon/admin/dashboard.png"/>
                <a href="/panel">Dashboard</a>
            </div>
            <div>
                <img alt="report" src="../../assets/icon/admin/report.png"/>
                <a href="/panel/reports">Signalements</a>
            </div>
        </div>
        <div class="content">
            <div class="content-top">
                <p>heello</p>
            </div>
            <div class="content-bottom">
                <p>aled</p>
            </div>
        </div>


    </div>

</template>

<script lang="ts">
    import { Component, Prop, Vue } from 'vue-property-decorator';
    import axios from "axios"


    @Component({
        components: {
        },
    })

    export default class HelloWorld extends Vue {
        mounted() {
            this.checkAdmin();
        }

        async checkAdmin(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/users/me/profile",{
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function(response) {
                rep = response.data;
            });
            if (rep) {
               if( !(rep as Record<string,any>).isAdmin )
                   window.location.href = '/';
            }
        }


    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .content-bottom {
        height:calc(100vh - 300px);
        width: calc(100vw - 220px);
        background:#f8f9fe;
    }
    .content-top {
        height:300px;
        width: calc(100vw - 220px);
        background:#2AB2FF;
    }
    .main {
        display: flex;
        flex-direction: row;
    }
    #logo {
        display:flex;
        align-items: center;
        justify-content: center;
    }
    #logo img{
        width:130px;
        height:130px;
    }
    .menu {
        z-index:10;
        display:flex;
        flex-direction: column;
        width:200px;
        min-height: 100vh;
        background:white;
        padding:10px 10px 10px 20px;
    }

    .menu a {
        text-decoration: none;
        color:black;
    }

    .menu > div {
        display:flex;
        flex-direction: row;
        align-items: center;
        margin-top:15px;
        margin-bottom:5px;
        cursor:pointer;
    }

    .menu > div > img {
        width:20px;
        height:20px;
        margin-right:10px;
    }

</style>
