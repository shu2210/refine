<template>
  <div class="uk-margin tag">
    <input type="text" id="tag" class="uk-input" data-role="tagsinput" />
  </div>
</template>

<script>
export default {
  mounted: function () {
    $('#tag').tagsInput({
      'height': 'auto',
      'width': '100%',
      'defaultText': 'タグを入力'
    });
  }
}
</script>
