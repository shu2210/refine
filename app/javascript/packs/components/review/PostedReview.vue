<template>
  <transition name="fade">
    <tr v-if="show" :id="'review-' + id">
      <td colspan="2">
        <div class="edit-review" v-if="mode == 'edit'">
          <review-editor
            commit-label="更新"
            :review="review"
            @input="review = $event"
            @commit="updateReview"
            @cancel="cancelReview"
          />
        </div>
        <div class="posted-review uk-flex" v-else>
          <div class="uk-flex-first uk-width-1-6 uk-text-center">
            <img :src="icon" class="uk-border-circle uk-width-1-3" />
            <div class="user-name uk-margin">
              {{ userName }}
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="control-area uk-width-1-1 uk-text-right uk-margin" v-if="canEdit">
              <a class="uk-margin-small-right uk-icon-button" uk-icon="check" uk-tooltip="解決済みにする"></a>
              <a class="uk-margin-small-right uk-icon-button" uk-icon="pencil" @click="switchEditMode" uk-tooltip="編集"></a>
              <a :href="`#confirm${id}`" class="uk-margin-small-right uk-icon-button" uk-icon="trash" uk-tooltip="削除" uk-toggle></a>
            </div>
            <div class="review-info uk-width-1-1">
              <div class="description">
                <p v-html="markedReview"></p>
              </div>
            </div>
            <post-date :posted-at="createdAt" />
          </div>
          <modal :id="'confirm' + id">
            <p class="uk-margin">削除すると元に戻せません。よろしいですか？</p>
            <div class="uk-text-right">
              <button class="uk-button uk-button-default uk-modal-close" type="button">キャンセル</button>
              <button class="uk-button uk-button-primary" type="button" @click="deleteReview">削除</button>
            </div>
          </modal>
        </div>
      </td>
    </tr>
  </transition>
</template>

<script>
import axios from 'axios';
import Modal from '../common/Modal';
import marked from 'marked/marked.min.js';
import hljs from 'highlight.js';
import 'highlight.js/styles/github-gist.css';
import ReviewEditor from './ReviewEditor';
import PostDate from './PostDate';

export default {
  props: {
    id: {
      type: Number
    },
    userName: {
      type: String,
      default: ''
    },
    review: {
      type: String,
      default: ''
    },
    icon: {
      type: String
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
      show: true,
      mode: 'view'
    }
  },
  created() {
    marked.setOptions({
      langPrefix: '',
      highlight(code, lang) {
        return hljs.highlightAuto(code, [lang]).value
      }
    });
  },
  computed: {
    markedReview() {
      return marked(this.review);
    }
  },
  methods: {
    switchEditMode() {
      this.mode = 'edit';
    },
    switchViewMode() {
      this.mode = 'view';
    },
    cancelReview() {
      this.switchViewMode();
    },
    updateReview() {
      axios.put('/reviews/' + this.id, { review: this.review }).then((response) => {
        this.switchViewMode();
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    deleteReview() {
      axios.delete('/reviews/' + this.id).then((response) => {
        if(response.data['status'] == 'success') {
          this.show = false;
          $(`#comment-area-${this.id}`).fadeOut();
          $(`#folding-comment-${this.id}`).fadeOut();
          response.data.comments.forEach(function(comment) {
            $(`#comment-${comment['id']}`).fadeOut();
          });
        }
        UIkit.modal('#confirm' + this.id).hide();
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    }
  },
  components: {
    Modal,
    ReviewEditor,
    PostDate
  }
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>