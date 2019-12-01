<template>
  <div class="jumbotron uk-flex uk-flex-center uk-flex-middle uk-width-1-1">
    <div class="catch-phrase uk-width-2-5 uk-padding uk-margin-large-top uk-margin-large-bottom">
      <span class="uk-text-small">コードレビューサイト</span>
      <h1 class="uk-heading-small uk-margin-remove">Refine</h1>
      <p>
        誰でもプロからのレビューを気軽に受けることができます。
        <br />
        あなたのコードを"洗練"しましょう。
      </p>
    </div>
    <slot></slot>
  </div>
</template>

<style scoped>
.jumbotron {
  background-color: #E8E8E8;
}
</style>
