import Repository from './Repository';
const resource = "/tratamentos";

export default{

  cadastrar(risco, tratamento) {
    return Repository.post(`${resource}/${risco}`, tratamento)
  },

  findByRisco(risco) {
    return Repository.get(`${resource}?risco=${risco}`)
  },

  findById(tratamentoId) {
    return Repository.get(`${resource}/${tratamentoId}`)
  },

  cadastrarMonitoramento(acaoPreventiva, monitoramento) {
    return Repository.post(`${resource}/acoesPreventivas/${acaoPreventiva}/monitoramentos`, monitoramento)
  },

  findAcaoPreventivaById(acaoPreventiva) {
    return Repository.get(`${resource}/acoesPreventivas/${acaoPreventiva}`)
  },

  finalizarAcaoPreventiva(acaoPreventiva) {
    return Repository.post(`${resource}/acoesPreventivas/${acaoPreventiva}/finalizar`)
  },

  cancelarAcaoPreventiva(acaoPreventiva) {
    return Repository.post(`${resource}/acoesPreventivas/${acaoPreventiva}/cancelar`)
  },

}