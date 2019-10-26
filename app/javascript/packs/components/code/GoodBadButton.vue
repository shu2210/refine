<template>
  <div class="good-bad-buttons uk-margin-left uk-text-right uk-text-middle">
    <a class="uk-link-reset" :class="{ 'liked': is_liked }" @click="toggleLike">
      <img src="~good.png" :width="icon_size" uk-img />
      <span class="likes uk-margin-small-left uk-text-large uk-text-middle">{{ likes_num }}</span>
    </a>
    <a class="uk-link-reset uk-margin-left" :class="{ 'disliked': is_disliked }" @click="toggleDislike">
      <img src="~bad.png" :width="icon_size" uk-img />
      <span class="dislikes uk-margin-small-left uk-text-large uk-text-middle">{{ dislikes_num }}</span>
    </a>
  </div>
</template>

<script>
import 'good.png';
import 'bad.png';
import axios from 'axios';

export default {
  props: {
    code_id: {
      type: Number,
      required: true
    },
    likes: Number,
    dislikes: Number,
    liked: Boolean,
    disliked: Boolean
  },
  data: function () {
    return {
      icon_size: 25,
      likes_num: this.likes,
      is_liked: this.liked,
      dislikes_num: this.dislikes,
      is_disliked: this.disliked
    }
  },
  methods: {
    toggleLike: function () {
      if(this.is_liked) {
        this.deleteLike();
      } else {
        this.addLike();
      }
    },
    toggleDislike: function () {
      if(this.is_disliked) {
        this.deleteDislike();
      } else {
        this.addDislike();
      }
    },
    addLike: function () {
      axios.post('/codes/likes', { code_id: this.code_id }).then((response) => {
        this.likes_num += 1;
        this.is_liked = true;
      }, (error) => {
        console.log(error);
      });
    },
    deleteLike: function () {
      axios.delete('/codes/likes/' + this.code_id).then((response) => {
        this.likes_num -= 1;
        this.is_liked = false;
      }, (error) => {
        console.log(error);
      });
    },
    addDislike: function () {
      axios.post('/codes/dislikes', { code_id: this.code_id }).then((response) => {
        this.dislikes_num += 1;
        this.is_disliked = true;
      }, (error) => {
        console.log(error);
      });
    },
    deleteDislike: function () {
      axios.delete('/codes/dislikes/' + this.code_id).then((response) => {
        this.dislikes_num -= 1;
        this.is_disliked = false;
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.likes, .dislikes {
  font-size: 1.2em;
}

.liked, .disliked {
  img {
    filter: brightness(0.2);
  }
}
</style>
