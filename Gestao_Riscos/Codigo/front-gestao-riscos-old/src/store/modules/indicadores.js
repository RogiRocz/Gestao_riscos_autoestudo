import axios from 'axios'


// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/indicador')
            .then(res => {
                commit('SET_INDICADOR', res.data)
            })
            .catch(
                error => console.log(error)
            )
    },

    ADD ({commit}, indicador) {
        commit('ADD_INDICADOR', indicador)
    }
};

// getters
const getters = {

};

// mutations
const mutations = {
    SET_INDICADOR (state, indicador) {
        state.all = indicador;
    },

    ADD_SELECAO (state, indicador) {
        state.selecoes.push(indicador);
    }
};



export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}