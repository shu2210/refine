import Vue from 'vue/dist/vue.esm.js';
import Badge from './components/common/Badge.vue';
import GoodBadButton from './components/code/GoodBadButton.vue';
import CodeArea from './components/code/CodeArea.vue';
import CodeAreaEdit from './components/code/CodeAreaEdit.vue';
import TagInput from './components/code/TagInput.vue';

new Vue({
  el: '#code',
  components: {
    GoodBadButton,
    CodeArea,
    CodeAreaEdit,
    Badge,
    TagInput
  },
  data: function () {
    return {
      tags: []
    }
  },
  methods: {
    addTags: function () {
      var keywords = $('#tag').siblings('.tagsinput').children('.tag');
      for (var i = keywords.length; i--;) {
        this.tags.push($(keywords[i]).text().substring(0, $(keywords[i]).text().length -  1).trim());
      }
    }
  }
})
