import axios from 'axios'


// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({ commit }) {
        axios
            .get('/usuarios')
            .then(res => {
                commit('SET_USUARIOS', res.data)
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
    SET_USUARIOS (state, usuarios) {
        state.all = usuarios;
    }
};



export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}