<template>
    <div>
        <v-card flat>
            <v-card-text>
               <v-row>
                    <v-spacer></v-spacer>
                    <v-btn v-if="avaliacoes.length > 0" class="ma-2" outlined color="primary" @click.stop="dialog = true">Novo plano de tratamento</v-btn>
                </v-row>
                <v-row v-if="avaliacoes.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            O plano de tratamento só poderá ser feito após a avaliação do evento de risco.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-row v-if="tratamentos.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            Nenhum plano de tratamento cadastrado.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-data-table v-if="tratamentos.length > 0" :headers="headers.tratamento" :items="tratamentos" item-key="id">
                    <template v-slot:item.resposta="{item}">
                        <v-badge bordered :color="item.status ? 'green' : 'grey'" overlap>
                            <v-chip color="primary" label text-color="white">{{item.resposta.nome.toUpperCase()}}</v-chip>
                        </v-badge>
                    </template>
                    <template v-slot:item.periodo="{item}">
                        {{$moment(item.inicio).format('DD/MM/YYYY')}} a {{$moment(item.termino).format('DD/MM/YYYY')}}
                    </template>
                    <template v-slot:item.acoes="{item}">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip :color="colorAcao('NAO_INICIADA')" v-on="on" class="mr-2 font-weight-bold">{{countAcoes(item, 'NAO_INICIADA')}}</v-chip>
                            </template>
                            <span>Não iniciadas</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip :color="colorAcao('EM_ANDAMENTO')" v-on="on" class="mr-2 font-weight-bold">{{countAcoes(item, 'EM_ANDAMENTO')}}</v-chip>
                            </template>
                            <span>Em andamento</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip :color="colorAcao('FINALIZADA')" v-on="on" class="mr-2 font-weight-bold">{{countAcoes(item, 'FINALIZADA')}}</v-chip>
                            </template>
                            <span>Finalizadas</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip :color="colorAcao('CANCELADA')" v-on="on" class="mr-2 font-weight-bold">{{countAcoes(item, 'CANCELADA')}}</v-chip>
                            </template>
                            <span>Finalizadas com ressalvas</span>
                        </v-tooltip>
                    </template>
                    <template v-slot:item.opcoes="{item}">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn class="mr-1" icon color="secondary" v-bind="attrs" v-on="on" :href="'/riscos/' + risco.id + '/tratamentos/' + item.id">
                                    <v-icon>info_outline</v-icon>
                                </v-btn>
                            </template>
                            <span>Visualizar</span>
                        </v-tooltip>
                    </template>
                </v-data-table>
            </v-card-text>
        </v-card>

        <v-dialog v-model="dialog" persistent max-width="80%">
            <v-card>
                <v-card-title>
                    <span class="headline">Novo plano de tratamento</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="4">
                                    <div class="font-weight-bold text-uppercase">Risco Residual</div>
                                    <v-chip v-if="riscoResidual" class="text-uppercase" :color="corResidual" label>{{riscoResidual.nome}}</v-chip>
                                </v-col>
                                <v-col cols="4" v-if="riscoResidual">
                                    <div class="font-weight-bold text-uppercase">Resposta(s) sugerida(s)</div>
                                    <v-chip v-for="resposta in riscoResidual.respostasRisco" :key="resposta.id" class="ma-1" color="secondary lighten-2" label>
                                        {{resposta.nome}}
                                    </v-chip>
                                </v-col>
                                <v-col cols="4">
                                    <v-select label="* Resposta ao risco" v-model="tratamento.resposta" item-text="nome"
                                              return-object :items="respostas" :rules="rules.required"></v-select>
                                </v-col>
                            </v-row>
                            <v-row v-if="tratamento.resposta && tratamento.resposta.planoTratamento">
                                <v-col cols="3">
                                    <v-menu v-model="menuInicio" :nudge-right="40" transition="scale-transition"
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="computedInicio" label="* Início"
                                                    prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on" :rules="rules.required"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="tratamento.inicio" @input="menuInicio = false" locale="pt-br"></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="3">
                                    <v-menu v-model="menuTermino" :close-on-content-click="false" :nudge-right="40" transition="scale-transition"
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="computedTermino" label="* Término" :rules="rules.required"
                                                      prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="tratamento.termino" @input="menuTermino = false"></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="6">
                                    <v-autocomplete v-model="tratamento.responsavel.id" :items="servidores" :rules="rules.required"
                                            label="* Responsável" item-text="nome" item-value="id"
                                    ></v-autocomplete>
                                </v-col>
                            </v-row>
                            <v-row v-if="requiresJustificativa">
                                <v-col cols="12">
                                    <v-textarea v-model="tratamento.justificativa" :rules="[(!!tratamento.justificativa || !requiresJustificativa) || 'Campo obrigatório']"
                                                label="* Justificativa para escolha de outra resposta ao risco"></v-textarea>
                                </v-col>
                            </v-row>
                            <v-row v-if="tratamento.resposta && tratamento.resposta.compartilhavel">
                                <v-col cols="12">
                                    <v-autocomplete v-model="tratamento.unidadesCompartilhadas" :items="unidades" chips deletable-chips
                                            label="* Com quais unidades deseja compartilhar o evento de risco" return-object
                                            item-text="nome" multiple item-color="primary" :rules="[tratamento.unidadesCompartilhadas.length > 0 || 'Campo obrigatório']"
                                    ></v-autocomplete>
                                </v-col>
                            </v-row>
                            <v-row v-if="tratamento.resposta && tratamento.resposta.planoTratamento">
                                <v-col cols="12">
                                    <span class="subtitle-1">Descrição:</span>
                                    <quill-editor v-model="tratamento.descricao" :options="editorOption"/>
                                </v-col>
                                <v-col cols="12">
                                    <span class="subtitle-1">Monitoramento:</span>
                                    <quill-editor v-model="tratamento.monitoramento" :options="editorOption"/>
                                </v-col>
                                <v-col cols="12">
                                    <span class="subtitle-1">Ações preventivas:</span>
                                    <v-row>
                                        <v-col cols="12">
                                            <v-text-field v-model="acaoPreventiva" label="* Descrição da ação"></v-text-field>
                                            <v-spacer></v-spacer>
                                            <v-btn color="primary" @click="addAcaoPreventiva" :disabled="!acaoPreventiva">Adicionar</v-btn>
                                        </v-col>
                                    </v-row>
                                    <v-row>
                                        <v-col cols="12">
                                            <v-data-table :headers="headers.acoes"
                                                      :items="tratamento.acoesPreventivas" hide-default-header hide-default-footer>
                                                <template v-slot:item.opcoes="{item}">
                                                    <v-tooltip bottom>
                                                        <template v-slot:activator="{on, attrs }">
                                                            <v-btn @click.stop="removeAcaoPreventiva(item)"
                                                                   icon color="error" v-bind="attrs" v-on="on"><v-icon>delete</v-icon></v-btn>
                                                        </template>
                                                        <span>Excluir</span>
                                                    </v-tooltip>
                                                </template>
                                            </v-data-table>
                                        </v-col>
                                    </v-row>
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

    const planoTratamentoRepository = RepositoryFactory.get("planoTratamento");
    const unidadeRepository = RepositoryFactory.get("unidade");

    export default {
        name: 'risco-plano-tratamento',
        data() {
            return {
                headers: {
                    tratamento: [
                        {text: "Resposta", value: "resposta", sortable: false},
                        {text: "Período de implementação", value: "periodo", sortable: false, align: 'center'},
                        {text: "Unidade responsável", value: "unidade.nome", sortable: false, align: 'center'},
                        {text: "Ações preventivas", value: "acoes", sortable: false, align: 'center'},
                        {text: "", value: "opcoes", sortable: false, align: 'right'}
                    ],
                    acoes: [
                        {text: "Descrição", value: "descricao", sortable: false},
                        {text: "", value: "opcoes", sortable: false, align: 'right'}
                    ]
                },
                dialog: false,
                formValid: true,
                tratamento: {
                    resposta: null,
                    descricao: null,
                    responsavel: {
                        id: null
                    },
                    acoesPreventivas: [],
                    unidadesCompartilhadas: [],
                    monitoramento: null,
                    inicio: null,
                    termino: null,
                    justificativa: null,
                    risco: {
                        id: null
                    },
                    avaliacao: null
                },
                acaoPreventiva: null,
                unidades: [],
                rules: {
                    required: [
                        v => !!v || 'Campo obrigatório',
                    ],
                },
                editorOption: {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                            [{ 'indent': '-1'}, { 'indent': '+1' }],
                        ]
                    },
                },
                menuInicio: false,
                menuTermino: false,
            };
        },
        created() {
            unidadeRepository.findAll().then(res => {
                this.unidades = res.data.filter(u => u.id !== this.unidade.id);
            });
        },

        methods: {
            cadastrar () {
                if (this.$refs.form.validate()) {
                    this.tratamento.avaliacao = this.avaliacao;
                    planoTratamentoRepository.cadastrar(this.risco.id, this.tratamento).then(res => {
                        this.$store.dispatch('tratamentos/addTratamento', res.data);
                        this.dialog = false;
                    })
                }
            },

            addAcaoPreventiva () {
                this.tratamento.acoesPreventivas.push({descricao: this.acaoPreventiva});
                this.acaoPreventiva = null;
            },

            removeAcaoPreventiva (item) {
                this.tratamento.acoesPreventivas.splice(this.tratamento.acoesPreventivas.findIndex(i => i.descricao == item), 1)
            },

            closeDialog() {
                this.$refs.form.reset();
                this.tratamento.descricao = null;
                this.tratamento.acoesPreventivas = [];
                this.tratamento.monitoramento = null;
            },

            countAcoes(item, status) {
                let count = 0;
                item.acoesPreventivas.forEach(acao => {
                    if (acao.status === status) {
                        count++;
                    }
                });
                return count;
            },
            colorAcao(status) {
                switch (status) {
                    case 'NAO_INICIADA':
                        return 'amber lighten-1';
                    case 'EM_ANDAMENTO':
                        return 'blue lighten-1';
                    case 'FINALIZADA':
                        return 'green lighten-1';
                    default:
                        return 'red lighten-1';
                }
            }


        },

        computed: {
            ...mapState({
                plano: state => state.app.plano,
                unidade: state => state.app.unidade,
                risco: (state) => state.riscos.risco,
                respostasPlano: (state) => state.planos.respostas,
                servidores: (state) => state.app.servidores
            }),

            ...mapGetters({
                avaliacoes : 'avaliacoes/avaliacoes',
                tratamentos : 'tratamentos/tratamentos',
                riscoResidual: 'avaliacoes/riscoResidual',
                corResidual: 'avaliacoes/corNivelResidual',
                avaliacao : 'avaliacoes/lastAvaliacao',
            }),

            requiresJustificativa () {
                if (this.tratamento.resposta) {
                    let result = true;
                    this.riscoResidual.respostasRisco.forEach(r => {
                        if (r.id === this.tratamento.resposta.id) {
                            result = false;
                        }
                    })
                    return result;
                }
                return false;
            },

            respostas () {
                if (this.risco.tipo === 'AMEACA') {
                    return this.respostasPlano.filter(r => r.ameaca)
                } else {
                    return this.respostasPlano.filter(r => r.oportunidade)
                }
            },

            computedInicio () {
                return this.tratamento.inicio ? moment(this.tratamento.inicio).format('DD/MM/YYYY') : null
            },

            computedTermino () {
                return this.tratamento.termino ? moment(this.tratamento.termino).format('DD/MM/YYYY') : null
            },
        },

        watch: {
            dialog: function (val) {
                if (!val) {
                    this.closeDialog();
                }
            }
        }
    };
</script>

<style scoped>

</style>

