<template>
  <div class="editor">
    <vue-simplemde
      v-model="editReview"
      ref="markdownEditor"
      @input="inputEditor"
    />
    <div class="uk-text-right uk-margin">
      <button class="uk-button uk-button-default" @click="cancel">キャンセル</button>
      <button class="uk-button uk-button-primary" @click="commit">{{ commitLabel }}</button>
    </div>
  </div>
</template>

<script>
import VueSimplemde from 'vue-simplemde';

export default {
  props: {
    commitLabel: String,
    review:{
      type: String,
      default: ''
    }
  },
  data() {
    return {
      editReview: this.review
    }
  },
  methods: {
    cancel() {
      this.$emit('cancel');
    },
    commit() {
      this.$emit('commit');
    },
    inputEditor() {
      this.$emit('input', this.editReview);
    }
  },
  components: {
    VueSimplemde
  }
}
</script>

<style>
@import 'simplemde/dist/simplemde.min.css';
</style>