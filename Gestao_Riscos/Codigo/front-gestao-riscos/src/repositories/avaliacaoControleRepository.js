import Repository from "./Repository";
const resource = "avaliacoesControle";

export default {

    findByPlano(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(avaliacao) {
        return Repository.post(`${resource}`, avaliacao)
    },

    editar(currentItem, resposta){
        return Repository.put(`${resource}/${currentItem}`, resposta)
    },

    excluir(avaliacao) {
        return Repository.delete(`${resource}/${avaliacao}`)
    }
} 