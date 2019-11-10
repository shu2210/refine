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
        <tr v-for="(line, index) in codeLines" :id="index" :key="index">
          <td class="line-num uk-table-shrink">
            <a class="uk-icon-button" uk-icon="comment" @click="appendReview(index)"></a>
            <span>{{ index + 1 }}</span>
          </td>
          <td>
            <pre class="line">{{ line }}</pre>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import ReviewArea from './ReviewArea.vue';
import Vue from 'vue/dist/vue.esm.js';

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
  },
  methods: {
    appendReview: function (index) {
      var review = $('#' + index).next('.review-area');
      if(review.length >= 1) {
        return
      }

      var ComponentClass = Vue.extend(ReviewArea)
      var instance = new ComponentClass({
        propsData: {
          line: index + 1,
          code_id: this.code_id
        }
      })
      instance.$mount()
      $('#' + index).after(instance.$el);
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
