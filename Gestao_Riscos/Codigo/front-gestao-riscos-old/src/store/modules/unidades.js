import axios from 'axios'


// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/unidade')
            .then(res => {
                commit('SET_UNIDADE', res.data)
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
    SET_UNIDADE (state, unidade) {
        state.all = unidade;
    }
};



export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}