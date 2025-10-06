<template>
    <div>
        <v-card flat>
            <v-card-text>
                <v-row>
                    <v-col cols="2">
                        <div class="font-weight-bold text-uppercase">Tipo</div>
                        <v-chip v-if="risco.tipo === 'AMEACA'" color="error lighten-2" label>AMEAÇA</v-chip>
                        <v-chip v-else color="success lighten-2" label>OPORTUNIDADE</v-chip>
                    </v-col>
                    <v-col cols="10">
                        <div class="font-weight-bold text-uppercase">Categoria(s)</div>
                        <v-chip v-for="categoria in risco.categorias" :key="categoria.id" class="ma-1" color="secondary lighten-2" label>
                            {{categoria.nome}}
                        </v-chip>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Ações relacionadas</div>
                        <v-chip v-for="acao in risco.acoes" :key="acao.id" class="ma-1" color="secondary lighten-2" label>
                            {{acao.titulo}}
                        </v-chip>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Causas</div>
                        <div class="font-weight-light title" v-html="risco.causa ? risco.causa : '-'"></div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Consequências</div>
                        <div class="font-weight-light title" v-html="risco.consequencia ? risco.consequencia : '-'"></div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Controles existentes</div>
                        <div class="font-weight-light title" v-html="risco.controles ? risco.controles : '-'"></div>
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>
    </div>
</template>

<script>
    import { mapGetters, mapState } from 'vuex';
    export default {
        name: 'risco-detalhes',
        data() {
            return {

            };
        },
        created() {

        },

        methods: {

        },

        computed: {
            ...mapGetters({
                avaliacao : 'avaliacoes/lastAvaliacao'
            }),

            ...mapState({
                risco: state => state.riscos.risco
            })
        },
    };
</script>

<style scoped>

</style>

