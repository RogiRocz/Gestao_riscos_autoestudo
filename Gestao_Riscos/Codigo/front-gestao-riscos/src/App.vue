<template>
    <v-app>
        <template v-if="!$route.meta.public">
            <app-navbar/>

            <v-main class="wrapper fill-height">
                <v-container fluid>
                    <v-snackbar color="success" v-model="snackbar" :timeout="timeout" elevation="24" right top class="mt-0 mr-1">
                        {{ text }}
                    </v-snackbar>

                    <app-breadcrumbs :items="breadcrumbItems"/>

                    <router-view v-if="finished"></router-view>
                </v-container>
            </v-main>

        </template>

        <template v-else>
          <transition>
            <keep-alive>
              <router-view :key="$route.fullpath"></router-view>
            </keep-alive>
          </transition>
        </template>
    </v-app>
</template>

<script>
    import { mapState } from 'vuex';
    import axios from 'axios'
    import AppNavbar from '@/components/core/AppNavbar';
    import AppBreadcrumbs from "@/components/core/AppBreadcrumbs";

    export default {
        name: 'App',
        components: {
            AppNavbar,
            AppBreadcrumbs
        },

        data: () => ({
            snackbar: false,
            text: 'Ação cadastrada com sucesso',
            timeout: 4000,
            finished: false
        }),

        computed: {
            ...mapState({
                breadcrumbItems: state => state.app.breadcrumbItems
            })
        },

        created() {
            if (typeof this.$route.query.plano != 'undefined') {
                axios.get('/planos/' + this.$route.query.plano).then(res => {
                    this.$store.dispatch('app/setPlano', res.data).then(() => {
                        this.finished = true;
                    });
                })
            } else {
                axios.get('/planos/vigente').then(res => {
                    this.$store.dispatch('app/setPlano', res.data).then(() => {
                        this.finished = true;
                    });
                })
            }
            axios.get('/usuarios/unidade').then(res => {
                this.$store.dispatch('app/setUnidade', res.data);
            })
        },

        methods: {
            logout() {
                this.$router.push('/logout')
            }

        }
    };
</script>

<style lang="stylus" scoped>
    .wrapper
        background-color: #f4f4f4;;

</style>
