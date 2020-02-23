<template>
  <div class="user-icon uk-text-center uk-margin">
    <div class="uk-width-1-2 uk-margin-auto">
      <img :src="selectedImage">
      <div class="uk-text-center uk-margin">
        <input type="file" accept="image/png, image/jpeg, image/gif" name="user[icon]" id="user_icon" @change="setImage" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    imageSource: {
      type: String
    }
  },
  data: function () {
    return {
      selectedImage: ""
    }
  },
  created: function () {
    this.selectedImage = this.imageSource;
  },
  methods: {
    setImage: function (event) {
      const file = event.target.files[0];
      if (file.type.startsWith("image/")) {
        this.selectedImage = window.URL.createObjectURL(file);
      }
    }
  }
}
</script>
