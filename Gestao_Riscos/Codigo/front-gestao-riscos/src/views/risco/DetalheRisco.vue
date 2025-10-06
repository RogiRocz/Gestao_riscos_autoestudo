<template>
    <div>
        <v-card-widget title="Detalhes do Evento de Risco" enableHeader v-if="risco">
            <div slot="widget-header-action">
                <v-tooltip bottom v-if="avaliacoes.length == 0">
                    <template v-slot:activator="{ on, attrs }">
                        <v-icon color="warning" dark v-bind="attrs" v-on="on">error</v-icon>
                    </template>
                    <span>Este evento de risco ainda não foi avaliado!</span>
                </v-tooltip>
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn icon color="primary" v-bind="attrs" v-on="on" :to="{ name: 'CadastroRisco', query: { risco: risco.id } }">
                            <v-icon>create</v-icon>
                        </v-btn>
                    </template>
                    <span>Editar</span>
                </v-tooltip>
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn icon color="error" v-bind="attrs" v-on="on" @click.stop="dialogRemove = true">
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
                        <div class="font-weight-bold text-uppercase">Gestor</div>
                        <div class="font-weight-light title">
                            {{ risco.responsavel.nome }}
                        </div>
                    </v-col>
                    <v-col cols="4">
                        <div class="font-weight-bold text-uppercase">Unidade</div>
                        <div class="font-weight-light title">{{ risco.unidade.nome }}</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Risco Residual</div>
                        <v-chip class="text-uppercase" :color="corResidual" label v-if="riscoResidual">{{riscoResidual.nome}}</v-chip>
                        <div v-if="!riscoResidual" class="font-weight-light title">-</div>
                    </v-col>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Próxima avaliação</div>
                        <div class="font-weight-light title">{{ proximaAvaliacao }}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <v-tabs icons-and-text fixed-tabs>
                            <v-tabs-slider></v-tabs-slider>
                            <v-tab>Dados Gerais<v-icon>info</v-icon></v-tab>
                            <v-tab>Avaliações<v-icon>done_all</v-icon></v-tab>
                            <v-tab>Plano de Tratamento<v-icon>verified_user</v-icon></v-tab>
                            <v-tab>Plano de Contingência<v-icon>alarm_on</v-icon></v-tab>
                            <v-tab>Ocorrências<v-icon>timeline</v-icon></v-tab>

                            <v-tab-item>
                                <risco-detalhes></risco-detalhes>
                            </v-tab-item>
                            <v-tab-item>
                                <risco-avaliacoes></risco-avaliacoes>
                            </v-tab-item>
                            <v-tab-item>
                                <risco-plano-tratamento></risco-plano-tratamento>
                            </v-tab-item>
                            <v-tab-item>
                                <risco-plano-contingencia></risco-plano-contingencia>
                            </v-tab-item>
                            <v-tab-item>
                                <risco-ocorrencia></risco-ocorrencia>
                            </v-tab-item>
                        </v-tabs>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>

        <confirm-dialog :dialogVisible="dialogRemove" :toogleVisible="function(){dialogRemove = false}" :confirmAction="excluir"
                       :descricao="'Tem certeza de que deseja excluir esse evento de risco?'">
        </confirm-dialog>
    </div>
