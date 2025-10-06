<template>
  <v-navigation-drawer app dark color="primary" permanent mini-variant>
    <v-list dense nav class="py-0">
      <v-list-item>
        <v-list-item-avatar>
          <img src="/static/logo.png">
        </v-list-item-avatar>
        <!--<v-list-item-content>
          <v-list-item-title class="text-uppercase">
            <span class="font-weight-light text-h5">Riscos</span>
            <span class="text-h5">UFC</span>
          </v-list-item-title>
        </v-list-item-content>-->
      </v-list-item>

      <v-divider></v-divider>

      <v-list-item v-for="item in items" :key="item.title" link :to="item.url" class="py-1">
        <v-list-item-content>
          <v-tooltip right>
            <template v-slot:activator="{ on, attrs }">
              <v-icon v-bind="attrs" v-on="on">{{ item.icon }}</v-icon>
            </template>
            <span>{{item.title}}</span>
          </v-tooltip>
        </v-list-item-content>
      </v-list-item>
      <v-list-item class="py-1" @click.stop="logout">
        <v-list-item-content>
          <v-icon>logout</v-icon>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <!--<template v-slot:append>
      <div class="text-center">
        <img src="/static/brasao-ufc.png">
      </div>
    </template>-->
  </v-navigation-drawer>
</template>
<script>

export default {

  data() {
    return {
      items: [
        { title: 'Painel de Bordo', url: '/', icon: 'home' },
        { title: 'Planos', url: '/planos', icon: 'calendar_today' },
        { title: 'Ações', url: '/acoes', icon: 'list_alt' },
        { title: 'Eventos de Risco', url: '/riscos', icon: 'feedback' },
        { title: 'Comunicação', url: '/comunicacao', icon: 'campaign' },
        { title: 'Relatórios', url: '/relatorios', icon: 'assessment' }
      ]
    }
  },

  methods: {
    logout() {
      this.$store.dispatch('logout')
    }
  }
}
</script>
