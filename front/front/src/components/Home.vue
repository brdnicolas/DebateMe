<template>
    <div class="contactUs">
        <headerComponent />

        <div class="explore-category">
          <div style="dispaly:flex;flex-direction: row;align-items: center;margin-top:20px;margin-left:13px">
            <img src="../../src/assets/icon/explore.png" alt="explore" style="width:31px; height:31px; object-fit: cover;"/>
            <h1 class="darkmode-ignore">Explorer</h1>
          </div>
            <div class="categories-container darkmode-ignore">
                <img @click="SwipeLeft" alt="swipe-left" src="../assets/icon/row.png" />
                <ul id="categories" class="categories">
                    <li style="padding-top:20px;padding-bottom:20px" v-for="item in this.themes" :key="item.created_at">
                        <div class="part" @click.capture="ChangeTheme($event,item.id)" style="background: #FFFFFF;
box-shadow: 0px 6px 20px rgba(89, 89, 89, 0.1);
cursor:pointer;
border-radius: 4px;
display:flex;
flex-direction: row;
align-items: center;
margin-left:20px;
margin-right:20px;
padding-left:20px;
padding-right:20px;
height: 50px;">
                          <img style="width:27px;height:27px;object-fit: cover" :alt="item.name" :title="item.name" v-bind:src="item.logo">
                          <p v-bind:style="'color:' + item.color" style="margin-left:12px">{{item.name}}</p>
                        </div>
                    </li>
                </ul>
                <img @click="SwipeRight" alt="swipe-right" src="../assets/icon/row2.png" />
            </div>
          <svg class="darkmode-ignore" style="margin-left:12px;width:100vw;border-radius:50px" height="2">
            <rect width="300" height="2" style="fill:#F9803B;width:calc(80vw - 24px);border-radius:50px" />
          </svg>
            <div v-if="idThemeActuel !== 0" class="Filter">
                <div>
                  <h4><span class="darkmode-ignore">Date</span></h4>
                    <select>
                      <option selected value="recents">Plus récents</option>
                      <option value="mois">Ce mois-ci</option>
                      <option value="annee">Cette année</option>
                      <option value="ancien">Plus ancien</option>
                    </select>
                </div>
                <div>
                  <h4><span class="darkmode-ignore">Sujet</span></h4>
                    <select>
                        <option selected value="actualite">Actualité</option>
                        <option value="populaire">Populaire</option>
                    </select>
                </div>
            </div>

        </div>
        <div v-if="idThemeActuel !== 0" class="card-list">
            <cardComponent v-for="item in this.listePostes" :themeid="idThemeActuel" :id="item.id" :key="item.id" :titre="item.title" :image="item.image" :date="item.created_at.slice(0,10)"/>
        </div>

        <div class="bienvenue" v-if="idThemeActuel === 0">
            <h1>Bienvenue,</h1>
            <p>Veuillez <span class="darkmode-ignore">choisir une catégorie</span> afin d'explorer les débats !</p>

            <div class="delimiteur"/>

            <h2>Nouveautés : </h2>
            <p>Parmis les nouveautés, nous avons <span class="darkmode-ignore">mis à jour les différents thèmes</span> et le formulaire de contact. Nous comptons sur vos <span class="darkmode-ignore">retours</span> dans le formulaire de contact <a class="darkmode-ignore" href="/contact">ici</a> afin que nous puissions vite nous améliorer !</p>

        </div>
        <footerComponent/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue, Watch } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import cardComponent from '@/components/mini-components/card.vue'
    import DAO from "@/components/DAO";
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
        api =  new DAO();
      constructor() {
            super();
            this.themes = {};
            this.listePostes = {};
            this.idThemeActuel = 0;
        }
        mounted() {
            this.getThemes();
            this.checkToken();
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

        checkToken(): void {
            if(localStorage.token === "") {
                window.location.href = '/';
            }
        }

        async getThemes(): Promise<void> {
            await this.api.getThemes().then(data => {
                this.themes = data as unknown as Record<string, any>
            })
        }

        async getPostesByTheme(): Promise<void> {
          await this.api.getPostesByTheme(this.idThemeActuel).then(data => {
              this.listePostes = data as unknown as Record<string, any>
          })
        }

        ChangeTheme(e: Event, id: number): void {
            let target = e.target as HTMLTextAreaElement;
            if(target.tagName != 'DIV')
             target = target.parentElement as HTMLTextAreaElement
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
        color:#353640;
    }
    .bienvenue > h1 {
        font-size:40px;
        font-weight: 500;
        color:#353640;
    }
    .bienvenue > p {
        margin-top:10px;
        padding-bottom:50px;
        width:50vw;
        font-weight: 400;
        color:#353640;
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
    .darkmode--activated select {
      color:black !important;
    }
    .Filter input, .Filter select {
        width: 250px;
        height: 45px;
        bdorder: 2px solid #EFEFEF;
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
    .explore-category > div > h1 {
        font-style: normal;
        font-weight: 500;
        font-size: 20px;
        color: #F9813B;
        margin-left:10px;
        margin-top:50px;

    }
    .categories-container {
        display:flex;
        flex-direction: row;
        padding-bottom:30px;
        align-items: center;
        width:100%;
    }
    .categories-container > img:nth-child(1) {
        width:48px;
        height:48px;
        object-fit: cover;
        padding-right:10px;
        margin-top:25px;
        cursor:pointer;
    }
    .categories-container > img:nth-child(3) {
      width:48px;
      height:48px;
      object-fit: cover;
      padding-left:10px;
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
        border: 2px solid #F9813B;
        margin-left:15px;
        margin-right:15px;
        cursor:pointer;
    }
    #selected {
        display: flex;
        min-height: min-content;
        object-fit: cover;
        border-radius: 50px;
        border: 2px solid #1569ff;
        margin-left:15px;
        margin-right:15px;
        cursor:pointer;
    }
    .darkmode--activated .part {
      background:#25292F !important;
    }
</style>