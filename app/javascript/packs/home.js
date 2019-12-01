import Vue from 'vue/dist/vue.esm.js';
import SocialLoginButton from './components/sns/SocialLoginButton.vue';
import Tag from './components/common/Tag.vue';
import PopularTags from './components/home/PopularTags.vue';
import Jumbotron from './components/home/Jumbotron.vue';
import Badge from './components/common/Badge';
import ReviewInfo from './components/home/ReviewInfo';

new Vue({
  el: '#home',
  components: {
    Badge,
    Jumbotron,
    PopularTags,
    ReviewInfo,
    SocialLoginButton,
    Tag
  }
})
