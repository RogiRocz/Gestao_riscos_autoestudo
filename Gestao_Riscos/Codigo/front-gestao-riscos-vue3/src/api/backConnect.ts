import axios, { type AxiosInstance } from 'axios';

const urlBase: string = import.meta.env.VITE_URL_BASE;
const urlPort: string = import.meta.env.VITE_URL_PORT;

let api: AxiosInstance;

if (urlBase.includes('firebase')) {
	api = axios.create({
		baseURL: `${urlBase}`,
	});
} else {
	// urlBase = localhost
	api = axios.create({
		baseURL: `${urlBase}:${urlPort}`,
	});
}

api.interceptors.request.use(
	(config) => {
		console.log('config da requisição: ', config);
		return config;
	},
	(error) => {
		console.log('Erro ao enviar a requisição: ', error);
		Promise.reject(error);
	},
);

export default api;
