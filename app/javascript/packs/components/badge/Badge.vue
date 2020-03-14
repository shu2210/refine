<template>
  <span
    class="status-badge uk-badge"
    :class="badgeClass"
  >
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
    badgeClass: {
      type: String,
      default: ''
    }
  }
}
</script>

<style scoped>
.status-badge {
  background-color: #E9606D !important;
}
</style>
