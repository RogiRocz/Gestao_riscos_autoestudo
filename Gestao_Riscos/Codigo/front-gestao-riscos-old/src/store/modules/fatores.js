import axios from 'axios'

// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/fatoresAvaliacao')
            .then(res => {
                commit('SET_FATORES', res.data)
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
    SET_FATORES(state, fatores) {
        state.all = fatores;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
