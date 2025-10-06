<template>
    <div>
        <v-card-widget title="Detalhes do Plano de Tratamento" enableHeader v-if="tratamento">
            <div slot="widget-header-action">
                <v-chip :color="tratamento.status ? 'green' : 'grey'" label text-color="white">{{tratamento.status ? 'ATIVO' : 'ENCERRADO'}}</v-chip>
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn icon color="primary" v-bind="attrs" v-on="on" v-if="tratamento.status">
                            <v-icon>create</v-icon>
                        </v-btn>
                    </template>
                    <span>Editar</span>
                </v-tooltip>
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }" v-if="tratamento.status">
                        <v-btn icon color="error" v-bind="attrs" v-on="on">
                            <v-icon>delete</v-icon>
                        </v-btn>
                    </template>
                    <span>Excluir</span>
                </v-tooltip>
            </div>
            <div slot="widget-content">
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Evento de risco</div>
                        <div class="font-weight-light title">{{ risco.nome }}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="4">
                        <div class="font-weight-bold text-uppercase">Unidade</div>
                        <div class="font-weight-light title">{{ risco.unidade.nome }}</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Data do início:</div>
                        <div class="font-weight-light title">{{$moment(tratamento.inicio).format('DD/MM/YYYY')}}</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Data do término:</div>
                        <div class="font-weight-light title">{{$moment(tratamento.termino).format('DD/MM/YYYY')}}</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Data da avaliação</div>
                        <div class="font-weight-light title">{{$moment(tratamento.avaliacao.data).format('DD/MM/YYYY')}}</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Data do planejamento:</div>
                        <div class="font-weight-light title">{{$moment(tratamento.dataPlanejamento).format('DD/MM/YYYY')}}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Resposta</div>
                        <v-chip color="primary" label text-color="white">{{tratamento.resposta.nome.toUpperCase()}}</v-chip>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Risco Residual</div>
                        <v-chip class="text-uppercase" :color="corResidual" label v-if="riscoResidual">{{riscoResidual.nome}}</v-chip>
                    </v-col>
                    <v-col cols="8" v-if="tratamento.unidadesCompartilhadas && tratamento.unidadesCompartilhadas.length > 0">
                        <div class="font-weight-bold text-uppercase">Unidades que compartilham o evento de risco:</div>
                        <v-chip v-for="unidade in tratamento.unidadesCompartilhadas" :key="unidade.id" class="ma-1" color="secondary lighten-2" label>
                            {{unidade.nome}}
                        </v-chip>
                    </v-col>
                </v-row>
                <v-row v-if="tratamento.justificativa">
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Justificativa para opção de resposta não indicada:</div>
                        <div class="font-weight-light title">{{tratamento.justificativa}}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Descrição:</div>
                        <div class="font-weight-light title" v-html="tratamento.descricao"></div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Monitoramento:</div>
                        <div class="font-weight-light title" v-html="tratamento.monitoramento"></div>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>

        <!-- Ações Preventivas -->
        <v-card-widget title="Ações Preventivas" enableHeader v-if="tratamento" class="mt-4">
            <div slot="widget-header-action">

            </div>
            <div slot="widget-content">
                <v-row>
                    <v-col cols="12">
                        <v-card v-for="(item,i) in tratamento.acoesPreventivas" :key="i" outlined class="mb-4">
                            <v-card-title>
                                <v-row>
                                    <v-col>
                                        <span class="title font-weight-medium">{{item.descricao}}</span>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-chip :color="colorAcao(item.status)" label class="float-right" outlined>
                                            {{textAcao(item.status)}}
                                        </v-chip>
                                    </v-col>
                                </v-row>
                            </v-card-title>
                            <v-card-text>
                                <v-alert outlined type="warning" prominent border="left" v-if="item.status === 'NAO_INICIADA'">
                                    Ainda não há nenhuma atualização do andamento da ação.
                                </v-alert>
                                <v-timeline align-top dense v-if="item.status !== 'NAO_INICIADA'">
                                    <v-timeline-item v-for="(action, i) in item.monitoramentos" :key="i"
                                                     color="green" small>
                                        <v-row class="pt-1">
                                            <v-col cols="2">
                                                <strong>{{$moment(action.data).format('DD/MM/YYYY')}}</strong>
                                            </v-col>
                                            <v-col>
                                                <div class="font-weight-light title" v-html="action.descricao"></div>
                                            </v-col>
                                        </v-row>
                                    </v-timeline-item>
                                </v-timeline>
                            </v-card-text>
                            <v-card-actions v-if="tratamento.status">
                                <v-spacer></v-spacer>
                                <v-tooltip bottom>
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-btn v-show="item.status === 'EM_ANDAMENTO' || item.status === 'NAO_INICIADA'" v-bind="attrs" v-on="on" color="secondary" @click.stop="dialog = true, acaoPreventiva = item.id" icon large>
                                            <v-icon>autorenew</v-icon>
                                        </v-btn>
                                    </template>
                                    <span>Atualizar andamento</span>
                                </v-tooltip>
                                <v-tooltip bottom>
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-btn v-show="item.status === 'EM_ANDAMENTO'" @click.stop="dialogRemove = true, acaoPreventiva = item.id, actionFinalizar = true" v-bind="attrs" v-on="on" color="success" icon large>
                                            <v-icon>check_circle_outline</v-icon>
                                        </v-btn>
                                    </template>
                                    <span>Finalizar</span>
                                </v-tooltip>
                                <v-tooltip bottom>
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-btn v-show="item.status === 'EM_ANDAMENTO'" @click.stop="dialogRemove = true, acaoPreventiva = item.id, actionFinalizar = false" v-bind="attrs" v-on="on" color="error" icon large>
                                            <v-icon>highlight_off</v-icon>
                                        </v-btn>
                                    </template>
                                    <span>Cancelar</span>
                                </v-tooltip>
                            </v-card-actions>
                        </v-card>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>

        <v-dialog v-model="dialog" persistent max-width="70%">
            <v-card>
                <v-card-title>
                    <span class="headline">Atualizar andamento da ação</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="12">
                                    <v-menu v-model="menuData" :close-on-content-click="false" transition="scale-transition"
                                            offset-y max-width="290px" min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="computedDateFormatted" label="* Data"
                                                    v-bind="attrs" v-on="on" readonly
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="monitoramento.data"  no-title
                                               @input="menuData = false" :max="today"
                                        ></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="12">
                                    <span class="subtitle-1">* Descrição</span>
                                    <quill-editor v-model="monitoramento.descricao" :options="editorOption"/>
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
                    <v-btn color="primary" @click="cadastrarMonitoramento()" :disabled="!formValid">Salvar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <confirm-dialog :dialogVisible="dialogRemove" :toogleVisible="function(){dialogRemove = false}" :titulo="actionFinalizar ? 'Finalizar' : 'Cancelar'"
                       :confirmAction="actionFinalizar ? finalizarAcaoPreventiva : cancelarAcaoPreventiva" :info="actionFinalizar"
                       :descricao="actionFinalizar ? 'Tem certeza de que deseja finalizar esta ação preventiva?' : 'Tem certeza de que deseja cancelar esta ação preventiva?'">
        </confirm-dialog>
    </div>
