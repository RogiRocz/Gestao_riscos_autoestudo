<template>
    <div id="appToolbar">

        <v-toolbar color="primary" fixed dark app>
            <img id="logo" src="/static/brasao-ufc.png" alt="Logo NPI">
            <v-toolbar-items class="ml-3">
                <v-btn flat :to="{name: 'Dashboard'}">Painel de Bordo</v-btn>
                <v-btn flat :to="{name: 'ListarPoliticas'}">Política de Riscos</v-btn>
                <v-btn flat :to="{name: 'ListarRiscos'}">Riscos</v-btn>
                <v-btn flat :to="{name: 'ListarProcessos'}">Processos</v-btn>
                <v-btn flat :to="{name: 'ListarComunicacoes'}">Comunicação</v-btn>
                <v-btn flat>Relatórios</v-btn>
            </v-toolbar-items>

            <v-spacer></v-spacer>

            <v-toolbar-title><h5>Olá, {{nome}}</h5></v-toolbar-title>
            <v-btn icon>
                <v-icon>notifications</v-icon>
            </v-btn>


            <v-menu offset-y origin="center center" :nudge-bottom="10" transition="scale-transition">
                <v-btn icon large flat slot="activator">
                    <v-avatar size="30px">
                        <v-icon>account_circle</v-icon>
                    </v-avatar>
                </v-btn>
                <v-list class="pa-0">
                    <v-list-tile @click="">
                        <v-list-tile-action>
                            <v-icon>face</v-icon>
                        </v-list-tile-action>
                        <v-list-tile-content>
                            <v-list-tile-title>Perfil</v-list-tile-title>
                        </v-list-tile-content>
                    </v-list-tile>
                    <v-list-tile @click="logout">
                        <v-list-tile-action>
                            <v-icon>power_settings_new</v-icon>
                        </v-list-tile-action>
                        <v-list-tile-content>
                            <v-list-tile-title>Sair</v-list-tile-title>
                        </v-list-tile-content>
                    </v-list-tile>
                </v-list>
            </v-menu>
        </v-toolbar>
    </div>
</template>


<script>
    import axios from "axios";
    export default {
        name: 'app-toolbar',
        data: () => ({
            nome: ''
        }),

        methods: {
            logout() {
                this.$router.push('/logout')
            }
        },

        created() {
            {
                axios.get('/usuarios/').then(res => {
                    this.usuarioLogado = res.data;
                    this.usuarioLogado = this.usuarioLogado.nome;
                    //this.nome = this.usuarioLogado.split(' ').join(' ');
                    var primeiro = this.usuarioLogado.split(' ')[0];
                    var x = this.usuarioLogado.split(' ').length;
                    var ultimo = this.usuarioLogado.split(' ')[x - 1];
                    this.nome =  primeiro + " " + ultimo;
                })
            }
        },
        mounted() {
        }

    }
</script>
