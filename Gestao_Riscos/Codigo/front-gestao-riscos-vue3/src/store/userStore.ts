// Utilities
import { defineStore } from 'pinia';

type UserState = {
	name: string;
	username: string;
	isAuthenticate: boolean;
	role: string;
};

type UserToken = {
	token: string;
	expiration?: Date;
};

const useUserStore = defineStore('user', {
	state: (): UserState => ({
		name: '',
		username: '',
		isAuthenticate: false,
		role: '',
	}),

	getters: {
		getName: (state: UserState) => state.name,
		getUsername: (state: UserState) => state.username,
		getAuthenticate: (state: UserState) => state.isAuthenticate,
		getRole: (state: UserState) => state.role,
	},

	actions: {
		setName(value: string) {
			this.name = value;
		},

		setUsername(value: string) {
			this.username = value;
		},

		setAuthtenticate(value: boolean) {
			this.isAuthenticate = value;
		},

		setRole(newRole: string) {
			this.role = newRole;
		},
	},
});

const useAuthStore = defineStore('auth', {
	state: (): UserToken => ({
		token: '',
		expiration: undefined,
	}),

	getters: {
		getToken: (state: UserToken) => state.token,
		getExpiration: (state: UserToken) => state.expiration,
	},

	actions: {
		setToken(newToken: string) {
			this.token = newToken;
		},

		setExpiration(newExpiration: Date) {
			this.expiration = newExpiration;
		},
	},
});

export { useUserStore, useAuthStore };
