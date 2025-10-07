import api from './backConnect';

async function getUser(login: string, password: string) {
	try {
		const response = await api.post('/login', {
			email: login,
			password: password,
		});

		console.log('resposta do back: ', response);
		return response.data;
	} catch (error) {
		console.error('Erro ao retornar usuário: ', error);
	}
}

export { getUser };
