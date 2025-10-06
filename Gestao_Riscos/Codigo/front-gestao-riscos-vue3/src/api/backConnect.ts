import axios from 'axios';

const urlBase = import.meta.env.VITE_URL_BASE;
const urlPort = import.meta.env.VITE_URL_PORT;

const api = axios.create({
	baseURL: `${urlBase}:${urlPort}`,
});

api.interceptors.request.use((config) => {
	console.log('config da requisição: ', config);
	return config;
}, (error) => {
	console.log('Erro ao enviar a requisição: ', error);	
	Promise.reject(error)
});

export default api;