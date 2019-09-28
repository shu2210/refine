<template>
  <div class="code">
    <div class="language-select uk-width-1-1 uk-text-right uk-margin">
      <select name="lang" class="uk-select uk-width-1-4">
        <option v-for="mode, name in languages" :value="mode">{{ name }}</option>
      </select>
    </div>
    <div id="editor">
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      languages: {
        'Ruby': 'ruby',
        'Javascript': 'javascript',
        'Python': 'python',
        'PHP': 'php',
        'Java': 'java'
      }
    }
  },
  mounted: function () {
    var editor = ace.edit('editor', {
      theme: 'ace/theme/textmate',
      mode: 'ace/mode/ruby',
      autoScrollEditorIntoView: true,
      minLines: 10,
    });
  }
}
</script>

<style>
#editor {
  min-height: 400px;
  height: 100%;
}
</style>
