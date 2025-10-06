<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-container grid-list-xl fluid>
    <v-layout row wrap>
      <v-flex xs12>
        <v-card>
          <v-card-title class="headline primary white--text">Riscos</v-card-title>
          <div id="app">
            <!-- <v-app id="inspire"> -->
            <v-card>

              <v-card-text>
              <v-card>
              <v-toolbar card color="white">
                <v-text-field
                  flat
                  solo
                  prepend-icon="search"
                  placeholder="Buscar"
                  v-model="search"
                  hide-details
                  class="hidden-sm-and-down"
                ></v-text-field>
              </v-toolbar>
              <cadastrar-risco @event-new-atListaAvaliacoes="atualizarListaAvaliacoes"
                               @event-new-mensagem="recebeMsg"
                               @event-new-snackbar="recebeSnack"
                               @event-new-cor="recebeCor"></cadastrar-risco>
              <v-data-table
                :pagination.sync="pagination"
                :search="search"
                :headers="headers"
                :items="riscos"
                :expand="expand"
                no-data-text="Nenhum resultado encontrado"
                no-results-text="Nenhum resultado encontrado"
              >
                <template v-slot:items="props">
                  <tr @click="props.expanded = !props.expanded">
                    <td class="text-xs-left">{{ props.item.nome }}</td>
                    <td class="text-xs-left">{{ nRisco(props.item.id , props.item.tipo) }}</td>
                    <td class="text-xs-left">{{ props.item.tipo }}</td>
                    <td class="text-xs-left">{{ props.item.categoria.nome }}</td>
                    <td class="text-xs-left">{{ props.item.responsavel.nome }}</td>
                    <td class="text-xs-left">{{ props.item.unidade.sigla }}</td>
                    <td class="justify-center layout px-0">
                      <v-tooltip bottom>
                        <template v-slot:activator="{ on }">
                          <v-btn
                            class="test"
                            depressed
                            outline
                            fab
                            dark
                            icon
                            v-on="on"
                            @click="redirecionarPagina(props.item.id)"
                            color="amber darken-4"
                            small
                          >
                            <v-icon>storage</v-icon>
                          </v-btn>
                        </template>
                        <span>Detalhes</span>
                      </v-tooltip>
                      <v-dialog v-model="editarRisco" persistent max-width="800">
                        <template #activator="{ on: editarRisco }">
                          <v-tooltip bottom>
                            <template #activator="{ on: tooltip }">
                              <v-btn
                                color="primary"
                                dark
                                depressed
                                outline
                                icon
                                fab
                                small
                                v-on="{ ...tooltip, ...editarRisco }"
                                @click="riscoEditar(props.item.id)"
                              >
                                <v-icon>edit</v-icon>
                              </v-btn>
                            </template>
                            <span>Editar</span>
                          </v-tooltip>
                        </template>
                        <v-card>
                          <v-form ref="form" v-model="valid" :lazy-validation="lazy">
                            <v-card-title
                              class="headline primary white--text"
                              primary-title
                            >Editar Risco</v-card-title>
                            <v-card-text>
                              <v-container grid-list-md>
                                <v-layout wrap>
                                  <v-flex xs6 class="text-xs-left">
                                    <h5>
                                      <b>Gestor:</b>
                                      {{risco.responsavel.nome}}
                                    </h5>
                                  </v-flex>
                                  <v-flex xs6 class="text-xs-left">
                                    <h5>
                                      <b>Unidade Responsável:</b>
                                      {{risco.unidade.sigla}}
                                    </h5>
                                  </v-flex>
                                </v-layout>
                                <v-layout wrap>
                                  <v-flex xs12>
                                    <v-text-field
                                      id="inputNomeRisco"
                                      label="Nome do Risco*"
                                      v-model="risco.nome"
                                      :rules="rules.risco.nome"
                                      required
                                      type="text"
                                    ></v-text-field>
                                  </v-flex>
                                </v-layout>
                                <v-layout wrap>
                                  <v-flex xs4 class="text-xs-left">
                                    <h5>
                                      <b>Tipo do Risco:</b>
                                      {{risco.tipo}}
                                    </h5>
                                  </v-flex>
                                  <v-flex xs4>
                                    <v-select
                                      v-model="risco.categoria"
                                      :items="listaCategorias"
                                      item-text="nome"
                                      item-value="id"
                                      return-object
                                      label="Categoria do Risco*"
                                      :rules="rules.risco.categoria"
                                      required
                                    ></v-select>
                                  </v-flex>
                                  <v-flex xs4 class="text-xs-left">
                                    <h5>
                                      <b>Politica:</b>
                                      {{risco.politica.nome}}
                                    </h5>
                                  </v-flex>
                                </v-layout>
                                <v-layout wrap>
                                  <v-flex xs12>
                                    <v-select
                                      v-model="risco.processos"
                                      :items="processos"
                                      :menu-props="{ maxHeight: '400' }"
                                      label="Processo*"
                                      item-text="nome"
                                      multiple
                                      persistent-hint
                                      validate-on-blur
                                      :rules="rules.risco.processos"
                                      required
                                      return-object
                                    ></v-select>
                                  </v-flex>
                                  <v-flex xs12>
                                    <v-text-field
                                      id="inputCausaRisco"
                                      label="Causa do Risco*"
                                      v-model="risco.causa"
                                      :rules="rules.risco.causa"
                                      required
                                      type="text"
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 class="text-xs-left">
                                    <v-text-field
                                      id="inputConsequenciaRisco"
                                      label="Consequência do Risco*"
                                      v-model="risco.consequencia"
                                      :rules="rules.risco.consequencia"
                                      required
                                      type="text"
                                    ></v-text-field>
                                  </v-flex>
                                  <small>*Campos obrigatórios</small>
                                </v-layout>
                              </v-container>
                              <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn
                                  color="primary"
                                  v-on:click="editarRisco = false, salvar()"
                                  @click="validate"
                                  :disabled="!valid"
                                >Editar</v-btn>
                                <v-btn
                                  color="disabled"
                                  v-on:click="editarRisco = false"
                                >Cancelar</v-btn>
                              </v-card-actions>
                            </v-card-text>
                          </v-form>
                        </v-card>
                      </v-dialog>
                      <v-dialog v-model="dialog" persistent max-width="300">
                        <template #activator="{ on: dialog }">
                          <v-tooltip bottom>
                            <template #activator="{ on: tooltip }">
                              <v-btn
                                class="test"
                                depressed
                                outline
                                icon
                                fab
                                dark
                                color="red"
                                small
                                v-on="{ ...tooltip, ...dialog }"
                                @click="riscoGet(props.item.id)"
                              >
                                <v-icon>delete</v-icon>
                              </v-btn>
                            </template>
                            <span>Remover</span>
                          </v-tooltip>
                        </template>
                        <v-card>
                          <v-card-title class="headline">Excluir Risco</v-card-title>
                          <v-card-text>Deseja realmente excluir este Risco?</v-card-text>
                          <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn
                              color="error"
                              small
                              @click="dialog = false,  deletarRisco(flag.id)"
                            >Excluir</v-btn>
                            <v-btn color="disabled" small @click="dialog = false">Cancelar</v-btn>
                          </v-card-actions>
                        </v-card>
                      </v-dialog>
                    </td>
                  </tr>
                </template>
              </v-data-table>
              </v-card>
              </v-card-text>
            </v-card>
          </div>
        </v-card>
      </v-flex>
    </v-layout>
    <v-snackbar :timeout="timeout" right top :color="cor" v-model="snackbar">{{ mensagem }}</v-snackbar>
  </v-container>
