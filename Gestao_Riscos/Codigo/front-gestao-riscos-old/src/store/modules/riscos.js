import axios from 'axios'
// state
const state = {
    all: [],
   
};
// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/riscos')
            .then(res => {
                commit('SET_RISCOS', res.data)
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
    SET_RISCOS (state,  riscos) {
        state.all = riscos;
    }
};
export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
