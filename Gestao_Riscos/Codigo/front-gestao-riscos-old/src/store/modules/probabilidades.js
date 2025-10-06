import axios from 'axios'


// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/probabilidades')
            .then(res => {
                commit('SET_PROBABILIDADES', res.data)
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
    SET_PROBABILIDADES (state, probabilidades) {
        state.all = probabilidades;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
