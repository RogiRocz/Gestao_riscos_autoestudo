import axios from 'axios'

// state

const state = {
    all: [],
    av: []

};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/avaliacoes')
            .then(res => {
                commit('SET_AVALIACOES', res.data)
            })
            .catch(
                error => console.log(error)
            )
    },


};

// getters
const getters = {

};

// mutations
const mutations = {
    SET_AVALIACOES (state, avaliacoes) {
        state.all = avaliacoes;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
