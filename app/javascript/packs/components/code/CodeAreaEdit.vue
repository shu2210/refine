<template>
  <div class="code">
    <div class="language-select uk-width-1-1 uk-text-right uk-margin">
      <select name="lang" class="uk-select uk-width-1-4" @change="changeMode">
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
        'TypeScript': 'typescript',
        'Python': 'python',
        'PHP': 'php',
        'Perl': 'perl',
        'HTML': 'html',
        'XML': 'xml',
        'erb': 'html_ruby',
        'slim': 'slim',
        'CSS': 'css',
        'SCSS': 'scss',
        'SASS': 'sass',
        'stylus': 'stylus',
        'Java': 'java',
        'C': 'c',
        'C++': 'c_pp',
        'Go': 'golang',
        'Kotlin': 'kotlin',
        'Swift': 'swift',
        'Lisp': 'lisp',
        'Scala': 'scala',
        'COBOL': 'cobol',
        'SQL': 'sql',
        'MySQL': 'mysql',
        'PostgreSQL': 'pgsql',
        'SQLServer': 'sqlserver',
        'JSON': 'json',
        'Shell': 'sh',
      },
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
      this.editor.session.setMode('ace/mode/' + event.target.value);
    }
  }
}
</script>

<style lang="scss" scoped>
#editor {
  height: 400px;
}
</style>
