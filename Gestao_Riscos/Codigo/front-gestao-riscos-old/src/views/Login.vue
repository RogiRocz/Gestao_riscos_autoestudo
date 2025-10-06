<template>
    <v-app id="login">
        <v-content>
            <v-container fluid fill-height>
                <v-layout align-center justify-center>
                    <v-flex xs8 sm6 md4 lg4>
                        <v-card class="elevation-1 pa-3">
                            <v-form @submit.prevent="onSubmit">
                                <v-card-text>
                                    <div class="layout column text-md-center">
                                        <img id="logo" src="/static/brasao-ufc.png" alt="Logo Sistema de Gestão Riscos">
                                        <h1 class="flex my-4 primary--text headline font-weight-light">Sistema de Gestão de Riscos</h1>
                                        <span class="body-1 red--text">{{error}}</span>
                                    </div>

                                    <v-text-field append-icon="person" name="email" label="Email" type="text" v-model="email"></v-text-field>
                                    <v-text-field append-icon="lock" name="password" label="Senha" id="password" type="password" v-model="password"></v-text-field>

                                </v-card-text>
                                <v-card-actions class="layout column align-center">
                                    <v-btn color="primary" type="submit" :loading="loading" large>Entrar</v-btn>
                                </v-card-actions>
                            </v-form>
                        </v-card>
                    </v-flex>
                </v-layout>
            </v-container>
        </v-content>
    </v-app>
</template>

<script>
    import { mapState } from 'vuex'

    export default {
        data () {
            return {
                loading: false,
                email: '',
                password: '',
                error: ''
            }
        },
        methods: {
            onSubmit () {
                this.loading = true
                this.$store.dispatch('auth/login', {email: this.email, password: this.password})
                    .then(() => {
                        if (this.$store.getters['auth/isAuthenticated']) {
                            this.$router.push('/dashboard')
                        } else {
                            this.error = 'Usuário e/ou senha inválidos'
                        }
                    })
                this.loading = false
            }
        },
        computed: {
            ...mapState({
                token: state => state.auth.token
            }),
            /*...mapGetters('cart', {
                products: 'cartProducts',
                total: 'cartTotalPrice'
            })*/
        }

    };
</script>
<style scoped lang="css">
    #login {
        background: #EFEFEF url('/static/back.jpg') no-repeat fixed center;
    }
    #logo {
        max-width: 170px;
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 50%;
    }
</style>
