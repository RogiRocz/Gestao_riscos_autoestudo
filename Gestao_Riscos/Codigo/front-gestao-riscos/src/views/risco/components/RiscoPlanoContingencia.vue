<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn v-if="avaliacoes.length > 0" class="ma-2" outlined color="primary" @click.stop="dialog = true">Novo plano de contingência</v-btn>
                </v-row>
                <v-row v-if="avaliacoes.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            O plano de contingência só poderá ser feito após a avaliação do evento de risco.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-row v-if="contingencias.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            Nenhum plano de contingência cadastrado.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-data-table v-if="avaliacoes.length > 0" :headers="headers" :items="contingencias" disable-pagination show-expand>
                    <template v-slot:item.responsavel="{item}">
                        {{item.responsavel.nome}}
                    </template>
                    <template v-slot:item.gatilho="{item}">
                        {{item.gatilho}}
                    </template>
                    <template v-slot:item.acoes="{item}">
                        <div class="text-no-wrap">
                            <v-tooltip bottom>
                                <template v-slot:activator="{ on, attrs }">
                                    <v-btn class="mr-1" icon color="primary" v-bind="attrs" v-on="on"><v-icon>create</v-icon></v-btn>
                                </template>
                                <span>Editar</span>
                            </v-tooltip>
                            <v-tooltip bottom>
                                <template v-slot:activator="{on, attrs }">
                                    <v-btn class="mr-1" icon color="error" v-bind="attrs" v-on="on"><v-icon>delete</v-icon></v-btn>
                                </template>
                                <span>Excluir</span>
                            </v-tooltip>
                        </div>
                    </template>
                    <template v-slot:expanded-item="{ headers, item }">
                        <td :colspan="headers.length">
                            <v-row class="ma-3">
                                <v-col cols="12">
                                    <div class="font-weight-bold text-uppercase">Ações de contingência:</div>
                                    <div class="font-weight-light title" v-html="item.acoes"></div>
                                </v-col>
                            </v-row>
                        </td>
                    </template>
                </v-data-table>
            </v-card-text>
        </v-card>

        <v-dialog v-model="dialog" persistent max-width="70%">
            <v-card>
                <v-card-title>
                    <span class="headline">Novo plano de contingência</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="12">
                                    <v-autocomplete v-model="contingencia.responsavel.id" :items="servidores" :rules="rules.required"
                                                    label="* Responsável" item-text="nome" item-value="id"
                                    ></v-autocomplete>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="12">
                                    <v-textarea v-model="contingencia.gatilho" :rules="rules.required" label="* Gatilho"></v-textarea>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="12">
                                    <span class="subtitle-1">Ações de contingência:</span>
                                    <quill-editor v-model="contingencia.acoes" :options="editorOption"/>
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
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const planoContingenciaRepository = RepositoryFactory.get("planoContingencia");

    export default {
        name: 'risco-plano-contingencia',
        data() {
            return {
                headers: [
                    {text: "Gatilho", value: "gatilho", sortable: false},
                    {text: "Responsável", value: "responsavel", sortable: false, align: 'center'},
                    {text: "", value: "acoes", sortable: false, align: 'right'}
                ],
                dialog: false,
                formValid: true,
                contingencia: {
                    acoes: null,
                    gatilho: null,
                    risco: {
                        id: null
                    },
                    responsavel: {
                        id: null
                    }
                },
                rules: {
                    required: [
                        v => !!v || 'Campo obrigatório',
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
                }
            };
        },
        created() {
           this.contingencia.risco.id = this.risco.id;
        },

        methods: {
            cadastrar () {
                if (this.$refs.form.validate()) {
                    planoContingenciaRepository.cadastrar(this.contingencia).then(res => {
                        this.$store.dispatch('riscos/addContingencia', res.data)
                        this.dialog = false;
                    })
                }
            },

            closeDialog() {
                this.$refs.form.reset();
                this.contingencia.acoes = null;
                this.contingencia.gatilho = null;
            }
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano,
                risco: (state) => state.riscos.risco,
                contingencias: state => state.riscos.contingencias,
                servidores: (state) => state.app.servidores
            }),

            ...mapGetters({
                avaliacoes : 'avaliacoes/avaliacoes',
            })
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

