import Repository from "./Repository";

const resource = "areas-atuacao";

export default{

    find (planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(area) {
        return Repository.post(`${resource}`, area)
    },

    editar(currentItem, area) {
        return Repository.put(`${resource}/${currentItem}`, area)
    },

    excluir(area) {
        return Repository.delete(`${resource}/${area}`)
    }
}   