import { http } from './config'

export default {
    listar:() => {
        return http.get('avaliacoes');
    },
    salvar:(processo) => {
        return http.post('avaliacoes',processo); //{ headers: {'Content-Type': 'multipart/form-data'}}
    },
    deletar:(id) =>{
        return http.delete('avaliacoes/' + id); //{ headers: {'Content-Type': 'multipart/form-data'}}
    }

}
