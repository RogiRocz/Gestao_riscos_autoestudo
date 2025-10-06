<template>
    <div id="v-card-widget">
        <v-card outlined>
            <v-toolbar :dark="dark" :color="color" dense flat>
                <v-toolbar-title><span class="title font-weight-light">{{title}}</span></v-toolbar-title>
                <v-spacer></v-spacer>
                <slot name="widget-header-action"></slot>
            </v-toolbar>
            <v-divider v-if="enableHeader"></v-divider>
            <v-card-text :class="contentBg">
                <slot name="widget-content"></slot>
            </v-card-text>
            <v-divider v-if="enableActions"></v-divider>
            <v-card-actions v-if="enableActions">
                <v-spacer></v-spacer>
                <slot name="widget-actions"></slot>
            </v-card-actions>
        </v-card>
    </div>
</template>

<script>
    export default {
        name: 'v-card-widget',
        props: {
            title: {
                type: String,
            },
            color: {
                type: String,
                default: 'transparent'
            },
            enableHeader: {
                type: Boolean,
                default: false
            },
            contentBg: {
                type: String,
                default: 'white'
            },
            enableActions: {
                type: Boolean,
                default: false
            },
        },
        data() {
            return {};
        },
        computed: {
            dark () {
                return this.color !== 'transparent'
            }
        },
    };
</script>

<style scoped>
    .v-card-title {
        color: #332e38;
    }
    /*.v-card__text {
        color: black;
    }*/
</style>

