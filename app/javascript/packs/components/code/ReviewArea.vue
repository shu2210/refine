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
    codeId: Number,
    line: Number
  },
  data: function () {
    return {
      review: '',
      type: 1,
      userName: ''
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
