<template>
    <v-container fluid>
        <v-row>
        <v-dialog v-model="addPlano" persistent max-width="800">
               <template v-slot:activator="{on,addPlano}">
                        <v-btn class="mr-4"
                        absolute
                        right
                        outlined
                        color="white"
                        v-bind="{ ...addPlano}"
                        v-on="on"
                        >
                        Novo Plano
                        </v-btn>           
                </template>
        <v-card>
            <v-form ref="form" v-model="valid" :lazy-validation="lazy">
            <v-card-title class="headline primary white--text" primary-title>
            <span class="headline">Novo Plano de Gestão de Risco</span>
            </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" md="12">
                <v-text-field id="inputNomePlano" 
                v-model="nome" 
                label="Nome do Plano de Gestão de Risco*" 
                value ref="nome"
                :rules="rules.plano.nome" 
                required></v-text-field>
                <v-textarea
                  auto-grow
                  rows="1"
                  flat
                  v-model="descricao"
                  label="Descrição do Plano de Gestão de Risco"
                  value
                  ref="descricao"
                ></v-textarea>
              <h5>
                <b>Período  :</b>
              </h5>
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
              </v-col>
            </v-row>
            <small>*Campos obrigatórios</small>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text color="primary" v-on:click="adicionar()" @click="validate" :disabled="!valid">Salvar</v-btn>
          <v-btn text color="disabled" @click="addPlano = false, limparCampos()">Cancelar</v-btn>
        </v-card-actions>
        </v-form>  
      </v-card>
        </v-dialog>
      </v-row>
    </v-container>
</template>

<style>

</style>

<script>
import axios from "axios";
export default {
   name: 'CadastrarPlanosRiscos',
           
    data() {
    return {
      dialog: false,
      addPlano: false,
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
        plano: {
          nome : [v => !!v || 'Nome do Plano é um campo obrigatório'],
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
        const plano = {
          nome: this.nome,
          descricao: this.descricao,
          dataInicio: this.dataInicio,
          dataFim: this.dataFim
        };
        axios
                .post("/planos", plano)
                .then(res => {
                  this.limparCampos();
                  this.addPlano = false;
                  this.$emit("event-new-plano", res.data);
                  this.nome = "";
                  this.descricao = "";
                  this.cor = "success";
                  this.snackbar = true;
                  this.mensagem = "Plano cadastrado com sucesso!";
                  this.$emit('event-new-snackbar', this.snackbar);
                  this.$emit('event-new-mensagem', this.mensagem);
                  this.$emit('event-new-cor', this.cor);
                  
                })
                // eslint-disable-next-line
                .catch(e => {
                  this.mensagem = "Erro ao cadastrar Plano!";
                  this.cor = "error";
                  this.snackbar = true;
                  this.addPlano = false;
                  this.$emit('event-new-snackbar', this.snackbar);
                  this.$emit('event-new-mensagem', this.mensagem);
                  this.$emit('event-new-cor', this.cor);
                });
      }else{
        this.mensagem = "A data de início não pode ser maior que a data de término!";
        this.cor = "error";
        this.snackbar = true;
        this.addPlano = false;
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