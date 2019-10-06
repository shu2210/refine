<template>
  <div class="uk-margin tag">
    <input type="text" id="tag" class="uk-input" placeholder="タグを入力" />
  </div>
</template>

<script>
export default {
  mounted: function () {
    $('#tag').autocomplete({
      source: ['Ruby', 'Javascript']
    });
  }
}
</script>
