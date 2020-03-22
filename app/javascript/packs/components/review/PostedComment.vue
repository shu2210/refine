<template>
  <tr v-if="show">
    <td colspan="2">
      <div class="comment-area uk-margin-large-left">
        <div class="posted-review uk-flex">
          <div class="uk-flex-first uk-width-1-6 uk-text-center">
            <img :src="userIcon" class="uk-border-circle uk-width-1-3" />
            <div class="user-name uk-margin">
              {{ userName }}
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="control-area uk-width-1-1 uk-text-right uk-margin">
              <a class="uk-margin-small-right" uk-icon="pencil"></a>
              <a :href="`#confirm${id}`" class="uk-margin-small-right" uk-icon="trash" uk-toggle></a>
            </div>
            <div class="review-info uk-width-1-1">
              <div class="description">
                <p>{{ comment }}</p>
              </div>
            </div>
          </div>
          <modal :id="`confirm${id}`">
            <p class="uk-margin">削除すると元に戻せません。よろしいですか？</p>
            <div class="uk-text-right">
              <button class="uk-button uk-button-default uk-modal-close" type="button">キャンセル</button>
              <button class="uk-button uk-button-primary" type="button" @click="deleteComment">削除</button>
            </div>
          </modal>
        </div>
      </div>
    </td>
  </tr>
</template>

<script>
import axios from 'axios';
import Modal from '../common/Modal.vue';

export default {
  props: {
    id: {
      type: Number,
      default: 0
    },
    comment: {
      type: String,
      default: ''
    },
    userName: {
      type: String,
      default: ''
    },
    userIcon: {
      type: String,
      default: ''
    },
    show: {
      type: Boolean,
      default: true
    }
  },
  methods: {
    deleteComment() {
      axios.delete(`/comments/${this.id}`).then((response) => {
        if(response.data['status'] == 'success') {
          this.show = false;
        }
        UIkit.modal(`#confirm${this.id}`).hide();
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    }
  },
  components: {
    Modal
  }
}
</script>