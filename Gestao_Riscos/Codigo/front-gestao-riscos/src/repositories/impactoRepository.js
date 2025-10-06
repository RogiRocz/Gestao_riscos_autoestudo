import Repository from "./Repository";
const resource = "impactos";

export default {

    findByPlano(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(impacto) {
        return Repository.post(`${resource}`, impacto)
    },

    editar(currentItem, impacto) {
        return Repository.put(`${resource}/${currentItem}`, impacto)
    },

    excluir(impacto) {
        return Repository.delete(`${resource}/${impacto}`)
    }
} 