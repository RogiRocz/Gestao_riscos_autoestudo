import axios from 'axios'


// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/tipoProcesso')
            .then(res => {
                commit('SET_TIPOPROCESSO', res.data)
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
    SET_TIPOPROCESSO (state, tipoProcesso) {
        state.all = tipoProcesso;
    }
};



export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}