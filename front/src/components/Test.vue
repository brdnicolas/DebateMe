<template>
  <div>
    <p>TEST</p>
    <button @clicl="getTest()">Refresh</button>
    <ul>
      <li v-for="test in tests" :key="test.id">{{test.name}}</li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  created() {
    this.getTest();
  },
  name: 'Test',
  data() {
    return {
      errors: [],
      tests: [],
    };
  },
  methods: {
    getTest() {
      axios.get(
        'http://localhost:5000/test',
      ).then((response) => {
        this.tests = response.data;
      })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>

<style>

</style>
