<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>

                <v-card>
                    <div id="app">
                        <!-- <v-app id="inspire"> -->
                        <v-card>

                        <v-card-text>
                            <h5>
                                <b>AVALIAÇÕES</b>
                                <cadastrar-avaliacao @event-new-avaliacao="atualizarAvaliacoes"
                                                     @event-new-mensagem="recebeMsg"
                                                     @event-new-snackbar="recebeSnack"
                                                     @event-new-cor="recebeCor"></cadastrar-avaliacao>
                            </h5>

                            <v-toolbar card color="white">
                                <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down"></v-text-field>
                            </v-toolbar>


                            <v-data-table
                                    :pagination.sync="pagination"
                                    :search="search"
                                    :headers="headers"
                                    :items="avaliacoes"
                                    no-data-text="Nenhum resultado encontrado"
                                    no-results-text="Nenhum resultado encontrado"
                            >

                                <template v-slot:items="props">
                                    <tr @click="props.expanded = !props.expanded">
                                        <td class="justify-center" >{{ props.item.risco.nome}}</td>
                                        <td class="justify-center" >{{ props.item.probabilidade.valor * props.item.impacto.valor}}</td>
                                        <td
                                                class="justify-center"

                                        >{{props.item.data| moment("DD/MM/YYYY") }}</td>
                                        <td class="justify-center">{{ props.item.risco.responsavel.nome}}</td>
                                        <td class="justify-center">{{ props.item.risco.unidade.sigla}}</td>
                                            <v-dialog  v-model="tei" persistent max-width="800">
                                                <template #activator="{ on: tei }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">

                                                            <v-btn   color="primary" dark
                                                                     depressed outline icon fab small v-on="{ ...tooltip, ...tei }" @click="avaliacaoEditar(props.item.id)"
                                                            >
                                                                <v-icon>edit</v-icon> </v-btn>
                                                        </template>
                                                        <span>Editar</span>
                                                    </v-tooltip>
                                                </template>

                                                <v-card>
                                                    <v-card-title class="headline primary white--text" primary-title>
                                                        Editar Avaliação
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

                                                                <v-flex xs4>
                                                                    <v-select v-model="avaliacao.probabilidade"
                                                                              :items="listaProbabilidades"
                                                                              item-text="nome"
                                                                              item-value="id"
                                                                              return-object
                                                                              label="Probabilidade*"
                                                                              :rules="[v => !!v || 'Campo obrigatório']"
                                                                             required
                                                                    ></v-select>
                                                                </v-flex>



                                                                <v-flex xs4>
                                                                    <v-select v-model="avaliacao.impacto"
                                                                              :items="listaImpactos"
                                                                              item-text="nome"
                                                                              item-value="id"
                                                                              return-object
                                                                              label="Impacto*"
                                                                              :rules="[v => !!v || 'Campo obrigatório']"
                                                                              required
                                                                    ></v-select>
                                                                </v-flex>

                                                                <v-flex xs4>
                                                                    <v-text-field

                                                                            label="Risco Inerente"
                                                                            tooltip="Detalhes"
                                                                            :value="inerente"
                                                                            disabled
                                                                            type="text"

                                                                    ></v-text-field>
                                                                </v-flex>

                                                                <v-flex xs4>
                                                                    <v-select v-model="avaliacao.fatorAvaliacaoControle"
                                                                              :items="listafatorAvaliacaoControle"
                                                                              item-text="nome"
                                                                              item-value="id"
                                                                              return-object
                                                                              label="Fator Controle*"
                                                                              :rules="[v => !!v || 'Campo obrigatório']"
                                                                              required
                                                                    ></v-select>
                                                                </v-flex>

                                                                <v-flex xs4>

                                                                    <v-text-field
                                                                            label="Risco Residual"
                                                                            disabled
                                                                            :value="residual"
                                                                            center
                                                                            type="text"
                                                                    ></v-text-field>
                                                                </v-flex>

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
                                                                                    v-model="computedDateFormatted"
                                                                                    label="Data*"
                                                                                    persistent-hint
                                                                                    prepend-icon="event"
                                                                                    readonly
                                                                                    v-on="on"></v-text-field>
                                                                        </template>
                                                                        <v-date-picker v-model="avaliacao.data" @input="menu2 = false" locale="pt-br" ></v-date-picker>
                                                                    </v-menu>
                                                                </v-flex>

                                                                <small>*Campos obrigatórios</small>
                                                            </v-layout>

                                                        </v-container>
                                                    </v-card-text>

                                                    <v-card-actions>
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="primary" @click="editar" :disabled="!formIsValid">Editar</v-btn>
                                                        <v-btn color="disabled" @click="tei=false">Cancelar</v-btn>
                                                    </v-card-actions>

                                                </v-card>

                                            </v-dialog>

                                            <v-dialog  v-model="dialog" persistent max-width="300">
                                                <template #activator="{ on: dialog }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">
                                                            <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                                    @click="avaliacaoGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                                        </template>
                                                        <span>Remover</span>
                                                    </v-tooltip>
                                                </template>
                                                <v-card>
                                                    <v-card-title class="headline">Excluir Avaliação</v-card-title>
                                                    <v-card-text>Deseja realmente excluir esta avaliação?</v-card-text>
                                                    <v-card-actions >
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="error"  small @click="avaliacaoDelete(flag.id)">Excluir</v-btn>
                                                        <v-btn color="disabled" small @click="dialog = false">Cancelar</v-btn>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-dialog>
                                        <!--</td> -->
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
    import axios from "axios"
    import CadastrarAvaliacao from './CadastrarAvaliacao'

    export default {
        components: {
            CadastrarAvaliacao
        },

    data() {
            return {
                pagination: { rowsPerPage: 10 },
                listaImpactos:[],
                listaProbabilidades:[],
                listafatorAvaliacaoControle:[],
                riscoId: null,
                nameRules: [
                    v => !!v || '',
                ],
                search: '',
                risco: '',
                headers: [
                    { text: 'Risco', value: "risco.nome" },
                    { text: 'Risco Inerente', value: "probabilidade.valor" },
                    { text: 'Data', value: "data" },
                    { text: 'Responsável', value: "responsavel.nome" },
                    { text: 'Unidade Responsável', value: "risco.unidade.sigla" },
                    { text: "", sortable: false, value: ""}
                ],
                av:[],
                flag:'',
                dialog:false,
                tei: false,
                hidden:false,
                avaliacao:{
                    probabilidade:'',
                    impacto:'',
                    fatorAvaliacaoControle: '',
                    risco: '',
                    responsavel: '',
                    data:  '',
                },
                row: null,
                calendar: false,
                listaDeAvaliacoesGet: [],
                avaliacoes:[],
                menu2: false,
                usuarioLogado:'',
                sigla:'',
                snackbar: '',
                mensagem: "",
                cor: "",
                timeout: 3500,

            };
        },

        computed: {
            computedDateFormatted () {
                return this.formatDate(this.avaliacao.data)
            },
            inerente: function () {
                if(this.avaliacao.probabilidade.valor != null && this.avaliacao.impacto.valor != null){
                    return this.avaliacao.probabilidade.valor * this.avaliacao.impacto.valor;
                }

                else{
                    return null;
                }

            },
            residual: function () {
                if(this.avaliacao.probabilidade.valor != null && this.avaliacao.impacto.valor != null
                    && this.avaliacao.fatorAvaliacaoControle.valor != null){
                    return (this.avaliacao.probabilidade.valor * this.avaliacao.impacto.valor) * this.avaliacao.fatorAvaliacaoControle.valor;
                }

                else{
                    return null;
                }

            },
            formIsValid() {
                return this.avaliacao.probabilidade !== "" && this.avaliacao.impacto !== ""
                    && this.avaliacao.fatorAvaliacaoControle !== "" && this.avaliacao.data !== "";
            },


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
            this.listarAvaliacoes();
            axios.get('politicas/vigente').then(res => {
                this.politicaVirgente = res.data;
                this.criarListaProbabilidades();
                this.criarListaImpactos();
                this.criarListafatorAvaliacaoControle();
            });
            {
                axios.get('/usuarios/').then(res => {
                    this.usuarioLogado = res.data.nome;
                    this.sigla = res.data.unidade.sigla;
                })
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

            criarListaImpactos() {
                axios.get("/impactos/listar/" + this.politicaVirgente.id).then(res => {
                    return this.listaImpactos = res.data;

                })
                    .catch(error => console.log(error));
            },
            criarListaProbabilidades() {
                axios.get("/probabilidades/listar/" + this.politicaVirgente.id).then(res => {
                    return this.listaProbabilidades = res.data;

                })
                    .catch(error => console.log(error));
            },

            criarListafatorAvaliacaoControle() {
                axios.get("/fatoresAvaliacao/listar/" + this.politicaVirgente.id).then(res => {
                    return this.listafatorAvaliacaoControle = res.data;

                })
                    .catch(error => console.log(error));
            },

            atualizarAvaliacoes(avaliacao) {
                this.avaliacoes.push(avaliacao);
                this.$emit('event-update-av', this.avaliacoes);
            },

            listarAvaliacoes(){
                axios.get('/avaliacoes/listar/' + this.riscoId).then(res => {
                    this.avaliacoes = res.data
                    /*for(let i = 0; i < this.listaDeAvaliacoesGet.length; i++){

                        if(this.listaDeAvaliacoesGet[i].risco.id == this.riscoId){
                            this.avaliacoes.push(this.listaDeAvaliacoesGet[i])
                        }
                    }*/
                    this.$emit('event-update-av2', this.avaliacoes);
                }).catch(
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

            avaliacaoGet(id){
                axios.get('/avaliacoes/' + id).then(res => {
                        this.flag = res.data;
                })
            },


            avaliacaoDelete(id) {
                    axios.delete('/avaliacoes/' + id).then(res => {
                        //removido o alert
                        /*location.reload();*/
                        this.dialog = false;
                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Avaliação excluída com sucesso!";
                        this.listarAvaliacoes();
                    }).catch(e => {
                        /*this.mensagem = e.response.data;*/
                        this.mensagem = "Erro ao excluir Avaliação!";
                        this.cor = "error";
                        this.snackbar = true;
                        this.tei = false;

                    })

            },

            avaliacaoEditar(id) {
                axios.get('/avaliacoes/' + id).then(res => {
                    this.y = res.data;
                    this.avaliacao.probabilidade = this.y.probabilidade;
                    this.avaliacao.impacto = this.y.impacto;
                    this.avaliacao.fatorAvaliacaoControle = this.y.fatorAvaliacaoControle;
                    this.avaliacao.data =  this.y.data;
                    this.avaliacao.responsavel = this.y.responsavel;
                    this.avaliacao.risco = this.y.risco;
                })
            },

            editar() {
                axios.put('/avaliacoes/' + this.y.id, this.avaliacao).then(res => {
                    this.tei = false;
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Avaliação editada com sucesso!";
                    this.listarAvaliacoes();
                }).catch(e => {
                    /*this.mensagem = e.response.data;*/
                    this.mensagem = "Erro ao editar avaliação!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;
                });

            }
        }}


</script>

<style scoped>

</style>