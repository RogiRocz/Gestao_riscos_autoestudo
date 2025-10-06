<template>
  <div>
    <v-card-widget enableActions :title="'Risco: '+risco.nome">
      <div slot="widget-header-action">
        <v-row align="center" class="mx-2">
          <v-btn class="px-2" icon
              @click="$router.push('/riscos/')">
            <v-icon>arrow_back</v-icon>
          </v-btn>
          <h5>VOLTAR</h5>
        </v-row>
      </div>
      <div slot="widget-content">
        <v-row>
          <v-col cols="12">
            <v-tabs
                centered
                icons-and-text
                :grow="true">
              <v-tabs-slider color="blue"></v-tabs-slider>
              <v-tab href="#tab-1">
                DETALHES
                <v-icon>search</v-icon>
              </v-tab>
              <v-tab href="#tab-2">
                AVALIAÇÕES
                <v-icon>thumb_up_alt</v-icon>
              </v-tab>
              <v-tab href="#tab-3">
                PLANO DE TRATAMENTO
                <v-icon>library_books</v-icon>
              </v-tab>
              <v-tab href="#tab-5">
                PLANO DE CONTINGÊNCIA
                <v-icon>chrome_reader_mode</v-icon>
              </v-tab>
              <v-tab href="#tab-4">
                OCORRENCIAS
                <v-icon>warning</v-icon>
              </v-tab>

              <v-tab-item
                  v-for="i in 5"
                  :key="i"
                  :value="'tab-' + i">
                <div v-if="i == 1" >
                  <v-row class="my-2 mx-4 justify-space-between">
                    <v-col class="d-flex flex-column flex-wrap">
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Responsável</h4>
                        <p class="text-capitalize" v-text="risco.responsavel.nome"></p>
                      </div>
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Unidade</h4>
                        <p class="text-capitalize" v-text="risco.unidade.sigla"></p>
                      </div>
                    </v-col>
                    <v-col class="d-flex flex-column flex-wrap">
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Tipo de Risco</h4>
                       <div v-for="item in tipoRisco" :key="item.value">
                          <p v-if="risco.tipo == item.value" class="text-capitalize"
                            v-text="item.text"></p>
                        </div>
                      </div>   
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Causas</h4>
                        <p class="text-capitalize" v-text="risco.causa"></p>
                      </div>
                    </v-col>
                    <v-col class="d-flex flex-column flex-wrap">
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Consequência</h4>
                        <p class="text-capitalize" v-text="risco.consequencia"></p>
                      </div>
                      <div class="mx-8 my-2">
                        <h4 class="font-weight-bold">Resposta ao Risco</h4>
                        <p class="text-capitalize" v-text="tratamento(planoTratamento)"></p>
                      </div>
                    </v-col>
                  </v-row>
                  <v-row class="my-2 justify-space-between">
                    <v-col class="d-flex flex-wrap">
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Probabilidade</h4>
                        <p class="text-capitalize" v-text="probabilidade(listaAvaliacoes)"></p>
                      </div>
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Impacto</h4>
                        <p class="text-capitalize" v-text="impacto(listaAvaliacoes)"></p>
                      </div>
                    </v-col>
                    <v-col class="d-flex flex-wrap">
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Risco Inerente</h4>
                        <p class="text-capitalize" v-text="inerente(listaAvaliacoes)"></p>
                      </div>
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Risco Residual</h4>
                        <p class="text-capitalize" v-text="residual(listaAvaliacoes)"></p>
                      </div>
                    </v-col>
                    <v-col class="d-flex flex-wrap">
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Nível do Risco</h4>
                        <p v-if="nivelRisco(listaAvaliacoes) == ' - '" class="text-capitalize"
                            v-text="nivelRisco(listaAvaliacoes)"></p>
                        <div v-else v-for="item in niveisRisco" :key="item.value">
                          <p v-if="item.value == nivelRisco(listaAvaliacoes)" class="text-capitalize"
                            v-text="item.text"></p>                          
                        </div>                        
                      </div>
                      <div class="mx-5 my-4">
                        <h4 class="font-weight-bold">Fator de Avaliação</h4>
                        <div v-for="item in periodicidadeRisco" :key="item.value">
                          <p v-if="item.value == risco.periodicidadeAvaliacao" class="text-capitalize"
                            v-text="item.text"></p>
                        </div>                        
                      </div>
                      
                    </v-col>
                  </v-row>
                </div>
                <div v-if="i == 5" >
                  <v-row>
                    <v-col cols="12">
                      
                    </v-col>
                  </v-row>
                </div>
              </v-tab-item>
            </v-tabs>
          </v-col>
        </v-row>
      </div>
    </v-card-widget>
  </div>
