<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <Test/>
  </div>
</template>

<!--<script>
import Test from './Test.vue';

export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  components: {
    Test,
  },
};
</script>-->

<script lang="ts">
  import { Vue, Component, Prop } from 'vue-property-decorator'

  @Component
export default class HelloWorld extends Vue {
  @Prop(Number) readonly propA: number | undefined;
  @Prop({ default: 'default value' }) readonly propB!: string;
  @Prop([String, Boolean]) readonly propC: string | boolean | undefined
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
