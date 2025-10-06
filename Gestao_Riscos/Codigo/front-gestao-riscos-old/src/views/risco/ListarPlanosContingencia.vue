<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>

                <v-card>
                    <div id="app">
                        <!-- <v-app id="inspire"> -->
                        <v-card>

                            <v-card-text>
                                <h5><b>PLANOS DE CONTINGÊNCIA</b>
                                    <cadastrar-plano-contingencia @event-new-plano="atualizarPlano"
                                                                  @event-new-mensagem="recebeMsg"
                                                                  @event-new-snackbar="recebeSnack"
                                                                  @event-new-cor="recebeCor"></cadastrar-plano-contingencia>
                                </h5>
                                <v-toolbar card color="white">
                                    <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down"></v-text-field>
                                </v-toolbar>
                                <v-data-table
                                        :pagination.sync="pagination"
                                        :search="search"
                                        :headers="headers"
                                        :items="planosEsp"
                                        no-data-text="Nenhum resultado encontrado"
                                        no-results-text="Nenhum resultado encontrado"
                                >


                                    <template v-slot:items="props">
                                        <tr @click="props.expanded = !props.expanded">
                                            <td class="text-xs-left">{{ props.item.gatilho }}</td>
                                            <td class="text-xs-left">{{ props.item.acao }}</td>
                                            <td class="text-xs-left">{{ props.item.responsavel.nome }}</td>
                                            <td class="text-xs-left">{{ props.item.responsavel.unidade.sigla }}</td>

                                            <v-dialog  v-model="tei" persistent max-width="800">
                                                <template #activator="{ on: tei }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">

                                                            <v-btn   color="primary" dark
                                                                     depressed outline icon fab small v-on="{ ...tooltip, ...tei }" @click="planoEditar(props.item.id)"
                                                            >
                                                                <v-icon>edit</v-icon> </v-btn>
                                                        </template>
                                                        <span>Editar</span>
                                                    </v-tooltip>
                                                </template>

                                                <v-card>
                                                    <v-card-title class="headline primary white--text" primary-title>
                                                        Editar Plano de Contingência
                                                    </v-card-title>

                                                    <v-card-text>
                                                        <v-container grid-list-md text-xs-center>
                                                            <v-layout row wrap>

                                                                <v-flex xs6 class="text-xs-left">
                                                                    <h5><b>Gestor:</b> {{usuarioLogado}}</h5>
                                                                    <br>
                                                                </v-flex>
                                                                <v-flex xs6 class="text-xs-left">
                                                                    <h5><b>Unidade Responsável:</b> {{sigla}}</h5>
                                                                    <br>
                                                                </v-flex>


                                                                <v-flex xs12>
                                                                    <v-text-field
                                                                            label="Gatilho*"
                                                                            v-model="planoContingencia.gatilho"
                                                                            type="text"
                                                                            :rules="rules.planoContingencia.gatilho"
                                                                            required
                                                                    ></v-text-field>
                                                                </v-flex>



                                                                <v-flex xs12>
                                                                    <v-text-field
                                                                            label="Ação*"
                                                                            v-model="planoContingencia.acao"
                                                                            type="text"
                                                                            :rules="rules.planoContingencia.acao"
                                                                            required
                                                                    ></v-text-field>
                                                                </v-flex>

                                                                <small>*Campos obrigatórios</small>

                                                            </v-layout>

                                                        </v-container>

                                                    </v-card-text>

                                                    <v-card-actions>
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="primary" @click="editarPlano" :disabled="!formIsValid">Editar</v-btn>
                                                        <v-btn color="disabled" @click="tei=false">Cancelar</v-btn>
                                                    </v-card-actions>

                                                </v-card>

                                            </v-dialog>


                                            <v-dialog  v-model="dialog" persistent max-width="290">
                                                <template #activator="{ on: dialog }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">
                                                            <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                                    @click="planoGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                                        </template>
                                                        <span>Remover</span>
                                                    </v-tooltip>
                                                </template>
                                                <v-card>
                                                    <v-card-title class="headline">Excluir Plano de Contingência</v-card-title>
                                                    <v-card-text>Deseja realmente excluir este plano de contingência?</v-card-text>
                                                    <v-card-actions>
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="error" small @click="planoDelete(flag.id)">Excluir</v-btn>
                                                        <v-btn color="disable" small @click="dialog = false">Cancelar</v-btn>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-dialog>
                                        </tr>
                                    </template>
                                </v-data-table>
                            </v-card-text>


                        </v-card>
                        <!-- </v-app>-->

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
    import CadastrarPlanoContingencia from './CadastrarPlanoContingencia'

    export default {
        components: {
            CadastrarPlanoContingencia
        },

    data() {
            return {
                pagination: { rowsPerPage: 10 },
                planosAll:'',
                planosEsp:[],
                riscoId: null,
                search: '',
                risco: '',
                nameRules: [
                    v => !!v || '',
                ],
                headers: [
                    { text: 'Gatilho', value: "gatilho" },
                    { text: 'Ação', value: "acao" },
                    { text: 'Responsável', value: "responsavel.nome" },
                    { text: 'Unidade Responsável', value: "responsavel.unidade.sigla" },
                    { text: "", sortable: false, value: ""}
                ],
                av:[],
                flag:'',
                dialog:false,
                tei: false,
                hidden:false,
                planoContingencia:{
                    gatilho:'',
                    acao:'',
                    responsavel: '',
                    risco: '',
                },
                row: null,
                usuarioLogado:'',
                sigla:'',

                snackbar: '',
                mensagem: "",
                cor: "",
                timeout: 3500,

                rules: {
                    planoContingencia: {
                        gatilho: [v => !!v || 'Gatilho é um campo obrigatório'],
                        acao: [v => !!v || 'Ação é um campo obrigatório']
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
                return this.planoContingencia.gatilho !== "" && this.planoContingencia.acao !== ""
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
            axios.get('/usuarios/').then(res => {
                this.usuarioLogado = res.data.nome;
                this.sigla = res.data.unidade.sigla;
            })
            this.listarPlanosContingencia();
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

            atualizarPlano(plano) {
                this.planosEsp.push(plano);
            },
            listarPlanosContingencia(){
                axios.get('/plano_contingencia/listar/' + this.riscoId).then(res => {
                    this.planosEsp = res.data
                    /*for(let i = 0; i < this.planosAll.length; i++){

                        if(this.planosAll[i].risco.id == this.riscoId){
                            this.planosEsp.push(this.planosAll[i])
                        }
                    }*/

                }).catch(
                    error => console.log(error)
                )
            },


            planoGet(id){
                axios.get('/plano_contingencia/' + id).then(res => {
                        this.flag = res.data;
                })
            },


            planoDelete(id) {
                    axios.delete('/plano_contingencia/' + id).then(res => {
                       //removido o alert
                        this.dialog = false;
                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Plano de Contingencia excluído com sucesso!";
                        this.listarPlanosContingencia();
                    }).catch(e => {
                        //removido o alert
                        this.mensagem = "Erro ao excluir Plano de Contingencia!";
                        this.cor = "error";
                        this.snackbar = true;
                        this.tei = false;

                    })

            },

            planoEditar(id) {
                axios.get('/plano_contingencia/' + id).then(res => {
                    this.y = res.data;
                    this.planoContingencia.gatilho = this.y.gatilho;
                    this.planoContingencia.acao = this.y.acao;
                    this.planoContingencia.responsavel = this.y.responsavel;
                    this.planoContingencia.risco = this.y.risco;
                })
            },

            editarPlano() {

                axios.put('/plano_contingencia/' + this.y.id, this.planoContingencia).then(res => {
                    //removido o alert
                    this.tei = false;

                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Plano de Contingencia editado com sucesso!";
                    this.listarPlanosContingencia();
                }).catch(e => {
                    //removido o alert
                    this.mensagem = "Erro ao editar Plano de Contingencia!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;

                });
            }
        }}


</script>

<style scoped>

</style>
