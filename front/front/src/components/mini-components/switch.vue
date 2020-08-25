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
        @Prop({default: false})
        switchValue: boolean | undefined;

        changeSwitchValue(): void {
            this.$emit('switchValueChanged');
        }

    }
</script>

<style scoped>
    .switch-component-wrapper {
        display:flex;
    }
    .switch-wrapper {
        width:44px;
        min-height: 22px;
        display:flex;
        cursor:pointer;
        border-radius:22px;
        align-items: center;
        padding:2px;
        transition: 0.5s;
    }
    .on {
        background: #C0FEBD;
        justify-content: flex-end;
    }
    .off {
        background: #D8D8D8;
        justify-content: flex-start;
    }
    .circle {
        background:white;
        width:18px;
        height:18px;
        border-radius: 18px;
        display:flex;
        justify-content: center;
        align-items: center;
    }

</style>
