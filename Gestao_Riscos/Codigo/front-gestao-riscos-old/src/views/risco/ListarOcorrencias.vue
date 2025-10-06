<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>

                <v-card>

                    <div id="app">
                    <v-card-text>
                        <h5>
                            <b>OCORRÊNCIAS</b>
                            <cadastrar-ocorrencia @event-new-ocorrencia="atualizarOcorrencias"
                                                  @event-new-mensagem="recebeMsg"
                                                  @event-new-snackbar="recebeSnack"
                                                  @event-new-cor="recebeCor"></cadastrar-ocorrencia>
                        </h5>

                            <v-toolbar card color="white">
                                <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down"></v-text-field>
                            </v-toolbar>


                            <v-data-table
                                    :pagination.sync="pagination"
                                    :search="search"
                                    :headers="headers"
                                    :items="ocorrencias"
                                    no-data-text="Nenhum resultado encontrado"
                                    no-results-text="Nenhum resultado encontrado"
                            >

                                <template v-slot:items="props">
                                    <tr @click="props.expanded = !props.expanded">
                                        <td class="text-xs-left">{{ props.item.descricao }}</td>
                                        <td class="text-xs-left">{{ props.item.solucao }}</td>
                                        <td class="text-xs-left">{{ props.item.resultados }}</td>
                                        <td class="text-xs-left">{{ props.item.responsavel.nome }}</td>
                                        <td class="text-xs-left">{{ props.item.responsavel.unidade.sigla }}</td>
                                            <v-dialog  v-model="tei" persistent max-width="800">
                                                <template #activator="{ on: tei }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">

                                                            <v-btn   color="primary" dark
                                                                     depressed outline icon fab small v-on="{ ...tooltip, ...tei }" @click="ocorrenciaEditar(props.item.id)"
                                                            >
                                                                <v-icon>edit</v-icon> </v-btn>
                                                        </template>
                                                        <span>Editar</span>
                                                    </v-tooltip>
                                                </template>

                                                <v-card>
                                                    <v-card-title class="headline primary white--text" primary-title>
                                                        Editar Ocorrência
                                                    </v-card-title>

                                                    <v-card-text>
                                                        <v-container grid-list-md text-xs-center>
                                                            <v-layout row wrap>

                                                                <v-flex xs6 class="text-xs-left">
                                                                    <h5><b>Gestor:</b> {{usuarios.nome}}</h5>
                                                                    <br>
                                                                </v-flex>
                                                                <v-flex xs6 class="text-xs-left">
                                                                    <h5><b>Unidade Responsável:</b> {{usuarios.unidade.sigla}}</h5>
                                                                    <br>
                                                                </v-flex>


                                                                <v-flex xs12>
                                                                    <v-text-field
                                                                            label="Descrição*"
                                                                            v-model="ocorrencia.descricao"
                                                                            type="text"
                                                                            :rules="rules.ocorrencia.descricao"
                                                                            required
                                                                    ></v-text-field>
                                                                </v-flex>



                                                                <v-flex xs12>
                                                                    <v-text-field
                                                                            label="Solução*"
                                                                            v-model="ocorrencia.solucao"
                                                                            type="text"
                                                                            :rules="rules.ocorrencia.solucao"
                                                                            required
                                                                    ></v-text-field>
                                                                </v-flex>

                                                                <v-flex xs12>
                                                                    <v-text-field
                                                                            label="Resultados*"
                                                                            v-model="ocorrencia.resultados"
                                                                            type="text"
                                                                            :rules="rules.ocorrencia.resultados"
                                                                            required
                                                                    ></v-text-field>
                                                                </v-flex>

                                                                <!--<v-flex xs6>
                                                                    <v-select v-model="ocorrencia.planoContingencia" :rules="nameRules"
                                                                              :items="planosEsp"
                                                                              item-text="acao"
                                                                              return-object
                                                                              placeholder="Plano de Contingencia"
                                                                              label="Plano de Contingencia"
                                                                    ></v-select>
                                                                </v-flex>
                                            -->

                                                                <v-flex xs6>
                                                                    <v-menu
                                                                            v-model="menu2"
                                                                            :close-on-content-click="false"
                                                                            :nudge-right="50"
                                                                            lazy
                                                                            transition="scale-transition"
                                                                            offset-y
                                                                            full-width
                                                                            min-width="290px">
                                                                        <template v-slot:activator="{ on }">
                                                                            <v-text-field
                                                                                    v-model="computedDateFormatted"
                                                                                    label="Data*"
                                                                                    persistent-hint
                                                                                    prepend-icon="event"
                                                                                    readonly
                                                                                    v-on="on"></v-text-field>
                                                                        </template>
                                                                        <v-date-picker v-model="ocorrencia.data" @input="menu2 = false" locale="pt-br" ></v-date-picker>
                                                                    </v-menu>
                                                                </v-flex>
                                                                <v-flex xs6>
                                                                </v-flex>

                                                                <small>*Campos obrigatórios</small>
                                                            </v-layout>
                                                        </v-container>
                                                    </v-card-text>

                                                    <v-card-actions>
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="primary" @click="editarOcorrencia" :disabled="!formIsValid">Editar</v-btn>
                                                        <v-btn color="disabled" @click="tei=false">Cancelar</v-btn>
                                                    </v-card-actions>

                                                </v-card>
                                            </v-dialog>


                                            <v-dialog  v-model="dialog" persistent max-width="290">
                                                <template #activator="{ on: dialog }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">
                                                            <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                                    @click="ocorrenciaGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                                        </template>
                                                        <span>Remover</span>
                                                    </v-tooltip>
                                                </template>
                                                <v-card>
                                                    <v-card-title class="headline">Excluir Ocorrência</v-card-title>
                                                    <v-card-text>Deseja realmente excluir esta ocorrência?</v-card-text>
                                                    <v-card-actions>
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="error" small @click="ocorrenciaDelete(flag.id)">Excluir</v-btn>
                                                        <v-btn color="disable" small="" @click="dialog = false">Cancelar</v-btn>
                                                    </v-card-actions>

                                                </v-card>
                                            </v-dialog>
                                    </tr>
                                </template>
                            </v-data-table>


                    </v-card-text>
                    </div>

                </v-card>
            </v-flex>

        </v-layout>
        <v-snackbar :timeout="timeout" right top :color="cor" v-model="snackbar">{{ mensagem }}</v-snackbar>
    </v-container>
