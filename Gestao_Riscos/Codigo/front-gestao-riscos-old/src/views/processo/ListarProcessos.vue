<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>
                <v-card>
                    <v-card-title class="headline primary white--text">
                        Processos
                    </v-card-title>
                    <div id="app">
                        <!-- <v-app id="inspire"> -->
                      <v-card>
                        <v-card-text>
                              <v-card class="tmc">
                               <v-layout justify-space-between fill-height wrap class="tms">
                                 <v-flex xs12 lg4>
                                   <v-autocomplete v-model="uProcesso" :items="unidadePro" item-text="sigla"
                                                label="Unidade" prepend-icon="fa-users fa-lg"
                                    ></v-autocomplete>
                                </v-flex>

                                <v-flex xs12 lg4>
                                    <v-autocomplete v-model="gProcesso" :items="gerentePro" item-text="nome"
                                                label="Gerente" prepend-icon="fa-user fa-lg"
                                    ></v-autocomplete>
                                </v-flex>

                               <v-flex xs12 lg4>
                                    <v-select v-model="tProcesso" :items="tipoPro" item-text="nome" 
                                                label="Tipo de Processo" prepend-icon="fa-filter fa-lg" 
                                                
                                    ></v-select>                           
                               </v-flex>

                            </v-layout>
                            <v-toolbar card color="white" >
                                <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down" ></v-text-field>
                            </v-toolbar>
                            <cadastrar-processo @event-new-mensagem="recebeMsg"
                                                @event-new-snackbar="recebeSnack"
                                                @event-new-cor="recebeCor"></cadastrar-processo>
                            <v-data-table
                                    :pagination.sync="pagination"
                                    :search="search"
                                    :headers="headers"
                                    :items="ilteredItems"
                                    :expand="expand"
                                    no-data-text="Nenhum resultado encontrado"
                                    no-results-text="Nenhum resultado encontrado">
                                <template v-slot:items="props">
                                    <tr @click="props.expanded = !props.expanded" >
                                        <td class="text-xs-left">{{ props.item.nome }}</td>
                                        <td class="text-xs-left">{{ props.item.tipo.nome }}</td>
                                        <td class="text-xs-left">{{props.item.gerente.nome}}</td>
                                        <td class="text-xs-left">{{ props.item.unidadeResponsavel.sigla}}</td>
                                        <td class="justify-center layout px-0">
                                            <v-dialog  v-model="editarProcesso" persistent max-width="800">
                                                <template #activator="{ on: editarProcesso }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">
                                                            <v-btn color="primary" dark
                                                                     depressed outline icon fab small v-on="{ ...tooltip, ...editarProcesso }" @click="processoEditar(props.item.id)"
                                                            >
                                                                <v-icon>edit</v-icon> </v-btn>
                                                        </template>
                                                        <span>Editar</span>
                                                    </v-tooltip>
                                                </template>
                                                <v-card>
                                                    <v-form ref="form" v-model="valid" :lazy-validation="lazy">
                                                        <v-card-title class="headline primary white--text" primary-title> Editar Processo </v-card-title>
                                                        <v-card-text flat class="pa-3">
                                                            <v-container grid-list-md text-xs-center>
                                                                <v-layout row wrap>
                                                                    <v-flex xs6 class="text-xs-left">
                                                                        <h5> 
                                                                            <b>Gerente:</b> 
                                                                            {{usuarios.nome}}
                                                                        </h5>
                                                                    </v-flex>
                                                                    <v-flex xs6 class="text-xs-left">
                                                                        <h5>
                                                                            <b>Unidade Responsável:</b> 
                                                                            {{usuarios.unidade.sigla}}
                                                                        </h5>
                                                                    </v-flex>
                                                                </v-layout>
                                                                <v-layout wrap>
                                                                    <v-flex xs12>
                                                                        <v-text-field
                                                                            id="inputNomeProcesso"
                                                                            label="Nome do Processo*"
                                                                            placeholder="Nome do processo"
                                                                            v-model="processo.nome"
                                                                            :rules="rules.processo.nome"
                                                                            required
                                                                            type="text"
                                                                        ></v-text-field>
                                                                    </v-flex>
                                                                    <v-flex xs12>
                                                                        <v-select 
                                                                            v-model="processo.tipo"
                                                                            :items="tipoProcesso"
                                                                            item-text="nome"
                                                                            item-value="id"
                                                                            return-object
                                                                            placeholder="Tipo de processo"
                                                                            label="Selecioneo tipo do processo*"
                                                                            :rules="rules.processo.tipo"
                                                                            required
                                                                        ></v-select>
                                                                    </v-flex>
                                                                    <small>*Campos obrigatórios</small>
                                                                </v-layout>
                                                            </v-container>
                                                            <v-card-actions>
                                                                <v-spacer></v-spacer>
                                                                     <v-btn color="primary" v-on:click="editarProcesso = false, salvar()" @click="validate" :disabled="!valid">Editar</v-btn>
                                                                    <v-btn color="disabled" v-on:click="editarProcesso = false" >Cancelar</v-btn>
                                                            </v-card-actions>
                                                        </v-card-text>
                                                    </v-form>
                                                </v-card> 
                                            </v-dialog>
                                            <v-dialog  v-model="dialog" persistent max-width="300">
                                                <template #activator="{ on: dialog }">
                                                    <v-tooltip bottom>
                                                        <template #activator="{ on: tooltip }">
                                                            <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                                    @click="procGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                                        </template>
                                                        <span>Remover</span>
                                                    </v-tooltip>
                                                </template>
                                                <v-card>
                                                    <v-card-title class="headline">Excluir Processo</v-card-title>
                                                    <v-card-text>Deseja realmente excluir este Processo?</v-card-text>
                                                    <v-card-actions >
                                                        <v-spacer></v-spacer>
                                                        <v-btn color="error"  small @click="processoDelete(flag.id)">Excluir</v-btn>
                                                        <v-btn color="disabled" small @click="dialog = false">Cancelar</v-btn>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-dialog>
                                        </td>
                                    </tr>
                                </template>
                            </v-data-table>
                        </v-card>
                     </v-card-text>
                    </v-card>
                    </div>
                </v-card>
            </v-flex>
        </v-layout>

        <v-snackbar :timeout="timeout" right top :color="cor" v-model="snackbar">{{ mensagem }}</v-snackbar>
    </v-container>
