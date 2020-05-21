<template>
    <div class="contactUs">
        <headerComponent />

        <div class="explore-category">
            <h1>Explorer les catégories</h1>
            <div class="categories-container">
                <img @click="SwipeLeft" alt="swipe-left" src="../assets/icon/row.png" />
                <ul id="categories" class="categories">
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                    <li>
                        <img src="../assets/categories/nature.jpg" title="nature"/>
                    </li>
                </ul>
                <img @click="SwipeRight" alt="swipe-right" src="../assets/icon/row2.png" />
            </div>
            <div class="Filter">
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
        <div class="card-list">
            <cardComponent/>
            <cardComponent/>
            <cardComponent/>
            <cardComponent/>
        </div>
        <footerComponent/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from 'vue-property-decorator'
    import headerComponent from '@/components/mini-components/header.vue'
    import footerComponent from '@/components/mini-components/footer.vue'
    import cardComponent from '@/components/mini-components/card.vue'
    @Component({
        components: {
            headerComponent,
            footerComponent,
            cardComponent,
        },
    })
    export default class ContactUs extends Vue {
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
    }
</style>