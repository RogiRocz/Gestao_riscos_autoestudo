<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap justify-center>
            <v-flex xs12 >

                <v-toolbar-title card>
                    <h3 style="text-align: center "><b></b></h3>
                </v-toolbar-title>

                <div id="app">
                    <v-app id="inspire">
                        <!---->


                        <v-card >

                            <v-card-title class="headline primary white--text">
                                <div v-if="risco.tipo == 'OPORTUNIDADE'">
                                    <b>Oportunidade:</b> {{risco.nome}}
                                </div>
                                <div v-if="risco.tipo == 'AMEACA'">
                                    <b>Ameaça:</b> {{risco.nome}}
                                </div>
                                <v-spacer></v-spacer>

                                <v-btn

                                        icon

                                        color="white"

                                        outline

                                        @click="$router.push('/riscos/')"


                                >

                                    <v-icon>arrow_back</v-icon>

                                </v-btn>

                                <h5>VOLTAR</h5>
                            </v-card-title>

                            <v-tabs
                                    centered
                                    icons-and-text
                                    :grow="true"
                            >
                                <v-tabs-slider color="blue"></v-tabs-slider>

                                <v-tab href="#tab-1">
                                    DETALHES
                                    <v-icon>search</v-icon>
                                </v-tab>

                                <v-tab href="#tab-2" v-if="risco.tipo == 'AMEACA'">
                                    AVALIAÇÕES
                                    <v-icon>thumb_up_alt</v-icon>
                                </v-tab>

                                <v-tab href="#tab-3">
                                    PLANO DE TRATAMENTO
                                    <v-icon>library_books</v-icon>
                                </v-tab>

                                <v-tab href="#tab-4">
                                    OCORRENCIAS
                                    <v-icon>warning</v-icon>
                                </v-tab>

                                <v-tab href="#tab-5">
                                    PLANO DE CONTINGÊNCIA
                                    <v-icon>chrome_reader_mode</v-icon>
                                </v-tab>

                                <v-tab-item
                                        v-for="i in 5"
                                        :key="i"
                                        :value="'tab-' + i">
                                    <div v-if="i == 1" >

                                        <v-flex xs10 offset-xs1>

                                            <v-flex xs12 class="text-xs-left">

                                                <br>
                                                <v-layout row wrap >
                                                    <v-flex xs2>
                                                        <h5><b>Responsável</b></h5>
                                                        {{risco.responsavel.nome}}
                                                    </v-flex>
                                                    <v-flex xs2>
                                                        <h5><b>Política</b></h5>
                                                        {{ verificarPolitica(risco.politica) }}
                                                    </v-flex>
                                                    <v-flex xs2>
                                                        <h5><b>Categoria</b></h5>
                                                        {{risco.categoria.nome}}
                                                    </v-flex>
                                                    <v-flex xs2 v-if="avaliacoes.length > 0">
                                                        <h5><b>Nível do Risco</b></h5>
                                                        {{ nRisco(avaliacoes) }}
                                                    </v-flex>
                                                    <v-flex xs2 v-if="risco.tipo == 'AMEACA'">
                                                        <h5><b>Periodicidade</b></h5>
                                                        {{risco.periodicidadeAvaliacao}}
                                                    </v-flex>

                                                </v-layout>
                                            </v-flex>



                                            <template v-if="risco.tipo === x && avaliacoes.length > 0" >
                                                <v-flex xs12 class="text-xs-left" >
                                                    <v-layout row wrap >
                                                        <v-flex xs2>
                                                            <h5><b>Probabilidade</b></h5>
                                                            {{verificarProbailidade(avaliacoes)}}
                                                        </v-flex>
                                                        <v-flex xs2>
                                                            <h5><b>Impacto</b></h5>
                                                            {{verificarImpacto(avaliacoes)}}
                                                        </v-flex>
                                                        <v-flex xs2>
                                                            <h5><b>Risco Inerente</b></h5>
                                                            {{inerente(avaliacoes)}}
                                                        </v-flex>
                                                        <v-flex xs2>
                                                            <h5><b>Fator de Avaliação</b></h5>
                                                            {{verificarverificaratorAvaliacaoControle(avaliacoes)}}
                                                        </v-flex>
                                                        <v-flex xs2>
                                                            <h5><b>Risco Residual</b></h5>
                                                            {{residual(avaliacoes)}}
                                                        </v-flex>
                                                    </v-layout>
                                                </v-flex>
                                                <br>
                                            </template>


                                            <v-flex xs12 class="text-xs-left" >
                                                <v-layout row wrap>
                                                    <v-flex xs12 >
                                                        <h5><b>Causa:</b> {{risco.causa}}</h5>
                                                    </v-flex>

                                                    <v-flex xs12 >
                                                        <h5><b>Consequências:</b> {{risco.consequencia}}</h5>
                                                    </v-flex>

                                                    <v-flex xs12 >
                                                        <h5><b>Tratamento:</b> {{ verificarTratamento(planosAll)}}</h5>
                                                    </v-flex>



                                                    <v-flex xs12>

                                                        <h5><b>Processos: </b> <!--{{imprimeProcessos(risco.processos)-->
                                                            <font color="black" v-for="(p, index) in risco.processos" :key="p.nome">
                                                                <font v-if="index != risco.processos.length - 1">
                                                                    {{" " + p.nome + ","}}
                                                                </font>
                                                                <font v-if="index == risco.processos.length - 1">
                                                                    {{" " + p.nome + ""}}
                                                                </font>
                                                            </font>


                                                            <font v-if="risco.processos.length === 0">
                                                                Nenhum Processo Vinculado ao Risco
                                                            </font>
                                                        </h5>

                                                    </v-flex>
                                                </v-layout>
                                            </v-flex>

                                            <br>
                                        </v-flex>
                                    </div>



                                    <div v-if="i == 2" >
                                        <listar-avaliacoes @event-update-av="atualizarAvaliacoes"
                                                           @event-update-av2="testeAv"></listar-avaliacoes>
                                    </div>



                                    <div v-if="i === 3">

                                        <listar-planos-tratamento @event-update-plano="atualizarPlano"></listar-planos-tratamento>

                                    </div>

                                    <div v-if="i === 4">
                                        <listar-ocorrencias></listar-ocorrencias>

                                    </div>

                                    <div v-if="i === 5">
                                        <listar-planos-contingencia></listar-planos-contingencia>

                                    </div>
                                </v-tab-item>


                            </v-tabs>

                        </v-card>

                    </v-app>

                </div>

            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
    import { mapState } from 'vuex'
    import axios from 'axios'
    import  ListarAvaliacoes from './ListarAvaliacoes'
    import  ListarOcorrencias from './ListarOcorrencias'
    import  ListarPlanosContingencia from './ListarPlanosContingencia'
    import  ListarPlanosTratamento from './ListarPlanosTratamento'


    export default {

        components: {
            ListarOcorrencias,
            ListarAvaliacoes,
            ListarPlanosContingencia,
            ListarPlanosTratamento
        },

        data() {
            return {
                i:0,
                detalhes: 1,
                ava:2,
                riscoId: null,
                risco: '',
                x: "AMEACA",
                avaliacoes:[],
                planosAll: '',
                politicaVirgente: '',
                nivel:[],
                lista:[]
            }
        },

        computed:{
            ...mapState({
                processos: state => state.processos.all
            }),

        },
        created: function () {
            this.riscoId = this.$route.params.id;            {
                axios.get('/riscos/' + this.riscoId).then(res => {
                    this.risco = res.data;
                    this.planosAll = this.risco.tratamento;
                })
            }
            this.listarAvaliacoes();
            axios.get('politicas/vigente').then(res => {
                this.politicaVirgente = res.data;
                this.niveis();
            });

        },
        methods:{
            atualizarPlano(plano) {
                this.planosAll = plano;
            },
            atualizarAvaliacoes(avaliacao) {
                this.avaliacoes = avaliacao;
            },

            testeAv(avaliacao){
                this.avaliacoes = avaliacao;
            },

            listarAvaliacoes(){
                axios.get('/avaliacoes/listar/' + this.riscoId).then(res => {
                    this.avaliacoes = res.data;
                }).catch(
                    error => console.log(error)
                )
            },
            verificarTratamento(t) {
                if(t === null) {
                    return "Sem Tratamento";
                }
                else {
                    return t.tratamentoRisco.nome;
                }
            },
            verificarPolitica(p) {
                if(p == null) {
                    return "-"
                }
                else {
                    return p.nome;
                }
            },
            verificarProbailidade(a) {
                if(a.length <= 0) {
                    return "-";
                }
                return  a[a.length-1].probabilidade.nome + ' - ' + a[a.length-1].probabilidade.valor;
            },
            verificarImpacto(a) {
                if(a.length <= 0) {
                    return "-";
                }
                return a[a.length-1].impacto.nome + ' - ' + a[a.length-1].impacto.valor;
            },
            verificarverificaratorAvaliacaoControle(a) {
                if(a.length <= 0) {
                    return "-";
                }

                return a[a.length-1].fatorAvaliacaoControle.nome + " - " + parseInt((a[a.length-1].fatorAvaliacaoControle.valor)*100)/100;

            },
            incrementa(){
              this.i = this.i + 1;
            },
            imprimeProcessos(a) {
                if (a.length >= 1) {
                    for (let i = 0; i < a.length; i++) {
                        if (i !== (a.length - 1)) {
                          this.lista[i] =  a[i].nome;
                        } else {
                            this.lista[i] = a[i].nome;
                        }
                    }
                    return this.lista;
                }
                else{
                    return "Nenhum Processo Vinculado ao Risco."
                }
            },
            niveis(){
                axios
                    .get("/niveisRisco/listar/" + this.politicaVirgente.id)
                    .then(res => {
                        this.nivel = res.data;
                    })
                    .catch(error => console.log(error));
            },
            inerente(a) {
                var recebe;

                if(a.length <= 0) {
                    return "-";
                }
                else{
                    for(let i = 0; i < this.nivel.length; i++){
                        if(this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor
                            && this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor <= this.nivel[i].valorFinal){
                            recebe = this.nivel[i].nome;
                        }
                    }
                    return "Risco " + recebe + " - " + a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor;
                }

            },
            residual(a) {
                if(a.length <= 0) {
                    return "-";
                }
                return parseInt((a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor * a[a.length-1].fatorAvaliacaoControle.valor)*100)/100;

            },
            nRisco(a) {
                var recebe;

                if(a.length <= 0) {
                    return "-";
                }
                else{
                    for(let i = 0; i < this.nivel.length; i++){
                        if(this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor
                            && this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor <= this.nivel[i].valorFinal){
                            recebe = this.nivel[i].nome;
                        }
                    }
                    return "Risco " + recebe ;
                }
            }
        }

    }

</script>
