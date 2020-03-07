<template>
  <transition name="fade">
    <tr v-if="show">
      <td colspan="2">
        <div class="edit-review" v-if="mode == 'edit'">
          <vue-simplemde v-model="review" ref="markdownEditor" />
          <div class="uk-text-right uk-margin">
            <button class="uk-button uk-button-default" @click="cancelReview">キャンセル</button>
            <button class="uk-button uk-button-primary" @click="updateReview">更新</button>
          </div>
        </div>
        <div class="posted-review uk-flex" v-else>
          <div class="uk-flex-first uk-width-1-6 uk-text-center">
            <img :src="icon" class="uk-border-circle uk-width-1-3" />
          </div>
          <div class="review-info uk-width-3-6">
            <div class="user-name uk-margin">
              {{ userName }}
            </div>
            <div class="description">
              <p v-html="markedReview"></p>
            </div>
          </div>
          <div class="control-area uk-width-1-6 uk-text-center" v-if="canEdit">
            <a class="uk-margin-small-right" uk-icon="pencil" @click="switchEditMode"></a>
            <a :href="'#confirm' + id" class="uk-margin-small-right" uk-icon="trash" uk-toggle></a>
            <a class="uk-margin-small-right" uk-icon="menu"></a>
          </div>
          <modal title="確認" :id="'confirm' + id">
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
import Modal from '../common/Modal.vue';
import marked from 'marked/marked.min.js';
import hljs from 'highlight.js';
import 'highlight.js/styles/github-gist.css';
import VueSimplemde from 'vue-simplemde';

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
      highlight: function(code, lang) {
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
          // TODO: fade後、削除
          // this.$destroy();
          // this.$el.parentNode.removeChild(this.$el);
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
    VueSimplemde
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