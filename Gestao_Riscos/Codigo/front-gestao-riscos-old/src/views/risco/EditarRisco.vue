<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-layout row justify-center>
        <v-dialog  v-model="tei" persistent max-width="800">
            <template #activator="{ on: tei }">
                <v-tooltip bottom>
                    <template #activator="{ on: tooltip }">
                        <v-fab-transition>
                            <v-btn v-on="{ ...tooltip, ...tei }" v-show="!hidden" color="cyan" dark absolute top right fab>
                                <v-icon>add</v-icon>
                            </v-btn>
                        </v-fab-transition>
                    </template>
                    <span> Novo Risco</span>
                </v-tooltip>
            </template>
            <v-card>
                <v-card-title class="headline primary white--text"  primary-title>
                    Novo Risco
                </v-card-title>
                <v-card-text>
                <v-container grid-list-md>
                    <v-layout wrap>
                        <v-flex xs6 class="text-xs-left">
                            <h5><b>Gestor:</b> {{risco.responsavel.nome}}</h5>
                        </v-flex>
                        <v-flex xs6 class="text-xs-left">
                            <h5><b>Unidade Responsável:</b> {{risco.unidade.sigla}}</h5>
                        </v-flex>
                    </v-layout>
                    <v-layout wrap>
                        <v-flex xs12>
                            <v-text-field id="inputNomeRisco" label="Nome do Risco*"
                                    :rules="nameRules" v-model="risco.nome" required type="text"
                            ></v-text-field>
                        </v-flex>
                        <small>*Campos obrigatórios</small>
                    </v-layout>
                     <v-layout wrap>
                        <v-flex xs4 class="text-xs-left">
                            <h5><b>Tipo do Risco:</b> {{risco.tipo}}</h5>
                        </v-flex>
                        <v-flex xs4>
                            <v-select v-model="risco.categoria" :rules="nameRules" :items="listaCategorias" item-text="nome"
                                      item-value="id" return-object label="Categoria do Risco*"
                            ></v-select>
                        </v-flex>
                         <v-flex xs4 class="text-xs-left">
                            <h5><b>Politica:</b> {{risco.politica.nome}}</h5>
                        </v-flex>
                        <small>*Campos obrigatórios</small>
                    </v-layout>
                    <v-layout wrap >
                        <v-flex xs12>
                            <v-select v-model="risco.processos" :rules="nameRules" :items="processos" :menu-props="{ maxHeight: '400' }" label="Processo"
                              item-text="nome" return-object multiple persistent-hint>
                            </v-select>
                        </v-flex>
                        <v-flex xs12>
                            <v-text-field id="inputCausaRisco" label="Causa do Risco*"
                                    :rules="nameRules" v-model="risco.causa" required type="text"
                            ></v-text-field>
                        </v-flex>
                         <v-flex xs12 class="text-xs-left">
                            <v-text-field id="inputConsequenciaRisco" label="Consequência do Risco*"
                                    :rules="nameRules" v-model="risco.consequencia" required type="text"
                            ></v-text-field>
                        </v-flex>
                        <small>*Campos obrigatórios</small>
                    </v-layout>
                </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="editarRisco" :disabled="!formIsValid" class = "botoes" dark > Editar </v-btn>
                    <v-btn color="disabled" v-on:click="tei=false" >Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-layout>
</template>

​

<script>

    import { mapState, mapActions } from 'vuex'
    import axios from 'axios'
    export default {
        data () {
            return {
            politicaVirgente:{},
            listaCategorias:[],
            risco: {
                categoria: {},
                responsavel: {},
                unidade:{},
                processo:[],
                avaliacoes:[],
                politica:{}
            },
            tei: false,
            tipoRisco: [
                {text: 'Ameaça', value: 'AMEACA'},
                {text: 'Oportunidade', value: 'OPORTUNIDADE'}
            ],
                menu1: false,
                row: null
            }
        },

        computed: {
                ...mapState({
                    processos: state => state.processos.all,
                    probabilidades: state => state.probabilidades.all,
                    fatoresAvaliacao: state => state.fatoresAvaliacao.all,
                    politicas: state => state.politicas.all,
                    impactos: state => state.impactos.all,
                    categorias: state => state.categorias.all,
                    usuarios: state => state.usuarios.all,
                    tipoProcesso:state => state.tipoProcesso.all

                }),
                computedDateFormatted () {
                    return this.formatDate(this.date)
                },
                formIsValid() {
                    return this.risco.nome !== "" && this.causaRisco !== "" && this.risco.consequencia !== "";
                }

        },

        created() {
            axios.get('politicas/vigente').then(res => {
                this.risco.politica = res.data
                this.criarListaCategorias();
            });
            this.$store.dispatch("processos/GET_ALL"),
            this.$store.dispatch('politicas/GET_ALL'),
            this.$store.dispatch('usuarios/GET_ALL');
            this.risco = this.$route.params.risco;

        },
        methods: {
            getRisco(id){
                axio.get('/riscos'+id).then(res => {this.risco.id = res.data;})

            },

            criarListaCategorias() {
                 axios.get("/categoriasRisco/listar/" + this.risco.politica.id).then(res => {
                    return this.listaCategorias = res.data;

                })
                .catch(error => console.log(error));
            },

            editarRisco(){
                
                    axios.put('/riscos/' + this.risco.id, this.risco).then(res =>  {
                            alert("Risco atualizado com Sucesso!");
                            console.log(res);
                           this.$router.push('/riscos/');
                    }).catch( e=> {
                        console.log(e)
                        alert(e)
                    });

            },

            ...mapActions('risco', [{
                getRisco: 'add'
            }]),
            ...mapActions('processos', [{
                addProcesso: 'add'

            }]),
            ...mapActions('riscos', [{
                addRisco: 'add'

            }]),
            ...mapActions('avaliacoes', [{
                addAvaliacoes: 'add'

            }]),
        },
    }
</script>