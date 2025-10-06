<template>
    <div>
        <v-row>
            <v-col cols="8">
                <v-card-widget :title="'Matriz de Risco'" enableHeader>
                    <div slot="widget-content">
                        <v-row class="text-center">
                            <v-col cols="12">
                                IMPACTOS
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="1" align-self="center">
                                <span class="vertical-rotate">PROBABILIDADES</span>
                            </v-col>
                            <v-col cols="11">
                                <v-row no-gutters>
                                    <v-col>
                                        <v-card flat>
                                        </v-card>
                                    </v-col>
                                    <v-col v-for="impacto in impactos" :key="impacto.nome">
                                        <v-card flat tile class="pa-2 text-center overline">
                                            {{impacto.nome}}
                                        </v-card>
                                    </v-col>
                                </v-row>
                                <v-row v-for="probabilidade in probabilidades" :key="probabilidade.nome" no-gutters>
                                    <v-col>
                                        <v-card class="pt-4 pb-4 text-center overline" flat>
                                            {{probabilidade.nome}}
                                        </v-card>
                                    </v-col>
                                    <v-col v-for="impacto in impactos" :key="impacto.nome">
                                        <v-card flat tile class="pt-6 pb-6 text-center overline" :color="getCor(impacto, probabilidade)">
                                            <v-row class="justify-center">
                                                <span class="font-weight-bold display-1">
                                                    {{countMatriz(impacto, probabilidade)}}
                                                </span>
                                            </v-row>
                                        </v-card>
                                    </v-col>
                                </v-row>
                            </v-col>
                        </v-row>
                    </div>
                </v-card-widget>
            </v-col>
            <v-col cols="4">
                <v-card-widget title="Níveis de Risco" enableHeader>
                    <div slot="widget-content">
                        <v-row>
                            <v-col cols="6" v-for="nivel in niveis" :key="nivel.nome">
                                <v-card :color="nivel.cor" dark>
                                    <v-card-text>
                                        <v-row class="justify-center">
                                            <span class="text-center subtitle-1 text-uppercase">{{nivel.nome}}</span>
                                        </v-row>
                                        <v-row class="justify-center">
                                            <h1 class="font-weight-bold display-3">
                                                {{countNivel(nivel)}}
                                            </h1>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </div>
                </v-card-widget>
            </v-col>
        </v-row>

    </div>
</template>

<script>
    import { mapState } from 'vuex';
    import VCardWidget from "@/components/VWidget";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    const impactoRepository = RepositoryFactory.get("impacto");
    const probabilidadeRepository = RepositoryFactory.get("probabilidade");
    const nivelRiscoRepository = RepositoryFactory.get("nivel");
    const riscoRepository = RepositoryFactory.get("risco");
    const avaliacaoRepository = RepositoryFactory.get("avaliacao");

    export default {
        name: 'home',

        components: {
            VCardWidget
        },

        data: () => ({
            breadcrumbItems: [
                {position: 1, text: "Início", disabled: false, href: "/"},
                {position: 1, text: "Painel de Bordo", disabled: true}
            ],
            impactos: [],
            probabilidades: [],
            niveis: [],
            riscos: [],
            avaliacoes: []
        }),

        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            impactoRepository.findByPlano(this.plano.id).then(res => {
                this.impactos = res.data;
            });
            probabilidadeRepository.findByPlano(this.plano.id).then(res => {
                this.probabilidades = res.data;
            });
            nivelRiscoRepository.findByPlano(this.plano.id).then(res => {
                this.niveis = res.data;
            });
            riscoRepository.findByUnidade(this.plano.id).then(res => {
                this.riscos = res.data;
                this.riscos.filter(risco => {
                    avaliacaoRepository.findLastByRisco(risco.id).then(res => {
                        if (res.data) {
                            this.avaliacoes.push(res.data)
                        }
                    })
                })
            })
        },

        methods: {
            getNivel(impacto, probabilidade) {
                let valor = impacto.peso * probabilidade.peso;
                let nivelInerente = '-';
                this.niveis.forEach(nivel => {
                    if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                        nivelInerente = nivel.nome;
                    }
                })
                return nivelInerente;
            },

            getCor(impacto, probabilidade) {
                let valor = impacto.peso * probabilidade.peso;
                let cor = '';
                this.niveis.forEach(nivel => {
                    if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                        cor = nivel.cor;
                    }
                })
                return cor;
            },

            countNivel(nivel) {
                let count = 0;
                this.avaliacoes.forEach(avaliacao => {
                    let valor = avaliacao.probabilidade.peso * avaliacao.impacto.peso;
                    if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                        count++;
                    }
                })
                return count;
            },

            countMatriz(impacto, probabilidade) {
                let count = 0;
                this.avaliacoes.forEach(avaliacao => {
                    if (avaliacao.impacto.id == impacto.id && avaliacao.probabilidade.id == probabilidade.id) {
                        count++;
                    }
                })
                return count;
            },
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano
            })
        },
    }
</script>

<style scoped>

    .vertical-rotate {
        display: inline-block;
        transform: rotate(270deg);
    }

</style>
