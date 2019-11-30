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
        <tr v-for="(codeLine, line) in codeLines" :id="line + 1" :key="line">
          <td class="line-num uk-table-shrink">
            <a class="uk-icon-button" uk-icon="comment" @click="createReviewArea(line + 1)"></a>
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
import ReviewArea from './ReviewArea.vue';
import PostedReview from './PostedReview';
import Vue from 'vue/dist/vue.esm.js';
import axios from 'axios';

export default {
  props: {
    title: String,
    code: String,
    code_id: Number
  },
  data: function () {
    return {
      codeLines: []
    }
  },
  mounted: function () {
    this.codeLines = this.code.split(/\n/);
    this.fetchReview();
  },
  methods: {
    createReviewArea: function (line) {
      var review = $('#' + line).next('.review-area');
      if(review.length >= 1) {
        return
      }

      var ComponentClass = Vue.extend(ReviewArea)
      var instance = new ComponentClass({
        propsData: {
          code_id: this.code_id,
          line: line
        }
      });
      instance.$on('post-review', this.switchReview);
      instance.$mount();
      $('#' + line).after(instance.$el);
    },
    fetchReview: function () {
      var vm = this;

      axios.get('/reviews/' + this.code_id).then((response) => {
        response.data.review.forEach(function(review) {
          var userName = vm.getUserName(response.data.users, review['user_id'])
          vm.appendPostedReview(review['line'], userName, review['review'])
        });
      }, (error) => {
        console.log(error);
      });
    },
    appendPostedReview: function (line, user_name, review) {
      var ComponentClass = Vue.extend(PostedReview);
      var instance = new ComponentClass({
        propsData: {
          user_name: user_name,
          review: review
        }
      });
      instance.$mount();
      $('#' + line).after(instance.$el);
    },
    getUserName: function (users, user_id) {
      for(var i = 0; i < users.length; i++) {
        if(user_id == users[i]['id']) {
          return users[i]['name'];
        }
      }
    },
    // 投稿された後の処理
    switchReview: function (component) {
      component.$destroy();
      component.$el.parentNode.removeChild(component.$el);
      var ComponentClass = Vue.extend(PostedReview)
      var instance = new ComponentClass({
        propsData: {
          user_name: component.user_name,
          review: component.review
        }
      });
      instance.$mount();
      $('#' + component.line).after(instance.$el);
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
