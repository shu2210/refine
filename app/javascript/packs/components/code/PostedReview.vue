<template>
  <tr>
    <td colspan="2">
      <div class="posted-review uk-flex">
        <div class="uk-flex-first uk-width-1-6 uk-text-center">
          <img :src="icon" class="uk-border-circle uk-width-1-3" />
        </div>
        <div class="review-info uk-width-3-6">
          <div class="user-name uk-margin">
            {{ userName }}
          </div>
          <div class="description">
            <p>
              {{ review }}
            </p>
          </div>
        </div>
        <div class="control-area uk-width-1-6 uk-text-center">
          <a class="uk-margin-small-right" uk-icon="pencil"></a>
          <a class="uk-margin-small-right" uk-icon="trash"></a>
          <a class="uk-margin-small-right" uk-icon="menu"></a>
        </div>
      </div>
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    userName: {
      type: String,
      default: ''
    },
    review: {
      type: String,
      default: ''
    },
    icon: {
      type: String
    }
  }
}
</script>
