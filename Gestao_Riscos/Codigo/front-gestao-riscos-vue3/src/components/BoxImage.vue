<template>
  <v-img
    :width="width"
    :height="height"
    aspect-ratio="1"
    :src="pathImg"
    cover
  ></v-img>
</template>

<script setup lang="ts">
import { watch } from 'vue';

const props = defineProps<{
  pathImg: string;
  width: string | number;
  height: string | number;
}>();

watch(props, () => {
  console.log('Caminho da imagem: ', props.pathImg);
});
</script>

<style scoped></style>
