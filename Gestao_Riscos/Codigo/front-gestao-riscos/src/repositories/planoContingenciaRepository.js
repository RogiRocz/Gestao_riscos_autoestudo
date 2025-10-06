import Repository from './Repository';
const resource = "/contingencias";

export default{

  cadastrar(contingencia) {
    return Repository.post(`${resource}`, contingencia)
  },

  findByRisco(risco) {
    return Repository.get(`${resource}?risco=${risco}`)
  }

}