<template>
  <div class="editor">
    <monaco-editor
      :language="language"
      height="400"
      v-model="editCode"
    >
    </monaco-editor>
    <input type="hidden" :value="editCode" name="code[][code]" />
    <span class="uk-text-danger" v-for="error in errors" :key="error">{{ error }}</span>
  </div>
</template>

<script>
import 'monaco-editor';
import MonacoEditor from 'monaco-editor-vue';

export default {
  props: {
    code: String,
    language: String,
    errors: Array
  },
  data() {
    return {
      editCode: ''
    }
  },
  created() {
    this.editCode = this.code;
  },
  components: {
    MonacoEditor
  }
}
</script>

<style lang="scss" scoped>
.editor {
  height: 400px;
}
</style>
