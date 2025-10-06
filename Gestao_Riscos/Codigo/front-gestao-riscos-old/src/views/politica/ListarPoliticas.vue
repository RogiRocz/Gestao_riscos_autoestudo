<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-container grid-list-xl fluid>
    <v-layout row wrap>
      <v-flex xs12>
        <v-card>
          <v-card-title class="headline primary white--text">Políticas</v-card-title>
          <div id="app">
            <v-card>
              <v-card-text>

                <v-card>
                  <v-toolbar card color="white">
                    <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down"></v-text-field>
                  </v-toolbar>
                  <CadastrarPolitica @event-new-politica="atualizarPoliticas"
                                     @event-new-mensagem="recebeMsg"
                                     @event-new-snackbar="recebeSnack"
                                     @event-new-cor="recebeCor">

                  </CadastrarPolitica>
                  <v-data-table
                          :search="search"
                          :headers="headers"
                          :items="politicas"
                          :pagination.sync="pagination"
                          :expand="expand"
                          no-data-text="Nenhum resultado encontrado"
                          no-results-text="Nenhum resultado encontrado"
                  >
                    <template v-slot:items="props">
                      <tr @click="props.expanded = !props.expanded">
                        <td class="justify-center">{{ (props.item.nome) }}</td>
                        <td class="justify-center">{{ props.item.descricao }}</td>
                        <td
                                class="justify-center"

                        >{{props.item.dataInicio| moment("DD/MM/YYYY") }} a {{ props.item.dataFim| moment("DD/MM/YYYY")}}</td>
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
                                      color="green"
                                      small
                              >
                                <v-icon>settings</v-icon>
                              </v-btn>
                            </template>
                            <span>Configurar</span>
                          </v-tooltip>

                          <v-dialog v-model="editarPolitica" persistent max-width="800">
                            <template #activator="{ on: editarPolitica }">
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
                                          v-on="{ ...tooltip, ...editarPolitica }"
                                          @click="politicaEditar(props.item.id)"
                                  >
                                    <v-icon>edit</v-icon>
                                  </v-btn>
                                </template>
                                <span>Editar</span>
                              </v-tooltip>
                            </template>

                            <v-card>
                              <v-card-title
                                      class="headline primary white--text"
                                      primary-title
                              >Editar Política</v-card-title>
                              <v-card-text>
                                <v-container grid-list-md>
                                  <v-layout wrap>
                                    <v-flex xs12>
                                      <v-text-field
                                              flat
                                              v-model="politica.nome"
                                              label="Nome da Política*"
                                              value
                                              ref="nome"
                                              :rules="rules.nome"
                                              required
                                      ></v-text-field>
                                      <!-- Input descrição da política -->
                                      <v-textarea
                                              auto-grow
                                              rows="1"
                                              flat
                                              v-model="politica.descricao"
                                              label="Descrição da Política"
                                              value
                                              ref="descricao"
                                      ></v-textarea>
                                    </v-flex>
                                  </v-layout>

                                  <h5>
                                    <b>Período:</b>
                                  </h5>

                                  <v-layout row wrap>
                                    <v-flex xs4>
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
                                        <v-date-picker
                                                v-model="politica.dataInicio"
                                                @input="dateInicio = false"
                                                locale="pt-br"
                                        ></v-date-picker>
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
                                        <v-date-picker
                                                v-model="politica.dataFim"
                                                @input="dateFim = false"
                                                locale="pt-br"
                                        ></v-date-picker>
                                      </v-menu>
                                    </v-flex>
                                  </v-layout>
                                  <small>*Campos obrigatórios</small>
                                </v-container>
                              </v-card-text>
                              <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn
                                        color="primary"
                                        @click="editarPolitica = false, salvar()"
                                        :disabled="!formIsValid"
                                >Editar</v-btn>
                                <v-btn color="disabled" @click="editarPolitica = false">Cancelar</v-btn>
                              </v-card-actions>
                            </v-card>
                          </v-dialog>
                          <v-dialog  v-model="dialog" persistent max-width="300">
                            <template #activator="{ on: dialog }">
                              <v-tooltip bottom>
                                <template #activator="{ on: tooltip }">
                                  <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                          @click="politicasGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                </template>
                                <span>Remover</span>
                              </v-tooltip>
                            </template>
                            <v-card>
                              <v-card-title class="headline">Excluir Política</v-card-title>
                              <v-card-text>Deseja realmente excluir esta Política?</v-card-text>
                              <v-card-actions >
                                <v-spacer></v-spacer>
                                <v-btn color="error"  small @click="dialog = false, deletarPolitica(flag.id)">Excluir</v-btn>
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
  import axios from "axios";
  import CadastrarPolitica from "./CadastrarPolitica";

  export default {
    components: { CadastrarPolitica },
    data() {
      return {
        pagination: { rowsPerPage: 10},
        editarPolitica: false,
        flag: "",
        dialog: false,
        search: "",
        expand: false,
        dateInicio: false,
        dateFim: false,
        headers: [
          { text: "Políticas", value: "nome" },
          { text: "Descrição", value: "descricao" },
          { text: "Período", value: "" },
          { text: "", value: "acoes" }
        ],
        politicas: [],
        impactos: [],
        politica: {
          nome: "",
          descricao: "",
          dataInicio: new Date().toISOString().substr(0, 10),
          dataFim: new Date().toISOString().substr(0, 10),
        },
        y: "",

        mensagem: "",
        cor: "",
        snackbar: false,
        timeout: 3500,

        rules: {
          nome : [v => !!v || 'Nome da Política é um campo obrigatório'],
        },

      };
    },
    created() {
      this.listar();
    },
    computed: {
      formIsValid() {
        return this.politica.nome !== "" && this.politica.dataInicio !== "" && this.politica.dataFim !== "";
      },
      computedDateFormattedInicio() {
        return this.formatDate(this.politica.dataInicio);
      },
      computedDateFormattedFim() {
        return this.formatDate(this.politica.dataFim);
      }
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
      atualizarPoliticas(politica) {
        this.politicas.push(politica);
      },

      listar() {
        axios
                .get("/politicas")
                .then(res => {
                  this.politicas = res.data;
                })
                .catch(error => console.log(error));
      },
      redirecionarPagina(id) {
        let dados = [];
        axios.get("/politicas/" + id).then(res => {
          this.y = res.data;
          dados.push(this.y.impactos);
          console.log(dados);
          console.log(dados.length);
          this.$router.push("/politicas/configuracaoPolitica/" + id);
        });
      },
      politicaEditar(id) {
        axios.get("/politicas/" + id).then(res => {
          this.y = res.data;
          console.log(this.y.id);
          this.politica.nome = this.y.nome;
          this.politica.descricao = this.y.descricao;
          this.politica.dataInicio = this.y.dataInicio;
          this.politica.dataFim = this.y.dataFim;

        });
      },
      politicasGet(id) {
        console.log(id);
        axios.get("/politicas/" + id).then(res => {
          this.flag = res.data;
        });
      },
      deletarPolitica(id) {
        axios
                .delete("/politicas/" + id)
                .then(res => {
                  this.cor = "success";
                  this.snackbar = true;
                  this.mensagem = "Politica excluída com sucesso!";
                  this.tei = false;

                  this.listar();
                })
                .catch(e => {
                  this.mensagem = "Erro ao excluir: Política vinculada à um risco!";
                  this.cor = "error";
                  this.snackbar = true;
                  this.tei = false;
                });
      },

      salvar() {
        var startDate= this.politica.dataInicio;
        var endDate= this.politica.dataFim;

        if (startDate <= endDate){
          const politica = {
            nome: this.politica.nome,
            descricao: this.politica.descricao,
            dataInicio: this.politica.dataInicio,
            dataFim: this.politica.dataFim
          };
          axios
                  .put("/politicas/" + this.y.id, politica)
                  .then(res => {
                    this.addPolitica = false;
                    this.$emit("event-new-politica", res.data);


                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Politica editada com sucesso!";
                    this.listar();

                  })
                  .catch(e => {
                    this.mensagem = "Erro ao editar Politica!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.addPolitica = false;
                  });

        }
        else{
          this.mensagem = "A data de início não pode ser maior que a data de término!";
          this.cor = "error";
          this.snackbar = true;

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

<style scoped>
</style>
