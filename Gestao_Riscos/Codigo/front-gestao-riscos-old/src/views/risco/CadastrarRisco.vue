<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-layout row justify-center>
    <v-dialog v-model="tei" persistent max-width="800">
      <template #activator="{ on: tei }">
        <v-tooltip bottom>
          <template #activator="{ on: tooltip }">
            <v-fab-transition>
              <v-btn
                v-on="{ ...tooltip, ...tei }"
                v-show="!hidden"
                color="cyan"
                dark
                absolute
                top
                right
                fab
              >
                <v-icon>add</v-icon>
              </v-btn>
            </v-fab-transition>
          </template>
          <span>Novo Risco</span>
        </v-tooltip>
      </template>

      <v-card>
        <v-form ref="form" v-model="valid" :lazy-validation="lazy">
          <v-card-title class="headline primary white--text" primary-title>Novo Risco</v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <h5>
                <b>Identificação do Risco</b>
              </h5>
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
                <v-flex xs4>
                  <v-select
                    v-model="risco.tipo"
                    :items="tipoRisco"
                    label="Tipo do Risco*"
                    :rules="rules.risco.tipo"
                    required
                  ></v-select>
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
                    label="Processos*"
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
              </v-layout>
              <div v-if="(risco.tipo === 'AMEACA')">
                <h5>
                  <b>Avaliação do Risco</b>
                </h5>
                <v-layout wrap>
                  <v-flex xs4>
                    <v-select
                      v-model="avaliacao.impacto"
                      :items="listaImpactos"
                      item-text="nome"
                      item-value="id"
                      return-object
                      label="Impacto*"
                      :rules="rules.avaliacao.impacto"
                      required
                    ></v-select>
                  </v-flex>
                  <v-flex xs4>
                    <v-select
                      v-model="avaliacao.probabilidade"
                      :items="listaProbabilidades"
                      :rules="rules.avaliacao.probabilidade"
                      item-text="nome"
                      item-value="id"
                      return-object
                      label="Probabilidade*"
                    ></v-select>
                  </v-flex>
                  <v-flex xs4 class="text-xs-left">
                    <v-text-field
                      label="Risco Inerente"
                      disabled
                      :value="inerente"
                      center
                      type="text"
                    ></v-text-field>
                  </v-flex>
                </v-layout>
                <v-layout wrap>
                  <v-flex xs12 class="text-xs-left">
                    <v-text-field
                      id="inputControlesRisco"
                      label="Controle do Risco*"
                      v-model="risco.controles"
                      :rules="rules.risco.controles"
                      required
                      type="text"
                    ></v-text-field>
                  </v-flex>
                </v-layout>
                <v-layout wrap>
                  <v-flex xs6>
                    <v-select
                      v-model="avaliacao.fatorAvaliacaoControle"
                      :items="listafatorAvaliacaoControle"
                      item-text="nome"
                      item-value="id"
                      return-object
                      label="Fator de Avaliação dos Controles*"
                      :rules="rules.avaliacao.fatorAvaliacaoControle"
                      required
                    ></v-select>
                  </v-flex>
                  <v-flex xs6 class="text-xs-left">
                    <v-text-field
                      label="Risco Residual"
                      disabled
                      :value="residual"
                      center
                      type="text"
                    ></v-text-field>
                  </v-flex>
                </v-layout>
                <v-layout wrap>
                  <v-flex xs6>
                    <v-select
                      v-model="risco.periodicidadeAvaliacao"
                      :items="periodicidade"
                      label="Periodicidade do Risco*"
                      :rules="rules.risco.periodicidadeAvaliacao"
                      required
                    ></v-select>
                  </v-flex>
                  
                  <v-flex xs12 sm6>
                    <v-menu
                      v-model="menu3"
                      :close-on-content-click="false"
                      :nudge-right="50"
                      lazy
                      transition="scale-transition"
                      offset-y
                      full-width
                      min-width="290px"
                    >
                      <template v-slot:activator="{ on }">
                        <v-text-field
                          required
                          id="teste1"
                          :value="computedDateFormatted"
                          label="Data da Avaliação*"
                          persistent-hint
                          append-icon="event"
                          readonly
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker v-model="avaliacao.data" @input="menu3 = false" locale="pt-br"></v-date-picker>
                    </v-menu>
                  </v-flex>
                </v-layout>    
              </div>
              <small>*Campos obrigatórios</small>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="primary"
              v-on:click="salvarRisco()"
              @click="validate"
              :disabled="!valid"
            >Salvar</v-btn>
            <v-btn color="disabled" v-on:click="tei=false,  reset()">Cancelar</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import { mapState, mapActions } from "vuex";
