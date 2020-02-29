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
    <prism-editor
      :language="language"
      v-model="code"
      class="editor"
    ></prism-editor>
    <input type="hidden" :value="code" name="code[][code]" />
    <span class="uk-text-danger" v-for="error in errors" :key="error">{{ error }}</span>
  </div>
</template>

<script>
import "prismjs";
import "prismjs/themes/prism.css";
import "prismjs/components/prism-ruby.min.js";
import "prismjs/components/prism-python.min.js";
import "prismjs/components/prism-perl.min.js";
import "prismjs/components/prism-java.min.js";
import "prismjs/components/prism-c.min.js";
import "prismjs/components/prism-cpp.min.js";
import "prismjs/components/prism-go.min.js";
import "prismjs/components/prism-kotlin.min.js";
import "prismjs/components/prism-swift.min.js";
import "prismjs/components/prism-lisp.min.js";
import "prismjs/components/prism-scala.min.js";

import "vue-prism-editor/dist/VuePrismEditor.css";
import PrismEditor from 'vue-prism-editor';

export default {
  components: {
    PrismEditor
  },
  props: {
    langs: Array,
    errors: Array
  },
  data: function () {
    return {
      code: "",
      editor: null,
      language: "ruby"
    }
  },
  methods: {
    changeMode: function (event) {
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
  height: 400px !important;
}
</style>
