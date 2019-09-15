import Vue from 'vue/dist/vue.esm.js'
import SocialLoginButton from './components/sns/SocialLoginButton.vue'
import CodeList from './components/home/CodeList.vue'

new Vue({
  el: '#home',
  components: {
    SocialLoginButton,
    CodeList
  }
})
