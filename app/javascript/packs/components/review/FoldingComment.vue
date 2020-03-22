<template>
  <tr v-if="show">
    <td colspan="2" class="uk-text-center">
      <a @click="displayComments">
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
    },
    show: {
      type: Boolean,
      default: false
    }
  },
  mounted() {
    if(this.commentCount > 0) {
      this.show = true;
    }
  },
  methods: {
    displayComments() {
      this.$emit('display', this.reviewId);
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
    }
  }
}
</script>