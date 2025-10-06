<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
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
              right
              fab
            >
              <v-icon>add</v-icon>
            </v-btn>
          </v-fab-transition>
        </template>
        <span>Nova Avaliação</span>
      </v-tooltip>
    </template>

    <v-card>
      <v-form ref="form" v-model="valid" :lazy-validation="lazy">
        <v-card-title class="headline primary white--text" primary-title>Nova Avaliação</v-card-title>

        <v-card-text>
          <v-container grid-list-md text-xs-center>
            <v-layout row wrap>
              <v-flex xs6 class="text-xs-left">
                <h5>
                  <b>Gestor:</b>
                  {{usuarioLogado}}
                </h5>
                <br />
              </v-flex>
              <v-flex xs6 class="text-xs-left">
                <h5>
                  <b>Unidade Responsável:</b>
                  {{sigla}}
                </h5>
                <br />
              </v-flex>

              <v-flex xs4>
                <v-select
                  v-model="avaliacao.probabilidade"
                  :items="listaProbabilidades"
                  item-text="nome"
                  item-value="id"
                  return-object
                  label="Probabilidade*"
                  :rules="rules.avaliacao.probabilidade"
                  required
                ></v-select>
              </v-flex>

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
                <v-text-field
                  label="Risco Inerente"
                  tooltip="Detalhes"
                  v-model="inerente"
                  disabled
                  type="text"
                ></v-text-field>
              </v-flex>

              <v-flex xs4>
                <v-select
                  v-model="avaliacao.fatorAvaliacaoControle"
                  :items="listafatorAvaliacaoControle"
                  item-text="nome"
                  item-value="id"
                  return-object
                  label="Fator Controle*"
                  :rules="rules.avaliacao.fatorAvaliacaoControle"
                  required
                ></v-select>
              </v-flex>

              <v-flex xs4>
                <v-text-field label="Risco Residual" disabled v-model="residual" center type="text"></v-text-field>
              </v-flex>

              <v-flex xs4>
                <v-menu
                  v-model="menu2"
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
                      v-model="computedDateFormatted"
                      label="Data*"
                      persistent-hint
                      prepend-icon="event"
                      readonly
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="avaliacao.data" @input="menu2 = false" locale="pt-br"></v-date-picker>
                </v-menu>
              </v-flex>

              <small>*Campos obrigatórios</small>
            </v-layout>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" v-on:click="salvar()" @click="validate" :disabled="!valid">Salvar</v-btn>
          <v-btn color="disabled" @click="tei=false, limparCampos()">Cancelar</v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  components: {},
  data: function() {
    return {
      nameRules: [v => !!v || ""],
      listaCategorias: [],
      listaImpactos: [],
      listaProbabilidades: [],
      listafatorAvaliacaoControle: [],
      avaliacoes: "",
      tei: false,
      hidden: false,
      riscoId: null,
      valid: true,
      lazy: false,
      avaliacao: {
        probabilidade: "",
        impacto: "",
        fatorAvaliacaoControle: "",
        risco: {},
        responsavel: "",
        data: new Date().toISOString().substr(0, 10)
      },
      row: null,
      menu1: false,
      menu2: false,
      usuarioLogado: "",
      sigla: "",

      snackbar: false,
      mensagem: "",
      cor: "",

      rules: {
        avaliacao: {
          probabilidade: [v => !!v || "Probabilidade é um campo obrigatório"],
          impacto: [v => !!v || "Impacto é um campo obrigatório"],
          fatorAvaliacaoControle: [v => !!v || "Fator é um campo obrigatório"]
        }
      }
    };
  },
  mounted: function() {},

  computed: {
    computedDateFormatted() {
      return this.formatDate(this.avaliacao.data);
    },

    inerente: function() {
      if (
        this.avaliacao.probabilidade.valor != null &&
        this.avaliacao.impacto.valor != null
      ) {
        return (
          this.avaliacao.probabilidade.valor * this.avaliacao.impacto.valor
        );
      } else {
        return null;
      }
    },
    residual: function() {
      if (
        this.avaliacao.probabilidade.valor != null &&
        this.avaliacao.impacto.valor != null &&
        this.avaliacao.fatorAvaliacaoControle.valor != null
      ) {
        return (
          this.avaliacao.probabilidade.valor *
          this.avaliacao.impacto.valor *
          this.avaliacao.fatorAvaliacaoControle.valor
        );
      } else {
        return null;
      }
    },
    ...mapState({
      usuarios: state => state.usuarios.all
    }),
    /*formIsValid() {
                return this.processo.nome !== "" && this.processo.tipo !== "";
            }*/
    formIsValid() {
      return (
        this.avaliacao.probabilidade !== "" &&
        this.avaliacao.impacto !== "" &&
        this.avaliacao.fatorAvaliacaoControle !== "" &&
        this.avaliacao.data !== ""
      );
    }
  },

  created() {
    this.$store.dispatch("usuarios/GET_ALL");
    /*this.$store.dispatch('probabilidades/GET_ALL');
            this.$store.dispatch('impactos/GET_ALL');
            this.$store.dispatch('fatoresAvaliacao/GET_ALL');*/
    this.riscoId = this.$route.params.id;
    {
      axios.get("/riscos/" + this.riscoId).then(res => {
        this.avaliacao.risco = res.data;
      });
    }
    {
      axios.get("/usuarios/").then(res => {
        this.avaliacao.responsavel = res.data;
        this.usuarioLogado = res.data.nome;
        this.sigla = res.data.unidade.sigla;
      });
    }
    axios.get("politicas/vigente").then(res => {
      this.politicaVirgente = res.data;
      this.criarListaProbabilidades();
      this.criarListaImpactos();
      this.criarListafatorAvaliacaoControle();
    });
  },

  methods: {
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
    },
    limparCampos() {
      this.avaliacao.probabilidade = "";
      this.avaliacao.impacto = "";
      this.avaliacao.fatorAvaliacaoControle = "";
      this.avaliacao.data = new Date().toISOString().substr(0, 10);
      this.resetValidation();
    },
    criarListaImpactos() {
      axios
        .get("/impactos/listar/" + this.politicaVirgente.id)
        .then(res => {
          return (this.listaImpactos = res.data);
        })
        .catch(error => console.log(error));
    },
    criarListaProbabilidades() {
      axios
        .get("/probabilidades/listar/" + this.politicaVirgente.id)
        .then(res => {
          return (this.listaProbabilidades = res.data);
        })
        .catch(error => console.log(error));
    },

    criarListafatorAvaliacaoControle() {
      axios
        .get("/fatoresAvaliacao/listar/" + this.politicaVirgente.id)
        .then(res => {
          return (this.listafatorAvaliacaoControle = res.data);
        })
        .catch(error => console.log(error));
    },
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [month, day, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },

    salvar() {
      this.data = this.date;
      axios
        .post("/avaliacoes", this.avaliacao)
        .then(res => {
          //removido o alert
          /*location.reload();*/
          this.tei = false;
          this.limparCampos();
          this.$emit("event-new-avaliacao", res.data);

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Avaliação cadastrada com sucesso!";
          
          this.$emit("event-new-snackbar", this.snackbar);
          this.$emit("event-new-mensagem", this.mensagem);
          this.$emit("event-new-cor", this.cor);
        })
        .catch(e => {
          //removido o alert

          /*this.mensagem = e.response.data;*/
          this.mensagem = "Erro ao cadastrar avaliação!";
          this.cor = "error";
          this.snackbar = true;
          this.tei = false;

          this.$emit("event-new-snackbar", this.snackbar);
          this.$emit("event-new-mensagem", this.mensagem);
          this.$emit("event-new-cor", this.cor);
        });
    }
  }
};
</script>

<style scoped>
</style>
