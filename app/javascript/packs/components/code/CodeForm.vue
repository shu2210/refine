<template>
  <div class="code">
    <div class="language-select uk-width-1-1 uk-text-right uk-margin">
      <select name="code[][language_id]" class="uk-select uk-width-1-4" @change="changeMode($event)">
        <option v-for="lang in langs"
                :value="lang['id']"
                :key="lang['id']">
          {{ lang['name'] }}
        </option>
      </select>
    </div>
    <monaco-editor
      :language="language"
      v-model="code"
      height="400"
    >
    </monaco-editor>
    <input type="hidden" :value="code" name="code[][code]" />
    <span class="uk-text-danger" v-for="error in errors" :key="error">{{ error }}</span>
  </div>
</template>

<script>
import 'monaco-editor';
import MonacoEditor from 'monaco-editor-vue';

export default {
  components: {
    MonacoEditor
  },
  props: {
    langs: Array,
    errors: Array
  },
  data() {
    return {
      code: "",
      language: "ruby"
    }
  },
  methods: {
    changeMode(event) {
      var mode = '';
      var vm = this;
      this.langs.forEach(function(lang){
        if(lang['id'] == event.target.value) {
          vm.language = lang['mode'];
        }
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.editor {
  height: 400px;
}
</style>
