<template>
	<v-container fluid class="pa-0 ma-0">
		<v-row no-gutters class="fill-height">
			<v-col cols="6">
				<v-img src="/static/images/back5.png" cover class="fill-height"></v-img>
			</v-col>

			<v-col cols="6">
				<v-card flat max-width="450" width="100%" class="pa-4">
					<v-container class="centerFormTitle">
						<v-card-item class="mb-4">
							<template v-slot:prepend>
								<BoxImage :path-img="imgForm" :width="50" :height="50" />
							</template>
							<v-card-title class="pl-2">
								Sistema de <br />
								<span class="font-weight-bold">Gestão de Riscos</span>
							</v-card-title>
						</v-card-item>
					</v-container>

					<v-card-text>
						<v-form @submit.prevent="handleLogin" width="100%">
							<v-text-field
								label="Usuário"
								type="text"
								v-model="login"
								variant="underlined"
								class="pa-5"
								placeholder="Digite seu usuário"
								:rules="[rules.minimumSize, rules.email]"
							></v-text-field>
							<v-text-field
								label="Senha"
								type="password"
								v-model="password"
								variant="underlined"
								class="pa-5"
								placeholder="Digite sua senha"
								:rules="[rules.minimumSize]"
							></v-text-field>

							<v-btn
								type="submit"
								size="large"
								variant="outlined"
								color="#8E24AA"
							>
								Acessar
							</v-btn>
						</v-form>
					</v-card-text>
				</v-card>
			</v-col>
		</v-row>
	</v-container>
</template>

<script lang="ts" setup>
import { authLogin } from '@/api/usersRepository';
import BoxImage from '@/components/BoxImage.vue';
import { rules } from '@/utils/rulesInput';
import { ref } from 'vue';
import router from '@/router/index';

const imgForm = 'favicon.ico';

const login = ref('');
const password = ref('');

async function handleLogin() {
	const credentials = await authLogin(login.value, password.value);

	if (credentials != null) {
		await router.push('admin');
	}

}
</script>

<style scoped>
.v-card-title span {
	text-transform: uppercase;
	color: indigo !important;
}

.v-btn {
	margin: 0 auto;
	width: 50%;
	display: flex;
}

.v-col {
	display: flex;
	justify-content: center;
	align-items: center;
}

.centerFormTitle {
	display: flex;
	justify-content: center;
	align-items: center;
}

.v-text-field {
	margin-bottom: 2vh;
}
</style>
