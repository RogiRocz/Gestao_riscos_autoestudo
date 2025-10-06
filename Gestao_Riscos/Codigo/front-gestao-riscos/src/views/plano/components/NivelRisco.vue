<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn class="ma-2" outlined color="primary" @click.stop="dialog = true">Novo Nível</v-btn>
                </v-row>
                <v-data-table :headers="headers" :items="niveis">
                    <template v-slot:[`item.cor`]="{item}">
                        <v-icon :color="item.cor">mdi-square</v-icon>
                    </template>
                    <template v-slot:[`item.respostas`]="{item}">
                        <span v-for="(resposta, index) in item.respostasRisco" :key="resposta.id">
                            {{resposta.nome}}{{index !== item.respostasRisco.length - 1 ? ',' : ''}}
                        </span>
                    </template>
                    <template v-slot:[`item.faixa`]="{item}">
                        <span>{{item.valorInicial}} - {{item.valorFinal}}</span>
                    </template>
                    <template v-slot:[`item.acoes`]="{item}">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn class="mr-1" icon color="primary" v-bind="attrs" v-on="on" @click.stop="editDialog(item)"><v-icon>create</v-icon></v-btn>
                            </template>
                            <span>Editar</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn class="mr-1" icon color="error" v-bind="attrs" v-on="on" @click="dialogRemove = true, currentItem = item.id"><v-icon>delete</v-icon></v-btn>
                            </template>
                            <span>Excluir</span>
                        </v-tooltip>
                    </template>
                </v-data-table>
            </v-card-text>
        </v-card>

        <v-dialog v-model="dialog" persistent max-width="70%">
            <v-card>
                <v-card-title>
                    <span class="headline">{{dialogTitle}} nível de risco</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field v-model="nivel.nome" label="* Nome" :rules="rules.required"></v-text-field>
                                </v-col>
                                <v-col cols="6">
                                    <v-select label="Periodicidade sugerida de avaliação" v-model="nivel.periodicidade" item-text="nome" item-value="value" :items="periodicidades"></v-select>
                                </v-col>
                                <v-col cols="3">
                                    <v-text-field v-model="nivel.valorInicial" label="* Valor inicial" :rules="rules.required"></v-text-field>
                                </v-col>
                                <v-col cols="3">
                                    <v-text-field v-model="nivel.valorFinal" label="* Valor final" :rules="rules.required"></v-text-field>
                                </v-col>
                                <v-col cols="12">
                                    <v-select label="Resposta(s) sugerida(s) para o tratamento" multiple return-object v-model="nivel.respostasRisco" item-text="nome" :items="respostas"></v-select>
                                </v-col>
                                <v-col cols="12">
                                    <v-textarea v-model="nivel.descricao" label="Descrição"></v-textarea>
                                </v-col>
                                <v-col cols="12">
                                    <p>Cor:</p>
                                    <v-color-picker v-model="nivel.cor" hide-inputs></v-color-picker>
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
                    <v-btn color="primary" @click="update ? editar() : cadastrar() " :disabled="!formValid">Cadastrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <confirm-dialog :dialogVisible="dialogRemove" :toogleVisible="function(){dialogRemove = false}"
                       :confirmAction="excluir"
                       :descricao="'Tem certeza de que deseja excluir esse nível de risco?'">
        </confirm-dialog>
    </div>
</template>

<script>
    import { mapState } from 'vuex';
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    import ConfirmDialog from "@/components/ConfirmDialog"

    const nivelRiscoRepository = RepositoryFactory.get("nivel");
    export default {
        name: 'nivel-risco',
        components: {
            ConfirmDialog
        },
        data() {
            return {
                headers: [
                    {text: "Cor", value: "cor", sortable: false},
                    {text: "Nome", value: "nome", sortable: false},
                    {text: "Descrição", value: "descricao", sortable: false},
                    {text: "Periodicidade", value: "periodicidade", sortable: false},
                    {text: "Respostas", value: "respostas", sortable: false},
                    {text: "Faixa", value: "faixa", align: "center", width: "8%", sortable: false},
                    {text: "", value: "acoes", align: "right", width: "10%", sortable: false}
                ],
                niveis: [],
                nivel:{
                    nome:'',
                    descricao:'',
                    valorInicial: null,
                    valorFinal: null,
                    periodicidade: '',
                    cor: '#FF6200',
                    respostasRisco: []
                },
                dialog: false,
                dialogRemove: false,
                currentItem: null,
                formValid: true,
                update: false,
                dialogTitle: 'Cadastrar',
                rules:{
                    required:[
                        v => !!v || 'Campo obrigatório',
                    ]
                },
                periodicidades: [
                    {nome: "DIARIA", value:"DIÁRIA"},
                    {nome: "SEMANAL", value:"SEMANAL"},
                    {nome: "QUINZENAL", value:"QUINZENAL"},
                    {nome: "MENSAL", value:"MENSAL"},
                    {nome: "BIMESTRAL", value:"BIMESTRAL"},
                    {nome: "TRIMESTRAL", value:"TRIMESTRAL"},
                    {nome: "SEMESTRAL", value:"SEMESTRAL"},
                    {nome: "ANUAL", value:"ANUAL"},
                ]
            };
        },
        created() {
            this.getNiveis();
        },

        methods: {
            getNiveis() {
                nivelRiscoRepository.findByPlano(this.plano.id).then(res => {
                    this.niveis = res.data;
                })
            },

            cadastrar(){
                if (this.$refs.form.validate()) {
                    nivelRiscoRepository.cadastrar(this.nivel).then(res =>{
                        this.niveis.push(res.data);
                        this.dialog = false;
                    })
                }
            },

            editar(){
                if(this.$refs.form.validate()){
                    nivelRiscoRepository.editar(this.currentItem, this.nivel).then(res =>{
                        this.niveis.splice(this.niveis.findIndex(i => i.id == this.currentItem), 1, res.data);
                        this.dialog = false;
                    })
                }
            },

            excluir () {
                nivelRiscoRepository.excluir(this.currentItem).then(() => {
                    // TODO: tratar a resposta da exclusão
                    this.niveis.splice(this.niveis.findIndex(i => i.id == this.currentItem), 1);
                    this.dialogRemove = false;
                })
            },

            closeDialog(){
                this.dialogTitle='Cadastrar';
                this.nivel.cor = '#FF6200';
                this.update = false;
                this.$refs.form.reset();
            },

            editDialog(nivel){
                this.update = true;
                this.currentItem = nivel.id;
                this.nivel.nome = nivel.nome;
                this.nivel.descricao = nivel.descricao;
                this.nivel.valorInicial = nivel.valorInicial;
                this.nivel.valorFinal = nivel.valorFinal;
                this.nivel.periodicidade = nivel.periodicidade;
                this.nivel.respostasRisco = nivel.respostasRisco;
                this.nivel.cor = nivel.cor;
                this.dialogTitle = 'Editar';
                this.dialog = true;
            }
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano,
                respostas: state => state.planos.respostas
            })
        },

        watch:{
            dialog: function(val){
                if(!val){
                    this.closeDialog();
                }
            }
        }
    };
</script>

<style scoped>

</style>

