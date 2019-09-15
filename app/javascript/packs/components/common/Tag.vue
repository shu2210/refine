<template>
  <span class="tag uk-margin-small-left">{{ label }}</span>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true
    }
  }
}
</script>

<style scoped>
.tag {
  padding: 7px;
  border-radius: 5px;
  background-color: #B2CDDE;
}
</style>
