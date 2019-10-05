<template>
  <div class="code">
    <div class="language-select uk-width-1-1 uk-text-right uk-margin">
      <select name="code[language_id]" class="uk-select uk-width-1-4" @change="changeMode($event)">
        <option v-for="lang in langs"
                :value="lang['id']">
          {{ lang['name'] }}
        </option>
      </select>
    </div>
    <div id="editor">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    langs: Array
  },
  data: function () {
    return {
      editor: null
    }
  },
  mounted: function () {
    this.editor = ace.edit('editor', {
      theme: 'ace/theme/textmate',
      mode: 'ace/mode/ruby',
      autoScrollEditorIntoView: true,
      maxLines: 30,
      minLines: 25,
    });
  },
  methods: {
    changeMode: function (event) {
      var id = event.target.value;
      var mode = ''
      this.langs.forEach(function(lang){
        if(lang['id'] == event.target.value) {
          mode = lang['mode']
        }
      });
      this.editor.session.setMode('ace/mode/' + mode);
    }
  }
}
</script>

<style lang="scss" scoped>
#editor {
  height: 400px;
}
textarea[name="editor"] {
  display: none;
}
</style>
