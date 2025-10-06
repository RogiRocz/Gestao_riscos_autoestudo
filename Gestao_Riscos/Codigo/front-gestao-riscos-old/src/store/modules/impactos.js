import axios from 'axios'

// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/impactos')
            .then(res => {
                commit('SET_IMPACTOS', res.data)
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
    SET_IMPACTOS (state, impactos) {
        state.all = impactos;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
