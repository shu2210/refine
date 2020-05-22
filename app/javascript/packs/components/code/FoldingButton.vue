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
      var id = $(`#${this.codeId}`).next().attr('id');
      while (!id?.startsWith('code')) {
        if (id === undefined) {
          break;
        } else {
          if ($(`#${id}`).hasClass("uk-hidden")) {
            this.icon = "shrink";
            this.tooltip = "レビューを折りたたむ";
            $(`#${id}`).removeClass("uk-hidden");
          } else {
            this.icon = "expand";
            this.tooltip = "レビューを拡げる";
            $(`#${id}`).addClass("uk-hidden");
          }
        }
        id = $(`#${id}`).next().attr('id');
      }
    }
  }
}
</script>