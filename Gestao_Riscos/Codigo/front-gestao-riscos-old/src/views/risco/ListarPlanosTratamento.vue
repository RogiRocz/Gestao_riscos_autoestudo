<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform" xmlns:justify-content="http://www.w3.org/1999/xhtml">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>

                <v-card>
                    <div id="app">
                        <v-card>

                            <v-card-text>

                            <v-flex xs12 class="text-xs-left">

                                <h5>
                                <b>PLANO DE TRATAMENTO</b>

                                <cadastrar-plano-tratamento @event-new-plano="atualizarPlano"
                                                            @event-new-mensagem="recebeMsg"
                                                            @event-new-snackbar="recebeSnack"
                                                            @event-new-cor="recebeCor"
                                v-if="planosAll == null"></cadastrar-plano-tratamento>


                                <v-dialog  v-model="tei" persistent max-width="800" v-if="planosAll != null">
                                    <template #activator="{ on: tei }">
                                        <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">

                                                <v-btn   color="primary" dark
                                                         depressed outline icon fab small v-on="{ ...tooltip, ...tei }" @click="planoEditar(planosAll.id)"

                                                >
                                                    <v-icon>edit</v-icon> </v-btn>
                                            </template>
                                            <span>Editar</span>
                                        </v-tooltip>
                                    </template>

                                    <v-card>
                                        <v-card-title class="headline primary white--text" primary-title>
                                            Editar Plano de Tratamento
                                        </v-card-title>

                                        <v-card-text>
                                            <v-container grid-list-md text-xs-center>
                                                <v-layout row wrap>

                                                    <v-flex xs6 class="text-xs-left">
                                                        <h5><b>Gestor:</b> {{usuarioLogado}}</h5>
                                                    </v-flex>
                                                    <v-flex xs6 class="text-xs-left">
                                                        <h5><b>Unidade Responsável:</b> {{sigla}}</h5>
                                                    </v-flex>


                                                    <v-flex xs12 sm6 d-flex>
                                                        <v-select
                                                                :items="listaTratamentos"
                                                                item-text="nome"
                                                                label="Opções de Tratamento*"
                                                                return-object
                                                                v-model="planoTratamento.tratamentoRisco"
                                                                :rules="rules.planoTratamento.tratamentoRisco"
                                                                required
                                                        ></v-select>
                                                    </v-flex>

                                                    <v-flex xs12>
                                                        <v-text-field v-model="planoTratamento.justificativa"
                                                                      label="Justificativa de escolha do Tratamento*"
                                                                      type="text"
                                                                      :rules="rules.planoTratamento.justificativa"
                                                                      required
                                                        ></v-text-field>
                                                    </v-flex>


                                                    <v-flex xs12>
                                                        <v-text-field v-model="planoTratamento.monitoramento"
                                                                      label="Monitoramento do Risco e Tratamento*"
                                                                      type="text"
                                                                      :rules="rules.planoTratamento.monitoramento"
                                                                      required
                                                        ></v-text-field>
                                                    </v-flex>



                                                    <v-flex xs4>
                                                        <v-menu
                                                                v-model="menu1"
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
                                                                        label="Planejamento*"
                                                                        persistent-hint
                                                                        prepend-icon="event"
                                                                        readonly
                                                                        v-on="on"></v-text-field>
                                                            </template>
                                                            <v-date-picker v-model="planoTratamento.dataPlanejamento" @input="menu1 = false" locale="pt-br" ></v-date-picker>
                                                        </v-menu>

                                                    </v-flex>



                                                    <v-flex xs12 class="text-xs-left">

                                                        <div v-if="planoTratamento.tratamentoRisco.planoAcao == true">

                                                            <h5><b>Plano de Ação</b></h5>


                                                            <v-text-field  v-model="planoTratamento.planoAcao"
                                                                           label="Descrição do Plano*"
                                                                           type="text"
                                                                           :rules="rules.planoTratamento.planoAcao"
                                                                           required
                                                            ></v-text-field>

                                                            <v-text-field v-model="planoTratamento.custos"
                                                                          label="Custos*"
                                                                          type="text"
                                                                          :rules="rules.planoTratamento.custos"
                                                                          required
                                                            ></v-text-field>

                                                            <v-layout row wrap>
                                                                <v-flex xs4>
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
                                                                                    v-model="computedDateFormattedInicio"
                                                                                    label="Início*"
                                                                                    persistent-hint
                                                                                    prepend-icon="event"
                                                                                    readonly
                                                                                    v-on="on"></v-text-field>
                                                                        </template>
                                                                        <v-date-picker v-model="planoTratamento.inicio" @input="menu2 = false" locale="pt-br" ></v-date-picker>
                                                                    </v-menu>

                                                                </v-flex>

                                                                <v-flex xs4>
                                                                    <v-menu
                                                                            v-model="menu3"
                                                                            :close-on-content-click="false"
                                                                            :nudge-right="50"
                                                                            lazy
                                                                            transition="scale-transition"
                                                                            offset-y
                                                                            full-width
                                                                            min-width="290px">
                                                                        <template v-slot:activator="{ on }">
                                                                            <v-text-field
                                                                                    v-model="computedDateFormattedTermino"
                                                                                    label="Termino*"
                                                                                    persistent-hint
                                                                                    prepend-icon="event"
                                                                                    readonly
                                                                                    v-on="on"></v-text-field>
                                                                        </template>
                                                                        <v-date-picker v-model="planoTratamento.termino" @input="menu3 = false" locale="pt-br" ></v-date-picker>
                                                                    </v-menu>

                                                                </v-flex>
                                                            </v-layout>
                                                        </div>

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

                                <v-dialog  v-model="dialog" persistent max-width="290" v-if="planosAll != null">
                                    <template #activator="{ on: dialog }">
                                        <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                                <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                        ><v-icon>delete</v-icon></v-btn>
                                            </template>
                                            <span>Remover</span>
                                        </v-tooltip>
                                    </template>
                                    <v-card>
                                        <v-card-title class="headline">Excluir Plano de Tratamento</v-card-title>
                                        <v-card-text>Deseja realmente excluir este plano de tratamento?</v-card-text>
                                        <v-card-actions >
                                            <v-spacer></v-spacer>
                                            <v-btn color="error"  small @click="planoDelete(planosAll.id)">Excluir</v-btn>
                                            <v-btn color="disabled" small @click="dialog = false">Cancelar</v-btn>
                                        </v-card-actions>
                                    </v-card>
                                </v-dialog >

                            </h5>
                        </v-flex>

                            <div v-if="planosAll != null">

                                <v-flex xs12 class="text-xs-left">
                                    <v-layout row wrap >
                                        <v-flex xs2>
                                            <h5><b>Responsável</b></h5>
                                            {{planosAll.responsavel.nome}}
                                        </v-flex>

                                        <v-flex xs2>
                                            <h5><b>Unidade Responsável</b></h5>
                                            {{planosAll.responsavel.unidade.sigla}}
                                        </v-flex>

                                        <v-flex xs2>
                                            <h5><b>Tratamento</b></h5>
                                            {{ planosAll.tratamentoRisco.nome}}
                                        </v-flex>

                                        <v-flex xs2>
                                            <h5><b>Data de Planejamento</b></h5>
                                            {{planosAll.dataPlanejamento | moment("DD/MM/YYYY") }}
                                        </v-flex>
                                    </v-layout>

                                    <v-layout row wrap>
                                    <v-flex xs12 >
                                        <h5><b>Justificativa:</b> {{planosAll.justificativa}}</h5>
                                    </v-flex>

                                    <v-flex xs12 >
                                        <h5><b>Consequências:</b> {{planosAll.monitoramento}}</h5>
                                    </v-flex>
                                    </v-layout>




                                    <div v-if="planosAll.tratamentoRisco.planoAcao === true">
                                        <hr size="0.1">

                                        <v-layout row wrap >

                                        <v-flex xs12 >


                                            <h5><b>PLANO DE AÇÃO</b></h5>


                                            <v-layout row wrap >
                                                <v-flex xs2>
                                                    <h5><b>Descrição</b></h5>
                                                    {{ planosAll.planoAcao}}
                                                </v-flex>

                                                <v-flex xs2>
                                                    <h5><b>Custos</b></h5>
                                                    {{planosAll.custos}}
                                                </v-flex>

                                                <v-flex xs2>
                                                    <h5><b>Início</b></h5>
                                                    {{planosAll.inicio| moment("DD/MM/YYYY") }}
                                                </v-flex>

                                                <v-flex xs2>
                                                    <h5><b>Término</b></h5>
                                                    {{planosAll.termino | moment("DD/MM/YYYY") }}
                                                </v-flex>

                                            </v-layout>


                                        </v-flex>
                                    </v-layout>
                                    </div>
                                </v-flex>
                                <br>
                            </div>

                                <v-flex xs12 class="text-xs-left">

                                    <div v-if="planosAll === null" >
                                        <br>
                                        <h4 style="justify-content: center">Nenhum Plano de Tratamento Cadastrado</h4>
                                    </div>
                                </v-flex>
                            </v-card-text>
                        </v-card>

                    </div>

                </v-card>
            </v-flex>

        </v-layout>
        <v-snackbar :timeout="timeout" right top :color="cor" v-model="snackbar">{{ mensagem }} </v-snackbar>

    </v-container>
