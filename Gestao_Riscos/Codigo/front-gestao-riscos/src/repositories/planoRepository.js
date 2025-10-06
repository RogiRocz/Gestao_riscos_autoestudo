import Repository from "./Repository";

const resource = "/planos";

export default {

    getVigente() {
        return Repository.get(`${resource}/vigente`);
    },
    getById(id) {
        return Repository.get(`${resource}/${id}`);
    },

    getByAutenticacao() {
        return Repository.get(`${resource}/plano`);
    },
    
    getAll() {
      return Repository.get(`${resource}`)
    }
}