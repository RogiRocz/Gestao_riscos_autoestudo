import Vue from 'vue'
import Vuex from 'vuex'
import politicas from './modules/politicas'
import riscos from './modules/riscos'
import processos from './modules/processos'
import auth from './modules/auth'
import usuarios from './modules/usuarios'
import tipoProcesso from './modules/tipoProcesso'
import impactos from './modules/impactos'
import categorias from './modules/categorias'
import probabilidades from './modules/probabilidades'
import unidade from './modules/unidades'
import indicador from './modules/indicadores'
import avaliacoes from './modules/avaliacoes'
import fatoresAvaliacao from './modules/fatoresAvaliacao'


Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        auth,
        politicas,
        processos,
        riscos,
        usuarios,
        tipoProcesso,
        unidade,
        indicador,
        avaliacoes,
        probabilidades,
        fatoresAvaliacao,
        categorias,
        impactos

    }
})
