<template>
  <div>
    <div class="review">
      <span>レビュー</span>
    </div>
    <div class="review-num">
      <span>{{ num }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    num: {
      type: Number,
      default: 0
    }
  }
}
</script>

<style scoped>
.review, .review-num {
  color: #E9606D;
}
</style>
