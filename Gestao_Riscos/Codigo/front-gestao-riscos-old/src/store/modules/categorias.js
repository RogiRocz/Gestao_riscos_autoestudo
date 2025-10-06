import axios from 'axios'
// state
const state = {
    all: []
};
// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/categoriasRisco')
            .then(res => {
                commit('SET_CATEGORIAS', res.data)
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
    SET_CATEGORIAS(state, categorias) {
        state.all = categorias;
    }
};
export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
