<template>
  <div class="uk-margin tag">
    <input type="hidden" name="tags[]" :value="tag.text" v-for="(tag, index) in tags" :key="index">
    <vue-tags-input
      v-model="tag"
      :tags="tags"
      @tags-changed="newTags => tags = newTags"
      placeholder="タグを追加"
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

<style>
.vue-tags-input {
  min-width: 100% !important;
  background: #324652;
}
.ti-tag {
  color: #FCF6F5FF !important;
  background-color: #2460A7FF !important;
}
.vue-tags-input .ti-input {
  min-height: 40px !important;
  border: solid 1px rgb(229, 229, 229);
}
.vue-tags-input .ti-tag {
  font-size: 15px;
}
</style>