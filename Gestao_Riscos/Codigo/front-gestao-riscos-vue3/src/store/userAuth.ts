// Utilities
import { defineStore } from 'pinia';

type UserState = {
  isAuthtenticated: boolean;
  role: string;
};

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    isAuthtenticated: false,
    role: '',
  }),

  getters: {
    getAuthtenticated: (state: UserState) => state.isAuthtenticated,
    getRole: (state: UserState) => state.role,
  },

  actions: {
    setAuthtenticated(value: boolean) {
      this.isAuthtenticated = value;
    },

    setRole(newRole: string) {
      this.role = newRole;
    },
  },
});
