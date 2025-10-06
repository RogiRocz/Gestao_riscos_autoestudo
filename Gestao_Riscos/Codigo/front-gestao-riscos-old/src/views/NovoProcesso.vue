<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
<div id="app" class="card">
  <v-app id="inspire">
    <v-form  @submit.prevent="salvar"  >
      <v-container>
        <v-flex xs12>
          <h3>NOVO PROCESSO</h3>
        </v-flex>

          <v-card>
               <v-container grid-list-md text-xs-center>
                  <v-layout row wrap>
                      <v-flex xs12 class="text-xs-left">
                        <h3>Dados do Processo</h3>
                          <br>
                    </v-flex>

                    <v-flex xs6 class="text-xs-left">
                        <h5>Unidade Responsável</h5>
                        {{processo.unidadeResponsavel.sigla}}
                        <br>
                    </v-flex>
                      <v-flex xs6 class="text-xs-left">
                          <h5>Gestor</h5>
                          {{processo.unidadeResponsavel.nome}}
                          <br>
                      </v-flex>


                    <v-flex  xs6>
                        <v-text-field
                          id="inputNomeProcesso"
                          label="Nome do Processo*"
                          placeholder="Nome do processo"
                          :rules="nameRules"
                          v-model="processo.nome"
                          required
                          type="text"
                        ></v-text-field>
                    </v-flex>



                    <v-flex xs6>
                        <v-select v-model="processo.tipo" :rules="nameRules"
                          :items="tipoProcesso"
                          item-text="nome"
                          item-value="id"
                          return-object
                          placeholder="Tipo de processo"
                          label="Selecione o tipo de processo*"
                        ></v-select>
                    </v-flex>

                      <v-flex xs12 class="text-xs-left">
                          <v-select v-model="processo.unidadeResponsavel"
                                    :items="usuarios"
                                    item-text="unidade.nome"
                                    item-value="unidade"
                                    placeholder="Unidade Responsavel"
                                    label="Unidade Responsavel"
                          ></v-select>

                      </v-flex>

                    <v-flex  xs12 >
                        <v-text-field
                          id="inputObjetivoProcesso"
                          label="Objetivo do Processo"
                          placeholder="Objetivo do processo"
                          type="text"
                          v-model="processo.objetivo"
                        ></v-text-field>
                    </v-flex>


                    <v-flex  xs12>
                        <v-text-field
                          id="inputDescricaoProcesso"
                          label="Descrição do Processo*"
                          placeholder="Descrição do processo"
                          :rules="nameRules"
                          v-model="processo.descricao"
                          type="text"
                        ></v-text-field>
                    </v-flex>

                    <v-flex  xs12>
                          <v-text-field
                            id="inputAlinhamentoEstrategico"
                            :rules="nameRules"
                            label="Alinhamento Estratégico*"
                            placeholder="Alinhamento Estratégico"
                            v-model="processo.alinhamento"
                            type="text"

                          ></v-text-field>
                    </v-flex>


                   <v-flex xs12 class="text-xs-left">
                        <br>
                        <h3>Gerente do Processo</h3>
                   </v-flex>


                      <v-flex xs6>
                          <v-select v-model="processo.gerente"
                                    :items="usuarios"
                                    item-text="nome"
                                    item-value="id"
                                    return-object
                                    placeholder="Selecione o gerente do processo"
                                    label="Gerente do Processo "
                          ></v-select>
                      </v-flex>


                      <v-flex xs12 class="text-xs-left">
                          <br>
                          <h3>Detalhes do Processo</h3>
                          <h5>Agentes do Processo</h5>
                      </v-flex>

                      <v-flex  xs12>
                          <v-text-field
                                  id="inputFornecedores"
                                  label="Fornecedores do Processo"
                                  placeholder="Fornecedores"
                                  v-model="processo.fornecedores"
                                  type="text"
                          ></v-text-field>
                      </v-flex>

                      <v-flex  xs12>
                          <v-text-field
                                  id="inputClientes"
                                  label="Clientes"
                                  placeholder="Clientes"
                                  v-model="processo.clientes"
                                  type="text"
                          ></v-text-field>
                      </v-flex>

                      <v-flex  xs12>
                          <v-text-field
                                  id="inputEntradas"
                                  label="Entradas"
                                  placeholder="Entradas"
                                  v-model="processo.entradas"
                                  type="text"
                          ></v-text-field>
                      </v-flex>

                      <v-flex  xs12>
                          <v-text-field
                                  id="inputSaidas"
                                  label="Saídas"
                                  placeholder="Saídas"
                                  v-model="processo.saidas"
                                  type="text"
                          ></v-text-field>
                      </v-flex>


                      <v-flex  xs12>
                          <v-text-field
                                  id="inputSetores"
                                  label="Setores Envolvidos"
                                  placeholder="Inserir Setores"
                                  v-model="processo.setores"
                          ></v-text-field>
                      </v-flex>

                      <v-flex  xs3>
                          <v-text-field
                                  id="inputAtividades"
                                  label="Atividades que compõe o Processo"
                                  placeholder="Inserir Atividades"
                                  v-model="atividade"
                          ></v-text-field>
                      </v-flex>
                      <v-flex xs6 text-xs-left>
                          <v-btn
                                  :disabled="!formIsValidAlividade"
                                  color="blue"
                                  text="white"
                                  type="button"
                                  v-on:click="adicionarAtividade"
                                  large
                                  outline
                          >
                              Adicionar
                          </v-btn>
                      </v-flex>


                      <div style="margin-top: -50px">
                      <v-data-table  :items="processo.atividades" v-if="processo.atividades.length > 0">
                          <template v-slot:items="props">
                              <td class="text-xs-left">{{ props.item}}</td>
                              <td class="text-xs-center">
                                  <v-tooltip bottom>
                                      <template v-slot:activator="{ on }">
                                          <v-btn @click="editarAtividade(props.item)"
                                                  class="test" depressed outline icon fab dark v-on="on" color="primary" small>
                                              <v-icon>edit</v-icon>

                                          </v-btn>
                                      </template>
                                      <span>Editar</span>
                                  </v-tooltip>

                                  <v-tooltip bottom>
                                      <template v-slot:activator="{ on }">
                                          <v-btn class="test"
                                                 depressed outline icon fab dark v-on="on" color="error" small
                                                 @click="removerAtividade(props.item)">

                                              <v-icon class="material-icons">delete</v-icon>

                                          </v-btn>
                                      </template>
                                      <span>Excluir</span>
                                  </v-tooltip>
                              </td>
                          </template>
                      </v-data-table>
                      </div>

          <!--            <div class="form-row">
            <div class="form-group col-md-6">
              <label for="inputDiagrama">Diagrama</label>
              <input type="file" class="form-control-file" ref="image" id="image" lang="ptbr" v-on:change="processFile()">
              <small id="inputDiagrama" class="form-text text-muted">Imagens no formato PNG de no máximo 5mb</small>
              <label for="inputDiagrama">Diagrama</label>
              <div class="custom-file">
                <input type="file" class="custom-file-input" id="inputDiagrama" lang="ptbr" @change="processFile($event)">
                <label class="custom-file-label" for="inputDiagrama">Click para inserir a imagem do diagrama</label>
                <small id="inputDiagrama" class="form-text text-muted">Imagens no formato PNG de no máximo 5mb</small>
              </div>
            </div>
          </div>-->


                      <v-flex xs12 class="text-xs-left">
                          <br>
                          <h3>Indicadores do Processo</h3>
                      </v-flex>


                      <v-flex  xs6>
                          <v-text-field
                                  id="inputIndicador"
                                  label="Nome do Indicador"
                                  placeholder="Nome do Indicador"
                                  v-model="indicador.nomeIndicador"
                                  type="text"
                          ></v-text-field>
                      </v-flex>


                      <v-flex xs6>

                          <v-select v-model="indicador.responsavel"
                                    :items="usuarios"
                                    id="inputResponsavelMedicao"
                                    item-text="nome"
                                    item-value="id"
                                    return-object
                                    label="Responsável pela Medição"
                                    placeholder="Responsável pela Medição"
                          ></v-select>
                      </v-flex>

                      <v-flex  xs6>
                          <v-text-field
                                  id=""
                                  label="Forma de Medição"
                                  placeholder="Forma de Medição"
                                  v-model="indicador.medicao"
                          ></v-text-field>
                      </v-flex>

                      <v-flex xs6>

                          <v-select v-model="indicador.periodicidade"
                                    :items="periodicidades"
                                    id="inputPeriodicidade"
                                    label="Periodicidade"
                                    placeholder="Responsável pela Medição"
                          ></v-select>
                      </v-flex>


                      <v-flex xs6 text-xs-left>
                          <v-btn

                                  :disabled="!formIsValid"
                                  color="blue"
                                  text="white"
                                  type="button"
                                  v-on:click="adicionarIndicador"
                                  large
                                  outline
                          >
                              Adicionar
                          </v-btn>
                      </v-flex>


                      <div style="margin-top: -50px">
                          <v-data-table  :items="processo.indicadores" v-if="processo.indicadores.length > 0">
                              <template v-slot:items="props">
                                  <td class="text-xs-left">Indicador: {{ props.item.nomeIndicador}}</td>
                                  <td class="text-xs-left">Responsavel: {{ props.item.responsavel.nome}}</td>
                                  <td class="text-xs-left">Medição: {{ props.item.medicao}}</td>
                                  <td class="text-xs-left">Responsavel: {{ props.item.periodicidade}}</td>

                                  <td class="text-xs-center">
                                      <v-tooltip bottom>
                                          <template v-slot:activator="{ on }">
                                              <v-btn @click="editarIndicador(props.item)"
                                                     class="test" depressed outline icon fab dark v-on="on" color="primary" small>
                                                  <v-icon>edit</v-icon>

                                              </v-btn>
                                          </template>
                                          <span>Editar</span>
                                      </v-tooltip>

                                      <v-tooltip bottom>
                                          <template v-slot:activator="{ on }">
                                              <v-btn class="test"
                                                     depressed outline icon fab dark v-on="on" color="error" small
                                                     @click="removerIndicador(props.item)">

                                                  <v-icon class="material-icons">delete</v-icon>

                                              </v-btn>
                                          </template>
                                          <span>Excluir</span>
                                      </v-tooltip>
                                  </td>
                              </template>
                          </v-data-table>
                      </div>


                      <v-flex xs12 class="text-xs-left">
                          <br>
                          <h3>Cronograma de Mapeamento</h3>
                          <br>
                          <h5>Levantamento de Informações</h5>
                      </v-flex>

                      <v-flex xs12 class="text-xs-left">
                          <inputdate labeltitle="Inicio" idInput="inicioLevantamento" v-model="processo.inicioLevantamento"></inputdate>
                          <inputdate labeltitle="Término" idInput="terminoLevantamento" v-model="processo.terminoLevantamento"></inputdate>
                      </v-flex>


                      <v-flex xs12 class="text-xs-left">
                          <br>
                          <h5>Desenho do Fluxo</h5>
                      </v-flex>

                      <v-flex xs12 class="text-xs-left">
                          <inputdate labeltitle="Inicio" idInput="inicioDesenho" v-model="processo.inicioDesenho"></inputdate>
                          <inputdate labeltitle="Término" idInput="terminoDesenho" v-model="processo.terminoDesenho"></inputdate>
                      </v-flex>

                      <v-flex xs12 class="text-xs-left">
                          <br>
                          <h5>Validação do Fluxo de Processo</h5>
                      </v-flex>

                      <v-flex xs12 class="text-xs-left">
                          <inputdate labeltitle="Inicio" idInput="inicioValidacao" v-model="processo.inicioValidacao"></inputdate>
                          <inputdate labeltitle="Término" idInput="terminoValidacao" v-model="processo.terminoValidacao"></inputdate>
                      </v-flex>

                            <v-flex xs6>
                              <br><br><br>
                              <v-btn
                                      color="error"
                                      type="button"
                                      @click="limpar"
                                      large
                              >
                                  Cancelar <v-icon dark right>block</v-icon>
                              </v-btn>

                          </v-flex>

                          <v-flex xs6>
                              <br><br><br>
                              <v-btn
                                      color="success"
                                      type="submit"
                                      large
                              >
                                  Confirmar <v-icon dark right>check_circle</v-icon>
                              </v-btn>
                          </v-flex>

                  </v-layout>


               </v-container>
          </v-card>

      </v-container>

    </v-form>
  </v-app>
