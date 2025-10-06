import api from './backConnect';

async function getUser(login: string, password: string) {
	try {
		const response = await api.get('/users', {
            params: {
                login: login,
                password: password
            }
        });

        return response.data;
	} catch (error) {
        console.error('Erro ao retornar usuário: ', error);
    }
}

export {
    getUser
}
