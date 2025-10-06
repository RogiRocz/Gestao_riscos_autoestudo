import Repository from "./Repository";
const resource = "acoes";

export default {

    findByUnidade(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    findById(id) {
        return Repository.get(`${resource}/${id}`)
    },

    cadastrar(acao) {
        return Repository.post(`${resource}`, acao)
    },

    atualizar(acao) {
        return Repository.put(`${resource}`, acao)
    },

    excluir(acao) {
        return Repository.delete(`${resource}/${acao}`)
    }
} 