</template>
<script>
    import {mapState, mapGetters} from "vuex";
    import moment from "moment";
    import VCardWidget from "@/components/VWidget";
    import ConfirmDialog from "@/components/ConfirmDialog"
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const riscoRepository = RepositoryFactory.get("risco");
    const tratamentoRepository = RepositoryFactory.get("planoTratamento");
    const nivelRiscoRepository = RepositoryFactory.get("nivel");

    export default {
        props: ["riscoId", "tratamentoId"],
        components: {VCardWidget, ConfirmDialog},
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {position: 2, text: "Eventos de risco", disabled: false,  href: "/riscos"},
                    {position: 4, text: "Plano de tratamento", disabled: true}
                ],
                dialogRemove: false,
                panel: [],
                headers: {
                    acoes: [
                        {text: "Data", value: "data", sortable: false, align: 'center'},
                        {text: "Descrição", value: "descricao", sortable: false},
                        {text: "Status", value: "unidade.nome", sortable: false, align: 'center'}
                    ]
                },
                dialog: false,
                formValid: true,
                today: moment().format('YYYY-MM-DD'),
                monitoramento: {
                    data: moment().format('YYYY-MM-DD'),
                    descricao: ''
                },
                menuData: false,
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
                acaoPreventiva: null,
                actionFinalizar: false
            };
        },
        created() {
            this.$store.commit("app/setBreadcrumb", this.breadcrumbItems);
            riscoRepository.findById(this.riscoId).then((res) => {
                this.$store.dispatch("riscos/setRisco", res.data).then(() => {
                    this.breadcrumbItems.push({position: 3, text: this.risco.nome, disabled: false,  href: "/riscos/" + this.risco.id});
                });
            });
            this.findTratamento();
            nivelRiscoRepository.findByPlano(this.plano.id).then((res) => {
                this.$store.dispatch("planos/setNiveis", res.data);
            });
        },

        methods: {
            findTratamento() {
                tratamentoRepository.findById(this.tratamentoId).then((res) => {
                    this.$store.dispatch("tratamentos/setTratamento", res.data);
                });
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
            },

            textAcao(status) {
                switch (status) {
                    case 'NAO_INICIADA':
                        return 'NÃO INICIADA';
                    case 'EM_ANDAMENTO':
                        return 'EM ANDAMENTO';
                    case 'FINALIZADA':
                        return 'FINALIZADA';
                    default:
                        return 'CANCELADA';
                }
            },

            formatDate(date) {
                if (!date) return null;
                const [year, month, day] = date.split("-");
                return `${day}/${month}/${year}`;
            },

            cadastrarMonitoramento() {
                if (this.$refs.form.validate()) {
                    tratamentoRepository.cadastrarMonitoramento(this.acaoPreventiva, this.monitoramento).then(() => {
                        tratamentoRepository.findAcaoPreventivaById(this.acaoPreventiva).then(res =>{
                            this.$store.dispatch("tratamentos/updateAcaoPreventiva", res.data);
                            this.dialog = false;
                        })
                    })
                }
            },

            finalizarAcaoPreventiva() {
                tratamentoRepository.finalizarAcaoPreventiva(this.acaoPreventiva).then(res => {
                    this.$store.dispatch("tratamentos/updateAcaoPreventiva", res.data);
                    this.dialogRemove = false;
                })
            },

            cancelarAcaoPreventiva() {
                tratamentoRepository.cancelarAcaoPreventiva(this.acaoPreventiva).then(res => {
                    this.$store.dispatch("tratamentos/updateAcaoPreventiva", res.data);
                    this.dialogRemove = false;
                })
            },

            /*excluir() {
                riscoRepository.excluir(this.risco.id).then((res) => {
                    this.$router.push({name: "ListaRiscos"}, res.data);
                });
            },*/
        },

        computed: {
            ...mapState({
                plano: (state) => state.app.plano,
                risco: (state) => state.riscos.risco,
                tratamento: (state) => state.tratamentos.tratamento,
            }),

            ...mapGetters({
                riscoResidual: 'tratamentos/riscoResidual',
                corResidual: 'tratamentos/corNivelResidual',
            }),

            computedDateFormatted () {
                return this.formatDate(this.monitoramento.data)
            },
        },

        watch: {
            dialog: function (val) {
                if (!val) {
                    this.monitoramento.data = moment().format('YYYY-MM-DD');
                    this.monitoramento.descricao = '';
                }
            },

        }
    };
</script>
<style lang="stylus" scoped></style>
