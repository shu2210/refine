<template>
  <a
    class="uk-icon-button folding-button"
    uk-icon="shrink"
    uk-tooltip="レビューを折りたたむ"
    @click="foldReview()"
  />
</template>

<script>
export default {
  props: {
    codeId: {
      type: String,
      default: ""
    }
  },
  methods: {
    foldReview() {
      var id = $(`#${this.codeId}`).next().attr('id');
      while (!id?.startsWith('code')) {
        if (id === undefined) {
          break;
        } else {
          $(`#${id}`).addClass("uk-hidden");
        }
        id = $(`#${id}`).next().attr('id');
      }
    }
  }
}
</script>