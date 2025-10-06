import Repository from "./Repository";
const resource = "/usuarios";

export default {
    getByAutenticacao() {
        return Repository.get(`${resource}/usuario`);
    },

    findByUnidade(unidade) {
        return Repository.get(`${resource}?unidade=${unidade}`);
    },
    
}
