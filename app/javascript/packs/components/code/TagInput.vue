<template>
  <div class="uk-margin tag">
    <vue-tags-input
      v-model="tag"
      :tags="tags"
      @tags-changed="newTags => tags = newTags"
    />
  </div>
</template>

<script>
import VueTagsInput from '@johmun/vue-tags-input';

export default {
  data() {
    return {
      tag: '',
      tags: []
    }
  },
  components: {
    VueTagsInput
  }
}
</script>

<style scoped>
.vue-tags-input {
  max-width: 100% !important;
}
</style>