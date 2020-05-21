<template>
  <a
    class="uk-icon-button folding-button"
    uk-icon="shrink"
    uk-tooltip="レビューを折りたたむ"
    @click="toggleReview()"
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
    toggleReview() {
      var id = $(`#${this.codeId}`).next().attr('id');
      while (!id?.startsWith('code')) {
        if (id === undefined) {
          break;
        } else {
          if ($(`#${id}`).hasClass("uk-hidden")) {
            $(`#${id}`).removeClass("uk-hidden");
          } else {
            $(`#${id}`).addClass("uk-hidden");
          }
        }
        id = $(`#${id}`).next().attr('id');
      }
    }
  }
}
</script>