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
          <a class="uk-margin-small-right" uk-icon="trash" @click="deleteReview"></a>
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
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>
