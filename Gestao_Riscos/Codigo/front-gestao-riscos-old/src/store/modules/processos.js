import axios from 'axios'

// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios

            .get('/processos')
            .then(res => {
                commit('SET_PROCESSOS', res.data)
            })
            .catch(
                error => console.log(error)
            )
    }
};

// getters
const getters = {

};

// mutations
const mutations = {
    SET_PROCESSOS (state, processos) {
        state.all = processos;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters

}
