import Repository from './Repository';
const resource = "/avaliacoes";

export default{

  cadastrar(avaliacao) {
    return Repository.post(`${resource}`, avaliacao)
  },

  findByRisco(risco) {
    return Repository.get(`${resource}?risco=${risco}`)
  },

  findLastByRisco(risco) {
    return Repository.get(`${resource}/last?risco=${risco}`)
  }

}