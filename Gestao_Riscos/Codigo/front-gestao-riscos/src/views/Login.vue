<template>
    <v-container fluid class="pl-10 wrapper fill-height">
        <v-row>
            <img src="/static/brasao-ufc.png">
        </v-row>
        <v-row class="mt-5">
            <v-col cols="7">
                <img src="/static/images/back1.svg" width="90%">
            </v-col>
            <v-col cols="5" class="text-center">
                <v-row class="justify-center mb-4">
                    <img src="/static/logo.png" width="60px">
                </v-row>
                <span class="font-weight-light text-h5">Sistema de </span>
                <span class="text-h5 primary--text">GESTÃO DE RISCOS</span>
                <v-form @submit.prevent="onSubmit" ref="form" lazy-validation v-model="valid">
                    <v-card-text>
                        <p class="error--text text-center">{{error}}</p>
                        <v-text-field label="Usuário" name="email" prepend-icon="person" type="text" v-model="email" required :rules="requiredRule"/>
                        <v-text-field id="password" label="Senha" name="password" prepend-icon="lock" type="password" v-model="password" required :rules="requiredRule"/>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="primary" type="submit" :loading="loading" large>Acessar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import { mapState } from 'vuex'

    export default {
        props: ["to", "invalidToken"],
        data: () => ({
            valid: true,
            loading: false,
            email: '',
            password: '',
            error: '',
            requiredRule: [
                v => !!v || 'Campo obrigatório'
            ],
        }),
        created() {
            if (this.invalidToken) {
                this.error = 'Sua sessão expirou. Faça login novamente'
            }
        },
        methods: {
            onSubmit () {
                this.loading = true
                if (this.$refs.form.validate()) {
                    this.$store.dispatch('auth/login', {email: this.email, password: this.password})
                        .then(() => {
                            if (this.$store.getters['auth/isAuthenticated']) {
                                window.location.href = '/'
                            } else {
                                this.error = 'Usuário e/ou senha inválidos'
                            }
                        })
                }

                this.loading = false
            }
        },
        computed: {
            ...mapState({
                token: state => state.auth.token
            })
        }
    };
</script>

<style scoped lang="css">
    .wrapper::before {
        background-color: rgba(81, 14, 128, 0.13);
    }
</style>
