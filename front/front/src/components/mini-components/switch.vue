<template>
    <div class="switch-component-wrapper darkmode-ignore" @click="changeSwitchValue">
        <div class="switch-wrapper" :class="{'on':switchValue, 'off': !switchValue}">
            <div class="circle">
            </div>
        </div>

    </div>
</template>

<script lang="ts">
    import {Component, Prop, Vue} from 'vue-property-decorator';
    @Component
    export default class Header extends Vue {

        // On récupère la variable du parent
        @Prop({default: false})
        switchValue: boolean | undefined;

        // Fonction changeant le switch d'un coté à l'autre
        changeSwitchValue(): void {
            this.$emit('switchValueChanged');
        }
    }
</script>

<style scoped src="../../css/mini-components/switch.css"/>