</template>

<script>
    import { mapState } from "vuex";
    import axios from "axios"
    import CadastrarPlanoTratamento from './CadastrarPlanoTratamento'


    export default {
        components: {
            CadastrarPlanoTratamento
        },

    data() {
            return {
                pagination: { rowsPerPage: 10},
                planosAll:'',
                riscoId: null,
                risco: '',
                nameRules: [
                    v => !!v || '',
                ],
                headers: [
                    { text: 'Justificativa', value: "justificativa" },
                    { text: 'Monitoramento', value: "monitoramento" },
                    { text: 'Data Planejamento', value: "dataPlanejamento" },
                    { text: 'Responsável', value: "responsavel" },
                    { text: "", sortable: false, value: ""}
                ],
                av:[],
                flag:'',
                dialog:false,
                tei: false,
                hidden:false,
                planoTratamento:{
                    justificativa:'',
                    monitoramento:'',
                    planoAcao:'',
                    custos:'',
                    responsavel: '',
                    inicio: new Date().toISOString().substr(0, 10),
                    termino:new Date().toISOString().substr(0, 10),
                    dataPlanejamento: new Date().toISOString().substr(0, 10),
                    tratamentoRisco:''
                },
                row: null,
                menu1: false,
                menu2: false,
                menu3: false,
                listaTratamentos: [],
                politicaVirgente:'',
                riscoTratamento:{
                    tratamento: null,
                },
                usuarioLogado:'',
                sigla:'',

                snackbar: '',
                mensagem: "",
                cor: "",
                timeout: 3500,

                rules: {
                    planoTratamento: {
                        tratamentoRisco: [v => !!v || 'Opção do Tratamento é um campo obrigatório'],
                        justificativa: [v => !!v || 'Justificativa do Tratamento é um campo obrigatório'],
                        monitoramento: [v => !!v || 'Monitoramento é um campo obrigatório'],
                        planoAcao: [v => !!v || 'Descrição do Plano de Ação é um campo obrigatório'],
                        custos: [v => !!v || 'Custos é um campo obrigatório'],
                    }
                }
                
            };
        },

        computed: {
            ...mapState({
                usuarios: state => state.usuarios.all,
            }),
            formIsValid() {
                return this.planoTratamento.monitoramento !== "" && this.planoTratamento.justificativa !== ""
            },
            computedDateFormatted () {
                return this.formatDate(this.planoTratamento.dataPlanejamento)
            },
            computedDateFormattedInicio () {
                return this.formatDate(this.planoTratamento.inicio)
            },
            computedDateFormattedTermino () {
                return this.formatDate(this.planoTratamento.termino)
            }

        },

        created() {
            this.$store.dispatch('usuarios/GET_ALL')
            this.riscoId = this.$route.params.id;


            {
                axios.get('/usuarios/').then(res => {
                    this.planoTratamento.responsavel = res.data;
                    this.listarPlanosTratamento();
                    this.usuarioLogado = planoTratamento.responsavel.nome
                    this.sigla = res.data.unidade.sigla;
                })

            }

            axios.get('politicas/vigente').then(res => {
                this.politicaVirgente = res.data
                this.listarTratamentos();
            });

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
                this.planosAll = plano;
                this.$emit('event-update-plano', this.planosAll);
            },


            listarTratamentos(){
                axios.get("/tratamentosRisco/listar/" + this.politicaVirgente.id).then(res => {
                    this.listaTratamentos = res.data;
                })
            },
            listarPlanosTratamento(){
                axios.get('/riscos/' + this.riscoId).then(res => {
                    this.planos = res.data;
                    this.planosAll = this.planos.tratamento;
                    this.$emit('event-update-plano', this.planosAll);
                })
                /*axios.get('/plano_tratamento/').then(res => {
                    this.planosAll = res.data;
                    this.planosEsp.push(this.planosAll.tratamento);
                })*/
            },


            planoGet(id){
                axios.get('/plano_tratamento/' + id).then(res => {
                        this.flag = res.data;
                })
            },

            planoDelete(id){
                this.snackbar = false;
                //Desvincula plano do risco
                axios.put('/riscos/addPlano/' + this.riscoId, this.riscoTratamento).then(res => {
                    //Remove Plano
                    axios.delete('/plano_tratamento/' + id).then(res => {
                        /*alert("Deletado");*/
                        this.planosAll = null;
                        this.dialog = false;
                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Plano de Tratamento excluído com sucesso!";
                        this.$emit('event-update-plano', this.planosAll);
                    })

                }) .catch(e => {
                    //removido o alert
                    this.mensagem = "Erro ao excluir Plano de Tratamento!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;

                })
            },

            planoEditar(id) {
                axios.get('/plano_tratamento/' + id).then(res => {
                    this.y = res.data;
                    this.planoTratamento.justificativa = this.y.justificativa;
                    this.planoTratamento.monitoramento = this.y.monitoramento;
                    this.planoTratamento.planoAcao = this.y.planoAcao;
                    this.planoTratamento.custos = this.y.custos;
                    this.planoTratamento.inicio = this.y.inicio;
                    this.planoTratamento.termino = this.y.termino;
                    this.planoTratamento.dataPlanejamento = this.y.dataPlanejamento;
                    this.planoTratamento.responsavel= this.y.responsavel;
                    this.planoTratamento.tratamentoRisco = this.y.tratamentoRisco;
                })
            },

            editarPlano() {
                this.snackbar = false;
                var startDate= new Date(this.planoTratamento.inicio).toISOString().substr(0, 10);
                var endDate= new Date(this.planoTratamento.termino).toISOString().substr(0, 10);

                if(startDate <= endDate ) {
                    axios.put('/plano_tratamento/' + this.y.id, this.planoTratamento).then(res => {
                        //alert deletado
                        this.tei = false;

                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Plano de Tratamento editado com sucesso!";
                        this.listarPlanosTratamento();

                    }).catch(e => {
                        //alert deletado
                        this.mensagem = "Erro ao editar Plano de Tratamento!";
                        this.cor = "error";
                        this.snackbar = true;
                        this.tei = false;

                    });
                }
                else{
                    this.mensagem = "A data de início não pode ser maior que a data de término!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;


                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
                }
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
            }
        }}


</script>

<style scoped>

</style>
