<template>
  <div class="comment-info uk-text-right">
    <span class="uk-text-small uk-text-muted uk-text-light">
      投稿日時：{{ postedAt | formatDate }}
    </span>
  </div>
</template>

<script>
import moment from 'moment';

export default {
  props: {
    postedAt: {
      type: Date
    }
  },
  filters: {
    formatDate(date) {
      return moment(date).format('YYYY-MM-DD hh:mm:ss');
    }
  }
}
</script>