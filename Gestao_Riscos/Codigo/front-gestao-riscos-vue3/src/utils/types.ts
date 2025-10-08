interface Login {
	email: string;
	password: string;
}

interface Credentials {
	nome: string;
	email: string;
	token: string;
}

export type { Login, Credentials };
