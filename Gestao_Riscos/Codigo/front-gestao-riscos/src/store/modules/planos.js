
const state = {
    respostas: [],
    niveis: [],
    impactos: [],
    probabilidades: [],
    controles: []
};

const actions = {
    setRespostas ({ commit }, respostas) {
        commit('SET_RESPOSTAS', respostas)
    },

    setNiveis ({ commit }, niveis) {
        commit('SET_NIVEIS', niveis)
    },

    setImpactos ({ commit }, impactos) {
        commit('SET_IMPACTOS', impactos)
    },

    setProbabilidades ({ commit }, probabilidades) {
        commit('SET_PROBABILIDADES', probabilidades)
    },

    setControles ({ commit }, controles) {
        commit('SET_CONTROLES', controles)
    }
};

const getters = {

};

const mutations = {
    SET_RESPOSTAS (state, respostas) {
        state.respostas = respostas;
    },

    SET_NIVEIS (state, niveis) {
        state.niveis = niveis;
    },

    SET_IMPACTOS (state, impactos) {
        state.impactos = impactos;
    },

    SET_PROBABILIDADES (state, probabilidades) {
        state.probabilidades = probabilidades;
    },

    SET_CONTROLES (state, controles) {
        state.controles = controles;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}