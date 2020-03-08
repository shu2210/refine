<template>
  <div class="code">
    <div class="uk-margin">
      <code-editor
        v-for="(code, index) in formCodes"
        :code="code.code"
        :default-language="langs[code.language_id - 1]"
        :langs="langs"
        :errors="errors[index]"
        :key="index"
      />
    </div>
    <div class="uk-text-right">
      <a class="uk-button uk-button-default" v-show="canDelete" @click="deleteCode">削除</a>
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
      codeErrors: null,
      formCodes: []
    }
  },
  created() {
    this.formCodes = JSON.parse(this.codes);
    this.codeObject = JSON.parse(this.newCode);
  },
  computed: {
    canDelete() {
      return this.formCodes.length >= 2;
    }
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
