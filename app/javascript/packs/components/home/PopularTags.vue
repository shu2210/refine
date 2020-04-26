<template>
  <div>
    <span>人気のタグ</span>
    <ul class="tag-list">
      <li v-for="tag in tags" :key="tag.id">
        <div class="uk-flex uk-flex-center uk-flex-middle">
          <div class="uk-width-1-2 uk-text-center">
            <tag :label="tag.name" width="1-2"></tag>
          </div>
          <div class="uk-width-1-2">
            <span class="uk-margin-left uk-text-bold">{{ tag.count }} post</span>
          </div>
        </div>
        <hr class="uk-margin-small" />
      </li>
    </ul>
  </div>
</template>

<script>
import Tag from '../common/Tag';

export default {
  components: {
    Tag
  },
  props: {
    tags: {
      type: Array,
      default: []
    }
  }
}
</script>
