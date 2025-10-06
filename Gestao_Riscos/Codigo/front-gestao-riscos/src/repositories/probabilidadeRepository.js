import Repository from "./Repository";
const resource = "probabilidades";

export default {

    findByPlano(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(probabilidade) {
        return Repository.post(`${resource}`, probabilidade)
    },

    editar(currentItem, probabilidade) {
        return Repository.put(`${resource}/${currentItem}`, probabilidade)
    },

    excluir(probabilidade) {
        return Repository.delete(`${resource}/${probabilidade}`)
    }
} 