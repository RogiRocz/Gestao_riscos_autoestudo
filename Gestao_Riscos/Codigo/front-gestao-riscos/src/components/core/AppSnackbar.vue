<template>
    <v-snackbar class="mt-0 mr-1" v-model="visibilidadeStatus" :color="cor" top right :timeout="4000">
        {{texto}}
    </v-snackbar>
</template>

<script>
    export default {
        name: "AppSnackbar",
        data() {
            return {
                visible: false
            }
        },
        props: {
            visibilidade: {
                type: Boolean,
                default: false
            },
            error: {
                type: Boolean,
                default: false
            },
            texto: {
                type: String,
                default: ""
            }
        },

        watch: {
            visibilidade() {
                this.visibilidadeStatus = this.visibilidade;
            }
        },

        methods: {
            cor() {
                return this.error ? 'error' : 'success'
            }
        }
    }
</script>

<style scoped>

</style>