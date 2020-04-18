import Vue from 'vue/dist/vue.esm.js';
import Tag from './components/common/Tag.vue';
import ReviewInfo from './components/home/ReviewInfo.vue';
import IconUploader from './components/profile/IconUploader.vue';
import GoodBadButton from './components/code/GoodBadButton.vue';
import CodeArea from './components/code/CodeArea.vue';
import CodeForm from './components/code/CodeForm.vue';
import TagInput from './components/code/TagInput.vue';
import SocialLoginButton from './components/sns/SocialLoginButton.vue';
import PopularTags from './components/home/PopularTags.vue';
import Jumbotron from './components/home/Jumbotron.vue';
import Modal from './components/common/Modal.vue';
import RequiredBadge from './components/badge/RequiredBadge.vue';
import LargeBadge from './components/badge/LargeBadge.vue';
import sanitizeHTML from 'sanitize-html';

Vue.prototype.$sanitize = sanitizeHTML

new Vue({
  el: '#app',
  components: {
    GoodBadButton,
    CodeArea,
    CodeForm,
    RequiredBadge,
    LargeBadge,
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
  }
})
