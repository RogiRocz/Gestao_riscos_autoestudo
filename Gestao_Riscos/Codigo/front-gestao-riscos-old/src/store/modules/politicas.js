import axios from 'axios'
// state
const state = {
  all: []
};
// actions
const actions = {
  GET_ALL ({ commit }) {
    axios
        .get('/politicas')
        .then(res => {
            commit('SET_POLITICAS', res.data)
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
  SET_POLITICAS (state, politicas) {
    state.all = politicas;
}
};
export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
}