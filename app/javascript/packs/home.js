import Vue from 'vue/dist/vue.esm.js'
import SocialLoginButton from './components/sns/SocialLoginButton.vue'
import CodeList from './components/home/CodeList.vue'
import Tag from './components/common/Tag.vue'
import PopularTags from './components/home/PopularTags.vue'

new Vue({
  el: '#home',
  components: {
    SocialLoginButton, CodeList, Tag, PopularTags
  }
})
