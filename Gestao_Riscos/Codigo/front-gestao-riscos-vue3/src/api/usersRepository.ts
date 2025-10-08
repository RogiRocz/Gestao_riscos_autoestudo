import api from './backConnect';
import type { Credentials } from '@/utils/types';
import { useUserStore, useAuthStore } from '@/store/userStore';
import getTimestampFromToken from '@/utils/getTimestampFromToken';

async function authLogin(login: string, password: string) {
	try {
		const response = await api.post('/login', {
			email: login,
			password: password,
		});

		if (response.data != null && response.data.token != null) {
			const { name, email, token } = response.data;
			const userStore = useUserStore();
			const authStore = useAuthStore();

			const tokenExpTimestamp = getTimestampFromToken(token); // Tenho que converter para js

			authStore.setToken(token);
			authStore.setExpiration(new Date(tokenExpTimestamp * 1000));

			userStore.setName(name);
			userStore.setUsername(email);
			userStore.setAuthtenticate(true);
		}

		console.log('resposta: ', response);
		return response.data;
	} catch (error) {
		console.error('Erro ao autenticar usuário: ', error);
	}
}

async function getAllUsers(credentials: Credentials) {
	try {
		const response = await api.get('usuarios/');

		return response.data;
	} catch (error) {
		console.error('Erro ao retornar todos usuarios: ', error);
	}
}

export { authLogin, getAllUsers };
