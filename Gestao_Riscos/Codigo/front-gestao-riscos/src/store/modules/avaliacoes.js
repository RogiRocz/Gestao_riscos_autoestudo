import moment from 'moment'

const state = () => ({
    avaliacoes: []
});

const actions = {
    setAvaliacoes ({ commit }, avaliacoes) {
        commit('SET_AVALIACOES', avaliacoes)
    },

    addAvaliacao({ commit }, avaliacao) {
        commit('ADD_AVALIACAO', avaliacao)
    }
};

const getters = {
    avaliacoes(state) {
        return state.avaliacoes.slice().sort(function(a, b) { return a.data - b.data});
    },

    lastAvaliacao(state) {
        state.avaliacoes.slice().sort(function(a, b) { return a.data - b.data} );
        return state.avaliacoes.length > 0 ? state.avaliacoes[0] : null;
    },

    riscoResidual(state, getters, rootState) {
        let avaliacao = getters.lastAvaliacao;
        let nivelResidual = null
        if (avaliacao != null) {
            let valor = avaliacao.probabilidade.peso * avaliacao.impacto.peso * avaliacao.avaliacaoControle.fator;
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

    proximaAvaliacao(state, getters) {
        let avaliacao = getters.lastAvaliacao;
        if (avaliacao === null) {
            return "-";
        }

        switch (avaliacao.periodicidade) {
            case "DIARIA":
                return moment(avaliacao.data, "YYYY-MM-DD").add(1, 'days').format("DD/MM/YYYY");
            case "SEMANAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(1, 'weeks').format("DD/MM/YYYY");
            case "QUINZENAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(2, 'weeks').format("DD/MM/YYYY");
            case "MENSAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(1, 'months').format("DD/MM/YYYY");
            case "BIMESTRAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(2, 'months').format("DD/MM/YYYY");
            case "TRIMESTRAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(3, 'months').format("DD/MM/YYYY");
            case "SEMESTRAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(6, 'months').format("DD/MM/YYYY");
            case "ANUAL":
                return moment(avaliacao.data, "YYYY-MM-DD").add(1, 'years').format("DD/MM/YYYY");

        }
    }
};

const mutations = {
    SET_AVALIACOES (state, avaliacoes) {
        state.avaliacoes = avaliacoes;
    },

    ADD_AVALIACAO (state, avaliacao) {
        state.avaliacoes.push(avaliacao);
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
}
