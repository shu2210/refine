<template>
  <tr :id="`comment-area-${reviewId}`">
    <td colspan="2">
      <div class="uk-container uk-flex" v-if="isLogin">
        <input type="text" class="uk-input" v-model="comment" />
        <button class="uk-button uk-button-primary uk-text-nowrap" @click="addComment">コメント</button>
      </div>
      <div class="uk-text-center" v-else>
        <a class="uk-button uk-button-default uk-width-expand" href="/users/sign_in">
          コメントをするには会員登録またはログインしてください
        </a>
      </div>
    </td>
  </tr>
</template>

<script>
import Vue from 'vue/dist/vue.esm.js';
import PostedComment from './PostedComment';
import axios from 'axios';
import DateHelper from '../../helpers/date.helper.js';

export default {
  mixins: [DateHelper],
  props: {
    reviewId: {
      type: Number
    },
    isLogin: {
      type: Boolean
    }
  },
  data() {
    return {
      comment: ''
    }
  },
  methods: {
    addComment() {
      var vm = this;

      axios.post('/comments', {
        comments: { comment: this.comment, review_id: this.reviewId }
      }).then((response) => {
        if(response.data.status != 'success') {
          return;
        }
        this.comment = '';

        var newComment = response.data.comment;
        var ComponentClass = Vue.extend(PostedComment);
        var instance = new ComponentClass({
          propsData: {
            id: newComment['id'],
            defaultComment: newComment['comment'],
            userName: newComment['user']['name'],
            userIcon: newComment['user']['icon_url'],
            canEdit: true,
            createdAt: vm.parseDate(newComment['created_at'])
          }
        });
        instance.$mount();

        $(`#comment-area-${this.reviewId}`).before(instance.$el);
        console.log(response.data);
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>