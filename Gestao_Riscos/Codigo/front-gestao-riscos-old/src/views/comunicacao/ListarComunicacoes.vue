<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container grid-list-xl fluid>
        <v-layout row wrap>
            <v-flex xs12>
                <v-card>
                    <v-card-title class="headline primary white--text">Comunicações</v-card-title>
                    <div id="app">
     <!-- <v-app id="inspire"> -->
        <v-card>
        <v-card-text>
        <v-card>

            <v-toolbar card color="white">
          <v-text-field flat solo prepend-icon="search" placeholder="Buscar" v-model="search" hide-details class="hidden-sm-and-down"></v-text-field>
        </v-toolbar>
        <v-data-table
        :search="search"
        :headers="headers"
        :items="desserts"
        :expand="expand"
        no-data-text="Nenhum resultado encontrado"
        no-results-text="Nenhum resultado encontrado">
          <template v-slot:items="props">
            <tr @click="props.expanded = !props.expanded">
              <td class="justify-center">{{ props.item.nomeRisco }}</td>
              <td class="justify-center">{{ props.item.parteInteressada }}</td>
              <td class="justify-center">{{ props.item.comunicador }}</td>
              <td class="justify-center">{{ props.item.proposito }}</td>
              <td class="justify-center">{{ props.item.metodoComunicacao }}</td>
              <td class="justify-center">{{ props.item.dataComunicacao}}</td>
              <td class="justify-center">{{ props.item.frequencia}}</td>
              <td class="justify-center">{{ props.item.status}}</td>
            <td class="justify-center layout px-0">
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-btn
                    class="test" depressed outline icon fab dark v-on="on" color="primary" small>
                    <v-icon>edit</v-icon>
                  </v-btn>
                </template>
                <span>Editar</span>
              </v-tooltip>
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
                        <v-card-title class="headline">Excluir Comunicação</v-card-title>
                        <v-card-text>Deseja realmente excluir esta Comunicação?</v-card-text>
                        <v-card-actions >
                            <v-spacer></v-spacer>
                            <v-btn color="error"  small @click="dialog = false">Excluir</v-btn>
                            <v-btn color="disabled" small @click="dialog = false">Cancelar</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
                <v-dialog  v-model="tei" persistent max-width="1500">
                    <template #activator="{ on: tei }">
                        <v-tooltip bottom>
                            <template #activator="{ on: tooltip }">
                                <v-btn class="test" depressed outline icon fab dark color="orange" small v-on="{ ...tooltip, ...tei }"><v-icon>storage</v-icon></v-btn>
                            </template>
                            <span>Detalhes</span>
                        </v-tooltip>
                    </template>
                    <v-card flat class="pa-5" >
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn
                                    color="primary"
                                    flat
                                    @click="tei = false"
                            >
                                Sair
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </td>
            </tr>
          </template>
        </v-data-table>
        </v-card>
     <!-- </v-app>-->
        </v-card-text>
        </v-card>
    </div>
    </v-card>
    </v-flex>
        <v-card-text style="height: 100px; position: relative">
            <v-fab-transition>
              <v-btn
                v-show="!hidden"
                color="primary"
                dark
                absolute
                top
                right
                fab
              >
                <v-icon>add</v-icon>
              </v-btn>
            </v-fab-transition>
    </v-card-text>
    </v-layout>
  </v-container>
</template>

<script>


export default {
      components: {

    },
  data() {
    return {
      search: '',
      expand: false,
      headers: [
        { text: 'Riscos', value: 'nomeRisco' },
        { text: 'Parte Interessada', value: 'parteInteressada' },
        { text: 'Comunicador', value: 'comunicador' },
        { text: 'Próposito', value: 'proposito' },
        { text: 'Método de Comunicação', value: 'metodoComunicacao' },
        { text: 'Data da Comunicação', value: 'dataComunicacao' },
        { text: 'Frequência', value: 'frequência' },
        { text: 'Status', value: 'status' }             
        ],
      desserts: [
        {
          nomeRisco: 'Ausência de infraestrutura e equipamentos necessários para a realização do curso',
          parteInteressada: 'CODEC',
          comunicador: 'João Pedro',
          proposito:'Informar',
          metodoComunicacao:'Memorando',
          dataComunicacao: '15/03/2017',
          frequencia:'Mensal',
          status: 'Não Analisada'
        },
        {
          nomeRisco: 'Ausência de infraestrutura',
          parteInteressada: 'Pró-Reitorias',
          comunicador: 'Gleydson Pinto',
          proposito:'Consultar',
          metodoComunicacao:'E-mail',
          dataComunicacao: '20/03/2017',
          frequencia:'Esporádica',
          status: 'Não Analisada'
        }
      ],  
      dialog: false,
      tei: false,
      hidden: false
    }
  }
}
</script>

<style scoped>

</style>
