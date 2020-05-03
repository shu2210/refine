<template>
  <tr :id="`comment-${id}`" v-if="show">
    <td colspan="2">
      <div class="comment-area uk-margin-large-left">
        <div class="edit-comment" v-if="mode == 'edit'">
          <div class="uk-container">
            <textarea class="uk-input uk-margin" v-model="comment" />
            <div class="uk-text-right">
              <button class="uk-button uk-button-default uk-text-nowrap" @click="cancelComment">キャンセル</button>
              <button class="uk-button uk-button-primary uk-text-nowrap" @click="updateComment">更新</button>
            </div>
          </div>
        </div>
        <div class="posted-review uk-flex" v-else>
          <div class="uk-flex-first uk-width-1-6 uk-text-center">
            <img :src="userIcon" class="uk-border-circle uk-width-1-3" />
            <div class="user-name uk-margin">
              {{ userName }}
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="control-area uk-width-1-1 uk-text-right uk-margin" v-if="canEdit">
              <a class="uk-margin-small-right uk-icon-button" uk-icon="check" uk-tooltip="解決済みにする"></a>
              <a class="uk-margin-small-right uk-icon-button" uk-icon="pencil" @click="switchEditMode"></a>
              <a :href="`#confirm${id}`" class="uk-margin-small-right uk-icon-button" uk-icon="trash" uk-toggle></a>
            </div>
            <div class="review-info uk-width-1-1">
              <div class="description">
                <p>{{ comment }}</p>
              </div>
            </div>
            <post-date :posted-at="createdAt" />
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
import Modal from '../common/Modal';
import PostDate from './PostDate';

export default {
  props: {
    id: {
      type: Number,
      default: 0
    },
    defaultComment: {
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
    },
    canEdit: {
      type: Boolean,
      default: false
    },
    createdAt: {
      type: Date
    }
  },
  data() {
    return {
      originalComment: '',
      comment: this.defaultComment,
      mode: 'view'
    }
  },
  methods: {
    switchEditMode() {
      // キャンセルした時のためにオリジナルのコメントを保持
      this.originalComment = this.comment;
      this.mode = 'edit';
    },
    switchViewMode() {
      this.mode = 'view';
    },
    cancelComment() {
      this.comment = this.originalComment;
      this.switchViewMode();
    },
    updateComment() {
      axios.put(`/comments/${this.id}`, { comment: this.comment }).then((response) => {
        if(response.data['status'] == 'success') {
          this.switchViewMode();
        }
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
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
    Modal,
    PostDate
  }
}
</script>