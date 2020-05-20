<template>
  <div class="uk-margin">
    <div class="code-title uk-padding-small">
      <div class="uk-panel uk-text-right"></div>
    </div>
    <div class="code">
      <table class="uk-table uk-table-small uk-table-hover uk-margin-remove">
        <tr v-for="(codeLine, line) in codeLines" :id="`code${codeId}-${(line + 1)}`" :key="line">
          <td class="line-num uk-table-shrink">
            <a
              class="uk-icon-button review-button"
              uk-icon="comment"
              uk-tooltip="レビューをする"
              @click="createReviewArea(line + 1)"
              v-if="isLogin && !disabled"
            />
            <folding-button
              :code-id="`code${codeId}-${(line + 1)}`"
            />
            <span>{{ line + 1 }}</span>
          </td>
          <td>
            <pre
              class="line"
              v-html="highlight(codeLine)"
            >
            </pre>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import ReviewArea from '../review/ReviewArea';
import CommentArea from '../review/CommentArea';
import PostedReview from '../review/PostedReview';
import PostedComment from '../review/PostedComment';
import FoldingComment from '../review/FoldingComment';
import FoldingButton from './FoldingButton';
import Vue from 'vue/dist/vue.esm.js';
import axios from 'axios';
import hljs from 'highlight.js';
import 'highlight.js/styles/github-gist.css';
import DateHelper from '../../helpers/date.helper.js';

export default {
  components: {
    FoldingButton
  },
  mixins: [DateHelper],
  props: {
    code: {
      type: String
    },
    codeId: {
      type: Number
    },
    isLogin: {
      type: Boolean
    },
    currentUserId: {
      type: Number
    },
    disabled: {
      type: Boolean,
      default: false
    }
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
      var review = $(`#code${this.codeId}-${line}`).next('.review-area');
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
      $(`#code${this.codeId}-${line}`).after(instance.$el);
    },
    fetchReview() {
      if(this.disabled) {
        return;
      }
      var vm = this;

      axios.get(`/reviews/${this.codeId}`).then((response) => {
        response.data.review.forEach(function(review) {
          vm.appendPostedReview({
            id: review['id'],
            line: review['line'],
            userName: review['user']['name'],
            review: review['review'],
            icon: review['user']['icon_url'],
            canEdit: (review['user_id'] == vm.currentUserId),
            createdAt: vm.parseDate(review['created_at']),
            resolved: review['resolved']
          });
          if(review['comments'].length == 0) {
            vm.appendCommentArea(review['id'], `#review-${review['id']}`);
          }
          vm.appendFoldingComment(review['id'], review['comments'].length);
        });
      }, (error) => {
        console.log(error);
      });
    },
    // 投稿された後の処理
    switchReview(component, response) {
      var newReview = response.data.review;

      component.$destroy();
      component.$el.parentNode.removeChild(component.$el);
      this.appendPostedReview({
        id: newReview['id'],
        line: newReview['line'],
        userName: newReview['user']['name'],
        review: newReview['review'],
        icon: newReview['user']['icon_url'],
        canEdit: true,
        createdAt: this.parseDate(newReview['created_at']),
        resolved: newReview['resolved']
      });
      this.appendCommentArea(newReview['id'], `#review-${newReview['id']}`);
    },
    appendPostedReview(props) {
      var ComponentClass = Vue.extend(PostedReview);
      var instance = new ComponentClass({ propsData: props });
      instance.$mount();
      $(`#code${this.codeId}-${props['line']}`).after(instance.$el);
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
      instance.$on('display', this.fetchComment)

      $(`#review-${reviewId}`).after(instance.$el);
    },
    // ~件のコメントを表示クリック時に発火
    fetchComment(reviewId) {
      var vm = this;

      axios.get(`/comments/${reviewId}`).then((response) => {
        response.data.comments.forEach(function(comment) {
          var ComponentClass = Vue.extend(PostedComment);
          var instance = new ComponentClass({
            propsData: {
              id: comment['id'],
              defaultComment: comment['comment'],
              userName: comment['user']['name'],
              userIcon: comment['user']['icon_url'],
              canEdit: (comment['user_id'] == vm.currentUserId),
              createdAt: vm.parseDate(comment['created_at']),
              resolved: comment['resolved']
            }
          });
          instance.$mount();

          $(`#review-${reviewId}`).after(instance.$el);
        });
        vm.appendCommentArea(reviewId, `#comment-${response.data.comments[0]['id']}`);
        $(`#folding-comment-${reviewId}`).hide();
      }, (error) => {
        console.log(error);
      });
    },
    appendCommentArea(reviewId, appendId) {
      var ComponentClass = Vue.extend(CommentArea);
      var instance = new ComponentClass({
        propsData: {
          reviewId: reviewId,
          isLogin: this.isLogin
        }
      });
      instance.$mount();
      $(appendId).after(instance.$el);
    },
    highlight(code) {
      return hljs.highlightAuto(code).value;
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
  border-bottom: none;

  .uk-icon-link {
    margin-right: 10px !important;
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

      .review-button {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: -25px;
        visibility: hidden;
      }

      .folding-button {
        position: absolute;
        top: 90%;
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
