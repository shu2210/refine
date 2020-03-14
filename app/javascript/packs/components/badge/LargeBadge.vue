<template>
  <badge
    :label="label"
    badge-class="uk-padding-small uk-margin-small-bottom"
  />
</template>

<script>
import Badge from './Badge.vue';

export default {
  props: {
    label: {
      type: String,
      default: ''
    }
  },
  components: {
    Badge
  }
}
</script>
