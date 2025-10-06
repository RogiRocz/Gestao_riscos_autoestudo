//import moment from 'moment'

const state = () => ({
    tratamento: null,
    tratamentos: []
});

const actions = {
    setTratamentos ({ commit }, tratamentos) {
        commit('SET_TRATAMENTOS', tratamentos)
    },

    addTratamento({ commit }, tratamento) {
        commit('ADD_TRATAMENTO', tratamento)
    },

    setTratamento({ commit }, tratamento) {
        commit('SET_TRATAMENTO', tratamento)
    },

    updateAcaoPreventiva({ commit }, acaoPreventiva) {
        commit('UPDATE_ACAO_PREVENTIVA', acaoPreventiva)
    }
};

const getters = {
    tratamentos(state) {
        return state.tratamentos.slice().sort(function(a, b) { return b.termino - a.termino});
    },

    riscoResidual(state, getters, rootState) {
        let nivelResidual = null
        if (state.tratamento.avaliacao != null) {
            let valor = state.tratamento.avaliacao.probabilidade.peso
                * state.tratamento.avaliacao.impacto.peso
                * state.tratamento.avaliacao.avaliacaoControle.fator;
            rootState.planos.niveis.forEach(nivel => {
                if (valor >= nivel.valorInicial && valor <= nivel.valorFinal) {
                    nivelResidual = nivel;
                }
            })
        }
        return nivelResidual;
    },

    corNivelResidual(state, getters, rootState) {
        let cor = '';
        if (getters.riscoResidual) {
            let nivelResidual = getters.riscoResidual;
            rootState.planos.niveis.forEach(nivel => {
                if (nivelResidual.nome === nivel.nome) {
                    cor = nivel.cor;
                }
            })
        }
        return cor;
    },
};

const mutations = {
    SET_TRATAMENTOS (state, tratamentos) {
        state.tratamentos = tratamentos;
    },

    ADD_TRATAMENTO (state, tratamento) {
        state.tratamentos.push(tratamento);
    },

    SET_TRATAMENTO (state, tratamento) {
        state.tratamento = tratamento;
    },

    UPDATE_ACAO_PREVENTIVA (state, acaoPreventiva) {
        state.tratamento.acoesPreventivas.splice(state.tratamento.acoesPreventivas.findIndex(i => i.id === acaoPreventiva.id), 1, acaoPreventiva);
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
