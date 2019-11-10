<template>
  <tr class="review-area">
    <td colspan="2">
      <textarea class="uk-textarea review" rows="5"></textarea>
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
  methods: {
    postReview: function () {
      axios.post('/codes/likes', { code_id: this.code_id }).then((response) => {
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
