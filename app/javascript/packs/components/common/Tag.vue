<template>
  <div class="uk-inline" :class="'uk-width-' + width">
    <span class="tag uk-margin-small-left uk-margin-small-top uk-text-small">
      {{ label }}
    </span>
  </div>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true
    },
    width: {
      type: String,
      default: 'auto'
    }
  }
}
</script>

<style scoped>
.tag {
  display: block;
  padding: 5px;
  border-radius: 5px;
  background-color: #B2CDDE;
}
</style>
