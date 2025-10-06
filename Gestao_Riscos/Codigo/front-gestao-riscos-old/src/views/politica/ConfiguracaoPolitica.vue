<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-container grid-list-xl fluid>
    <v-layout row wrap justify-center>
      <v-flex xs12>
        <v-card-title class="headline primary white--text">
          {{flagPolitica.nome}}
          <v-spacer></v-spacer>
          <v-btn
            color="white"
            icon
            outline
            @click="$router.push('/politicas/')"
            v-on="{ ...tooltip, ...dialogFatorAvaliacao }"
          >
            <v-icon color="white">arrow_back</v-icon>
          </v-btn>
          <h5>VOLTAR</h5>
        </v-card-title>
        <div id="app">
          <v-app id="inspire">
            <v-card>
              <v-tabs centered
                      icons-and-text
                      :grow="true">
                <v-tabs-slider color="blue"></v-tabs-slider>

                <v-tab href="#tab-1">
                  MATRIZ DE RISCOS
                  <v-icon>pie_chart</v-icon>
                </v-tab>

                <v-tab href="#tab-2">
                  IMPACTOS E PROBABILIDADES
                  <v-icon>show_chart</v-icon>
                </v-tab>

                <v-tab href="#tab-3">
                  NÍVEIS DE RISCO
                  <v-icon>dns</v-icon>
                </v-tab>

                <v-tab href="#tab-4">
                  CATEGORIAS DE RISCO
                  <v-icon>category</v-icon>
                </v-tab>

                <v-tab href="#tab-5">
                  FORMAS DE TRATAMENTO DO RISCO
                  <v-icon>gavel</v-icon>
                </v-tab>

                <v-tab href="#tab-6">
                  FATORES DE AVALIAÇÃO DO RISCO
                  <v-icon>check</v-icon>
                </v-tab>

                <v-tab-item v-for="i in 6" :key="i" :value="'tab-' + i">
                  <div v-if="i == 1">
                    <v-container grid-list-md>
                      <v-layout row wrap>
                        <!-- Gerar Matriz -->
                        <v-card-text>
                          <div>
                            <div>
                              <div class="col-11 table-responsive">
                                <v-flex align-center xs12 sm6>
                                  <v-container grid-list-md text-xs-center>
                                    <div class="p-2 text-uppercase">Impacto</div>
                                  </v-container>
                                  <div>
                                    <div>
                                      <p class="text-uppercase p-2 foo">Probabilidade</p>
                                    </div>
                                    <table class="matriz">
                                      <tbody>
                                        <tr>
                                          <th></th>
                                          <th
                                            v-for="(i, indexI) in impactos"
                                            :key="indexI"
                                            scope="row"
                                          >
                                            <v-card color="white" class="dark--text" mb-2>
                                              <v-list two-line subheader>
                                                <v-list-tile avatar>
                                                  <v-list-tile-content>
                                                    <v-list-tile-title>
                                                      <b>{{i.nome}}</b>
                                                    </v-list-tile-title>
                                                    <v-list-tile-sub-title>
                                                      <b>{{i.valor}}</b>
                                                    </v-list-tile-sub-title>
                                                  </v-list-tile-content>
                                                </v-list-tile>
                                              </v-list>
                                            </v-card>
                                          </th>
                                        </tr>
                                        <tr v-for="(p, indexP) in probabilidades" :key="indexP">
                                          <th scope="row">
                                            <v-card color="white" class="dark--text" mb-2>
                                              <v-list two-line subheader>
                                                <v-list-tile avatar>
                                                  <v-list-tile-content>
                                                    <v-list-tile-title>
                                                      <b>{{p.nome}}</b>
                                                    </v-list-tile-title>
                                                    <v-list-tile-sub-title>
                                                      <b>{{p.valor}}</b>
                                                    </v-list-tile-sub-title>
                                                  </v-list-tile-content>
                                                </v-list-tile>
                                              </v-list>
                                            </v-card>
                                          </th>
                                          <td v-for="(i, indexI) in impactos" :key="indexI">
                                            <div>
                                              <v-card>
                                                <v-list two-line subheader>
                                                  <v-list-tile
                                                    avatar
                                                    v-bind:style="{backgroundColor: pegarNivelRisco(p, i).cor}"
                                                    class="white--text"
                                                  >
                                                    <v-list-tile-content>
                                                      <v-list-tile-title
                                                        class="white--text"
                                                      >{{ pegarNivelRisco(p, i).nome }}</v-list-tile-title>
                                                      <v-list-tile-sub-title
                                                        class="white--text"
                                                      >{{ p.valor * i.valor }}</v-list-tile-sub-title>
                                                    </v-list-tile-content>
                                                  </v-list-tile>
                                                </v-list>
                                              </v-card>
                                            </div>
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </div>
                                </v-flex>
                              </div>
                            </div>
                          </div>
                        </v-card-text>
                      </v-layout>
                    </v-container>
                  </div>

                  <div v-if="i == 2">
                    <v-container grid-list-xl fluid>
                      <v-layout row wrap>
                        <!-- Impactos -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>IMPACTO</b>
                              <div>
                                <v-layout>
                                  <v-flex>
                                    <v-text-field
                                      v-model="impacto.nome"
                                      label="Nome do Impacto*"
                                      flat
                                      :rules="rules.impacto.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm2>
                                    <v-text-field
                                      v-model="impacto.valor"
                                      label="Valor*"
                                      flat
                                      type="number"
                                      :rules="rules.impacto.valor"
                                      required
                                      
                                    ></v-text-field>
                                  </v-flex>
                                  <!-- Salvar inputs de impactos -->
                                </v-layout>
                                <v-layout>
                                  <v-flex xs12 sm12>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="impacto.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formImpactoIsValid"
                                      @click="salvarImpacto(impacto.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersImpacto"
                                :items="impactos"
                                hide-actions
                                disable-initial-sort
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td class="justify-center">{{ props.item.valor }}</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de impactos -->
                                     <!-- <v-dialog  v-model="dialogImpacto" persistent max-width="300">
                                        <template #activator="{ on: dialogImpacto }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn  class="test" depressed outline icon fab dark color="red" small v-on="{ ...tooltip, ...dialog }"
                                                      @click="impactosGet(props.item.id)"><v-icon>delete</v-icon></v-btn>
                                            </template>
                                            <span>Remover</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Impacto</v-card-title>
                                          <v-card-text>Deseja realmente excluir este Processo?</v-card-text>
                                          <v-card-actions >
                                            <v-spacer></v-spacer>
                                            <v-btn color="error"  small v-on:click="deletarDadosImpactos(impactos, flagImpacto.id)"
                                                   @click="dialogImpacto = false">Excluir</v-btn>
                                            <v-btn color="disabled" small @click="dialogImpacto = false">Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>-->

                                      <v-dialog v-model="dialogImpacto" persistent max-width="290">
                                        <template #activator="{ on: dialogImpacto }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="impactosGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogImpacto }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Impacto</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Impacto</v-card-title>
                                          <v-card-text>Deseja realmente excluir este Impacto?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosImpactos(impactos, flagImpacto.id)"
                                                    @click="dialogImpacto = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                              color="disabled"  small
                                              @click="dialogImpacto = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                        <!-- Probabilidades -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>PROBABILIDADE</b>
                              <div>
                                <v-layout>
                                  <v-flex>
                                    <v-text-field
                                      v-model="probabilidade.nome"
                                      label="Nome da Probabilidade*"
                                      flat
                                      :rules="rules.probabilidade.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm2>
                                    <v-text-field
                                      v-model="probabilidade.valor"
                                      label="Valor*"
                                      flat
                                      type="number"
                                      
                                      :rules="rules.probabilidade.valor"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <!-- Salvar inputs de probabilidades -->
                                </v-layout>
                                <v-layout>
                                  <v-flex xs12 sm12>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="probabilidade.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formProbabilidadeIsValid"
                                      @click="salvarProbabilidade(probabilidade.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersProbabilidade"
                                :items="probabilidades"
                                disable-initial-sort
                                hide-actions
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td class="justify-center">{{ props.item.valor }}</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de probabilidades -->
                                      <v-dialog
                                        v-model="dialogProbabilidade"
                                        persistent
                                        max-width="290"
                                      >
                                        <template #activator="{ on: dialogProbabilidade }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="probabilidadesGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogProbabilidade }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Probabilidade</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Probabilidade</v-card-title>
                                          <v-card-text>Deseja realmente excluir esta Probabilidade?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosProbabilidades(probabilidades, flagProbabilidade.id)"
                                                    @click="dialogProbabilidade = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                                    color="disabled"  small
                                                    @click="dialogProbabilidade = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </div>

                  <div v-if="i == 3">
                    <v-container grid-list-xl fluid>
                      <v-layout row wrap>
                        <!-- Níveis de Risco -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>NÍVEL DE RISCO</b>
                              <div>
                                <v-layout>
                                  <v-flex xs12 sm8>
                                    <v-text-field
                                      v-model="nivelRisco.nome"
                                      label="Nome do Nível*"
                                      flat
                                      :rules="rules.niveisRisco.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm2>
                                    <v-text-field
                                      v-model.number="nivelRisco.valorInicial"
                                      label="Valor Inicial*"
                                      flat
                                      type="number"
                                      :rules="rules.niveisRisco.valorInicial"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm2>
                                    <v-text-field
                                      v-model.number="nivelRisco.valorFinal"
                                      label="Valor Final*"
                                      flat
                                      type="number"
                                      :rules="rules.niveisRisco.valorFinal"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-card-actions>
                                    <div class="form__label">
                                      <span class="demonstration">Escolha uma cor:</span>
                                    </div>
                                    <div class="form__input">
                                      <swatches
                                        v-model="nivelRisco.cor"
                                        colors="text-advanced"
                                        popover-to="left"
                                        borderRadius
                                      ></swatches>
                                    </div>
                                  </v-card-actions>
                                </v-layout>
                                <v-layout>
                                  <v-flex xs12 sm12>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="nivelRisco.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formNivelRiscoIsValid"
                                      @click="salvarNivelRisco(nivelRisco.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersNívelRisco"
                                :items="niveisRisco"
                                hide-actions
                                disable-initial-sort
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td class="justify-center">
                                      <v-flex xs12 sm4>
                                        <div class="form__input">
                                          <swatches
                                            v-model="props.item.cor"
                                            colors="text-advanced"
                                            popover-to="left"
                                            borderRadius
                                          ></swatches>
                                        </div>
                                      </v-flex>
                                    </td>
                                    <td class="justify-center">{{ props.item.valorInicial }}</td>
                                    <td class="justify-center">{{ props.item.valorFinal }}</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de níveis de risco -->
                                      <v-dialog
                                        v-model="dialogNivelRisco"
                                        persistent
                                        max-width="290"
                                      >
                                        <template #activator="{ on: dialogNivelRisco }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="niveisRiscoGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogNivelRisco }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Nível de Risco</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Nível de Risco</v-card-title>
                                          <v-card-text>Deseja realmente excluir este Nível de Risco?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosNiveisRisco(niveisRisco, flagNivelRisco.id)"
                                                    @click="dialogNivelRisco = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                                    color="disabled"  small
                                                    @click="dialogNivelRisco = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </div>

                  <div v-if="i == 4">
                    <v-container grid-list-xl fluid>
                      <v-layout row wrap>
                        <!-- Categorias -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>CATEGORIAS DE RISCO</b>
                              <div>
                                <v-layout>
                                  <v-flex>
                                    <v-text-field
                                      v-model="categoria.nome"
                                      label="Nome da Categoria*"
                                      flat
                                      :rules="rules.categoria.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                </v-layout>
                                <v-layout>
                                    <v-flex xs12 sm12>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="categoria.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formCategoriaIsValid"
                                      @click="salvarCategoriaRisco(categoria.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersCategoria"
                                :items="categoriasRisco"
                                hide-actions
                                disable-initial-sort
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de categorias -->
                                      <v-dialog
                                        v-model="dialogCategoria"
                                        persistent
                                        max-width="290"
                                      >
                                        <template #activator="{ on: dialogCategoria }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="categoriasRiscoGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogCategoria }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Categoria</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Categoria</v-card-title>
                                          <v-card-text>Deseja realmente excluir esta Categoria?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosCategorias(categoriasRisco, flagCategoria.id)"
                                                    @click="dialogNivelRisco = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                                    color="disabled"  small
                                                    @click="dialogCategoria = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </div>

                  <div v-if="i === 5">
                    <v-container grid-list-xl fluid>
                      <v-layout row wrap>
                        <!-- Forma de Tratamento -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>FORMAS DE TRATAMENTO</b>
                              <div>
                                <v-layout>
                                  <v-flex>
                                    <v-text-field
                                      v-model="tratamentoRisco.nome"
                                      label="Nome do Tratamento*"
                                      flat
                                      xs12 sm6
                                      :rules="rules.tratamentoRisco.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm4>
                                    <v-checkbox
                                      v-model="tratamentoRisco.planoAcao"
                                      :label="`Existe plano de ação para o risco.`"
                                    ></v-checkbox>
                                  </v-flex>
                                  <!-- Salvar inputs de formas de tratamento -->
                                </v-layout>
                                <v-layout>
                                  <v-flex xs12 sm12>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="tratamentoRisco.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                 <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formFormaTratamentoIsValid"
                                      @click="salvarTratamentoRisco(tratamentoRisco.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersTratamentoRisco"
                                :items="tratamentosRisco"
                                hide-actions
                                disable-initial-sort
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td
                                      v-if="props.item.planoAcao==true"
                                      class="justify-center"
                                    >Existe</td>
                                    <td
                                      v-if="props.item.planoAcao==false"
                                      class="justify-center"
                                    >Não Existe</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de impactos -->
                                      <v-dialog
                                        v-model="dialogFormaTratamento"
                                        persistent
                                        max-width="290"
                                      >
                                        <template #activator="{ on: dialogFormaTratamento }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="tratamentosRiscoGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogFormaTratamento }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Forma de Tratamento</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Forma de Tratamento</v-card-title>
                                          <v-card-text>Deseja realmente excluir esta Forma de Tratamento?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosTratamentosRisco(tratamentosRisco, flagTratamentoRisco.id)"
                                                    @click="dialogFormaTratamento = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                                    color="disabled"  small
                                                    @click="dialogFormaTratamento = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </div>

                  <div v-if="i === 6">
                    <v-container grid-list-xl fluid>
                      <v-layout row wrap>
                        <!-- Fatores de Avaliação -->
                        <v-flex xs12>
                          <v-card>
                            <v-card-text>
                              <b>FATORES DE AVALIAÇÃO</b>
                              <!-- Criar inputs de fatores de avaliação -->
                              <div>
                                <v-layout>
                                  <v-flex>
                                    <v-text-field
                                      v-model="fatorAvaliacao.nome"
                                      label="Nome do Fator*"
                                      flat
                                      :rules="rules.fatorAvaliacao.nome"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <v-flex xs12 sm2>
                                    <v-text-field
                                      v-model="fatorAvaliacao.valor"
                                      label="Valor*"
                                      flat
                                      type="number"
                                      :rules="rules.fatorAvaliacao.valor"
                                      required
                                    ></v-text-field>
                                  </v-flex>
                                  <!-- Salvar inputs de fatores de avaliação -->
                                </v-layout>
                                <v-layout>
                                   <v-flex>
                                    <v-textarea
                                      auto-grow
                                      rows="1"
                                      v-model="fatorAvaliacao.descricao"
                                      label="Descrição"
                                      flat
                                    ></v-textarea>
                                  </v-flex>
                                </v-layout>
                              </div>
                              <small>*Campos obrigatórios</small>
                              <v-layout>
                                <v-spacer></v-spacer>
                                 <v-card-actions>
                                    <v-btn
                                      color="primary"
                                      outline
                                      v-on="{ ...tooltip }"
                                      :disabled="!formFatorAvaliacaoIsValid"
                                      @click="salvarFatorAvaliacao(fatorAvaliacao.id)"
                                    >SALVAR</v-btn>
                                  </v-card-actions>
                              </v-layout>
                            </v-card-text>
                            <v-card-text>
                              <v-data-table
                                :headers="headersFatorAvaliacao"
                                :items="fatoresAvaliacaoControle"
                                hide-actions
                                disable-initial-sort
                                no-data-text="Nenhum resultado encontrado"
                                no-results-text="Nenhum resultado encontrado"
                              >
                                <template v-slot:items="props">
                                  <tr @click="props.expanded = !props.expanded">
                                    <td class="justify-center">{{ props.item.nome }}</td>
                                    <td class="justify-center">{{ props.item.descricao }}</td>
                                    <td class="justify-center">{{ props.item.valor }}</td>
                                    <td class="justify-center layout px-0">
                                      <!-- Deletar inputs de impactos -->
                                      <v-dialog
                                        v-model="dialogFatorAvaliacao"
                                        persistent
                                        max-width="290"
                                      >
                                        <template #activator="{ on: dialogFatorAvaliacao }">
                                          <v-tooltip bottom>
                                            <template #activator="{ on: tooltip }">
                                              <v-btn
                                                depressed
                                                outline
                                                icon
                                                fab
                                                dark
                                                color="red"
                                                small
                                                @click="fatoresAvaliacaoGet(props.item.id)"
                                                v-on="{ ...tooltip, ...dialogFatorAvaliacao }"
                                              >
                                                <v-icon>delete</v-icon>
                                              </v-btn>
                                            </template>
                                            <span>Deletar Fator de Avaliação</span>
                                          </v-tooltip>
                                        </template>
                                        <v-card>
                                          <v-card-title class="headline">Excluir Fator de Avaliação</v-card-title>
                                          <v-card-text>Deseja realmente excluir esta Fator de Avaliação?</v-card-text>
                                          <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn
                                                    color="error" small
                                                    v-on:click="deletarDadosFatoresAvaliacao(fatoresAvaliacaoControle, flagFatorAvaliacao.id)"
                                                    @click="dialogFatorAvaliacao = false"
                                            >Excluir</v-btn>
                                            <v-btn
                                                    color="disabled"  small
                                                    @click="dialogFatorAvaliacao = false"
                                            >Cancelar</v-btn>
                                          </v-card-actions>
                                        </v-card>
                                      </v-dialog>
                                    </td>
                                  </tr>
                                </template>
                              </v-data-table>
                            </v-card-text>
                          </v-card>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </div>
                </v-tab-item>
              </v-tabs>
            </v-card>
          </v-app>
        </div>
      </v-flex>
    </v-layout>
    <v-snackbar :timeout="timeout" right top :color="cor" v-model="snackbar">{{ mensagem }}</v-snackbar>
  </v-container>