</template>

<script>
    import {mapState} from "vuex";
    import axios from "axios"
    import CadastrarOcorrencia from './CadastrarOcorrencia'

    export default {
        components: {
            CadastrarOcorrencia
        },

    data() {
            return {
                pagination: { rowsPerPage: 10 },
                x:1,
                planosAll:'',
                planosEsp:[],
                riscoId: null,
                search: '',
                risco: '',
                nameRules: [
                    v => !!v || '',
                ],
                headers: [
                    { text: 'Descrição', value: "descricao" },
                    { text: 'Solução', value: "solucao" },
                    { text: 'Resultados', value: "resultados" },
                    { text: 'Responsável', value: "responsavel.nome" },
                    { text: 'Unidade Responsável', value: "responsavel.unidade.sigla" },
                    { text: "", sortable: false, value: ""}
                ],
                av:[],
                flag:'',
                dialog:false,
                tei: false,
                hidden:false,
                ocorrencia:{
                    descricao:'',
                    solucao:'',
                    resultados: '',
                    /*planoContingencia: '',*/
                    responsavel: '',
                    risco: '',
                    data: '',
                },
                row: null,
                calendar: false,
                listaDeOcorrenciasGet: [],
                ocorrencias:[],
                menu2: false,
                usuarioLogado:'',
                sigla:'',

                snackbar: '',
                mensagem: "",
                cor: "",
                timeout: 3500,

                rules: {
                    ocorrencia: {
                        descricao: [v => !!v || 'Descrição da Ocorrência é um campo obrigatório'],
                        solucao: [v => !!v || 'Solução da Ocorrência é um campo obrigatório'],
                        resultados: [v => !!v || 'Resultados da Ocorrência é um campo obrigatório']

                    }
                }

            };
        },

        computed: {
            ...mapState({
                usuarios: state => state.usuarios.all,
            }),
            computedDateFormatted () {
                return this.formatDate(this.ocorrencia.data)
            },
            formIsValid() {
                return this.ocorrencia.solucao !== "" && this.ocorrencia.descricao !== ""
                    && this.ocorrencia.planoContingencia !== "" && this.ocorrencia.resultados !== "";
            }


        },
        mounted: function() {

        },
        created() {
            this.riscoId = this.$route.params.id;

            {
                axios.get('/riscos/' + this.riscoId).then(res => {
                    this.risco = res.data;
                })
            }
            {
            axios.get('/usuarios/').then(res => {
                this.usuarioLogado = res.data.nome;
                this.sigla = res.data.unidade.sigla;
                })
            }
            this.listarOcorrencias();
            /*this.listarPlanosContingencia();*/
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

            atualizarOcorrencias(ocorrencia) {
                this.ocorrencias.push(ocorrencia);
            },
            listarPlanosContingencia(){
                axios.get('/plano_contingencia').then(res => {
                    this.planosAll = res.data
                    for(let i = 0; i < this.planosAll.length; i++){

                        if(this.planosAll[i].risco.id == this.riscoId){
                            this.planosEsp.push(this.planosAll[i])
                        }
                    }

                }).catch(
                    error => console.log(error)
                )
            },
            listarOcorrencias(){
                axios.get('/ocorrencias/listar/' + this.riscoId).then(res => {
                    this.ocorrencias = res.data
                    /*this.listaDeOcorrenciasGet = res.data
                    for(let i = 0; i < this.listaDeOcorrenciasGet.length; i++){

                        if(this.listaDeOcorrenciasGet[i].risco.id == this.riscoId){
                            this.ocorrencias.push(this.listaDeOcorrenciasGet[i])
                        }
                    }*/

                }).catch(
                    error => console.log(error)
                )
            },
            formatDate (date) {
                if (!date) return null

                const [year, month, day] = date.split('-')
                return `${day}/${month}/${year}`
            },
            parseDate (date) {
                if (!date) return null

                const [month, day, year] = date.split('/')
                return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
            },

            ocorrenciaGet(id){
                axios.get('/ocorrencias/' + id).then(res => {
                        this.flag = res.data;
                })
            },


            ocorrenciaDelete(id) {

                    axios.delete('/ocorrencias/' + id).then(res => {
                        //removido o alert
                        this.dialog = false;
                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Ocorrência excluída com sucesso!";
                        this.listarOcorrencias();
                    }).catch(e => {
                        //removido o alert
                        this.mensagem = "Erro ao excluir Ocorrência!";
                        this.cor = "error";
                        this.snackbar = true;
                        this.tei = false;

                    })

            },

            ocorrenciaEditar(id) {
                axios.get('/ocorrencias/' + id).then(res => {
                    this.y = res.data;
                    this.ocorrencia.descricao = this.y.descricao;
                    this.ocorrencia.solucao = this.y.solucao;
                    this.ocorrencia.resultados = this.y.resultados;
                    this.ocorrencia.data =  this.y.data;
                    /*this.ocorrencia.planoContingencia = this.y.planoContingencia;*/
                    this.ocorrencia.responsavel = this.y.responsavel;
                    this.ocorrencia.risco = this.y.risco;
                })
            },

            editarOcorrencia() {
                axios.put('/ocorrencias/' + this.y.id, this.ocorrencia).then(res => {
                    //removido o alert
                    this.tei = false;
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Ocorrência editada com sucesso!";
                    this.listarOcorrencias();
                }).catch(e => {
                    //removido o alert
                    this.mensagem = "Erro ao editar Ocorrência!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;

                });
            }
        }}


</script>

<style scoped>

</style>
