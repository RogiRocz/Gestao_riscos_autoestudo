import axios from 'axios'
import router from '../../router'


// state
const state = {
    token: null
};

// actions
const actions = {
    login ({commit, dispatch}, authData) {
        return new Promise((resolve, reject) => {
            axios.post('/login', {
                email: authData.email,
                password: authData.password
            })
            .then(res => {
                localStorage.setItem('token', res.data.token)
                commit('AUTHENTICATE', {token: res.data.token })
                axios.defaults.headers.common['Authorization'] = res.data.token
            })
            .catch(error => console.log(error))
            .finally(() => resolve())

        })
    },

    logout ({commit}) {
        commit('CLEAR_AUTH_DATA')
        localStorage.removeItem('token')
        delete axios.defaults.headers.common['Authorization']
        router.replace('/login')
    }

};

// getters
const getters = {
    isAuthenticated (state) {
        return state.token !== null
    }
};

// mutations
const mutations = {
    AUTHENTICATE: (state, token) => {
        state.token = token
    },
    CLEAR_AUTH_DATA: (state) => {
        state.token = null
    },
    SET_LOGADO (state, usuario) {
        state.all = usuario;
    },
};



export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}