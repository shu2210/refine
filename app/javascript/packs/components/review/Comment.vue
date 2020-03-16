<template>
  <tr>
    <td colspan="2">
      <div class="uk-container uk-flex">
        <input type="text" class="uk-input" v-model="comment" />
        <button class="uk-button uk-button-primary uk-text-nowrap" @click="addComment">コメント</button>
      </div>
    </td>
  </tr>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    reviewId: {
      type: Number
    }
  },
  data() {
    return {
      comment: ''
    }
  },
  methods: {
    addComment() {
      axios.post('/comments', {
        comments: {
          comment: this.comment,
          review_id: this.reviewId
        }
      }).then((response) => {
        console.log(response.data);
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>