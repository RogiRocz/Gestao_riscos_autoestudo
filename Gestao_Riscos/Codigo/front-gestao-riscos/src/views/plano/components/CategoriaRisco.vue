<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-btn class="ma-2" outlined color="primary" @click.stop="dialog = true">Nova Categoria</v-btn>
                </v-row>
                <v-data-table :headers="headers" :items="categorias" disable-pagination item-key="id">
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
                    <span class="headline">{{dialogTitle}} categoria de risco</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <v-container>
                        <v-form ref="form" v-model="formValid" lazy-validation>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field v-model="categoria.nome" label="* Nome" :rules="rules.nome"></v-text-field>
                                </v-col>
                                <v-col cols="12">
                                    <v-textarea v-model="categoria.descricao" label="Descrição"></v-textarea>
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
                       :descricao="'Tem certeza de que deseja excluir essa categoria?'">
        </confirm-dialog>
    </div>
</template>

<script>
    import { mapState } from 'vuex';
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";
    import ConfirmDialog from "@/components/ConfirmDialog"

    const categoriaRiscoRepository = RepositoryFactory.get("categoriaRisco");
    export default {
        name: 'categoria-risco',
        components: {
            ConfirmDialog
        },
        data() { 
            return {
                headers: [
                    {text: "Nome", value: "nome", sortable: true},
                    {text: "Descrição", value: "descricao"},
                    {text: "", value: "acoes", align: "right", width: "10%"}
                ],
                categorias: [],
                categoria:{
                    nome:'',
                    descricao:''
                },
                dialog: false,
                dialogRemove: false,
                currentItem: null,
                formValid: true,
                update: false,
                dialogTitle: 'Cadastrar',
                rules:{
                    nome:[
                        v => !!v || 'Campo obrigatório',
                    ]
                }
            };
        },
        created() {
            this.getCategorias();
        },

        methods: {
            getCategorias() {
                categoriaRiscoRepository.findByPlano(this.plano.id).then(res => {
                    this.categorias = res.data;
                })
            },

            cadastrar(){
                if (this.$refs.form.validate()) {
                    categoriaRiscoRepository.cadastrar(this.categoria).then(res =>{
                        this.categorias.push(res.data);
                        this.dialog = false;
                    })
                }
            },

            editar(){
                if(this.$refs.form.validate()){
                    categoriaRiscoRepository.editar(this.currentItem, this.categoria).then(res =>{
                        this.categorias.splice(this.categorias.findIndex(i => i.id == this.currentItem), 1, res.data);
                        this.dialog = false;
                    })
                }
            },

            excluir () {
                categoriaRiscoRepository.excluir(this.currentItem).then(() => {
                    // TODO: tratar a resposta da exclusão
                    this.categorias.splice(this.categorias.findIndex(i => i.id == this.currentItem), 1);
                    this.dialogRemove = false;
                })
            },
           
            closeDialog(){
                this.dialogTitle='Cadastrar';
                this.update = false;
                this.$refs.form.reset();
            },

            editDialog(categoria) {
                this.update = true;
                this.currentItem = categoria.id;
                this.categoria.nome = categoria.nome;
                this.categoria.descricao = categoria.descricao;
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
            dialog: function(val) {
                if(!val){
                    this.closeDialog();
                }
            }
        }
    };
</script>

<style scoped>

</style>

