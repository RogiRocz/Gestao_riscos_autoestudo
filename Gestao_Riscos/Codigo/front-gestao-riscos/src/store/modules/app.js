/*
    Como utilizar:
        Para mostrar uma mensagem de sucesso:
            this.$store.dispatch("app/putInfo", "MENSAGEM DE INFORMAÇÃO A SER EXIBIDA!")

        Para mostrar uma mensagem de erro:
            this.$store.dispatch("app/putError", "MENSAGEM DE ERRO A SER EXIBIDA!")
*/
const state = () => ({
    breadcrumbItems: [],
    plano: {
        id: -1
    },
    unidade: null,
    messages: {
        error: "",
        info: ""
    },
    servidores: []
})

// São os dados computados do store
const getters = {
    GET_ERROR(state) {
        return state.messages.error
    },
    GET_INFO(state) {
        return state.messages.info
    }
}

const actions = {
    setPlano ({ commit }, plano) {
        return new Promise((resolve) => {
            commit('setPlano', plano)
            resolve()
        })
    },
    setUnidade({ commit }, unidade) {
        commit('setUnidade', unidade)
    },
    setServidores({ commit }, servidores) {
        commit('setServidores', servidores)
    },
    putError({commit}, message){
        commit('SET_ERROR', message)
    },
    putInfo({commit}, message){
        commit('SET_INFO', message)
    },
    clearError({commit}){
        commit('SET_ERROR', "")
    },
    clearInfo({commit}){
        commit('SET_INFO', "")
    }
}

const mutations = {
    setBreadcrumb (state, breadcrumb) {
        state.breadcrumbItems = breadcrumb;
    },
    setPlano (state, plano) {
        state.plano = plano;
    },
    setUnidade (state, unidade) {
        state.unidade = unidade;
    },
    setServidores (state, servidores) {
        state.servidores = servidores;
    },
    SET_ERROR: (state, message) => {
        state.messages.error =  message
    },
    SET_INFO: (state, message) => {
        state.messages.info = message
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}