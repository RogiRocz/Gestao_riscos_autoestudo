import Repository from "./Repository";
const resource = "categorias";

export default {

    findByPlano(planoId) {
        return Repository.get(`${resource}?plano=${planoId}`)
    },
    
    cadastrar(categoria){
        return Repository.post(`${resource}`, categoria)
    },
    editar(currentItem, categoria) {
        return Repository.put(`${resource}/${currentItem}`, categoria)
    },

    excluir(id){
        return Repository.delete(`${resource}`+"/"+id)
    }
} 