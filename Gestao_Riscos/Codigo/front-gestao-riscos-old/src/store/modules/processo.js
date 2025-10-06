import axios from 'axios'

// state
const state = {
    all: []
};

// actions
const actions = {
    GET_ALL ({commit}){
        axios
            .get('/processo')
            .then(res => {
                commit('SET_PROCESSOS', res.data)
            })
            .catch(
                error => console.log(error)
            )
    },
    adicionarProcesso({ commit }, processo) {
        axios
            .post('/processo', processo)
            .then(res => {
                commit('adicionarProcesso', res.data)
            }) .catch (
            error => console.log(error)
        )

    }
};

// getters
const getters = {

};

// mutations
const mutations = {
    SET_PROCESSOS (state, processos){
        state.all = processos;
    },
    adicionarProcesso(state, processo){
        state.all.push(processo)
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}