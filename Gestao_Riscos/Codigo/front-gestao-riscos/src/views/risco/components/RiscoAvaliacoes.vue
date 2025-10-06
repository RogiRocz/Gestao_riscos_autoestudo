<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn class="ma-2" outlined color="primary" @click.stop="dialog = true">Nova avaliação</v-btn>
                </v-row>
                <v-row v-if="avaliacoes.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            Este evento de risco ainda não foi avaliado.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-data-table v-if="avaliacoes.length > 0" :headers="headers" :items="avaliacoes" disable-pagination>
                    <template v-slot:[`item.data`]="{item}">
                        {{item.data | date}}
                    </template>
                    <template v-slot:[`item.periodicidade`]="{item}">
                        {{item.periodicidade}}
                    </template>
                    <template v-slot:[`item.impacto`]="{item}">
                        {{item.impacto.nome}}
                    </template>
                    <template v-slot:[`item.probabilidade`]="{item}">
                        {{item.probabilidade.nome}}
                    </template>
                    <template v-slot:[`item.inerente`]="{item}">
                        <v-chip class="text-uppercase" :color="getCorNivel(getRiscoInerente(item.probabilidade, item.impacto, item.avaliacaoControle).nome)" label>
                            {{getRiscoInerente(item.probabilidade, item.impacto).nome}}
                        </v-chip>
                    </template>
                    <template v-slot:[`item.controles`]="{item}">
                        {{item.avaliacaoControle.nome}}
                    </template>
                    <template v-slot:[`item.residual`]="{item}">
                        <v-chip class="text-uppercase" :color="getCorNivel(getRiscoResidual(item.probabilidade, item.impacto, item.avaliacaoControle).nome)" label>
                            {{getRiscoResidual(item.probabilidade, item.impacto, item.avaliacaoControle).nome}}
                        </v-chip>
                    </template>
                    <template v-slot:[`item.responsavel`]="{item}">
                        {{item.responsavel.nome}}
                    </template>
                </v-data-table>
            </v-card-text>
        </v-card>

        <v-dialog v-model="dialog" persistent max-width="70%">
            <v-card>
                <v-card-title>
                    <span class="headline">Nova avaliação</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="6">
                                    <v-select label="* Probabilidade" v-model="avaliacao.probabilidade" item-text="nome"
                                              return-object :items="probabilidades" :rules="rules.required"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select label="* Impacto" v-model="avaliacao.impacto" item-text="nome"
                                              return-object :items="impactos" :rules="rules.required"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="4">
                                    <v-select label="* Avaliação dos controles" v-model="avaliacao.avaliacaoControle" item-text="nome"
                                              return-object :items="controles" :rules="rules.required"></v-select>
                                </v-col>
                                <v-col cols="3">
                                    <v-menu ref="menu" v-model="menu" :close-on-content-click="false"
                                            transition="scale-transition" offset-y min-width="290px">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="dataAvaliacao" label="* Data da avaliação"
                                                    readonly v-bind="attrs" v-on="on" :rules="rules.required">
                                            </v-text-field>
                                        </template>
                                        <v-date-picker v-model="avaliacao.data" no-title scrollable :max="today" locale="pt-br">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu = false">Cancelar</v-btn>
                                            <v-btn text color="primary" @click="$refs.menu.save(avaliacao.data)">OK</v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="5">
                                    <v-select label="* Periodicidade de reavaliação" v-model="avaliacao.periodicidade" item-text="descricao"
                                          item-value="id" :items="periodicidades" :rules="rules.required" persistent-hint
                                          :hint="periodicidadeSugerida"></v-select>
                                </v-col>
                            </v-row>
                            <v-row v-if="requiresJustificativa">
                                <v-col cols="12">
                                    <v-textarea v-model="avaliacao.justificativa" :rules="[(!!avaliacao.justificativa || !requiresJustificativa) || 'Campo obrigatório']"
                                                label="* Justificativa para escolha de periodicidade não sugerida"></v-textarea>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <div class="font-weight-bold text-uppercase">Risco inerente</div>
                                    <v-chip class="text-uppercase" :color="getCorNivel(riscoInerente)" label>{{riscoInerente}}</v-chip>
                                </v-col>
                                <v-col cols="6">
                                    <div class="font-weight-bold text-uppercase">Risco residual</div>
                                    <v-chip class="text-uppercase" :color="getCorNivel(riscoResidual)" label>{{riscoResidual}}</v-chip>
                                </v-col>
                            </v-row>
                        </v-form>
                    </v-container>
                    <small>* Campo obrigatório</small>
                </v-card-text>
                <v-divider></v-divider>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn text @click="dialog = false">Cancelar</v-btn>
                    <v-btn color="primary" @click="cadastrar" :disabled="!formValid">Cadastrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    import { mapState, mapGetters } from 'vuex';
    import moment from "moment";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const avaliacaoRepository = RepositoryFactory.get("avaliacao");

    export default {
        name: 'risco-avaliacoes',
        data() {
            return {
                headers: [
                    {text: "Data", value: "data", sortable: false},
                    {text: "Periodicidade", value: "periodicidade", sortable: false},
                    {text: "Impacto", value: "impacto", sortable: false},
                    {text: "Probabilidade", value: "probabilidade", sortable: false},
                    {text: "Risco Inerente", value: "inerente", align: 'center', sortable: false},
                    {text: "Controles", value: "controles", align: 'center', sortable: false},
                    {text: "Risco Residual", value: "residual", align: 'center', sortable: false},
                    {text: "Responsável", value: "responsavel", sortable: false}
                ],
                dialog: false,
                formValid: true,
                avaliacao: {
                    impacto: null,
                    probabilidade: null,
                    periodicidade: null,
                    avaliacaoControle: null,
                    data: new Date().toISOString().substr(0, 10),
                    risco: {
                        id: null
                    }
                },
                rules: {
                    required: [
                        v => !!v || 'Campo obrigatório',
                    ]
                },
                periodicidades: [
                    {id:"DIARIA", descricao: "DIÁRIA"},
                    {id:"SEMANAL", descricao: "SEMANAL"},
                    {id:"QUINZENAL", descricao: "QUINZENAL"},
                    {id:"MENSAL", descricao: "MENSAL"},
                    {id:"BIMESTRAL", descricao: "BIMESTRAL"},
                    {id:"TRIMESTRAL", descricao: "TRIMESTRAL"},
                    {id:"SEMESTRAL", descricao: "SEMESTRAL"},
                    {id:"ANUAL", descricao: "ANUAL"}
                ],
                menu: false,
                today: moment().format('YYYY-MM-DD'),
                dataAvaliacao: moment().format('DD/MM/YYYY')
            };
        },
        created() {
            this.avaliacao.risco.id = this.risco.id;
        },

        methods: {
            cadastrar () {
                if (this.$refs.form.validate()) {
                    avaliacaoRepository.cadastrar(this.avaliacao).then(res => {
                        this.$store.dispatch('avaliacoes/addAvaliacao', res.data)
                        this.dialog = false;
                    })
                }
            },

            getRiscoInerente(probabilidade, impacto) {
                let nivelInerente = null
                if (probabilidade && impacto) {
                    let valor = probabilidade.peso * impacto.peso;
                    this.niveis.forEach(nivel => {
                        if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                            nivelInerente = nivel;
                        }
                    })
                }
                return nivelInerente;
            },

            getRiscoResidual(probabilidade, impacto, controle) {
                let nivelResidual = null
                if (probabilidade && impacto && controle) {
                    let valor = probabilidade.peso * impacto.peso * controle.fator;
                    this.niveis.forEach(nivel => {
                        if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                            nivelResidual = nivel;
                        }
                    })
                }
                return nivelResidual;
            },

            getCorNivel(nome) {
                let cor = '';
                this.niveis.forEach(nivel => {
                    if (nome === nivel.nome) {
                        cor = nivel.cor;
                    }
                })
                return cor;
            },

            closeDialog() {
                this.avaliacao.impacto = null;
                this.avaliacao.probabilidade = null;
                this.avaliacao.avaliacaoControle = null;
                this.avaliacao.data = '';
                this.dataAvaliacao = new Date().toISOString().substr(0, 10);
                this.$refs.form.reset();
            }

        },

        computed: {
            ...mapState({
                plano: state => state.app.plano,
                risco: state => state.riscos.risco,
                niveis: state => state.planos.niveis,
                impactos: state => state.planos.impactos,
                probabilidades: state => state.planos.probabilidades,
                controles: state => state.planos.controles,
            }),

            ...mapGetters({
                avaliacoes : 'avaliacoes/avaliacoes'
            }),

            riscoInerente () {
                let nivel = this.getRiscoInerente(this.avaliacao.probabilidade, this.avaliacao.impacto);
                return nivel ? nivel.nome : '-'
            },

            riscoResidual () {
                let nivel = this.getRiscoResidual(this.avaliacao.probabilidade, this.avaliacao.impacto, this.avaliacao.avaliacaoControle);
                return nivel ? nivel.nome : '-'
            },

            periodicidadeSugerida () {
                if (this.avaliacao.impacto && this.avaliacao.probabilidade && this.avaliacao.avaliacaoControle) {
                    let nivel = this.getRiscoResidual(this.avaliacao.probabilidade, this.avaliacao.impacto, this.avaliacao.avaliacaoControle);
                    return "Sugerida: " + nivel.periodicidade;
                }
                return "";
            },

            requiresJustificativa () {
                if (this.avaliacao.impacto && this.avaliacao.probabilidade && this.avaliacao.avaliacaoControle && this.avaliacao.periodicidade) {
                    let nivel = this.getRiscoResidual(this.avaliacao.probabilidade, this.avaliacao.impacto, this.avaliacao.avaliacaoControle);
                    if (nivel.periodicidade !== this.avaliacao.periodicidade) {
                        return true;
                    }
                }
                return false;
            }
        },

        watch: {
            'avaliacao.data' () {
                this.dataAvaliacao = this.avaliacao.data ? moment(this.avaliacao.data).format('DD/MM/YYYY') : '';
            },

            dialog: function (val) {
                if (!val) {
                    this.closeDialog();
                }
            },

        }
    };
</script>

<style scoped>

</style>

