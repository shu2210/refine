<template>
  <div class="uk-margin">
    <div class="code-title uk-padding-small">
      <input type="text" class="uk-input uk-form-blank" placeholder="タイトル" />
    </div>
    <div class="code">
      <table class="uk-table uk-table-small uk-margin-remove">
        <tr v-for="n in 5">
          <td class="line-num uk-padding-remove-bottom uk-table-shrink">
            <span>{{ n }}</span>
          </td>
          <td class="uk-padding-remove">
            <input type="text" class="uk-input uk-form-blank" />
          </td>
        </tr>
      </table>
    </div>
    <div class="uk-width-1-1 uk-text-right uk-margin">
      <button class="uk-button uk-button-default">追加</button>
    </div>
  </div>
</template>

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
    .line-num {
      background-color: $background-color;
    }
  }
}
</style>
