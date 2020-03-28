<template>
  <tr :id="`folding-comment-${reviewId}`" v-if="show">
    <td colspan="2" class="uk-text-center">
      <img :src="loader" width="35" uk-img v-if="isLoading" />
      <a @click="displayComments" v-else>
        {{ `${commentCount}件のコメントを表示する` }}
      </a>
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    reviewId: {
      type: Number,
      default: 0
    },
    commentCount: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loader: require('../../../../assets/images/loader.gif'),
      show: false,
      isLoading: false
    }
  },
  mounted() {
    if(this.commentCount > 0) {
      this.show = true;
    }
  },
  methods: {
    displayComments() {
      this.isLoading = true;
      this.$emit('display', this.reviewId);
      this.show = false;
    }
  }
}
</script>