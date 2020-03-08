<template>
  <div class="code">
    <div class="uk-margin">
      <code-editor
        :langs="langs"
        :errors="errors"
        v-for="code in formCodes"
        :key="code.id"
      />
    </div>
    <div class="uk-text-right">
      <a class="uk-button uk-button-default" @click="deleteCode">削除</a>
      <a class="uk-button uk-button-default" @click="addCode">追加</a>
    </div>
  </div>
</template>

<script>
import CodeEditor from './CodeEditor.vue';

export default {
  props: {
    newCode: String,
    codes: String,
    langs: Array,
    errors: Array
  },
  data() {
    return {
      codeObject: null,
      formCodes: []
    }
  },
  created() {
    this.formCodes = JSON.parse(this.codes);
    this.codeObject = JSON.parse(this.newCode);
  },
  methods: {
    addCode() {
      this.formCodes.push(this.codeObject);
    },
    deleteCode() {
      this.formCodes.splice(-1, 1);
    }
  },
  components: {
    CodeEditor
  }
}
</script>
