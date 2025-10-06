<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-dialog  v-model="tei" persistent max-width="800">
        <template #activator="{ on: tei }">
            <v-tooltip bottom>
                <template #activator="{ on: tooltip }">
                    <v-fab-transition>
                        <v-btn v-on="{ ...tooltip, ...tei }" v-show="!hidden" color="cyan" dark absolute  right fab>
                            <v-icon>add</v-icon>
                        </v-btn>
                    </v-fab-transition>
                </template>
                <span>Novo Plano de Contingência</span>
            </v-tooltip>
        </template>

        <v-card>

        <v-form ref="form" v-model="valid" :lazy-validation="lazy">
            <v-card-title class="headline primary white--text" primary-title>
                Novo Plano de Contingência
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
                nameRules: [
                    v => !!v || '',
                ],
                tei: false,
                hidden:false,
                riscoId: null,
                planoContingencia:{
                    gatilho:'',
                    acao:'',
                    responsavel: '',
                    risco: '',
                },

                row: null,
                menu2: false,
                usuarioLogado:'',
                sigla:'',
                valid: true,
                lazy: false,
                snackbar: false,
                mensagem: "",
                cor: "",

                rules: {
                    planoContingencia: {
                        gatilho: [v => !!v || 'Gatilho é um campo obrigatório'],
                        acao: [v => !!v || 'Ação é um campo obrigatório']
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
                return this.planoContingencia.gatilho !== "" && this.planoContingencia.acao !== ""
            }
        },


        created () {
            this.$store.dispatch('usuarios/GET_ALL');
            this.riscoId = this.$route.params.id;
            {
                axios.get('/riscos/' + this.riscoId).then(res => {
                    this.planoContingencia.risco = res.data;
                })
            }
            {
                axios.get('/usuarios/').then(res => {
                    this.planoContingencia.responsavel = res.data;
                    this.usuarioLogado = res.data.nome;
                    this.sigla = res.data.unidade.sigla;
                })
            }
        },


        methods: {
            limparCampos(){
                this.planoContingencia.gatilho = '';
                this.planoContingencia.acao = '';
                this.resetValidation();
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
                axios.post('/plano_contingencia', this.planoContingencia).then(res => {
                    //removido o alert
                    this.limparCampos();
                    this.tei = false;
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Plano de Contingencia cadastrado com sucesso!";

                    this.$emit('event-new-snackbar', this.snackbar);
                    this.$emit('event-new-mensagem', this.mensagem);
                    this.$emit('event-new-cor', this.cor);
                    this.$emit('event-new-plano', res.data)
                }).catch(e => {
                   //removido o alert

                    this.mensagem = "Erro ao cadastrar avaliação!";
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
