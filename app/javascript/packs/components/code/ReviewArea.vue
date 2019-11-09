<template>
  <tr>
    <td colspan="2">
      <textarea class="uk-textarea" rows="5"></textarea>
      <div class="uk-text-right uk-margin">
        <button class="uk-button uk-button-default" @click="cancelReview">キャンセル</button>
        <button class="uk-button uk-button-primary" @click="postReview">投稿</button>
      </div>
    </td>
  </tr>
</template>

<script>
export default {
  methods: {
    postReview: function () {
      console.log('test');
    },
    cancelReview: function () {
      console.log('cancel');
    }
  }
}
</script>
