<template>
  <div :id="id" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-modal-body uk-margin-auto-vertical">
      <h2 class="uk-modal-title" :class="'uk-text-' + titlePosition">{{ title }}</h2>
      <button class="uk-modal-close-default" type="button" uk-close></button>
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    id: String,
    titlePosition: {
      type: String,
      default: 'left'
    }
  }
}
</script>
