<template>
  <tr class="review-area">
    <td colspan="2" v-if="type == 1">
      <textarea class="uk-textarea review" v-model="review" rows="5"></textarea>
      <div class="uk-text-right uk-margin">
        <button class="uk-button uk-button-default" @click="cancelReview">キャンセル</button>
        <button class="uk-button uk-button-primary" @click="postReview">投稿</button>
      </div>
    </td>
    <td colspan="2" v-else-if="type == 2">
      <div class="posted_review uk-flex">
        <div class="uk-flex-first uk-width-1-6 uk-text-center">
          <img class="uk-border-circle uk-width-1-3" />
        </div>
        <div class="review-info uk-width-3-6">
          <div class="user-name uk-margin">
            shuto.yasunaga
          </div>
          <div class="description">
            <p>
              ここはこうしたらどうでしょうか？
            </p>
          </div>
        </div>
        <div class="control-area uk-width-1-6 uk-text-center">
          <a class="uk-margin-small-right" uk-icon="pencil"></a>
          <a class="uk-margin-small-right" uk-icon="trash"></a>
          <a class="uk-margin-small-right" uk-icon="menu"></a>
        </div>
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
      review: '',
      type: 1
    }
  },
  methods: {
    postReview: function () {
      console.log(this.review);
      axios.post('/reviews', { review: { line: this.line, code_id: this.code_id, review: this.review } }).then((response) => {
        this.type = 2;
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
