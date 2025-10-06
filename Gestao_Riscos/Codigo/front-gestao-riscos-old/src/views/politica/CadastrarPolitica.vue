<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-layout row justify-center>
    <v-dialog v-model="addPolitica" persistent max-width="800">
      <template #activator="{ on: addPolitica }">
        <v-tooltip bottom>
          <template #activator="{ on: tooltip }">
            <v-fab-transition>
              <v-btn
                v-show="!hidden"
                color="cyan"
                dark
                absolute
                top
                right
                fab
                v-on="{ ...tooltip, ...addPolitica }"
              >
                <v-icon>add</v-icon>
              </v-btn>
            </v-fab-transition>
          </template>
          <span>Nova Política</span>
        </v-tooltip>
      </template>
      <v-card>
        <v-form ref="form" v-model="valid" :lazy-validation="lazy">
        <v-card-title class="headline primary white--text" primary-title>Nova Política</v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <v-text-field flat
                 id="inputNomePolitica" 
                v-model="nome" 
                label="Nome da Política*" 
                value ref="nome"
                :rules="rules.politica.nome" 
                required
                ></v-text-field>
                <!-- Input descrição da política -->
                <v-textarea
                  auto-grow
                  rows="1"
                  flat
                  v-model="descricao"
                  label="Descrição da Política"
                  value
                  ref="descricao"
                ></v-textarea>
              </v-flex>
            </v-layout>
            <h5>
              <b>Período  :</b>
            </h5>
            <v-layout row wrap>
              <v-flex xs4 >
                <v-menu
                  v-model="dateInicio"
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
                      v-model="computedDateFormattedInicio"
                      label="Início*"
                      persistent-hint
                      append-icon="event"
                      readonly
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="dataInicio" @input="dateInicio = false" locale="pt-br"></v-date-picker>
                </v-menu>
              </v-flex>
              <v-flex xs4>
                <v-menu
                  v-model="dateFim"
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
                      v-model="computedDateFormattedFim"
                      label="Término*"
                      persistent-hint
                      append-icon="event"
                      readonly
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="dataFim" @input="dateFim = false" locale="pt-br"></v-date-picker>
                </v-menu>
              </v-flex>
            </v-layout>
            <small>*Campos obrigatórios</small>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" v-on:click="adicionar()" @click="validate" :disabled="!valid">Salvar</v-btn>
          <v-btn color="disabled" @click="addPolitica = false, limparCampos()">Cancelar</v-btn>
        </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
  </v-layout>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      hidden: false,
      addPolitica: false,
      nome: "",
      descricao: "",
      dataInicio: new Date().toISOString().substr(0, 10),
      dataFim: new Date().toISOString().substr(0, 10),
      dateInicio: false,
      dateFim: false,
      snackbar: false,
      mensagem: "",
      cor: "",
      valid: true,
      lazy: false,
      rules: {
        politica: {
          nome : [v => !!v || 'Nome da Política é um campo obrigatório'],
        }
      },
    };
  },
  
  computed: {
    formIsValid() {
         return this.nome !== "" && this.dataInicio !== "" && this.dataFim !== "";
    },
    computedDateFormattedInicio() {
      return this.formatDate(this.dataInicio);
    },
    computedDateFormattedFim() {
      return this.formatDate(this.dataFim);
    }
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
    limparCampos(){
      this.$refs.form.reset();
      this.nome = "";
      this.descricao = "";
      this.dataInicio = new Date().toISOString().substr(0, 10);
      this.dataFim = new Date().toISOString().substr(0, 10);
      this.resetValidation();
    },
    adicionar() {
      var startDate= this.dataInicio;
      var endDate= this.dataFim;
      if (startDate <= endDate) {
        const politica = {
          nome: this.nome,
          descricao: this.descricao,
          dataInicio: this.dataInicio,
          dataFim: this.dataFim
        };
        axios
                .post("/politicas", politica)
                .then(res => {
                  this.limparCampos();
                  this.addPolitica = false;
                  this.$emit("event-new-politica", res.data);
                  this.nome = "";
                  this.descricao = "";
                  this.cor = "success";
                  this.snackbar = true;
                  this.mensagem = "Politica cadastrada com sucesso!";
                  this.$emit('event-new-snackbar', this.snackbar);
                  this.$emit('event-new-mensagem', this.mensagem);
                  this.$emit('event-new-cor', this.cor);
                  
                })
                .catch(e => {
                  this.mensagem = "Erro ao cadastrar Politica!";
                  this.cor = "error";
                  this.snackbar = true;
                  this.addPolitica = false;
                  this.$emit('event-new-snackbar', this.snackbar);
                  this.$emit('event-new-mensagem', this.mensagem);
                  this.$emit('event-new-cor', this.cor);
                });
      }else{
        this.mensagem = "A data de início não pode ser maior que a data de término!";
        this.cor = "error";
        this.snackbar = true;
        this.addPolitica = false;
        this.$emit('event-new-snackbar', this.snackbar);
        this.$emit('event-new-mensagem', this.mensagem);
        this.$emit('event-new-cor', this.cor);
      }
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
    }
  }
};
</script>
<style>
</style>