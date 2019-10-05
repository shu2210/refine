import Vue from 'vue/dist/vue.esm.js'
import Badge from './components/common/Badge.vue'
import GoodBadButton from './components/code/GoodBadButton.vue'
import CodeArea from './components/code/CodeArea.vue'
import CodeAreaEdit from './components/code/CodeAreaEdit.vue'

new Vue({
  el: '#code',
  components: {
    GoodBadButton,
    CodeArea,
    CodeAreaEdit,
    Badge
  }
})
