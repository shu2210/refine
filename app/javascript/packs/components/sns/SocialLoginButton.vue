<template>
  <div class="uk-inline uk-width-1-1 uk-margin-bottom"
      :class="['uk-width-' + width, background_color]">
    <span class="uk-form-icon" :uk-icon="provider"></span>
    <a :href="url" class="uk-button uk-button-default uk-margin-small-right uk-width-1-1">
      {{ provider }}でログイン
    </a>
  </div>
</template>

<script>
export default {
  props: {
    url: {
      type: String,
      required: true
    },
    provider: {
      type: String,
      required: true
    },
    width: {
      type: String,
      default: '1-1'
    },
    background_color: {
      type: String,
      default: 'default'
    }
  }
}
</script>

<style scoped>
.white {
  background-color: #fff;
}
</style>
