<template>
  <tr>
    <td colspan="2">
      <div class="comment-area uk-margin-large-left">
        <div class="posted-review uk-flex">
          <div class="uk-flex-first uk-width-1-6 uk-text-center">
            <img src="icon" class="uk-border-circle uk-width-1-3" />
            <div class="user-name uk-margin">
              {{ userName }}
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="control-area uk-width-1-1 uk-text-right uk-margin">
              <a class="uk-margin-small-right" uk-icon="pencil"></a>
              <a href="#confirm" class="uk-margin-small-right" uk-icon="trash" uk-toggle></a>
            </div>
            <div class="review-info uk-width-1-1">
              <div class="description">
                <p>{{ comment }}</p>
              </div>
            </div>
          </div>
          <modal title="確認" id="confirm1">
            <p class="uk-margin">削除すると元に戻せません。よろしいですか？</p>
            <div class="uk-text-right">
              <button class="uk-button uk-button-default uk-modal-close" type="button">キャンセル</button>
              <button class="uk-button uk-button-primary" type="button">削除</button>
            </div>
          </modal>
        </div>
      </div>
    </td>
  </tr>
</template>

<script>
import Modal from '../common/Modal.vue';

export default {
  props: {
    comment: {
      type: String,
      default: ''
    },
    userName: {
      type: String,
      default: ''
    }
  },
  components: {
    Modal
  }
}
</script>