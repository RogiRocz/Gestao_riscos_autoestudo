<template>
    <div>
        <label :for="idInput">{{ labeltitle }}</label>

            <v-icon class="material-icons">
                calendar_today
            </v-icon>


        <input type="date" class="form-control" :id="idInput" ref="input" v-bind:value="dateToYYYYMMDD(value)" v-on:input="updateValue($event.target)" v-on:focus="selectAll"

        >

    </div>
</template>


<script>
    export default {
        name: "inputdate",
        props: {
            labeltitle:String,
            idInput:String,
            value: {
                type: Date,
                default: new Date()
            },
        },
        methods: {
            dateToYYYYMMDD(date) {
                return date && date.toISOString().split('T')[0]
            },
            updateValue: function (target) {
                this.$emit('input', target.valueAsDate);
            },
            selectAll: function (event) {
                setTimeout(function () {
                    event.target.select()
                }, 0)
            }
        }
    }
</script>

<style></style>
