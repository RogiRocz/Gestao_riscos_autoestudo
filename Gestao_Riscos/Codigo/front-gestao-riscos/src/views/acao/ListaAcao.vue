<template>
    <div>
        <v-card-widget :title="'Ações'" enableHeader>
            <div slot="widget-header-action">
                <v-btn class="ma-2" outlined color="primary" to="/acoes/cadastrar">Nova ação</v-btn>
            </div>
            <div slot="widget-content">
                <v-row>
                    <v-col cols="6">
                        <v-select label="Área de atuação" prepend-icon="filter_alt" v-model="area" item-text="nome"
                                  item-value="id" :items="areas"></v-select>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="search" label="Buscar" single-line prepend-inner-icon="search"></v-text-field>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <v-data-table :headers="headers" :items="acoesFilter" class="elevation-1" :search="search">
                            <template v-slot:[`item.titulo`]="{item}">
                                <a :href="'/acoes/' + item.id" class="text-decoration-none">{{item.titulo}}</a>
                            </template>
                            <template v-slot:[`item.areas`]="{item}">
                                <v-chip v-for="area in item.areas" :key="area.id" class="ma-1" color="secondary lighten-2"
                                        label>
                                    {{area.nome}}
                                </v-chip>
                            </template>
                        </v-data-table>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>
    </div>
</template>
<script>
    import { mapState } from 'vuex';
    import VCardWidget from "@/components/VWidget";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const acaoRepository = RepositoryFactory.get("acao");
    const areaAtuacaoRepository = RepositoryFactory.get("areaAtuacao");
    export default {
        components: {
            VCardWidget
        },
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {position: 2, text: "Ações", disabled: true}
                ],
                search: '',
                headers: [
                    {text: "Título", value: "titulo", sortable: true},
                    {text: "Área(s) de atuação", value: "areas", align: 'left', filterable: false}
                ],
                acoes: [],
                areas: [],
                area: -1
            }
        },
        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            this.getAcoes();
            this.getAreasAtuacao();
        },

        methods: {
            getAcoes() {
                acaoRepository.findByUnidade(this.plano.id).then(res => {
                    this.acoes = res.data

                })
            },

            getAreasAtuacao() {
                areaAtuacaoRepository.find(this.plano.id).then(res => {
                    this.areas = res.data;
                    this.areas.unshift({nome: "Todas", id: -1})
                })
            }
        },

        computed: {
            acoesFilter() {
                if (this.area === -1) {
                    return this.acoes;
                }
                return this.acoes.filter(acao => {
                    return acao.areas.filter(area => {
                        return area.id === this.area;
                    }).length > 0;
                })
            },
            ...mapState({
                plano: state => state.app.plano
            })
        }
    }

</script>
<style lang="stylus" scoped>

</style>