</template>

 <script>
import { mapState } from "vuex";
import axios from "axios";
import CadastrarRisco from "./CadastrarRisco";

export default {
  components: {
    CadastrarRisco
  },
  data() {
    return {
      riscoE: {
        categoria: {},
        responsavel: {},
        unidade: {},
        processos: [],
        politica: {},
        avaliacoes: []
      },
      risco: {
        categoria: {},
        responsavel: {},
        unidade: {},
        processos: [],
        avaliacoes: [],
        politica: {}
      },
      pagination: { rowsPerPage: 10 },
      nameRules: [
        v => !!v || "Campo obrigatório",
        v => (v && v.length <= 100) || "O campo deve ter menos de 100 caracteres"
      ],
      row: null,
      date: new Date().toISOString().substr(0, 10),
      date1: new Date().toISOString().substr(0, 10),
      menu1: false,
      menu2: false,
      menu3: false,
      valid: true,
      lazy: false,
      excluirRisco: false,
      del: false,
      listaCategorias: [],
      listaAvaliacoes: [],
      listaPoliticas: [],
      listaImpactos: [],
      listaProbabilidades: [],
      tRisco: "",
      listafatorAvaliacaoControle: [],
      hidden: false,
      search: "",
      expand: false,
      dialog: false,
      editarRisco: false,
      tei: false,
      mensagem: "",
      cor: "",
      flag: "",
      snackbar: false,
      timeout: 3500,
      headers: [
        { text: "Risco", value: "nome" },
        { text: "Nível de Risco", value: "nomeR" },
        { text: "Tipo", value: "tipo" },
        { text: "Categoria", value: "categoria.nome" },
        { text: "Responsável", value: "responsavel.nome" },
        { text: "Unidade Responsvel", value: "uidade.nome" },
        { text: "", sortable: false, value: "" }
      ],
      tipoRisco: [
        { text: "Ameaça", value: "AMEACA" },
        { text: "Oportunidade", value: "OPORTUNIDADE" }
      ],
      periodicidade: [
        { text: "Diaria", value: "DIARIA" },
        { text: "Semanal", value: "SEMANAL" },
        { text: "Quinzenal", value: "QUINZENAL" },
        { text: "Mensal", value: "MENSAL" },
        { text: "Bimestral", value: "BIMESTRAL" },
        { text: "Trimestral", value: "TRIMESTRAL" },
        { text: "Semestral", value: "SEMESTRAL" },
        { text: "Anual", value: "ANUAL" }
      ],
      politicaVirgente: '',
      nivel:[],
      avaliacao:'',

      rules: {
        risco: {
          nome: [v => !!v || 'Nome do Risco é um campo obrigatório'],
          tipo: [v => !!v || 'Tipo do Risco é um campo obrigatório'],
          categoria: [v => !!v || 'Categoria do Risco é um campo obrigatório'],
          processos: [v => v!= undefined && v.length > 0 || 'Adicione pelo menos um Processo'],
          causa: [v => !!v || 'Causa do Risco é um campo obrigatório'],
          consequencia: [v => !!v || 'Consequencia do Risco é um campo obrigatório'],
          controles: [v => !!v || 'Controle do Risco é um campo obrigatório'],
          periodicidade: [v => !!v || 'Periodicidade é um campo obrigatório'],

        },
        avaliacao: {
          impacto: [v => !!v || 'Impacto é um campo obrigatório'],
          probabilidade: [v => !!v || 'Probabilidade é um campo obrigatório'],
          fatorAvaliacaoControle: [v => !!v || 'Fator é um campo obrigatório'],
        }
      }
    };
  },
  computed: {
    inerente() {
      if (
        this.avaliacao.probabilidade != null &&
        this.avaliacao.impacto != null
      ) {
        return (
          this.avaliacao.probabilidade.valor * this.avaliacao.impacto.valor
        );
      }
      return null;
    },
    residual() {
      if (
        this.avaliacao.probabilidade != null &&
        this.avaliacao.impacto != null &&
        this.avaliacao.fatorAvaliacaoControle != null
      ) {
        return (
          this.avaliacao.probabilidade.valor *
          this.avaliacao.impacto.valor *
          this.avaliacao.fatorAvaliacaoControle.valor
        );
      }
      return null;
    },

    computedDateFormatted() {
      return this.formatDate(this.avaliacao.data);
    },
    ...mapState({
      riscos: state => state.riscos.all,
      processos: state => state.processos.all,
      probabilidades: state => state.probabilidades.all,
      politicas: state => state.politicas.all,
      fatoresAvaliacao: state => state.fatoresAvaliacao.all,
      impactos: state => state.impactos.all,
      categorias: state => state.categorias.all,
      usuarios: state => state.usuarios.all,
      tipoProcesso: state => state.tipoProcesso.all
    })
  },
  methods: {
    recebeMsg(dados){
      this.mensagem = dados;
    },
    recebeCor(dados){
      this.cor = dados;
    },
    recebeSnack(dados){
      this.snackbar = dados;
    },
    atualizarListaAvaliacoes() {
      axios.get("/avaliacoes/avaliacoesRecentes").then(res => {
        this.listaAvaliacoes = res.data;
      });
    },

    formatDate(date) {
      if (!date) return null;
      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },

    redirecionarPagina(id) {
      axios.get("/riscos/" + id).then(res => {
        this.$router.push("/riscos/editarRisco/" + id);
      });
    },

    close() {
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },

    riscoEditar(id) {
      axios.get("/riscos/" + id).then(res => {
        this.riscoE = res.data;
        this.risco = this.riscoE;
        this.tRisco = this.riscoE.tipo;
        this.criarListaCategorias();
        this.criarListaProbabilidades();
        this.criarListaImpactos();
        this.criarListafatorAvaliacaoControle();
      });
    },
    salvar() {
      axios
        .put("/riscos/" + this.riscoE.id, this.risco)
        .then(res => {
          this.tei = false;
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Risco editado com sucesso!";
          this.$store.dispatch("riscos/GET_ALL");
        })
        .catch(e => {
          this.mensagem = "Erro ao editar Risco!";
          this.cor = "error";
          this.snackbar = true;
          this.tei = false;
        });
    },

    verificarTratamento(t) {
      if (t === null) {
        return "-";
      } else {
        return t.tratamentoRisco.nome;
      }
    },

    niveis(){
      axios
              .get("/niveisRisco/listar/" + this.politicaVirgente.id)
              .then(res => {
                this.nivel = res.data;
              })
              .catch(error => console.log(error));
    },

    avaliacaoRecente(id) {
      axios.get("/avaliacoes/avaliacaoRecente/" + id).then(res => {
        this.avaliacao = res.data;
      });
      this.nRisco();
    },


    nRisco(id , tipo) {
      var recebe;

      if(tipo === "AMEACA"){
        for (let i = 0; i < this.nivel.length; i++) {
          if (this.nivel[i].valorInicial <= this.listaAvaliacoes[id].impacto.valor * this.listaAvaliacoes[id].probabilidade.valor
                  && this.listaAvaliacoes[id].impacto.valor * this.listaAvaliacoes[id].probabilidade.valor <= this.nivel[i].valorFinal
            ){
              recebe = this.nivel[i].nome;
              return "Risco " + recebe;
          }
        }
      }
      else {
        return " - "
      }

    },

    deletarRisco(id) {
      axios
        .delete("/riscos/" + id)
        .then(res => {
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Risco excluído com sucesso!";
          this.tei = false;
          this.$store.dispatch("riscos/GET_ALL");
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir o Risco!";
          this.cor = "error";
          this.snackbar = true;
          this.tei = false;
        });
    },

    riscoGet(id) {
      axios.get("/riscos/" + id).then(res => {
        this.flag = res.data;
      });
    },
    criarListaCategorias() {
      axios
        .get("/categoriasRisco/listar/" + this.risco.politica.id)
        .then(res => {
          return (this.listaCategorias = res.data);
        })
        .catch(e => {
          //removido o alert
        });
    },
    criarListaImpactos() {
      axios
        .get("/impactos/listar/" + this.risco.politica.id)
        .then(res => {
          return (this.listaImpactos = res.data);
        })
        .catch(e => {
          //removido o alert
        });
    },
    criarListaProbabilidades() {
      axios
        .get("/probabilidades/listar/" + this.risco.politica.id)
        .then(res => {
          return (this.listaProbabilidades = res.data);
        })
        .catch(e => {
          //removido o alert
        });
    },
    criarListafatorAvaliacaoControle() {
      axios
        .get("/fatoresAvaliacao/listar/" + this.risco.politica.id)
        .then(res => {
          return (this.listafatorAvaliacaoControle = res.data);
        })
        .catch(e => {
          //removido o alert
        });
    },

    validate() {
      if (this.$refs.form.validate()) {
        this.snackbar = true;
      }
    },
    reset() {
      this.$refs.form.reset();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
    }
  },

  created() {
    this.$store.dispatch("riscos/GET_ALL");
    axios.get("/avaliacoes/avaliacoesRecentes").then(res => {
      this.listaAvaliacoes = res.data;
    });

    this.$store.dispatch("processos/GET_ALL");
    this.$store.dispatch("usuarios/GET_ALL");
    this.$store.dispatch("politicas/GET_ALL");

    axios.get('politicas/vigente').then(res => {
      this.politicaVirgente = res.data;
      this.niveis();
    });
  }
};
</script>
  <style scoped>
</style>
