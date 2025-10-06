<template>
    <div>
        <v-card-widget :title="title" enableHeader enableActions>
            <div slot="widget-content">
                <v-form ref="form" v-model="valid" lazy-validation>
                    <v-row>
                        <v-col cols="12">
                            <v-text-field v-model="risco.nome" :rules="rules.required" label="* Evento de risco" required></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="3">
                            <v-select label="* Tipo" v-model="risco.tipo" item-text="nome" item-value="id"
                                      :items="tiposRisco" required :rules="rules.required"></v-select>
                        </v-col>
                        <v-col cols="9">
                            <v-select label="* Categoria(s)" v-model="risco.categorias" item-text="nome" multiple
                                      return-object :items="categorias" required :rules="rules.notEmpty"></v-select>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <v-select label="* Ações relacionadas" v-model="risco.acoes" item-text="titulo" multiple
                                      return-object :items="acoes" required :rules="rules.notEmpty"></v-select>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <span class="subtitle-1">Causas</span>
                            <quill-editor v-model="risco.causa" :options="editorOption"/>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <span class="subtitle-1" title="">Consequências</span>
                            <quill-editor v-model="risco.consequencia" :options="editorOption"/>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12">
                            <span class="subtitle-1">Descrição dos controles existentes</span>
                            <quill-editor v-model="risco.controles" :options="editorOption"/>
                        </v-col>
                    </v-row>
                </v-form>
            </div>
            <div slot="widget-actions">
                <v-btn text class="mr-2" @click="cancelar">Cancelar</v-btn>
                <v-btn :disabled="!valid" color="primary" @click="cadastrar">
                    {{riscoId ? 'Atualizar' : 'Cadastrar'}}
                </v-btn>
            </div>
        </v-card-widget>
    </div>
</template>
<script>
    import { mapState } from 'vuex';
    import VCardWidget from "@/components/VWidget";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const riscoRepository = RepositoryFactory.get("risco");
    const categoriaRepository = RepositoryFactory.get("categoriaRisco");
    const acaoRepository = RepositoryFactory.get("acao");

    export default {
        components: {
            VCardWidget
        },
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {position: 2, text: "Eventos de Risco", disabled: false, href: "/riscos"}
                ],
                valid: true,
                riscoId: null,
                risco: {
                    id: '',
                    nome: '',
                    tipo: null,
                    causa: '',
                    consequencia: '',
                    controles: '',
                    categorias: [],
                    acoes: [],
                    plano: {
                        id: null
                    }
                },
                categorias: [],
                acoes: [],
                tiposRisco: [
                    {id: 'AMEACA', nome: 'Ameaça'},
                    {id: 'OPORTUNIDADE', nome: 'Oportunidade'}
                ],
                rules: {
                    required: [
                        v => !!v || 'Campo obrigatório',
                    ],
                    notEmpty: [
                        v => v.length > 0 || 'Campo obrigatório',
                    ]
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
                title: ''
            }
        },
        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            this.riscoId = this.$route.query.risco;
            if (typeof this.riscoId != 'undefined') {
                this.title = 'Editar evento de risco';
                this.breadcrumbItems.push({position: 3, text: "Editar", disabled: true});
                riscoRepository.findById(this.riscoId).then(res => {
                    this.risco = res.data;
                })
            } else {
                this.title = 'Cadastrar evento de risco';
                this.breadcrumbItems.push({position: 3, text: "Cadastrar", disabled: true});
            }
            this.getCategorias();
            this.getAcoes();
        },

        methods: {
            cadastrar () {
                if(this.$refs.form.validate()){
                    this.risco.plano.id = this.plano.id;
                    if (typeof this.riscoId != 'undefined') {
                        riscoRepository.atualizar(this.risco).then(res => {
                            this.$router.push({ name: 'DetalheRisco', params: { riscoId: res.data.id } });
                        })
                    } else {
                        riscoRepository.cadastrar(this.risco).then(res => {
                            this.$router.push({ name: 'DetalheRisco', params: { riscoId: res.data.id } });
                        })
                    }
                }
            },
            cancelar () {
                this.$router.push('/riscos')
            },

            getCategorias () {
                categoriaRepository.findByPlano(this.plano.id).then(res => {
                    this.categorias = res.data;
                })
            },

            getAcoes () {
                acaoRepository.findByUnidade(this.plano.id).then(res => {
                    this.acoes = res.data;
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