import axios from "axios";

export default {
  data() {
    return {
      valid: true,
      nameRules: [
        v => !!v || "Campo obrigatório",
        v => (v && v.length <= 100) || "O campo deve ter menos de 100 caracteres"
      ],
      lazy: false,
      addRisco: false,
      listaPoliticas: [],
      listaCategorias: [],
      listaImpactos: [],
      listaProbabilidades: [],
      listafatorAvaliacaoControle: [],
      avaliacao: {
        probabilidade: null,
        impacto: null,
        fatorAvaliacaoControle: null,
        responsavel: {},
        risco: {},
        data: new Date().toISOString().substr(0, 10)
      },
      processo: {},
      risco: {
        categoria: null,
        responsavel: {},
        unidade: {},
        processos: [],
        avaliacoes: [],
        politica: {}
      },

      tei: false,
      hidden: false,
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
      row: null,
      date: new Date().toISOString().substr(0, 10),
      date1: new Date().toISOString().substr(0, 10),
      menu1: false,
      menu2: false,
      menu3: false,

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
    ...mapState({
      processos: state => state.processos.all,
      probabilidades: state => state.probabilidades.all,
      politicas: state => state.politicas.all,
      fatoresAvaliacao: state => state.fatoresAvaliacao.all,
      impactos: state => state.impactos.all,
      categorias: state => state.categorias.all,
      usuarios: state => state.usuarios.all,
      tipoProcesso: state => state.tipoProcesso.all
    }),

    computedDateFormatted() {
      return this.formatDate(this.avaliacao.data);
    }
  },
  methods: {
    formatDate(date) {
      if (!date) return null;
      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
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
      console.log(this.avaliacao.data)
      this.$refs.form.reset();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
    },

    salvarRisco() {
      if (this.risco.tipo == "AMEACA") {
        this.risco.avaliacoes.push(this.avaliacao);
      }
      axios
        .post("/riscos", this.risco)
        .then(res => {
          this.reset();
          this.tei = false;
          this.risco.avaliacoes = [];

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Risco cadastrado com sucesso!";

          this.$emit("event-new-snackbar", this.snackbar);
          this.$emit("event-new-mensagem", this.mensagem);
          this.$emit("event-new-cor", this.cor);
          this.$emit("event-new-atListaAvaliacoes", res.data);
          this.$store.dispatch("riscos/GET_ALL");
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Risco!";
          this.cor = "error";
          this.snackbar = true;
          this.tei = false;

          this.$emit("event-new-snackbar", this.snackbar);
          this.$emit("event-new-mensagem", this.mensagem);
          this.$emit("event-new-cor", this.cor);
        });
    },

    ...mapActions("processos", [
      {
        addProcesso: "add"
      }
    ]),
    ...mapActions("riscos", [
      {
        addRisco: "add"
      }
    ]),
    ...mapActions("avaliacoes", [
      {
        addAvaliacoes: "add"
      }
    ])
  },

  mounted() {},

  created() {
    axios.get("/politicas/vigente").then(res => {
      this.risco.politica = res.data;
      this.criarListaCategorias();
      this.criarListaProbabilidades();
      this.criarListaImpactos();
      this.criarListafatorAvaliacaoControle();
    });
    axios.get("/usuarios").then(res => {
      this.risco.responsavel = res.data;
      this.avaliacao.responsavel = this.risco.responsavel;
      this.risco.unidade = this.risco.responsavel.unidade;
    });
    this.$store.dispatch("processos/GET_ALL");
    this.$store.dispatch("usuarios/GET_ALL");
    this.$store.dispatch("politicas/GET_ALL");
  }
};
</script>
