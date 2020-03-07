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
    <div class="uk-margin">
      <code-editor
        :language="language"
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
    langs: Array,
    errors: Array
  },
  data() {
    return {
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
  },
  components: {
    CodeEditor
  }
}
</script>
