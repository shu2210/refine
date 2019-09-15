<template>
  <span class="status-badge uk-badge uk-padding-small uk-margin-small-bottom">{{ label }}</span>
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
.status-badge {
  background-color: #E9606D !important;
}
</style>
