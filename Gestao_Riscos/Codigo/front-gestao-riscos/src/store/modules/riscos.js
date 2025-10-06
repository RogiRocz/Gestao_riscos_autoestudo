import moment from "moment";

const state = () => ({
    risco: null,
    contingencias: [],
    ocorrencias: []
});

const actions = {
    setRisco ({ commit }, risco) {
        return new Promise((resolve) => {
            commit('SET_RISCO', risco)
            resolve()
        })
    },

    setContingencias ({ commit }, contingencias) {
        commit('SET_CONTINGENCIAS', contingencias)
    },

    addContingencia({ commit }, contingencia) {
        commit('ADD_CONTINGENCIA', contingencia)
    },

    setOcorrencias ({ commit }, ocorrencias) {
        commit('SET_OCORRENCIAS', ocorrencias)
    },

    addOcorrencia({ commit }, ocorrencia) {
        commit('ADD_OCORRENCIA', ocorrencia)
    },
};

const getters = {
    ocorrencias(state) {
        window.console.log('sorting');
        return state.ocorrencias.slice().sort(function(a, b) {
            return moment(b.data, "YYYY-MM-DD") - (moment(a.data, "YYYY-MM-DD"));
        });
    },
};

const mutations = {
    SET_RISCO (state, risco) {
        state.risco = risco;
    },

    SET_CONTINGENCIAS (state, contingencias) {
        state.contingencias = contingencias;
    },

    ADD_CONTINGENCIA (state, contingencia) {
        state.contingencias.push(contingencia);
    },

    SET_OCORRENCIAS (state, ocorrencias) {
        state.ocorrencias = ocorrencias;
    },

    ADD_OCORRENCIA (state, ocorrencia) {
        state.ocorrencias.push(ocorrencia);
    },
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
