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
                <span>Nova Ocorrência</span>
            </v-tooltip>
        </template>


        <v-card>

        <v-form ref="form" v-model="valid" :lazy-validation="lazy">
            <v-card-title class="headline primary white--text" primary-title>
                Nova Ocorrência
            </v-card-title>

            <v-card-text>
                <v-container grid-list-md text-xs-center>
                    <v-layout wrap>

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
                                    id="inputDescricaoOcorrencia"
                                    label="Descrição*"
                                    v-model="ocorrencia.descricao"
                                    type="text"
                                    :rules="rules.ocorrencia.descricao"
                                    required
                            ></v-text-field>
                        </v-flex>



                        <v-flex xs12>
                            <v-text-field
                                    id="inputSolucaoOcorrencia"
                                    label="Solução*"
                                    v-model="ocorrencia.solucao"
                                    type="text"
                                    :rules="rules.ocorrencia.solucao"
                                    required
                            ></v-text-field>
                        </v-flex>

                        <v-flex xs12>
                            <v-text-field
                                    id="inputResultadoOcorrencia"
                                    label="Resultados*"
                                    v-model="ocorrencia.resultados"
                                    type="text"
                                    :rules="rules.ocorrencia.resultados"
                                    required
                            ></v-text-field>
                        </v-flex>
                                   

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
                <v-btn color="primary" v-on:click="salvar()" @click="validate" :disabled="!valid">Salvar</v-btn>
                <v-btn color="disabled" v-on:click="tei=false,  limparCampos()">Cancelar</v-btn>
            </v-card-actions>

         </v-form>
        </v-card>

    </v-dialog>

</template>

<script>
    import axios from "axios";
    import {mapState} from 'vuex'

    export default {
        components: {
        },
        data: function() {

            return {
                planosAll:'',
                planosEsp:[

                ],
                avaliacoes: '',
                tei: false,
                valid: true,
                lazy: false,
                hidden:false,
                riscoId: null,
                ocorrencia:{
                    descricao:'',
                    solucao:'',
                    resultados: '',
                    responsavel: '',
                    risco: '',
                    data: new Date().toISOString().substr(0, 10),
                },
                row: null,
                menu2: false,
                usuarioLogado:'',
                sigla:'',
                snackbar: false,
                mensagem: "",
                cor: "",
                rules: {
                    ocorrencia: {
                        descricao: [v => !!v || 'Descrição da Ocorrência é um campo obrigatório'],
                        solucao: [v => !!v || 'Solução da Ocorrência é um campo obrigatório'],
                        resultados: [v => !!v || 'Resultados da Ocorrência é um campo obrigatório']

                    }
                }

            };



        },
        mounted: function() {

        },


        computed: {
            computedDateFormatted () {
                return this.formatDate(this.ocorrencia.data)
            },

            ...mapState({
                usuarios: state => state.usuarios.all,
            }),
            /*formIsValid() {
                return this.processo.nome !== "" && this.processo.tipo !== "";
            }*/
            formIsValid() {
                return this.ocorrencia.solucao !== "" && this.ocorrencia.descricao !== ""
                    && this.ocorrencia.resultados !== "";
            }
        },


        created () {
            this.$store.dispatch('usuarios/GET_ALL');
            this.riscoId = this.$route.params.id;
            {
                axios.get('/riscos/' + this.riscoId).then(res => {
                    this.ocorrencia.risco = res.data;
                })
            }
            {
                axios.get('/usuarios/').then(res => {
                    this.ocorrencia.responsavel = res.data;
                    this.usuarioLogado = res.data.nome;
                    this.sigla = res.data.unidade.sigla;
                })
            }
            /*{
                axios.get('/plano_contingencia/').then(res => {
                    this.planos = res.data;
                })
            }
            this.listarPlanosContingencia();*/

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
                this.ocorrencia.descricao = '';
                this.ocorrencia.solucao = '';
                this.ocorrencia.resultados =  '';
                this.ocorrencia.data = new Date().toISOString().substr(0, 10);
                this.resetValidation();
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

            salvar() {
                this.data = this.date;
                axios.post('/ocorrencias', this.ocorrencia).then(res => {

                    //removido o alert
                    this.tei = false;
                    this.limparCampos();
                    this.snackbar = true;

                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Ocorrência cadastrada com sucesso!";
                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
                    this.$emit('event-new-ocorrencia', res.data);
                    
                }).catch(e => {
                    //removido o alert
                    this.mensagem = "Erro ao cadastrar Ocorrência!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;

                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
                });

            },



        }
    };
</script>

<style scoped>

</style>