</template>

<script>
import VCardWidget from "@/components/VWidget";
/*import {RepositoryFactory} from "@/repositories/RepositoryFactory";
const avaliacaoRepo = RepositoryFactory.get("avaliacao");
const riscoRepo = RepositoryFactory.get("risco");*/


export default {
  name: "Risco",
  components: {
    VCardWidget,
  },
  
  data: () => ({
    i: 0,
    risco: [],
    idRisco: null,
    niveisAvaliacao: [],
    listaAvaliacoes: [],
    planoTratamento: [],
    niveisRisco: [
      { text: "1 - Baixo", value: "BAIXO" },
      { text: "2 - Médio", value: "MEDIO" },
      { text: "3 - Alto", value: "ALTO" }
    ],
    probabilidadeRisco: {
      1: "Improvável",
      2: "Pouco Provável",
      3: "Provável",
      4: "Muito Provável"
    },
    tipoRisco: [
      { text: "Ameaça", value: "AMEACA" },
      { text: "Oportunidade", value: "OPORTUNIDADE" }
    ],
    periodicidadeRisco: [
      { text: "Diaria", value: "DIARIA" },
      { text: "Semanal", value: "SEMANAL" },
      { text: "Quinzenal", value: "QUINZENAL" },
      { text: "Mensal", value: "MENSAL" },
      { text: "Bimestral", value: "BIMESTRAL" },
      { text: "Trimestral", value: "TRIMESTRAL" },
      { text: "Semestral", value: "SEMESTRAL" },
      { text: "Anual", value: "ANUAL" }
    ]
  }),

  computed: {
    
  },

  methods: {

    detalharRisco(){
      /*riscoRepo.getRisco(this.idRisco)
        .then(res => {
            this.risco = res.data;
            this.planoTratamento = this.risco.planoTratamento;
            //window.console.log(res.data)
        })
        .catch(window.console.error);*/
    },

    listarAvaliacoes(){
      /*avaliacaoRepo.getAvaliacao(this.idRisco)
        .then( res => {
          this.listaAvaliacoes.push(res.data);
        })*/
    },

    probabilidade(a) {
      if(a.length <= 0) {
        return "-";
      }
      return  a[a.length-1].probabilidade.nome + ' - ' + a[a.length-1].probabilidade.valor;
    },

    impacto(a) {
        if(a.length <= 0) {
            return "-";
        }
        return a[a.length-1].impacto.nome + ' - ' + a[a.length-1].impacto.valor;
    },

    inerente(a) {
      var retorno;

      if(a.length <= 0) {
        return "-";
      }
      else{
        for(let i = 0; i < this.nivel.length; i++){
          if(this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor
              && this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor <= this.nivel[i].valorFinal){
              retorno = this.nivel[i].nome;
          }
        }
        return retorno + " - " + a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor;
      }
    },

    residual(a) {
      if(a.length <= 0) {
        return "-";
      }
      return parseInt((a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor * a[a.length-1].fatorAvaliacaoControle.valor)*100)/100;
    },

    nivelRisco(a) {
      var retorno;

      if(a.length <= 0) {
        return " - ";
      }else{
        for(let i = 0; i < this.nivel.length; i++){
          if(this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor
              && this.nivel[i].valorInicial <= a[a.length-1].impacto.valor * a[a.length-1].probabilidade.valor <= this.nivel[i].valorFinal){
              retorno = this.nivel[i].nome;
          }
        }
        return retorno;
      }
    },

    tratamento(t) {
      if (t === null) {
        return "-";
      } else {
        return t.tratamentoRisco.nome;
      }
    },

  },
  
  created() {
    this.idRisco = this.$route.params.id;
    this.detalharRisco();
    this.listarAvaliacoes(); 
  }

}
</script>

<style scoped>

</style>