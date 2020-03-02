<template>
  <tr class="review-area">
    <td colspan="2">
      <div id="codex-editor" />

      <quill-editor
        v-model="review"
        ref="quillEditor"
        :options="option"
      />
      <div class="uk-text-right uk-margin">
        <button class="uk-button uk-button-default" @click="cancelReview">キャンセル</button>
        <button class="uk-button uk-button-primary" @click="postReview">投稿</button>
      </div>
    </td>
  </tr>
</template>

<script>
import Vue from 'vue/dist/vue.esm.js';
import axios from 'axios';
import VueQuillEditor from 'vue-quill-editor';
import 'quill/dist/quill.core.css';
import 'quill/dist/quill.snow.css';
import 'quill/dist/quill.bubble.css';

Vue.use(VueQuillEditor);

export default {
  props: {
    codeId: Number,
    line: Number
  },
  data: function () {
    return {
      review: '',
      type: 1,
      userName: '',
      option: {
        theme: 'snow'
      }
    }
  },
  methods: {
    postReview: function () {
      axios.post('/reviews', { review: { line: this.line, code_id: this.codeId, review: this.review } }).then((response) => {
        this.userName = response.data.user.name
        this.$emit('post-review', this, response);
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    cancelReview: function () {
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
    }
  }
}
</script>
