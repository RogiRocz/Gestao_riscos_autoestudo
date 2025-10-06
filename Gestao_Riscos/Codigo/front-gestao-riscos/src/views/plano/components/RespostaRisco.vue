<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn class="ma-2" outlined color="primary" @click.stop="dialog = true">Nova Resposta</v-btn>
                </v-row>
                <v-data-table :headers="headers" :items="respostas">
                    <template v-slot:[`item.tipo`]="{item}">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip v-if="item.ameaca" v-bind="attrs" v-on="on" class="mr-1" color="error lighten-2" label>A</v-chip>
                            </template>
                            <span>Ameaça</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-chip v-if="item.oportunidade" v-bind="attrs" v-on="on" class="nowrap" color="success lighten-2" label>O</v-chip>
                            </template>
                            <span>Oportunidade</span>
                        </v-tooltip>

                    </template>
                    <template v-slot:[`item.tratamento`]="{item}">
                        <span v-if="item.planoTratamento" class="mr-1 green--text">SIM</span>
                        <span v-else class="error--text">NÃO</span>
                    </template>
                    <template v-slot:[`item.compartilhavel`]="{item}">
                        <span v-if="item.compartilhavel" class="mr-1 green--text">SIM</span>
                        <span v-else class="error--text">NÃO</span>
                    </template>
                    <template v-slot:[`item.acoes`]="{item}">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn class="mr-1" icon color="primary" v-bind="attrs" v-on="on" @click.stop="editDialog(item)"><v-icon>create</v-icon></v-btn>
                            </template>
                            <span>Editar</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{on, attrs }">
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
                    <span class="headline">{{dialogTitle}} resposta ao risco</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field v-model="resposta.nome" label="* Nome" :rules="rules.required"></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="12">
                                    <v-textarea v-model="resposta.descricao" label="Descrição"></v-textarea>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="3">
                                    <v-switch v-model="resposta.planoTratamento" label="Exige plano de tratamento"></v-switch>
                                </v-col>
                                <v-col cols="3">
                                    <v-switch v-model="resposta.compartilhavel" label="Compartilhável"></v-switch>
                                </v-col>
                                <v-col cols="3">
                                    <v-switch v-model="resposta.ameaca" label="Resposta para ameaças"
                                          :rules="[(resposta.ameaca || resposta.oportunidade) || 'Deve ser indicada resposta para ameaça ou oportunidade']"></v-switch>
                                </v-col>
                                <v-col cols="3">
                                    <v-switch v-model="resposta.oportunidade" label="Resposta para oportunidades"
                                          :rules="[(resposta.ameaca || resposta.oportunidade) || 'Deve ser indicada resposta para ameaça ou oportunidade']"></v-switch>
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
                    <v-btn color="primary" @click="update ? editar() : cadastrar()" :disabled="!formValid">Cadastrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <confirm-dialog :dialogVisible="dialogRemove" :toogleVisible="function(){dialogRemove = false}"
                       :confirmAction="excluir"
                       :descricao="'Tem certeza de que deseja excluir essa resposta ao risco?'">
        </confirm-dialog>
    </div>
</template>

<script>
    import { mapState } from 'vuex';
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    import ConfirmDialog from "@/components/ConfirmDialog"

    const respostaRiscoRepository = RepositoryFactory.get("resposta");
    export default {
        name: 'resposta-risco',
        components: {
            ConfirmDialog
        },
        data() {
            return {
                headers: [
                    {text: "Nome", value: "nome", sortable: true},
                    {text: "Descrição", value: "descricao"},
                    {text: "Tipo de risco", value: "tipo", width: "10%"},
                    {text: "Plano de tratamento", value: "tratamento"},
                    {text: "Compartilhável", value: "compartilhavel"},
                    {text: "", value: "acoes", align: "right", width: "10%"}
                ],
                respostas: [],
                resposta:{
                    nome:'',
                    descricao:'',
                    planoTratamento: false,
                    compartilhavel: false,
                    ameaca: false,
                    oportunidade: false
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
            };
        },
        created() {
            this.getRespostasRisco();
        },

        methods: {
            getRespostasRisco() {
                respostaRiscoRepository.findByPlano(this.plano.id).then(res => {
                    this.respostas = res.data;
                })
            },

            cadastrar(){
                if (this.$refs.form.validate()) {
                    respostaRiscoRepository.cadastrar(this.resposta).then(res =>{
                        this.respostas.push(res.data);
                        this.dialog = false;
                    })
                }
            },

            editar(){
                if(this.$refs.form.validate()){
                    respostaRiscoRepository.editar(this.currentItem, this.resposta).then( res =>{
                        this.respostas.splice(this.respostas.findIndex(i => i.id == this.currentItem), 1, res.data);
                        this.dialog = false;
                    })
                }
            },

            excluir () {
                respostaRiscoRepository.excluir(this.currentItem).then(() => {
                    // TODO: tratar a resposta da exclusão
                    this.respostas.splice(this.respostas.findIndex(i => i.id == this.currentItem), 1);
                    this.dialogRemove = false;
                })
            },

            closeDialog(){
                this.dialogTitle='Cadastrar';
                this.update = false;
                this.$refs.form.reset();
            },

            editDialog(resposta){
                this.update = true;
                this.currentItem = resposta.id;
                this.resposta.nome = resposta.nome;
                this.resposta.descricao = resposta.descricao;
                this.resposta.planoTratamento = resposta.planoTratamento;
                this.resposta.ameaca = resposta.ameaca;
                this.resposta.oportunidade = resposta.oportunidade;
                this.dialogTitle = 'Editar';
                this.dialog = true;
            }
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano
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

