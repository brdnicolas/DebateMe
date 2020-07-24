<template>
    <div class="contactUs">
        <headerComponent />
        <div class="contact">
            <div class="card">
                <h1>Ecrivez-nous une petite ligne</h1>
                <h3>Comment pouvons-nous vous aider ?</h3>
                <form>
                    <div class="left">
                        <h4>Nom</h4>
                        <input type="text" placeholder="Entrez votre nom"/>
                        <h4>Message</h4>
                        <textarea type="text" placeholder="Entrez vos plus belles phrases"/>
                    </div>
                    <div class="right">
                        <h4>Email</h4>
                        <input type="email" placeholder="Entrez votre email"/>
                        <h4>Raison de votre message</h4>
                        <select v-model="selectRaison">
                            <option disabled>{{selectRaison}}</option>
                            <option>Je veux signaler un problème 😥</option>
                            <option>C'est un message d'amour 👉🏼👈🏼</option>
                            <option>Je veux me plaindre ! 😡</option>
                            <option>Autre 🕵🏼‍♂️</option>
                        </select>
                        <button type="submit">Envoyer</button>
                    </div>
                </form>
            </div>
        </div>
        <footerComponent style=" background:#F6FAFF;"/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    @Component({
        components: {
            headerComponent,
            footerComponent
        },
	data () {
		return {
			selectRaison:"Veuillez choisir une raison"
		}
	}
    })
    export default class HelloWorld extends Vue {
        mounted() {
            this.checkToken();
        }
        checkToken(): void {
            if(localStorage.token === "") {
                window.location.href = '/';
            }
        }

    }
</script>
<style scoped>
    .contact {
        display:flex;
        justify-content: center;
        align-items: center;
        height:100%;
        width:100%;
        padding:200px 0 200px 0;
        background:#F6FAFF;
    }
    .card h4 {
        font-style: normal;
        font-weight: 500;
        font-size: 18px;
        line-height: 18px;
        color: #1072FF;
        padding-bottom:8px;
        margin-top:50px;
    }
    .card form {
        margin-top:50px;
        display:flex;
        flex-direction: row;
    }
    .card form .right, .card form .left {
        display:flex;
        flex-direction: column;
        margin-left:50px;
        margin-right:50px;
    }
    .card input, .card select{
        width: 350px;
        height: 51px;
        border: 2px solid #EFEFEF;
        box-sizing: border-box;
        border-radius: 5px;
        padding:10px;
        outline:none;
        color:#1644A4;
        font-weight: bold;
    }
    .card button {
        width: 350px;
        height:53px;
        background: #1864FF;
        border-radius: 5px;
        margin-top:86px;
        border:none;
        cursor:pointer;
        color: #F7F9FF;
        font-weight: 500;
        font-size: 18px;
        text-transform: uppercase;
    }
    .card textarea {
        width: 350px;
        height: 190px;
        border: 2px solid #EFEFEF;
        box-sizing: border-box;
        border-radius: 5px;
        padding:10px;
        outline:none;
        resize: none;
        color:#1644A4;
        font-weight: bold;
    }
    .card input::placeholder, .card textarea::placeholder, .card select:disabled {
        color: #BCBCCA;
        font-weight: 600;
    }
    .card {
        background:white;
        box-shadow: 0px 0px 25px rgba(0, 0, 0, 0.15);
        border-radius: 4px;
        display:flex;
        justify-content: center;
        flex-direction: column;
        align-items: center;
        padding:80px 150px 80px 150px;

    }
    .card h1 {
        font-style: normal;
        font-weight: 500;
        font-size: 40px;
        color: #154A85;
    }
    .card h3 {
        font-style: normal;
        font-weight: 500;
        font-size: 18px;
        color: #154A85;

    }
   .contactUs {
       background:#F6FAFF;
   }
</style>
