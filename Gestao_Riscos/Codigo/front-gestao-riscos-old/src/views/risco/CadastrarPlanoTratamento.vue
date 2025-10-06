<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-dialog  v-model="tei" persistent max-width="800">
        <template #activator="{ on: tei }">
            <v-tooltip bottom>
                <template #activator="{ on: tooltip }">
                    <v-fab-transition>
                        <v-btn v-on="{ ...tooltip, ...tei }" v-show="!hidden" color="cyan" dark absolute right fab>
                            <v-icon>add</v-icon>
                        </v-btn>
                    </v-fab-transition>
                </template>
                <span>Novo Plano de Tratamento</span>
            </v-tooltip>
        </template>

        <v-card>

         <v-form ref="form" v-model="valid" :lazy-validation="lazy">
            <v-card-title class="headline primary white--text" primary-title>
                Novo Plano de Tratamento
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
                <v-btn color="primary" v-on:click="salvar()" @click="validate" :disabled="!valid">Salvar</v-btn>
                <v-btn color="disabled" v-on:click="tei=false,  limparCampos()">Cancelar</v-btn>
            </v-card-actions>
            </v-form> 
        </v-card>

    </v-dialog>

</template>

<script>
    import axios from "axios";
    import { mapState } from 'vuex'

    export default {
        components: {

        },

        data: function() {

            return {
                nameRules: [
                    v => !!v || '',
                ],
                tei: false,
                hidden:false,
                riscoId: null,
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
                limparCampos(){
                this.planoTratamento.tratamentoRisco = '';
                this.planoTratamento.justificativa = '';
                this.planoTratamento.monitoramento =  '';
                this.planoTratamento.planoAcao = '';
                this.planoTratamento.custos = '';
                this.planoTratamento.monitoramento =  '';
                this.planoTratamento.inicio = new Date().toISOString().substr(0, 10);
                this.planoTratamento.termino = new Date().toISOString().substr(0, 10);
                this.resetValidation();
            },
                row: null,
                menu1: false,
                menu2: false,
                menu3: false,
                listaTratamentos: [],
                politicaVirgente:'',
                riscoTratamento:{
                    tratamento:'',
                },
                t: [],
                usuarioLogado:'',
                sigla:'',
                valid: true,
                lazy: false,
                snackbar: false,
                mensagem: "",
                cor: "",

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
        mounted: function() {

        },

        computed: {
            ...mapState({
                usuarios: state => state.usuarios.all,
            }),
            formIsValid() {
                if(this.planoTratamento.tratamentoRisco.planoAcao == false){
                    return this.planoTratamento.monitoramento !== "" && this.planoTratamento.justificativa !== ""
                }
                else{
                    return this.planoTratamento.monitoramento !== "" && this.planoTratamento.justificativa !== ""
                    && this.planoTratamento.custos !== "" && this.planoTratamento.planoAcao !== ""
                }
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

        created () {
            this.riscoId = this.$route.params.id;
            this.$store.dispatch('usuarios/GET_ALL')
                {
                    axios.get('/usuarios/').then(res => {
                        this.planoTratamento.responsavel = res.data;
                        this.usuarioLogado = res.data.nome;
                        this.sigla = res.data.unidade.sigla;
                    })
                }


            axios.get('politicas/vigente').then(res => {
                this.politicaVirgente = res.data
                this.listarTratamentos();
            });
        },


        methods: {
            listarPlanosTratamento(){
                axios.get("/plano_tratamento/").then(res => {
                })
            },

            listarTratamentos(){
                axios.get("/tratamentosRisco/listar/" + this.politicaVirgente.id).then(res => {
                    this.listaTratamentos = res.data;
                })
            },
            adicionarPlanoAoRisco(){
                axios.get('/plano_tratamento/').then(res => {
                    this.t = res.data;
                    var dsa = this.t.length - 1;
                    this.riscoTratamento.tratamento = this.t[dsa];
                    axios.put('/riscos/addPlano/' + this.riscoId, this.riscoTratamento).then(res => {
                    }) .catch(e => {
                        //removido o alert
                    })
                })

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
                
                },
            salvar() {
                /*this.tratamento();*/
                var startDate= new Date(this.planoTratamento.inicio).toISOString().substr(0, 10);
                var endDate= new Date(this.planoTratamento.termino).toISOString().substr(0, 10);

                if(startDate <= endDate ) {
                axios.post('/plano_tratamento', this.planoTratamento).then(res => {
                    //alert deletado
                    this.tei = false;
                    this.adicionarPlanoAoRisco();
                    this.limparCampos();
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Plano de Tratamento cadastrado com sucesso!";

                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
                    this.$emit('event-new-plano', res.data);
                    this.$emit('event-new-p', true);
                }).catch(e => {
                    //alert deletado
                    this.mensagem = "Erro ao cadastrar Plano de Tratamento!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;


                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
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
        }
    };

</script>

<style scoped>

</style>
