<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn v-if="contingencias.length > 0" class="ma-2" outlined color="primary" @click.stop="dialog = true">Nova ocorrência</v-btn>
                </v-row>
                <v-row v-if="contingencias.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            É necessário um plano de contingência para registrar uma ocorrência.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-row v-if="contingencias.length > 0 && ocorrencias.length == 0">
                    <v-col cols="12">
                        <v-alert text outlined color="warning" icon="report_problem">
                            Nenhuma ocorrência registrada.
                        </v-alert>
                    </v-col>
                </v-row>
                <v-data-table v-if="ocorrencias.length > 0" :headers="headers" :items="ocorrencias" disable-pagination show-expand>
                    <template v-slot:item.data="{item}">
                        {{$moment(item.data).format('DD/MM/YYYY')}}
                    </template>
                    <template v-slot:item.responsavel="{item}">
                        {{item.responsavel.nome}}
                    </template>
                    <template v-slot:item.gatilho="{item}">
                        {{item.planoContingencia.gatilho}}
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
                                    <div class="font-weight-bold text-uppercase">Descrição da ocorrência:</div>
                                    <div class="font-weight-light title" v-html="item.descricao"></div>
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
                    <span class="headline">Registrar ocorrência</span>
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
                                        <v-date-picker v-model="ocorrencia.data"  no-title
                                                       @input="menuData = false" :max="today"
                                        ></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="12">
                                    <v-select label="* Gatilho" v-model="ocorrencia.planoContingencia.id" item-text="gatilho"
                                              :items="contingencias" :rules="rules.required" item-value="id"></v-select>
                                </v-col>
                                <v-col cols="12">
                                    <span class="subtitle-1">* Descrição</span>
                                    <quill-editor v-model="ocorrencia.descricao" :options="editorOption"/>
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
                    <v-btn color="primary" @click="cadastrar" :disabled="!formValid">Salvar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    import { mapState, mapGetters } from 'vuex';
    import moment from 'moment';
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    const ocorrenciaRepository = RepositoryFactory.get("ocorrencia");

    export default {
        name: 'risco-ocorrencia',
        data() {
            return {
                headers: [
                    {text: "Data", value: "data", sortable: false},
                    {text: "Gatilho", value: "gatilho", sortable: false},
                    {text: "Responsável", value: "responsavel", sortable: false, align: 'center'},
                    {text: "", value: "acoes", sortable: false, align: 'right'}
                ],
                dialog: false,
                formValid: true,
                menuData: false,
                today: moment().format('YYYY-MM-DD'),
                ocorrencia: {
                    descricao: null,
                    planoContingencia: {
                        id: null
                    },
                    risco: {
                        id: null
                    },
                    data: moment().format('YYYY-MM-DD'),
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
            this.ocorrencia.risco.id = this.risco.id;
        },

        methods: {
            cadastrar () {
                if (this.$refs.form.validate()) {
                    ocorrenciaRepository.cadastrar(this.ocorrencia).then(res => {
                        this.$store.dispatch('riscos/addOcorrencia', res.data)
                        this.dialog = false;
                    })
                }
            },

            closeDialog() {
                this.$refs.form.reset();
                this.ocorrencia.data = moment().format('YYYY-MM-DD');
                this.ocorrencia.planoContingencia.id = null;
            }
        },

        computed: {
            ...mapState({
                risco: (state) => state.riscos.risco,
                contingencias: state => state.riscos.contingencias,
            }),

            ...mapGetters({
                ocorrencias : 'riscos/ocorrencias'
            }),

            computedDateFormatted () {
                return moment(this.ocorrencia.data).format('DD/MM/YYYY')
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

