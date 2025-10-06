<template>
    <div>
        <v-card-widget :title="title" enableHeader enableActions>
            <div slot="widget-content">
                <v-form ref="form" v-model="valid" lazy-validation>
                    <v-row>
                        <v-col cols="12">
                            <v-text-field v-model="acao.titulo" :rules="rules.titulo" label="* Título" required></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <v-select label="Área(s) de atuação" v-model="acao.areas" item-text="nome" multiple
                                      return-object :items="areas"></v-select>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <v-text-field v-model="acao.objetivoGeral" label="Objetivo geral"></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <span class="subtitle-1">Objetivos específicos</span>
                            <quill-editor ref="objetivosEspecificosEditor" v-model="acao.objetivosEspecificos" :options="editorOption"/>
                        </v-col>
                    </v-row>

                </v-form>
            </div>
            <div slot="widget-actions">



                <v-btn text class="mr-2" @click="cancelar">Cancelar</v-btn>

                <v-btn :disabled="!valid" color="primary" @click="cadastrar">
                    {{acaoId ? 'Atualizar' : 'Cadastrar'}}
                </v-btn>

                
            </div>
        </v-card-widget>
    </div>
</template>
<script>
    import { mapState } from 'vuex';
    import VCardWidget from "@/components/VWidget";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const areaAtuacaoRepository = RepositoryFactory.get("areaAtuacao");
    const acaoRepository = RepositoryFactory.get("acao");

    export default {
        components: {
            VCardWidget
        },
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {position: 2, text: "Ações", disabled: false, href: "/acoes"},
                ],
                valid: true,
                acaoId: null,
                acao: {
                    id: '',
                    titulo: '',
                    areas: [],
                    objetivoGeral: '',
                    objetivosEspecificos: '',
                    plano: {
                        id: null
                    }
                },
                rules: {
                    titulo: [
                        v => !!v || 'Campo obrigatório',
                    ]
                },
                areas: [],
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
                title: ''
            }
        },
        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            this.acaoId = this.$route.query.acao;
            if (typeof this.acaoId != 'undefined') {
                this.title = 'Editar ação';
                this.breadcrumbItems.push({position: 3, text: "Editar", disabled: true});
                acaoRepository.findById(this.acaoId).then(res => {
                    this.acao = res.data;
                })
            } else {
                this.title = 'Cadastrar ação';
                this.breadcrumbItems.push({position: 3, text: "Cadastrar", disabled: true});
            }
            this.getAreasAtuacao();
        },

        methods: {
            cadastrar () {
                if (this.$refs.form.validate()) {
                    this.acao.plano.id = this.plano.id;
                    if (typeof this.acaoId != 'undefined') {
                        acaoRepository.atualizar(this.acao).then(res => {
                            this.$router.push({name: 'DetalheAcao', params: {acaoId: res.data.id}});


                        })
                    } else {
                        acaoRepository.cadastrar(this.acao).then(res => {
                            this.$router.push({name:"DetalheAcao", params: {acaoId: res.data.id}});

                        })
                    }
                }
            },

            
            cancelar() {
                this.$router.push({name: 'DetalheAcao', params: {acaoId: this.acaoId}});
             },


            getAreasAtuacao() {
                areaAtuacaoRepository.find(this.plano.id).then(res => {
                    this.areas = res.data;
                })
            }
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano
            })
        }
    }

</script>
<style lang="stylus" scoped>

</style>