</template>
<script>
    import {mapState, mapGetters} from "vuex";
    import VCardWidget from "@/components/VWidget";
    import RiscoDetalhes from "@/views/risco/components/RiscoDetalhes";
    import RiscoAvaliacoes from "@/views/risco/components/RiscoAvaliacoes";
    import RiscoPlanoTratamento from "@/views/risco/components/RiscoPlanoTratamento";
    import RiscoPlanoContingencia from "@/views/risco/components/RiscoPlanoContingencia";
    import RiscoOcorrencia from "@/views/risco/components/RiscoOcorrencia";
    import ConfirmDialog from "@/components/ConfirmDialog"
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const riscoRepository = RepositoryFactory.get("risco");
    const avaliacaoRepository = RepositoryFactory.get("avaliacao");
    const nivelRiscoRepository = RepositoryFactory.get("nivel");
    const probabilidadeRepository = RepositoryFactory.get("probabilidade");
    const impactoRepository = RepositoryFactory.get("impacto");
    const avaliacaoControleRepository = RepositoryFactory.get("avaliacaoControle");
    const usuarioRepository = RepositoryFactory.get("usuario");
    const planoContingenciaRepository = RepositoryFactory.get("planoContingencia");
    const ocorrenciaRepository = RepositoryFactory.get("ocorrencia");
    const planoTratamentoRepository = RepositoryFactory.get("planoTratamento");
    const respostaRiscoRepository = RepositoryFactory.get("resposta");

    export default {
        props: ["riscoId"],
        components: {VCardWidget, RiscoDetalhes, RiscoAvaliacoes, RiscoPlanoTratamento, RiscoPlanoContingencia, RiscoOcorrencia,
            ConfirmDialog},
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {
                        position: 2,
                        text: "Eventos de risco",
                        disabled: false,
                        href: "/riscos",
                    },
                    {position: 3, text: "Detalhes", disabled: true},
                ],
                dialogRemove: false,
            };
        },
        created() {
            this.$store.commit("app/setBreadcrumb", this.breadcrumbItems);
            riscoRepository.findById(this.riscoId).then((res) => {
                this.$store.dispatch("riscos/setRisco", res.data).then(() => {
                    this.loadData();
                });
            });
        },

        methods: {
            excluir() {
                riscoRepository.excluir(this.risco.id).then((res) => {
                    this.$router.push({name: "ListaRiscos"}, res.data);
                });
            },

            loadData() {
                avaliacaoRepository.findByRisco(this.risco.id).then((res) => {
                    this.$store.dispatch("avaliacoes/setAvaliacoes", res.data);
                });

                nivelRiscoRepository.findByPlano(this.plano.id).then((res) => {
                    this.$store.dispatch("planos/setNiveis", res.data);
                });

                impactoRepository.findByPlano(this.plano.id).then((res) => {
                    this.$store.dispatch("planos/setImpactos", res.data);
                });

                probabilidadeRepository.findByPlano(this.plano.id).then((res) => {
                    this.$store.dispatch("planos/setProbabilidades", res.data);
                });

                avaliacaoControleRepository.findByPlano(this.plano.id).then((res) => {
                    this.$store.dispatch("planos/setControles", res.data);
                });
                planoTratamentoRepository.findByRisco(this.risco.id).then((res) => {
                    this.$store.dispatch("tratamentos/setTratamentos", res.data);
                });
                planoContingenciaRepository.findByRisco(this.risco.id).then((res) => {
                    this.$store.dispatch("riscos/setContingencias", res.data);
                });
                ocorrenciaRepository.findByRisco(this.risco.id).then((res) => {
                    this.$store.dispatch("riscos/setOcorrencias", res.data);
                });
                usuarioRepository.findByUnidade(this.unidade.id).then(res => {
                    this.$store.dispatch("app/setServidores", res.data);
                });
                respostaRiscoRepository.findByPlano(this.plano.id).then((res) => {
                    this.$store.dispatch("planos/setRespostas", res.data);
                });
            },
        },

        computed: {
            ...mapState({
                plano: (state) => state.app.plano,
                risco: (state) => state.riscos.risco,
                unidade: state => state.app.unidade,
                avaliacoes: (state) => state.avaliacoes.avaliacoes
            }),

            ...mapGetters({
                avaliacao : 'avaliacoes/lastAvaliacao',
                riscoResidual: 'avaliacoes/riscoResidual',
                corResidual: 'avaliacoes/corNivelResidual',
                proximaAvaliacao: 'avaliacoes/proximaAvaliacao'
            })
        },
    };
</script>
<style lang="stylus" scoped></style>
