<template>
  <tr>
    <td colspan="2">
      <div class="posted-review uk-flex">
        <div class="uk-flex-first uk-width-1-6 uk-text-center">
          <img :src="icon" class="uk-border-circle uk-width-1-3" />
        </div>
        <div class="review-info uk-width-3-6">
          <div class="user-name uk-margin">
            {{ userName }}
          </div>
          <div class="description">
            <p>
              {{ review }}
            </p>
          </div>
        </div>
        <div class="control-area uk-width-1-6 uk-text-center" v-if="canEdit">
          <a class="uk-margin-small-right" uk-icon="pencil"></a>
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
</template>

<script>
import axios from 'axios';
import Modal from '../common/Modal.vue';

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
  methods: {
    deleteReview: function () {
      axios.delete('/reviews/' + this.id).then((response) => {
        if(response.data['status'] == 'success') {
          this.$destroy();
          this.$el.parentNode.removeChild(this.$el);
        }
        UIkit.modal('#confirm' + this.id).hide();
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
