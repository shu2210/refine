<template>
  <div>
    <span>人気のタグ</span>
    <ul class="tag-list">
      <li v-for="lang in ['Ruby', 'Rails', 'Java', 'PHP', 'Python']">
        <div class="uk-flex uk-flex-center uk-flex-middle">
          <div class="uk-width-1-2 uk-text-center">
            <tag :label="lang" width="1-2"></tag>
          </div>
          <div class="uk-width-1-2">
            <span class="uk-margin-left uk-text-bold">100 post</span>
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
  }
}
</script>
