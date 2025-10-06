import Repository from './Repository';
const resource = "/riscos"

export default{

  findByUnidade(planoId) {
    return Repository.get(`${resource}?plano=${planoId}`)
  },

  findById(id) {
    return Repository.get(`${resource}/${id}`)
  },

  cadastrar(risco) {
    return Repository.post(`${resource}`, risco)
  },

  atualizar(risco) {
    return Repository.put(`${resource}/${risco.id}`, risco)
  },

  excluir(risco) {
      return Repository.delete(`${resource}/${risco}`)
  },

  /*compartilhar(risco, unidades) {
      return Repository.post(`${resource}/${risco}/compartilhar`, unidades)
  }*/

  

}