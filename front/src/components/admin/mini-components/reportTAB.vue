<template>
    <tr>
      <td>{{ date }}</td>
      <td>{{ type }}</td>
      <td>{{ pseudoSignale }}</td>
      <td>{{ contentPost }}</td>
      <td>{{pseudoReporteur}}</td>
      <td>{{ message }}</td>
      <td><button @click="garder" class="garder">Garder</button></td>
      <td><button @click="supprimer" class="supprimer">Supprimer</button></td>
    </tr>
</template>

<script lang="ts">
// @ts-nocheck
import {Component, Prop, Vue} from 'vue-property-decorator';
import report from "@/components/admin/mini-components/report-comp.vue";
import Menu from "@/components/admin/Menu.vue";
import Header from "@/components/mini-components/header.vue";
import DAO from "@/components/DAO";


@Component({
  components: {
    Header,
    report,
    Menu
  },
})



export default class HelloWorld extends Vue {
  mounted() {
    this.getRaisonReport();
    this.getPost();
    this.getUserWhoReport();
  }

  type: string;
  contentPost: string;
  pseudoReporteur: string;
  pseudoSignale: string;
  api = new DAO();

  @Prop({default: ""})
  date: string | undefined;
  @Prop({default: 0})
  reportID: number | undefined;
  @Prop({default: 0})
  postID: number | undefined;
  @Prop({default: 0})
  userWhoReported: number | undefined;
  @Prop({default: "Aucun"})
  message: string | undefined;
  @Prop({default: 0})
  reasonID: number | undefined;

  constructor() {
    super();
    this.type = "";
    this.contentPost = "";
    this.pseudoReporteur = "";
    this.pseudoSignale = "";
  }

  async getRaisonReport() {
      this.api.getRaisonReport().then(datas => {
          datas.forEach(element => {
            if(element.id == this.reasonID)
              this.type = element.reason;
          });
      })
  }

  async getPost() {
    await this.api.getPostByID(this.postID).then(datas => {
        this.contentPost = datas.content;
        this.getUserReported(datas.user_id);
    })
  }

  async garder(): Promise<void> {
    await this.api.deleteReport(this.reportID).then(datas => {
      this.$router.go(0);
    })
  }

  async supprimer(): Promise<void> {
    await this.api.deletePost(this.postID).then(datas => {
      this.$router.go(0);
    })
  }

  async getUserWhoReport() {
      await this.api.getUserByID(this.userWhoReported).then( datas => {
            this.pseudoReporteur = datas.username;
      })
  }

  async getUserReported(userID) {
    await this.api.getUserByID(userID).then( datas => {
      this.pseudoSignale = datas.username;
    })
  }




}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
td {
  padding: 5px 10px !important;
  color:#AAABAD;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 0;
}
td:hover {
  white-space: normal;
}
.garder {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:100%;
  height:40px;
  background-color: #76E27E;
  color: white;
  padding: 10px 0 10px 0;
  cursor:pointer;
  text-transform: uppercase;
}
.garder:hover {
  transition:0.2s;
  background:#6BCE73;
}

.supprimer {
  transition:0.2s;
  border-radius: 6px;
  border: none;
  width:100%;
  height:40px;
  background-color: #F6786D;
  color: white;
  padding: 10px 0 10px 0;
  cursor:pointer;
  text-transform: uppercase;
}
.supprimer:hover {
  transition:0.2s;
  background:#D76960;
}

table.blueTable td, table.blueTable th {
  border: 2px solid #E5E5E5;
  padding: 0px 2px;
}
table.blueTable thead {
  border-bottom: 2px solid #E5E5E5;
}
table.blueTable tfoot td {
  font-size: 14px;
}
table.blueTable tfoot .links {
  text-align: right;
}
table.blueTable tfoot .links a{
  display: inline-block;
  background: #1C6EA4;
  color: #AAABAD;
  padding: 2px 8px;
  border-radius: 5px;
}

</style>
