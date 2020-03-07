<template>
  <div class="code">
    <div class="uk-margin">
      <code-editor
        :langs="langs"
        :errors="errors"
      />
    </div>
    <div class="uk-text-right">
      <a class="uk-button uk-button-default">追加</a>
    </div>
  </div>
</template>

<script>
import CodeEditor from './CodeEditor.vue';

export default {
  props: {
    codes: String,
    langs: Array,
    errors: Array
  },
  components: {
    CodeEditor
  }
}
</script>