</template>

<script>
import axios from "axios";
import Swatches from "vue-swatches";
import "vue-swatches/dist/vue-swatches.min.css";

export default {
  components: { Swatches },
  data() {
    return {
      contador: 0,
      tooltip: "",
      dialogImpacto: false,
      dialogProbabilidade: false,
      dialogNivelRisco: false,
      dialogCategoria: false,
      dialogFormaTratamento: false,
      dialogFatorAvaliacao: false,
      mostrar: false,
      linhas: 1,
      colunas: 1,
      politicaId: "",
      impactos: [],
      probabilidades: [],
      niveisRisco: [],
      tratamentosRisco: [],
      categoriasRisco: [],
      fatoresAvaliacaoControle: [],
      matrizPolitica: {
        probabilidades: [],
        impactos: [],
        matriz: []
      },
      matrizes: [],
      y: "",
      impacto: { nome: "", descricao: "", valor: "" },
      probabilidade: { nome: "", descricao: "", valor: "" },
      nivelRisco: {
        nome: "",
        descricao: "",
        cor: "#409EFF",
        valorInicial: '',
        valorFinal: ''
      },
      categoria: { nome: "", descricao: "" },
      fatorAvaliacao: { nome: "", descricao: "", valor: "" },
      tratamentoRisco: { nome: "", descricao: "", planoAcao: false },
      dados: [],
      headersImpacto: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "Valor", value: "valor" },
        { text: "", value: "acoes" }
      ],
      headersProbabilidade: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "Valor", value: "valor" },
        { text: "", value: "acoes" }
      ],
      headersNívelRisco: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "Cor", value: "cor" },
        { text: "Valor Inicial", value: "valorInicial" },
        { text: "Valor Final", value: "valorFinal" },
        { text: "", value: "acoes" }
      ],
      headersCategoria: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "", value: "acoes" }
      ],
      headersFatorAvaliacao: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "Valor", value: "valor" },
        { text: "", value: "acoes" }
      ],
      headersTratamentoRisco: [
        { text: "Nome", value: "nome" },
        { text: "Descrição", value: "descricao" },
        { text: "Plano Ação", value: "planoAcao" },
        { text: "", value: "acoes" }
      ],
      flagPolitica: "",
      flagImpacto: "",
      flagProbabilidade: "",
      flagNivelRisco: "",
      flagCategoria: "",
      flagFatorAvaliacao: "",
      flagTratamentoRisco: "",
      mensagem: "",
      cor: "",
      snackbar: false,
      timeout: 3500,
      rules: {
        impacto: {
          nome: [v => !!v || 'Nome do Impacto é um campo obrigatório'],
          valor: [v => !!v || 'Nome do Impacto é um campo obrigatório'],
        },
        probabilidade: {
          nome: [v => !!v || 'Nome da Probabilidade é um campo obrigatório'],
          valor: [v => !!v || 'Nome da Probabilidade é um campo obrigatório'],
        },
        niveisRisco: {
          nome: [v => !!v || 'Nome do Nível é um campo obrigatório'],
          valorInicial: [v => !!v || 'Valor inicial do Nível é um campo obrigatório'],
          valorFinal: [v => !!v || 'Valor final do Nível é um campo obrigatório'],
        },
        categoria: {
          nome: [v => !!v || 'Nome da Categoria é um campo obrigatório'],
        },
        tratamentoRisco: {
          nome: [v => !!v || 'Nome do Tratamento é um campo obrigatório'],
        },
        fatorAvaliacao: {
          nome: [v => !!v || 'Nome da Fator é um campo obrigatório'],
          valor: [v => !!v || 'Nome da fator é um campo obrigatório'],
        }

      },
    };
  },

  computed: {
    formImpactoIsValid() {
      return (
        this.impacto.nome !== "" && this.impacto.valor !== ""
      );
    },
    formProbabilidadeIsValid() {
      return (
        this.probabilidade.nome !== "" && this.probabilidade.valor !== ""
      );
    },
    formNivelRiscoIsValid() {
      return (
        this.nivelRisco.nome !== "" &&
        this.nivelRisco.valorInicial !== "" &&
        this.nivelRisco.valorFinal !== ""
      );
    },
    formCategoriaIsValid() {
      return this.categoria.nome;
    },
    formFormaTratamentoIsValid() {
      return (
        this.tratamentoRisco.nome !== ""
      );
    },
    formFatorAvaliacaoIsValid() {
      return (
        this.fatorAvaliacao.nome !== "" && this.fatorAvaliacao.valor !== ""
      );
    },
    formIsValid() {
      return this.y.impactos <= 0;
    }
  },
  mounted() {
    this.politicaId = this.$route.params.id;
    this.listarConfiguracoes();
    this.politicasGet();
    this.mostrar = true;
  },
  methods: {
    criarInput(list, object) {
      list.push(object);
      this.politicaModificada = false;
      if (list == this.impactos) {
        this.colunas++;
      } else if (list == this.probabilidades) {
        this.linhas++;
      }
    },

    pegarNivelRisco(p, i) {
      const riscoInerente = p.valor * i.valor;
      let nivel;
      if (
        this.niveisRisco.find(
          nivelRisco =>
            riscoInerente >= nivelRisco.valorInicial &&
            riscoInerente <= nivelRisco.valorFinal
        )
      ) {
        nivel = this.niveisRisco.find(
          nivelRisco =>
            riscoInerente >= nivelRisco.valorInicial &&
            riscoInerente <= nivelRisco.valorFinal
        );
        return nivel;
      } else {
        return this.niveisRisco;
      }
    },

    //Dados Get

    politicasGet(){
      axios.get("/politicas/" + this.politicaId).then(res => {
        this.flagPolitica = res.data;
      });
    },

    impactosGet(id) {
      console.log(id);
      axios.get("/impactos/" + id).then(res => {
        this.flagImpacto = res.data;
      });
    },
    probabilidadesGet(id) {
      console.log(id);
      axios.get("/probabilidades/" + id).then(res => {
        this.flagProbabilidade = res.data;
      });
    },
    niveisRiscoGet(id) {
      console.log(id);
      axios.get("/niveisRisco/" + id).then(res => {
        this.flagNivelRisco = res.data;
      });
    },
    categoriasRiscoGet(id) {
      console.log(id);
      axios.get("/categoriasRisco/" + id).then(res => {
        this.flagCategoria = res.data;
      });
    },
    tratamentosRiscoGet(id) {
      console.log(id);
      axios.get("/tratamentosRisco/" + id).then(res => {
        this.flagTratamentoRisco = res.data;
      });
    },
    fatoresAvaliacaoGet(id) {
      console.log(id);
      axios.get("/fatoresAvaliacao/" + id).then(res => {
        this.flagFatorAvaliacao = res.data;
      });
    },

    //Listar Configurações

    listarConfiguracoes() {
      axios
        .get("/impactos/listar/" + this.politicaId)
        .then(res => {
          this.impactos = res.data;
        })
        .catch(error => console.log(error));

      axios
        .get("/probabilidades/listar/" + this.politicaId)
        .then(res => {
          this.probabilidades = res.data;
        })
        .catch(error => console.log(error));

      axios
        .get("/niveisRisco/listar/" + this.politicaId)
        .then(res => {
          this.niveisRisco = res.data;
        })
        .catch(error => console.log(error));

      axios
        .get("/tratamentosRisco/listar/" + this.politicaId)
        .then(res => {
          this.tratamentosRisco = res.data;
        })
        .catch(error => console.log(error));

      axios
        .get("/categoriasRisco/listar/" + this.politicaId)
          .then(res => {
          this.categoriasRisco = res.data;
        })
        .catch(error => console.log(error));

      axios
        .get("/fatoresAvaliacao/listar/" + this.politicaId)
        .then(res => {
          this.fatoresAvaliacaoControle = res.data;
        })
        .catch(error => console.log(error));
    },

    //Salvar Configurações

    salvarImpacto(id) {
      axios
        .post("/impactos/add/" + this.politicaId, this.impacto)
        .then(res => {
          this.impacto.nome = "";
          this.impacto.descricao = "";
          this.impacto.valor = "";
          this.formImpactoIsValid;
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Impacto cadastrado com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Impacto!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    salvarProbabilidade() {
      axios
        .post("/probabilidades/add/" + this.politicaId, this.probabilidade)
        .then(res => {
          this.probabilidade.nome = "";
          this.probabilidade.descricao = "";
          this.probabilidade.valor = "";

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Probabilidade cadastrada com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Probabilidade!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    salvarNivelRisco() {
      var inicial = this.nivelRisco.valorInicial;
      var final = this.nivelRisco.valorFinal;


      if(inicial <= final) {

            const nivelRisco = {
              nome: this.nivelRisco.nome,
              descricao: this.nivelRisco.descricao,
              cor: this.nivelRisco.cor,
              valorInicial: this.nivelRisco.valorInicial,
              valorFinal: this.nivelRisco.valorFinal
            };

            var cont = 0;
            var fim;
            var inicio;
            //FOR VERIFICA SE OS VALORES NÃO PERTENCEM AOS INTERVALOS
            for(var i = 0; i < this.niveisRisco.length; i++){
                    inicio = this.niveisRisco[i].valorInicial;
                    fim = this.niveisRisco[i].valorFinal;

                    if(!((inicio <= nivelRisco.valorInicial && nivelRisco.valorInicial <= fim)
                            || (inicio <= nivelRisco.valorFinal && nivelRisco.valorFinal <= fim))){
                          cont = cont +1;
                    }
            }

            if(cont == this.niveisRisco.length){
                axios
                      .post("/niveisRisco/add/" + this.politicaId, nivelRisco)
                      .then(res => {
                        this.nivelRisco.nome = "";
                        this.nivelRisco.descricao = "";
                        this.nivelRisco.cor = "#409EFF";
                        this.nivelRisco.valorInicial = "";
                        this.nivelRisco.valorFinal = "";

                        this.cor = "success";
                        this.snackbar = true;
                        this.mensagem = "Nível do Risco cadastrado com sucesso!";
                        this.listarConfiguracoes();
                      })
                      .catch(e => {
                        this.mensagem = "Erro ao cadastrar Nível do Risco!";
                        this.cor = "error";
                        this.snackbar = true;
                      });

            }

            else {
              this.mensagem = "Intervalo já definido!";
              this.cor = "error";
              this.snackbar = true;

              this.$emit('event-new-snackbar', this.snackbar);
              this.$emit('event-new-mensagem', this.mensagem);
              this.$emit('event-new-cor', this.cor);
            }

      }

      else{
        this.mensagem = "O valor inicial não pode ser maior que o valor final!";
        this.cor = "error";
        this.snackbar = true;
        this.$emit('event-new-snackbar', this.snackbar);
        this.$emit('event-new-mensagem', this.mensagem);
        this.$emit('event-new-cor', this.cor);
      }

    },

    salvarTratamentoRisco() {
      axios
        .post("/tratamentosRisco/add/" + this.politicaId, this.tratamentoRisco)
        .then(res => {
          this.tratamentoRisco.nome = "";
          this.tratamentoRisco.descricao = "";
          this.tratamentoRisco.planoAcao = false;

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Forma de Tratamento cadastrada com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Forma de Tratamento!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    salvarCategoriaRisco() {
      axios
        .post("/categoriasRisco/add/" + this.politicaId, this.categoria)
        .then(res => {
          this.categoria.nome = "";
          this.categoria.descricao = "";

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Categoria cadastrada com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Categoria!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    salvarFatorAvaliacao() {
      axios
        .post("/fatoresAvaliacao/add/" + this.politicaId, this.fatorAvaliacao)
        .then(res => {
          this.fatorAvaliacao.nome = "";
          this.fatorAvaliacao.descricao = "";
          this.fatorAvaliacao.valor = "";

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Fator de Avaliação cadastrado com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao cadastrar Fator de Avaliação!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    //Deletar Configurações

    deletarDadosImpactos(list, id) {
      axios
        .delete("/impactos/" + id)
        .then(res => {
          list.splice(id, 1);
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Impacto excluído com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Impacto!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    deletarDadosProbabilidades(list, id) {
      axios
        .delete("/probabilidades/" + id)
        .then(res => {
          list.splice(id, 1);
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Probabilidade excluída com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Probabilidade!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    deletarDadosNiveisRisco(list, id) {
      axios
        .delete("/niveisRisco/" + id)
        .then(res => {
          list.splice(id, 1);

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Nível do Risco excluído com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Nível do Risco!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    deletarDadosCategorias(list, id) {
      axios
        .delete("/categoriasRisco/" + id)
        .then(res => {
          list.splice(id, 1);

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Categoria excluída com sucesso!";
          this.listarConfiguracoes();
          this.dialogCategoria =false;
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Categoria!";
          this.cor = "error";
          this.snackbar = true;
          this.dialogCategoria =false;

        });
    },

    deletarDadosFatoresAvaliacao(list, id) {
      axios
        .delete("/fatoresAvaliacao/" + id)
        .then(res => {
          list.splice(id, 1);

          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Fator de Avaliação excluído com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Fator de Avaliação!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    deletarDadosTratamentosRisco(list, id) {
      axios
        .delete("/tratamentosRisco/" + id)
        .then(res => {
          list.splice(id, 1);
          this.cor = "success";
          this.snackbar = true;
          this.mensagem = "Forma de Tratamento excluída com sucesso!";
          this.listarConfiguracoes();
        })
        .catch(e => {
          this.mensagem = "Erro ao excluir Forma de Tratamento!";
          this.cor = "error";
          this.snackbar = true;
        });
    },

    mostrarMatriz() {
      for (let i = 0; i < this.linhas; i++) {
        this.matrizPolitica.probabilidades.push({});
      }

      for (let i = 0; i < this.colunas; i++) {
        this.matrizPolitica.impactos.push({});
      }

      for (let i = 0; i < this.linhas; i++) {
        this.matrizPolitica.matriz.push([]);
        for (let j = 0; j < this.colunas; j++) {
          this.matrizPolitica.matriz[i].push({});
        }
      }
    }
  }
};
</script>

<style>
.foo {
  writing-mode: vertical-rl;
}
p {
  margin-top: 150px;
  margin-bottom: 100px;
  margin-right: 150px;
  margin-left: -50px;
}
table.matriz {
  margin-top: -350px;
  margin-bottom: 100px;
  margin-right: 150px;
  margin-left: 0px;
}
</style>
