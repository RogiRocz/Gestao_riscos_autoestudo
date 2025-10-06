import api from './backConnect';

async function getUser(login: string, password: string) {
	const credentials = {
		login: login,
		password: password
	}
	try {
		const response = await api.post('/login', credentials);


				console.log("resposta do back: ", response)
        return response.data;
	} catch (error) {
        console.error('Erro ao retornar usuário: ', error);
    }
}

export {
    getUser
}
