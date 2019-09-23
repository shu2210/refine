<template>
  <ul class="code-list">
    <li class="uk-margin" v-for="n in 10">
      <div class="uk-flex">
        <div class="status uk-width-1-6 uk-text-center">
          <badge label="受付中"></badge>
          <review-info></review-info>
        </div>
        <div class="information uk-width-4-6 uk-margin-left">
          <a class="uk-text-large" href="/codes/1">Rubyのfizz_buzz問題</a>
          <div class="tags uk-margin-top">
            <tag label="Ruby"></tag>
            <tag label="Rails"></tag>
          </div>
        </div>
        <div class="user uk-width-1-6">
          <div class="uk-width-1-2 uk-align-right">
            <img src="~ruby.png" />
          </div>
          <div class="user-name uk-text-right">
            <span>s_yasunaga</span>
          </div>
        </div>
      </div>
      <hr />
    </li>
  </ul>
</template>

<script>
import Tag from '../common/Tag';
import Badge from '../common/Badge';
import ReviewInfo from './ReviewInfo';
import 'ruby.png';

export default {
  components: {
    Tag, Badge, ReviewInfo
  }
}
</script>
