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
          <span>Novo Processo</span>
        </v-tooltip>
      </template>
      
      <v-card>
        <v-form ref="form" v-model="valid" :lazy-validation="lazy">
          <v-card-title class="headline primary white--text" primary-title>Novo Processo</v-card-title>
          
          <v-card-text>
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex xs6 class="text-xs-left">
                  <h5>
                    <b>Gestor:</b>
                    {{usuarioLogado}}
                  </h5>
                </v-flex>
                <v-flex xs6 class="text-xs-left">
                  <h5>
                    <b>Unidade Responsável:</b>
                    {{sigla}}
                  </h5>
                </v-flex>

              </v-layout>
              <v-layout wrap>
                <v-flex xs12>
                   <v-text-field
                    id="inputNomeProcesso"
                    label="Nome do Processo*"
                    v-model="processo.nome"
                    :rules="rules.processo.nome"
                    required
                    type="text"
                  ></v-text-field>
                </v-flex>
                
                <v-flex xs12>
                  <v-select
                    v-model="processo.tipo"
                   :items="tipoProcesso"
                    item-text="nome"
                    item-value="id"
                    return-object
                    label="Tipo do processo*"
                    :rules="rules.processo.tipo"
                    required
                  ></v-select>
                </v-flex>
                <small>*Campos obrigatórios</small>
              </v-layout>
            </v-container>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" v-on:click="salvar()" @click="validate" :disabled="!valid" >Salvar</v-btn>
            <v-btn color="disabled" v-on:click="tei=false,  reset()">Cancelar</v-btn>
          </v-card-actions>

        </v-form>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  components: {},
  data: function() {
    return {
      processo: {
        nome: "",
        tipo: "",
        unidadeResponsavel: "",
        gerente: ""
      },
      valid: true,
      lazy: false,
      tei: false,
      hidden: false,
      usuarioLogado: "",
      sigla: "",
      snackbar: false,
      mensagem: "",
      cor: "",
      rules: {
        processo: {
          nome: [v => !!v || 'Nome do Processo é um campo obrigatório'],
          tipo: [v => !!v || 'Tipo do Processo é um campo obrigatório'],
        }
      }
    };
  },
  mounted: function() {},

  computed: {
    ...mapState({
      usuarios: state => state.usuarios.all,
      tipoProcesso: state => state.tipoProcesso.all
    }),
    formIsValid() {
      return this.processo.nome !== "" && this.processo.tipo !== "";
    }
  },

  created() {
    this.$store.dispatch("usuarios/GET_ALL");
    this.$store.dispatch("tipoProcesso/GET_ALL");
    axios.get("/usuarios/").then(res => {
      this.processo.gerente = res.data;

      this.processo.unidadeResponsavel = this.processo.gerente.unidade;

      this.usuarioLogado = res.data.nome;
      this.sigla = res.data.unidade.sigla;
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
    limpar() {
      this.processo.nome = "";
      this.processo.tipo = "";
    },

    salvar() {
      axios
        .post("/processos", this.processo)
        .then(res => {
          this.reset();
          this.tei = false;
          this.$store.dispatch("processos/GET_ALL");

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Processo cadastrado com sucesso!";

          this.$emit("event-new-snackbar", this.snackbar);
          this.$emit("event-new-mensagem", this.mensagem);
          this.$emit("event-new-cor", this.cor);
        })
        .catch(error => {
          //removido o alert
          /*this.mensagem = error.response.data;*/
          this.mensagem = "Erro ao cadastrar Processo!";
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
