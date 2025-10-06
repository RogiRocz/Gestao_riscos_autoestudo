<template>
    <div>
        <v-card-widget :title="plano.nome" enableHeader>
            <div slot="widget-content">
                <v-row>
                    <v-col cols="12">
                        <v-tabs icons-and-text show-arrows>
                            <v-tabs-slider></v-tabs-slider>
                            <v-tab>Áreas de Atuação<v-icon>ballot</v-icon></v-tab>
                            <v-tab>Categorias de Risco<v-icon>view_list</v-icon></v-tab>
                            <v-tab>Impactos<v-icon>flash_on</v-icon></v-tab>
                            <v-tab>Probabilidades<v-icon>trending_up</v-icon></v-tab>
                            <v-tab>Níveis de Risco<v-icon>error</v-icon></v-tab>
                            <v-tab>Avaliação dos Controles<v-icon>playlist_add_check</v-icon></v-tab>
                            <v-tab>Respostas aos Riscos<v-icon>done</v-icon></v-tab>

                            <v-tab-item>
                                <areas-atuacao></areas-atuacao>
                            </v-tab-item>
                            <v-tab-item>
                                <categoria-risco></categoria-risco>
                            </v-tab-item>
                            <v-tab-item>
                                <impacto></impacto>
                            </v-tab-item>
                            <v-tab-item>
                                <probabilidade></probabilidade>
                            </v-tab-item>
                            <v-tab-item>
                                <nivel-risco></nivel-risco>
                            </v-tab-item>
                            <v-tab-item>
                                <avaliacao-controle></avaliacao-controle>
                            </v-tab-item>
                            <v-tab-item>
                                <resposta-risco></resposta-risco>
                            </v-tab-item>
                        </v-tabs>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>
    </div>
</template>

<script>
    import { mapState } from 'vuex';
    import AreasAtuacao from "@/views/plano/components/AreasAtuacao";
    import Impacto from "@/views/plano/components/Impacto";
    import Probabilidade from "@/views/plano/components/Probabilidade";
    import CategoriaRisco from "@/views/plano/components/CategoriaRisco";
    import NivelRisco from "@/views/plano/components/NivelRisco";
    import AvaliacaoControle from "@/views/plano/components/AvaliacaoControle";
    import RespostaRisco from "@/views/plano/components/RespostaRisco";
    import VCardWidget from "@/components/VWidget";

    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    const respostaRiscoRepository = RepositoryFactory.get("resposta");

    export default {
        components: {
            VCardWidget,
            AreasAtuacao,
            Impacto,
            Probabilidade,
            CategoriaRisco,
            NivelRisco,
            AvaliacaoControle,
            RespostaRisco
        },

        data: () => ({
            breadcrumbItems: [
                {position: 1, text: "Início", disabled: false, href: "/"},
                {position: 2, text: "Plano", disabled: true}
            ]
        }),

        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            respostaRiscoRepository.findByPlano(this.plano.id).then(res => {
                this.$store.dispatch('planos/setRespostas', res.data)
            })
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano
            })
        },

        methods: {

        }
    };
</script>
