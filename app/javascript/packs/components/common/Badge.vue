<template>
  <span class="status-badge uk-badge"
        :class="{
          'uk-padding-small uk-margin-small-bottom': category == 'large',
          'uk-text-small': category == 'required'
        }">
    {{ label }}
  </span>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true
    },
    category: {
      type: String,
      default: 'large'
    }
  }
}
</script>

<style scoped>
.status-badge {
  background-color: #E9606D !important;
}
</style>
