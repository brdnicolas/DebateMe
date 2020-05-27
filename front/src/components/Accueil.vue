<template>
    <div class="contactUs">
        <headerComponent />

        <div class="explore-category">
            <h1>Explorer les catégories</h1>
            <div class="categories-container">
                <img @click="SwipeLeft" alt="swipe-left" src="../assets/icon/row.png" />
                <ul id="categories" class="categories">
                    <li v-for="item in this.themes" :key="item.created_at">
                        <img :class="'theme' + item.id" id="notselected" @click="ChangeTheme($event,item.id)" :alt="item.name" :title="item.name" src="../assets/categories/nature.jpg"/>
                    </li>
                </ul>
                <img @click="SwipeRight" alt="swipe-right" src="../assets/icon/row2.png" />
            </div>
            <div v-if="idThemeActuel !== 0" class="Filter">
                <div>
                    <h4>Date</h4>
                    <select>
                        <option selected value="recents">Plus récents</option>
                        <option value="mois">Ce mois-ci</option>
                        <option value="annee">Cette année</option>
                        <option value="ancien">Plus ancien</option>
                    </select>
                </div>
                <div>
                    <h4>Sujet</h4>
                    <select>
                        <option selected value="actualite">Actualité</option>
                        <option value="populaire">Populaire</option>
                    </select>
                </div>
            </div>

        </div>
        <div v-if="idThemeActuel !== 0" class="card-list">
            <cardComponent v-for="item in this.listePostes" :themeid="idThemeActuel" :id="item.id" :key="item.id" :titre="item.title" :date="item.created_at.slice(0,10)"/>
        </div>

        <div class="bienvenue" v-if="idThemeActuel === 0">
            <h1>Bienvenue,</h1>
            <p>Veuillez <span>choisir une catégorie</span> afin d'explorer les débats !</p>

            <div class="delimiteur"/>

            <h2>Nouveautés : </h2>
            <p>Parmis les nouveautés, nous avons <span>mis à jour les différents thèmes</span> et le formulaire de contact. Nous comptons sur vos <span>retours</span> dans le formulaire de contact <a href="/contact">ici</a> afin que nous puissions vite nous améliorer !</p>

        </div>

        <footerComponent/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue, Watch } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import cardComponent from '@/components/mini-components/card.vue'
    import axios from "axios";
    @Component({
        components: {
            headerComponent,
            footerComponent,
            cardComponent,
        },
    })
    export default class ContactUs extends Vue {
        themes: Record<string, any>;
        listePostes: Record<string, any>;
        idThemeActuel: number;
        constructor() {
            super();
            this.themes = {};
            this.listePostes = {};
            this.idThemeActuel = 0;
        }
        mounted() {
            this.getThemes();
        }
        computed() {
            const element = document.getElementById("categories");
            if (element) {
                console.log(element.firstChild);
            }
        }

        @Watch('idThemeActuel')
        onPropertyChanged(value: string, oldValue: string) {
            this.getPostesByTheme();
        }

        async getThemes(): Promise<void> {
            let rep = null;
            await axios.get('https://api.hugovast.tech/themes', {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
               rep = response.data;
               console.log(response.data)
            });
            if (rep)
                this.themes = rep;
        }

        async getPostesByTheme(): Promise<void> {
            let rep = null;
            await axios.get("https://api.hugovast.tech/themes/" + this.idThemeActuel + "/questions", {
                headers: {
                    Authorization: localStorage.token //the token is a variable which holds the token
                }
            }).then(function (response) {
                rep = response.data;
                console.log(rep);
            });
            if (rep)
                this.listePostes = rep;
        }

        ChangeTheme(e: Event, id: number): void {
            const target = e.target as HTMLTextAreaElement;
            const selected = document.getElementById('selected');
            if (selected) {
                selected.id = 'notselected';
            }
            if (target) {
                target.id = 'selected';
            }
            this.idThemeActuel = id;
        }

        SwipeLeft (): void {
            const ele = document.getElementById("categories");
            if(ele != null) {
                let scrollAmount = 0;
                const slideTimer = setInterval(function(){
                    ele.scrollLeft -= 10;
                    scrollAmount += 10;
                    if(scrollAmount >= 200){
                        window.clearInterval(slideTimer);
                    }
                }, 25);
            }
        }
        SwipeRight (): void {
            const ele = document.getElementById("categories");
            if(ele != null) {
                let scrollAmount = 0;
                const slideTimer = setInterval(function(){
                    ele.scrollLeft += 10;
                    scrollAmount += 10;
                    if(scrollAmount >= 200){
                        window.clearInterval(slideTimer);
                    }
                }, 25);
            }
        }
    }
</script>
<style scoped>
    .bienvenue {
        margin:50px 10vw 16% 10vw;
    }
    .bienvenue > h1 {
        font-size:40px;
        font-weight: 500;
    }
    .bienvenue > p {
        margin-top:10px;
        padding-bottom:50px;
        width:50vw;
        font-weight: 400;
    }
    .bienvenue span {
        color:#048aff;
        font-weight: 500;
    }
    .bienvenue a {
        color:#048aff;
        font-weight: 500;
    }
    .card-list {
        width:calc(80% + (100px *2));
        margin-left:calc(10% );
        height:40%;
        padding: 50px 0 50px 0;
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        min-height: 40vh;
    }
    .Filter {
        font-style: normal;
        font-weight: 500;
        font-size: 18px;
        line-height: 18px;
        color: #1072FF;
        margin-top:50px;
        display:flex;
        flex-direction: row;
    }
    .Filter div {
        margin-right:40px;
    }
    .Filter input, .Filter select {
        width: 250px;
        height: 45px;
        border: 2px solid #EFEFEF;
        box-sizing: border-box;
        border-radius: 5px;
        padding: 10px;
        outline: none;
        color: #1644A4;
        font-weight: bold;
        margin-top:15px;
    }
    .explore-category {
        width:80vw;
        min-width: 80vw;
        margin-left:10vw;
    }
    .explore-category > h1 {
        font-style: normal;
        font-weight: 500;
        font-size: 20px;
        color: #E6654A;
        margin-left:15px;
        margin-top:50px;

    }
    .categories-container {
        display:flex;
        flex-direction: row;
        padding-bottom:30px;
        align-items: center;
        border-bottom: 2px solid #E6654A;
        width:100%;
    }
    .categories-container > img {
        width:20px;
        height:35px;
        padding-left:20px;
        padding-right:20px;
        margin-top:25px;
        cursor:pointer;
    }
    .categories {
        margin-top:30px;
        min-width: calc(80vw - 120px);
        display:flex;
        flex-direction: row;
        list-style: none;
        overflow:hidden;
    }
    .categories li > img {
        display: flex;
        min-height: min-content;
        width:70px;
        height:70px;
        object-fit: cover;
        border-radius: 50px;
        border: 2px solid #E6654A;
        margin-left:15px;
        margin-right:15px;
        cursor:pointer;
    }
    #selected {
        display: flex;
        min-height: min-content;
        width:70px;
        height:70px;
        object-fit: cover;
        border-radius: 50px;
        border: 2px solid #1569ff;
        margin-left:15px;
        margin-right:15px;
        cursor:pointer;
    }
</style>