</template>
<script>
    import {mapState} from "vuex";
    import axios from "axios"
    import CadastrarProcesso from "./CadastrarProcesso";
    export default {
        components: {
            CadastrarProcesso,
        },
        data() {
            return {
                pagination: { rowsPerPage: 10 },
                search: '',
                expand: false,
                headers: [
                    { text: "Processos", value: "nome" },
                    { text: "Tipo de Processo", value: "tipo.nome" },
                    { text: "Gerente", value: "gerente.nome" },
                    { text: "Unidade Responsável", value: "unidadeResponsavel.sigla" },
                    { text: "", sortable: false, value: ""}
                ],
                tipoPro: [],
                unidadePro:[],
                gerentePro:[],
                usuariosAll:[],
                dialog: false,
                unidade: "",
                tipoP: "",
                nameRules: [
                    v => !!v || '',
                ],
                processo:{
                    nome:'',
                    tipo:'',
                    unidadeResponsavel: ''
                },
                x: '',
                avaliacoes: '',
                listaDeRiscosGet:[],
                y: '',
                processoId: null,
                risco: '',
                tei: false,
                hidden:false,
                uProcesso: null,
                tProcesso: null,
                gProcesso: null,
                selected: [],
                allSelected: false,
                mensagem: "",
                cor: "",
                snackbar: false,
                timeout: 3500,

                valid: true,
                lazy: false,
                editarProcesso: false,
                 flag: "",

                rules: {
                    processo: {
                        nome: [v => !!v || 'Nome do Processo é um campo obrigatório'],
                        tipo: [v => !!v || 'Tipo do Processo é um campo obrigatório'],
                    }
                }

            };
        },
        methods: {
            validate() {
                if (this.$refs.form.validate()) {
                    this.snackbar = true;
                }
            },
            reset() {
                this.$refs.form.reset();
            },
            resetValidation() {
                this.$refs.form.resetValidation();
            },
            recebeMsg(dados){
                this.mensagem = dados;
            },
            recebeCor(dados){
                this.cor = dados;
            },
            recebeSnack(dados){
                this.snackbar = dados;
            },
            processoDelete(id){
                axios.delete('/processos/' + id).then(res => {
                    this.dialog = false;    
                    this.$store.dispatch("processos/GET_ALL");
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Processo excluído com sucesso!";
                }).catch(e => {
                    this.mensagem = "Erro ao excluir: Processo vinculado à um risco!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.dialog = false;
                })
            },
            processoEditar(id){
                axios.get('/processos/' + id).then(res => {
                    this.y = res.data;
                    this.processo.nome = this.y.nome;
                    this.processo.tipo = this.y.tipo;        
                })
            },
            processoDetalhe(id){
                axios.get('/processos/' + id).then(res => {
                    this.processo = res.data;
                    this.tipoP = this.processo.tipo.nome;
                    this.unidade = this.processo.unidadeResponsavel.nome;
                })
            },
            limpar(){
                this.processo.nome = ''
                this.processo.tipo=''
            },
            procGet(id){
                axios.get('/processos/' + id).then(res => {
                        this.flag = res.data;
                })
            },
            listG(){
                axios.get('/processos/').then(res => {
                    var processosAll;
                    processosAll = res.data;
                    for(let i = 0; i < processosAll.length; i++){
                        if(i == 0){
                            this.gerentePro.push("Todos");
                            this.gerentePro.push(processosAll[i].gerente);
                        }
                        else{
                            this.gerentePro.push(processosAll[i].gerente);
                        }
                    }
                })   
            },
            listU(){
                axios.get('/processos/').then(res => {
                    var processosAll;
                    processosAll = res.data;
                    for(let i = 0; i < processosAll.length; i++){
                        if(i == 0){
                            this.unidadePro.push("Todas");
                            this.unidadePro.push(processosAll[i].unidadeResponsavel);
                        }
                        else{
                            this.unidadePro.push(processosAll[i].unidadeResponsavel);
                        }
                    }
                })   
            },
            listT(){
                axios.get('/processos/').then(res => {
                    var processosAll;
                    processosAll = res.data;
                    for(let i = 0; i < processosAll.length; i++){
                        if(i == 0){
                            this.tipoPro.push("Todos");
                            this.tipoPro.push(processosAll[i].tipo);
                        }
                        else{
                            this.tipoPro.push(processosAll[i].tipo);
                        }
                    }
                })   
            },
            salvar() {
                axios.put('/processos/' + this.y.id, this.processo).then(res => {
                    //removido o alert
                    this.limpar();
                    this.tei = false;
                    this.snackbar = true;
                    this.$store.dispatch("processos/GET_ALL");
                    this.cor = "success";
                    this.snackbar = true;
                    this.mensagem = "Processo editado com sucesso!";
                    //location.reload();
                }).catch(e => {
                    /*this.mensagem = e.response.data;*/
                    this.mensagem = "Erro ao editar processo!";
                    this.cor = "error";
                    this.snackbar = true;
                    this.tei = false;

                });
            },
         },
        computed: {
            ...mapState({
                processos: state => state.processos.all,
                usuarios: state => state.usuarios.all,
                tipoProcesso:state => state.tipoProcesso.all
            }),
            ...mapState({
                indicador: state => state.indicador.all
            }),
            formIsValid() {
                return this.processo.nome !== "" && this.processo.tipo !== "";
            },
            ilteredItems() {
            return this.processos.filter((i) => {
              if(this.gProcesso == "Todos" && this.uProcesso != "Todas" && this.tProcesso != "Todos"){
                   return (!this.tProcesso || (i.tipo.nome === this.tProcesso)) && (!this.uProcesso || (i.unidadeResponsavel.sigla === this.uProcesso));
               }
               else if(this.gProcesso == "Todos" && this.tProcesso == "Todos" && this.uProcesso != "Todas"){
                   return (!this.uProcesso || (i.unidadeResponsavel.sigla === this.uProcesso));
               }
               else if(this.gProcesso == "Todos" && this.uProcesso == "Todas" && this.tProcesso != "Todos"){
                   return (!this.tProcesso || (i.tipo.nome === this.tProcesso));
               }

               else if(this.uProcesso == "Todas" && this.gProcesso != "Todos" && this.tProcesso != "Todos"){
                   return (!this.tProcesso || (i.tipo.nome === this.tProcesso)) && (!this.gProcesso || (i.gerente.nome === this.gProcesso));
               }
               else if(this.uProcesso == "Todas" && this.tProcesso == "Todos" && this.gProcesso != "Todos"){
                   return (!this.gProcesso || (i.gerente.nome === this.gProcesso));
               }
               else if(this.uProcesso == "Todas" && this.gProcesso == "Todos" && this.tProcesso != "Todos"){
                   return (!this.tProcesso || (i.tipo.nome === this.tProcesso));
               }

               else if(this.tProcesso == "Todos" && this.gProcesso != "Todos" && this.uProcesso != "Todas"){
                   return (!this.gProcesso || (i.gerente.nome === this.gProcesso)) && (!this.uProcesso || (i.unidadeResponsavel.sigla === this.uProcesso));
               }
               else if(this.tProcesso == "Todos" && this.uProcesso == "Todas" && this.gProcesso != "Todos"){
                   return (!this.gProcesso || (i.gerente.nome === this.gProcesso));
               }
               else if(this.tProcesso == "Todos" && this.gProcesso == "Todos" && this.uProcesso != "Todas"){
                   return (!this.uProcesso || (i.unidadeResponsavel.sigla === this.uProcesso));
               }

               else if (this.gProcesso == "Todos" && this.uProcesso == "Todas"  && this.tProcesso == "Todos"){
                  return this.processos;
              }
               else{
                return (!this.tProcesso || (i.tipo.nome === this.tProcesso)) && (!this.uProcesso || (i.unidadeResponsavel.sigla === this.uProcesso)) && (!this.gProcesso || (i.gerente.nome === this.gProcesso));
              }
                    
                })
            },
        },
        created() {
            this.$store.dispatch("processos/GET_ALL");
            this.$store.dispatch("riscos/GET_ALL");
            this.$store.dispatch("indicador/GET_ALL");
            this.$store.dispatch('usuarios/GET_ALL');
            this.$store.dispatch('tipoProcesso/GET_ALL');
            this.listG();
            this.listU();
            this.listT();
            axios.get('/usuarios/').then(res => {
                this.processo.gerente = res.data;
                this.processo.unidadeResponsavel = this.processo.gerente.unidade;

            });
        }
    }
</script>
<style scoped>
.tms{           
    padding: 15px 20px 0px 15px;
}
.tmc{           
    margin-top:12px;
}
</style>
