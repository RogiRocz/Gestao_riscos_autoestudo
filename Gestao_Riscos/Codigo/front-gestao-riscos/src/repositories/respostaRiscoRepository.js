import Repository from "./Repository";

const resource = "respostas";

export default{

    findByPlano (planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },

    cadastrar(resposta) {
        return Repository.post(`${resource}`, resposta)
    },

    editar(currentItem, resposta) {
        return Repository.put(`${resource}/${currentItem}`, resposta)
    },

    excluir(resposta) {
        return Repository.delete(`${resource}/${resposta}`)
    }
}   