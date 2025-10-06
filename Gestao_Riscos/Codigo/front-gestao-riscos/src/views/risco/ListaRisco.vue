<template>
  <div>
    <v-card-widget :title="'Eventos de Riscos'" enableHeader>
      <div slot="widget-header-action">
        <v-btn class="ma-2" outlined color="primary" to="/riscos/cadastrar"
          >Novo Evento de Risco</v-btn
        >
      </div>
      <div slot="widget-content">
        <v-row>
          <v-col cols="6">
            <v-select
              label="Tipo de evento"
              prepend-icon="filter_alt"
              v-model="tipo"
              item-text="nome"
              item-value="id"
              :items="tiposRisco"
            ></v-select>
          </v-col>
          <v-col cols="6">
            <v-text-field
              v-model="search"
              label="Buscar"
              single-line
              prepend-inner-icon="search"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12">
            <v-data-table
              :headers="headers"
              :items="riscosFilter"
              class="elevation-1"
              :search="search"
            >
              <template v-slot:[`item.nome`]="{ item }">
                <a :href="'/riscos/' + item.id" class="text-decoration-none">{{
                  item.nome
                }}</a>
              </template>
              <template v-slot:[`item.tipo`]="{ item }">
                <v-chip
                  v-if="item.tipo === 'AMEACA'"
                  class="mr-1"
                  color="error lighten-1"
                  label
                  >Ameaça</v-chip
                >
                <v-chip
                  v-if="item.tipo === 'OPORTUNIDADE'"
                  color="success lighten-1"
                  label
                  >Oportunidade</v-chip
                >
              </template>
              <template v-slot:[`item.acoes`]="{ item }">
                <v-tooltip bottom>
                  <template v-slot:activator="{ on, attrs }">
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          class="mr-1"
                          icon
                          color="primary"
                          v-bind="attrs"
                          v-on="on"
                          @click.stop="editDialog(item)"
                          ><v-icon>create</v-icon></v-btn
                        >
                      </template>
                      <span>Editar</span>
                    </v-tooltip>
                  </template>
                </v-tooltip>
              </template>
            </v-data-table>
          </v-col>
        </v-row>
      </div>
    </v-card-widget>
  </div>
</template>

<script>
import { mapState } from "vuex";
import VCardWidget from "@/components/VWidget";
import { RepositoryFactory } from "../../repositories/RepositoryFactory";
const riscoRepository = RepositoryFactory.get("risco");

export default {
  components: {
    VCardWidget,
  },

  data: () => ({
    breadcrumbItems: [
      { position: 1, text: "Início", disabled: false, href: "/" },
      { position: 2, text: "Eventos de Risco", disabled: true },
    ],
    search: "",
    headers: [
      { text: "Título", value: "nome", sortable: true },
      { text: "Tipo", value: "tipo", filterable: false },
    ],
    riscos: [],
    tiposRisco: [
      { id: "", nome: "Todos" },
      { id: "AMEACA", nome: "Ameaça" },
      { id: "OPORTUNIDADE", nome: "Oportunidade" },
    ],
    tipo: "",
    formValid: true,
    update: false,
    dialog: false,
    dialogTitle: "Cadastrar",
    dialogRemove: false,
    currentItem: null,

    rules: {
      nome: [(v) => !!v || "Campo obrigatório"],
    },
  }),

  created() {
    this.$store.commit("app/setBreadcrumb", this.breadcrumbItems);
    this.getRiscos();
  },

  methods: {
    getRiscos() {
      riscoRepository.findByUnidade(this.plano.id).then((res) => {
        this.riscos = res.data;
      });
    },

    editar() {
      if (this.$refs.form.validate()) {
        riscoRepository.editar(this.currentItem, this.risco).then((res) => {
          this.riscos.splice(
            this.riscos.findIndex((i) => i.id == this.currentItem),
            1,
            res.data
          );
          this.dialog = false;
        });
      }
    },
  },

  watch: {
    dialog: function(val) {
      if (!val) {
        this.closeDialog();
      }
    },
  },

  computed: {
    riscosFilter() {
      if (this.tipo === "") {
        return this.riscos;
      }
      return this.riscos.filter((risco) => {
        return risco.tipo === this.tipo;
      });
    },
    ...mapState({
      plano: (state) => state.app.plano,
    }),
  },
};
</script>
<style scoped>
.center {
  margin-left: 13%;
}
</style>
