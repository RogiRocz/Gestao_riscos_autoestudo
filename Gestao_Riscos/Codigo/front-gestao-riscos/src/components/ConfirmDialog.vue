<template>
    <v-dialog v-model="dialogVisible" persistent max-width="370">
      <v-card>
        <v-card-title class="headline">{{titulo}}</v-card-title>
        <v-card-text>{{descricao}}</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text :color="info ? 'success' : 'error'" @click="confirmAction()">Sim</v-btn>
          <v-btn text @click="toogleVisible()">Cancelar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
export default {
  name: 'confirm-dialog',
  props:{
    dialogVisible: Boolean,
    confirmAction: Function,
    toogleVisible: Function,
    titulo: {
      type: String,
      default: 'Excluir'
    },
    descricao: String,
    info: {
      type: Boolean,
      required: false,
      default: false
    },
  }
}
</script>