</div>
</template>




<script>
    import processo from "../views/ServiceProcessos";
    import inputdate from "../views/dataInput";

    export default {
        components: {
            processo,inputdate
        },
        data: function() {

            return {
                nameRules: [
                    v => !!v || '',
                ],
                atividade:'',
                periodicidades: [
                    { text: "Diaria", value:  "DIARIA" },
                    { text: "Semanal", value: "SEMANAL" },
                    { text: "Quinzenal", value: "QUINZENAL"},
                    { text: "Mensal", value: "MENSAL"},
                    { text: "Bimestral", value: "BIMESTRAL"},
                    { text: "Trimestral", value: "TRIMESTRAL"},
                    { text: "Semestral", value: "SEMESTRAL"},
                    { text: "Anual", value: "ANUAL"}
                ],
                indicador:{

                        nomeIndicador: '',

                        medicao: '',

                        periodicidade: '',

                        responsavel: '',

                },
                processo:{
                    nome:'',
                    objetivo:'',
                    descricao:'',
                    alinhamento:'',
                    fornecedores:'',
                    clientes:'',
                    entradas:'',
                    saidas:'',
                    setores:'',
                    atividades:[],
                    inicioLevantamento: new Date(),
                    terminoLevantamento: new Date(),
                    inicioDesenho: new Date(),
                    terminoDesenho: new Date(),
                    inicioValidacao: new Date(),
                    terminoValidacao: new Date(),
                    gerente:'',
                    indicadores:[],
                    tipo:'',
                    diagrama:'',
                    unidadeResponsavel:''

                },
            };

        },
        mounted: function() {},

        computed: {
            ...mapState({
                usuarios: state => state.usuarios.all,
                tipoProcesso:state => state.tipoProcesso.all
            }),

            formIsValid() {
                return this.indicador.nomeIndicador !== "" && this.indicador.medicao !== "" && this.indicador.periodicidade !== ""
                    && this.indicador.responsavel !== "";
            },
            formIsValidAlividade() {
                return this.atividade !== "";
            }

        },

        created () {
            this.$store.dispatch('usuarios/GET_ALL')
            this.$store.dispatch('tipoProcesso/GET_ALL')
        },

        methods: {
            // processFile() {
            //   this.image = this.$refs.image.files[0];
            //   // this.processo.diagrama = event.target.files[0];
            // },
             processFile() {
                this.image = this.$refs.image.files[0];

               this.processo.diagrama = event.target.files[0];
            },

            adicionarAtividade(){
                if(this.atividade.length > 0){
                    this.processo.atividades.push(this.atividade);
                    this.atividade = '';
                }
            },
            editarAtividade(item){
                this.atividade = item;
                this.removerAtividade(item);
            },
            removerAtividade(item){
                for(var i = 0; i <  this.processo.atividades.length; i++){
                    if (this.processo.atividades[i] === item) {
                        this.processo.atividades.splice(i, 1);
                    }
                }
            },
            adicionarIndicador(){
                    this.processo.indicadores.push(this.indicador);
                    this.indicador = {nomeIndicador:'',medicao:'',periodicidade:'', responsavel:''}

            },
            editarIndicador(item){
                this.indicador = item;
                this.removerIndicador(item);
            },
            removerIndicador(item){
                for(var i = 0; i <  this.processo.indicadores.length; i++){
                    if (this.processo.indicadores[i] === item) {
                        this.processo.indicadores.splice(i, 1);
                    }
                }
            },

            limpar(){
                    this.processo.nome = ''
                    this.processo.objetivo=''
                    this.processo.descricao = ''
                    this.processo.gerente=''
                    this.processo.tipo=''
                    this.processo.alinhamento = ''
                    this.processo.fornecedores = ''
                    this.processo.clientes = ''
                    this.processo.entradas = ''
                    this.processo.saidas = ''
                    this.processo.nomeIndicador = ''
                    this.processo.responsabilidades = ''
                    this.processo.mapeamentoInicio = new Date()
                    this.processo.mapeamentoTermino = new Date()
                    this.processo.reuniaoInicio = new Date()
                    this.processo.reuniaoTermino = new Date()
                    this.processo.validacaoInicio = new Date()
                    this.processo.validacaoTermino = new Date()
                    this.processo.indicadores = ''
                    this.processo.atividades = ''
                    this.processo.setores = ''
                    this.processo.unidadeResponsavel = ''
            },

            salvar() {
               processo.salvar(this.processo).then(resposta => {
                   //removido o alert
                    this.limpar();
                 }).catch(e => {
                    //removido o alert
                });
            }



        }
    };
</script>