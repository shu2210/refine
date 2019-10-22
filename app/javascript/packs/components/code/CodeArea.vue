<template>
  <div class="uk-margin">
    <div class="code-title uk-padding-small">
      <span>fizz_buzz.rb</span>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="trash"></a>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="file-edit"></a>
      <a href="#" class="uk-icon-link uk-align-right uk-margin-remove" uk-icon="copy"></a>
    </div>
    <div class="code">
      <table class="uk-table uk-table-small uk-table-hover uk-margin-remove">
        <tr v-for="(line, index) in codeLines" :key="index">
          <td class="line-num uk-table-shrink">
            <a href="" class="uk-icon-button" uk-icon="comment"></a>
            <span>{{ index + 1 }}</span>
          </td>
          <td>
            <pre class="line">{{ line }}</pre>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    code: String
  },
  data: function () {
    return {
      codeLines: []
    }
  },
  mounted: function () {
    this.codeLines = this.code.split(/\n/);
  }
}
</script>

<style lang="scss" scoped>
$background-color: #EFEFEF;
$border-color: #bbb;

.code-title {
  background-color: $background-color;
  border: solid 1px $border-color;

  .uk-icon-link:not(:first-of-type) {
    margin-right: 15px !important;
  }
}

.code {
  border: solid 1px $border-color;

  tr {
    &:hover .line-num .uk-icon-button {
      visibility: visible;
    }

    .line-num {
      position: relative;
      background-color: $background-color;

      .uk-icon-button {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: -25px;
        visibility: hidden;
      }
    }

    .line {
      display: inline;
      background-color: transparent;
      border: none;
    }
  }
}
</style>
