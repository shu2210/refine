import Vue from 'vue/dist/vue.esm.js';
import Badge from './components/common/Badge.vue';
import Tag from './components/common/Tag.vue';
import ReviewInfo from './components/home/ReviewInfo.vue';
import IconUploader from './components/profile/IconUploader.vue';
import GoodBadButton from './components/code/GoodBadButton.vue';
import CodeArea from './components/code/CodeArea.vue';
import CodeAreaEdit from './components/code/CodeAreaEdit.vue';
import TagInput from './components/code/TagInput.vue';
import SocialLoginButton from './components/sns/SocialLoginButton.vue';
import PopularTags from './components/home/PopularTags.vue';
import Jumbotron from './components/home/Jumbotron.vue';
import Modal from './components/common/Modal.vue';
import sanitizeHTML from 'sanitize-html';

Vue.prototype.$sanitize = sanitizeHTML

new Vue({
  el: '#app',
  components: {
    GoodBadButton,
    CodeArea,
    CodeAreaEdit,
    Badge,
    TagInput,
    Tag,
    ReviewInfo,
    IconUploader,
    Jumbotron,
    PopularTags,
    SocialLoginButton,
    Modal
  },
  data() {
    return {
      tags: []
    }
  },
  methods: {
    addTags() {
      var keywords = $('#tag').siblings('.tagsinput').children('.tag');
      for (var i = keywords.length; i--;) {
        this.tags.push($(keywords[i]).text().substring(0, $(keywords[i]).text().length -  1).trim());
      }
    }
  }
})
