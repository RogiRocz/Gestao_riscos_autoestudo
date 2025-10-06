import Repository from './Repository';
const resource = "/ocorrencias";

export default{

  cadastrar(ocorrencia) {
    return Repository.post(`${resource}`, ocorrencia)
  },

  findByRisco(risco) {
    return Repository.get(`${resource}?risco=${risco}`)
  }

}