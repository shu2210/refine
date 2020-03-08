<template>
  <div class="editor">
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
      height="400"
      v-model="editCode"
    ></monaco-editor>
    <input type="hidden" :value="editCode" name="code[][code]" />
    <span class="uk-text-danger" v-for="error in errors" :key="error">{{ error }}</span>
  </div>
</template>

<script>
import 'monaco-editor';
import MonacoEditor from 'monaco-editor-vue';

export default {
  props: {
    langs: Array,
    errors: Array
  },
  data() {
    return {
      language: 'ruby',
      editCode: ''
    }
  },
  created() {
    this.editCode = this.code;
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
  },
  components: {
    MonacoEditor
  }
}
</script>
