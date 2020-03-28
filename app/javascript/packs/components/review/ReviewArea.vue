<template>
  <tr class="review-area">
    <td colspan="2">
      <review-editor
        commit-label="投稿"
        @input="review = $event"
        @commit="postReview"
        @cancel="cancelReview"
      />
    </td>
  </tr>
</template>

<script>
import axios from 'axios';
import ReviewEditor from './ReviewEditor';

export default {
  props: {
    codeId: Number,
    line: Number
  },
  data() {
    return {
      review: '',
      userName: ''
    }
  },
  methods: {
    postReview() {
      axios.post('/reviews', { review: { line: this.line, code_id: this.codeId, review: this.review } }).then((response) => {
        if(response.data.status != 'success') {
          return;
        }
        this.userName = response.data.user.name
        this.$emit('post-review', this, response);
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    cancelReview() {
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
    }
  },
  components: {
    ReviewEditor
  }
}
</script>

<style>
@import 'simplemde/dist/simplemde.min.css';
</style>