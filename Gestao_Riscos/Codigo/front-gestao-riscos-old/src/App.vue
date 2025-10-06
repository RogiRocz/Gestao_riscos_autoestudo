<template>
    <div id="appRoot">
        <template v-if="!$route.meta.public">
            <v-app>
                <app-toolbar></app-toolbar>
                <v-content>
                    <v-container fluid>
                        <div class="page-wrapper">
                            <router-view></router-view>
                        </div>
                    </v-container>
                </v-content>

                <!-- App Footer -->
                <v-footer height="auto" class="white pa-3 app--footer">
                    <span class="caption">Núcleo de Práticas em Informática &copy; {{ new Date().getFullYear() }}</span>
                </v-footer>

            </v-app>
        </template>
        <template v-else>
            <transition>
                <keep-alive>
                    <router-view :key="$route.fullpath"></router-view>
                </keep-alive>
            </transition>
        </template>
    </div>
</template>

<script>
    import AppToolbar from './components/core/AppToolbar'

    export default {
        name: 'App',
        components: {
            AppToolbar
        },
        data () {
            return {
                //
            }
        },
        /*created: function () {
            axios.interceptors.response.use(undefined, function (err) {
                return new Promise(function (resolve, reject) {
                    if ((err.status === 401 || err.status === 403) && err.config && !err.config.__isRetryRequest) {
                        // if you ever get an unauthorized, logout the user
                        console.log('unauthou')
                        this.$route.push('403')
                        // you can also redirect to /login if needed !
                    }
                    throw err;
                });
            });
        }*/
    }
</script>

<style lang="stylus" scoped>
    .page-wrapper
        min-height:calc(100vh - 64px - 50px - 81px );

</style>
