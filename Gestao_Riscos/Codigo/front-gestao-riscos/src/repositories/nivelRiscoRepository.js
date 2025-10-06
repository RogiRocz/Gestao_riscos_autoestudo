import Repository from "./Repository";
const resource = "niveisRisco";

export default {

    findByPlano(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(nivel) {
        return Repository.post(`${resource}`, nivel)
    },

    editar(currentItem, nivel) {
        return Repository.put(`${resource}/${currentItem}`, nivel)
    },

    excluir(nivel) {
        return Repository.delete(`${resource}/${nivel}`)
    }
} 