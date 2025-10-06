<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <div>
        <v-breadcrumbs :items="items">
            <template v-slot:item="props">
                <v-breadcrumbs-item :href="props.item.href" :disabled="props.item.disabled">
                    {{ props.item.text.toUpperCase()}}
                </v-breadcrumbs-item>
            </template>
        </v-breadcrumbs>
    </div>
</template>

<script>
    export default {
        name: "app-breadcrumbs",
        props: {
            icon: {
                type: String,
                required: false,
                default: 'home'
            },
            items: {
                type: Array,
                required: false
            }
        },
        beforeUpdate() {
            this.items.sort((item1, item2) => item1.position - item2.position);
        },
        methods: {
            reloadPage() {
                this.$router.go();
            }
        }
    };
</script>

<style scoped>
    .link {
        text-decoration: none;
    }

    .disabled {
        color: grey;
        pointer-events: none
    }
</style>
