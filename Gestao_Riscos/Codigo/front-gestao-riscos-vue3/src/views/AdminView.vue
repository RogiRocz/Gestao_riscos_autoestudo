<template>
	<div>Tela de Admin</div>
</template>

<script setup lang="ts">
import { useUserStore, useAuthStore } from '@/store/userStore';

const authStore = useAuthStore();
const userStore = useUserStore();

console.log('user: ', userStore, ' auth: ', authStore);
</script>

<style scoped></style>
