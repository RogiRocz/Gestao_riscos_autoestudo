import { http } from './config'

export default {
    listar:() => {
        return http.get('/processo');
    },
    salvar:(processo) => {
        return http.post('/processo',processo); //{ headers: {'Content-Type': 'multipart/form-data'}}
    },

    getProcesso:(id) => {
        return http.get('/processo', id)
    }

}
