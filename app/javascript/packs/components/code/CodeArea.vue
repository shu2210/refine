<template>
  <div class="uk-margin">
    <div class="code-title uk-padding-small">
      <span>{{ title }}</span>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="trash"></a>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="file-edit"></a>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="copy"></a>
    </div>
    <div class="code">
      <table class="uk-table uk-table-small uk-table-hover uk-margin-remove">
        <tr v-for="(codeLine, line) in codeLines" :id="`code${no}-${(line + 1)}`" :key="line">
          <td class="line-num uk-table-shrink">
            <a class="uk-icon-button" uk-icon="comment" @click="createReviewArea(line + 1)" v-if="isLogin"></a>
            <span>{{ line + 1 }}</span>
          </td>
          <td>
            <pre class="line">{{ codeLine }}</pre>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import ReviewArea from '../review/ReviewArea';
import PostedReview from '../review/PostedReview';
import PostedComment from '../review/PostedComment';
import Comment from '../review/Comment';
import FoldingComment from '../review/FoldingComment';
import Vue from 'vue/dist/vue.esm.js';
import axios from 'axios';

export default {
  props: {
    no: Number,
    title: String,
    code: String,
    codeId: Number,
    isLogin: Boolean,
    postedUserIcon: String,
    currentUserId: Number
  },
  data() {
    return {
      codeLines: []
    }
  },
  mounted() {
    this.codeLines = this.code.split(/\n/);
    this.fetchReview();
  },
  methods: {
    createReviewArea(line) {
      var review = $(`#code${this.no}-${line}`).next('.review-area');
      if(review.length >= 1) {
        return
      }

      var ComponentClass = Vue.extend(ReviewArea)
      var instance = new ComponentClass({
        propsData: {
          codeId: this.codeId,
          line: line
        }
      });
      instance.$on('post-review', this.switchReview);
      instance.$mount();
      $(`#code${this.no}-${line}`).after(instance.$el);
    },
    fetchReview() {
      var vm = this;

      axios.get(`/reviews/${this.codeId}`).then((response) => {
        response.data.review.forEach(function(review) {
          var userName = vm.getUserName(response.data.users, review['user_id']);
          vm.appendPostedReview({
            id: review['id'],
            line: review['line'],
            userName: userName,
            review: review['review'],
            icon: vm.postedUserIcon,
            canEdit: (review['user_id'] == vm.currentUserId),
            createdAt: vm.parseDate(review['created_at'])
          })
          vm.appendCommentArea(review['id'], review['comments'].length, `#review-${review['id']}`);
          vm.appendFoldingComment(review['id'], review['comments'].length);
        });
      }, (error) => {
        console.log(error);
      });
    },
    getUserName(users, userId) {
      for(var i = 0; i < users.length; i++) {
        if(userId == users[i]['id']) {
          return users[i]['name'];
        }
      }
    },
    // 投稿された後の処理
    switchReview(component, response) {
      component.$destroy();
      component.$el.parentNode.removeChild(component.$el);
      this.appendPostedReview({
        id: response.data.id,
        line: component.line,
        userName: component.userName,
        review: component.review,
        icon: response.data.icon,
        canEdit: true,
        createdAt: this.parseDate(response.data.review['created_at'])
      })
    },
    appendPostedReview(props) {
      var ComponentClass = Vue.extend(PostedReview);
      var instance = new ComponentClass({ propsData: props });
      instance.$mount();
      $(`#code${this.no}-${props['line']}`).after(instance.$el);
    },
    appendFoldingComment(reviewId, commentCount) {
      var ComponentClass = Vue.extend(FoldingComment);
      var instance = new ComponentClass({
        propsData: {
          reviewId: reviewId,
          commentCount: commentCount
        }
      });
      instance.$mount();
      instance.$on('display', this.appendPostedComment)

      $(`#review-${reviewId}`).after(instance.$el);
    },
    // ~件のコメントを表示クリック時に発火
    appendPostedComment(reviewId) {
      var vm = this;

      axios.get(`/comments/${reviewId}`).then((response) => {
        response.data.comments.forEach(function(comment) {
          var ComponentClass = Vue.extend(PostedComment);
          var instance = new ComponentClass({
            propsData: {
              id: comment['id'],
              defaultComment: comment['comment'],
              userName: comment['user']['name'],
              userIcon: comment['user']['icon'],
              canEdit: (comment['user_id'] == vm.currentUserId),
              createdAt: vm.parseDate(comment['created_at'])
            }
          });
          instance.$mount();

          $(`#review-${reviewId}`).after(instance.$el);
        });
        vm.appendCommentArea(reviewId, 0, `#comment-${response.data.comments[0]['id']}`);
      }, (error) => {
        console.log(error);
      });
    },
    parseDate(dateStr) {
      var date = Date.parse(dateStr);
      return new Date(date);
    },
    appendCommentArea(reviewId, commentCount, appendId) {
      if(commentCount > 0) {
        return;
      }
      var ComponentClass = Vue.extend(Comment);
      var instance = new ComponentClass({
        propsData: {
          reviewId: reviewId
        }
      });
      instance.$mount();
      $(appendId).after(instance.$el);
    }
  }
}
</script>

<style lang="scss" scoped>
$background-color: #EFEFEF;
$border-color: #bbb;

.code-title {
  background-color: $background-color;
  border: solid 1px $border-color;

  .uk-icon-link:not(:first-of-type) {
    margin-right: 15px !important;
  }
}

.code {
  border: solid 1px $border-color;

  tr {
    &:hover .line-num .uk-icon-button {
      visibility: visible;
    }

    .line-num {
      position: relative;
      background-color: $background-color;

      .uk-icon-button {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: -25px;
        visibility: hidden;
      }
    }

    .line {
      display: inline;
      background-color: transparent;
      border: none;
    }
  }
}
</style>
