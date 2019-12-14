import Vue from 'vue/dist/vue.esm.js';
import Badge from './components/common/Badge.vue';
import Tag from './components/common/Tag.vue';
import ReviewInfo from './components/home/ReviewInfo.vue';

new Vue({
  el: '#profile',
  components: {
    Badge,
    Tag,
    ReviewInfo
  }
})
