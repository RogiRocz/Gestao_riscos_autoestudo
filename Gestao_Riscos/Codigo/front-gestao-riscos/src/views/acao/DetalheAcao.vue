 <template>
    <div>
        <v-card-widget title="Informações" enableHeader>
            <div slot="widget-header-action">
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn icon color="primary" v-bind="attrs" v-on="on" :to="{ name: 'CadastroAcao', query: { acao: acao.id } }"><v-icon>create</v-icon></v-btn>
                    </template>
                    <span>Editar</span>
                </v-tooltip>
                <v-tooltip bottom>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn icon color="error" v-bind="attrs" v-on="on" @click.stop="dialogRemove = true"><v-icon>delete</v-icon></v-btn>
                    </template>
                    <span>Excluir</span>
                </v-tooltip>
            </div>
            <div slot="widget-content">
                <v-row>
                    <v-col cols="6">
                        <div class="font-weight-bold text-uppercase">Gestor</div>
                        <div class="font-weight-light title">{{acao.gestor.nome}}</div>
                    </v-col>
                    <v-col cols="6">
                        <div class="font-weight-bold text-uppercase">Unidade</div>
                        <div class="font-weight-light title">{{acao.unidade.nome}}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Título</div>
                        <div class="font-weight-light title">{{acao.titulo}}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Objetivo geral</div>
                        <div class="font-weight-light title">{{acao.objetivoGeral}}</div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Objetivos específicos</div>
                        <div class="font-weight-light title" v-html="acao.objetivosEspecificos"></div>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <div class="font-weight-bold text-uppercase">Área(s) de atuação</div>
                        <v-chip v-for="area in acao.areas" :key="area.id" class="ma-1" color="secondary lighten-2" label>
                            {{area.nome}}
                        </v-chip>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>

        <v-card-widget :title="'Eventos de Risco'" enableHeader class="mt-3">
            <div slot="widget-header-action">
                <!--<v-btn class="ma-2" outlined color="primary" to="/acoes/cadastrar">Novo risco de risco</v-btn>-->
            </div>
            <div slot="widget-content">
                 <v-row>
                    <v-col cols="12">
                        <v-data-table :headers="headers" :items="riscosFilter" class="elevation-1" :search="search">
                            <template v-slot:[`item.nome`]="{item}">
                                <a :href="'/riscos/' + item.id" class="text-decoration-none">{{item.nome}}</a>
                            </template>
                            <template v-slot:[`item.tipo`]="{item}">
                                <v-chip v-if="item.tipo === 'AMEACA'" class="mr-1" color="error lighten-1" label>Ameaça</v-chip>
                                <v-chip v-if="item.tipo === 'OPORTUNIDADE'" color="success lighten-1" label>Oportunidade</v-chip>
                            </template>
                        </v-data-table>
                    </v-col>
                </v-row>
            </div>
        </v-card-widget>

        <v-dialog v-model="dialogRemove" persistent max-width="370">
            <v-card>
                <v-card-title>
                    <span class="headline">Excluir ação</span>
                </v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    Tem certeza de que deseja excluir esta ação?
                </v-card-text>
                <v-divider></v-divider>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn text @click="dialogRemove = false">Cancelar</v-btn>
                    <v-btn color="error" @click="excluir">Excluir</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>
<script>
    import { mapState } from 'vuex';
    import VCardWidget from "@/components/VWidget";
    import {RepositoryFactory} from "@/repositories/RepositoryFactory";

    const acaoRepository = RepositoryFactory.get("acao");
    const riscoRepository = RepositoryFactory.get("risco");
    export default {
        props: ['acaoId'],
        components: {
            VCardWidget
        },
        data() {
            return {
                breadcrumbItems: [
                    {position: 1, text: "Início", disabled: false, href: "/"},
                    {position: 2, text: "Ações", disabled: false, href: "/acoes"},
                    {position: 3, text: "Detalhes", disabled: true}
                ],
                acao: null,
                dialogRemove: false,
                
                headers: [
                {text: "Título", value: "nome", sortable: true},
                {text: "Tipo", value: "tipo", filterable: false}
            ],
            riscos: [],
            tiposRisco: [
                {id: '', nome: 'Todos'},
                {id: 'AMEACA', nome: 'Ameaça'},
                {id: 'OPORTUNIDADE', nome: 'Oportunidade'}
            ],
            tipo: ''
            }
        },
        created() {
            this.$store.commit('app/setBreadcrumb', this.breadcrumbItems);
            acaoRepository.findById(this.acaoId).then(res => {
                this.acao = res.data
            }),
            
            this.getRiscos();
        },

        methods: {
            getRiscos() {
                riscoRepository.findByUnidade(this.plano.id).then(res => {
                    this.riscos = res.data
                })
            },
            excluir () {
                acaoRepository.excluir(this.acao.id).then(() => {
                    // TODO: tratar a resposta da exclusão
                    this.$router.push({ name: 'ListaAcoes'});
                })
            },
        },

        computed: {
            ...mapState({
                plano: state => state.app.plano
            }),

            riscosFilter() {
                if (this.tipo === '') {
                    return this.riscos;
                }
                return this.riscos.filter(risco => {
                    return risco.tipo === this.tipo;
                })
            },

            // sem filtro não aparece os riscos 

           
        },
        
    }



</script>
<style lang="stylus" scoped>

</style>