<template>
  <a
    class="uk-icon-button folding-button"
    :uk-icon="icon"
    :uk-tooltip="tooltip"
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
  data() {
    return {
      icon: "shrink",
      tooltip: "レビューを折りたたむ"
    }
  },
  methods: {
    toggleReview() {
      var nextId = $(`#${this.codeId}`).next().attr('id');
      while (!nextId?.startsWith('code')) {
        if (nextId === undefined) {
          break;
        } else {
          if ($(`#${nextId}`).hasClass("uk-hidden")) {
            this.expandReview(nextId);
          } else {
            this.foldReview(nextId);
          }
        }
        nextId = $(`#${nextId}`).next().attr('id');
      }
    },
    foldReview(id) {
      this.icon = "expand";
      this.tooltip = "レビューを拡げる";
      $(`#${id}`).addClass("uk-hidden");
    },
    expandReview(id) {
      this.icon = "shrink";
      this.tooltip = "レビューを折りたたむ";
      $(`#${id}`).removeClass("uk-hidden");
    }
  }
}
</script>