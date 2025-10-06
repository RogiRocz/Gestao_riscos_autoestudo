import Vue from 'vue'
import Vuex from 'vuex'
import planos from './modules/planos'
import riscos from './modules/riscos'
import auth from './modules/auth'
import avaliacoes from './modules/avaliacoes'
import tratamentos from './modules/tratamentos'

import acoes from './modules/acoes'
import app from './modules/app'
Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        app,
        auth,
        planos,
        riscos,
        avaliacoes,
        acoes,
        tratamentos,
    }
})
