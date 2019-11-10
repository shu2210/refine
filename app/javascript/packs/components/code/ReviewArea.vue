<template>
  <tr class="review-area">
    <td colspan="2">
      <textarea class="uk-textarea review" v-model="review" rows="5"></textarea>
      <div class="uk-text-right uk-margin">
        <button class="uk-button uk-button-default" @click="cancelReview">キャンセル</button>
        <button class="uk-button uk-button-primary" @click="postReview">投稿</button>
      </div>
    </td>
  </tr>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    code_id: Number,
    line: Number
  },
  data: function () {
    return {
      review: ''
    }
  },
  methods: {
    postReview: function () {
      console.log(this.review);
      axios.post('/reviews', { review: { line: this.line, code_id: this.code_id, review: this.review } }).then((response) => {
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
