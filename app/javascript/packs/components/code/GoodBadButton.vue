<template>
  <div class="good-bad-buttons uk-margin-left uk-text-right uk-text-middle">
    <a class="uk-link-reset" :class="{ 'liked': isLiked }" @click="toggleLike">
      <img src="~good.png" :width="iconSize" uk-img />
      <span class="likes uk-margin-small-left uk-text-large uk-text-middle">{{ likesNum }}</span>
    </a>
    <a class="uk-link-reset uk-margin-left" :class="{ 'disliked': isDisliked }" @click="toggleDislike">
      <img src="~bad.png" :width="iconSize" uk-img />
      <span class="dislikes uk-margin-small-left uk-text-large uk-text-middle">{{ dislikesNum }}</span>
    </a>
  </div>
</template>

<script>
import 'good.png';
import 'bad.png';
import axios from 'axios';

export default {
  props: {
    codeId: {
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
      iconSize: 25,
      likesNum: this.likes,
      isLiked: this.liked,
      dislikesNum: this.dislikes,
      isDisliked: this.disliked
    }
  },
  methods: {
    toggleLike: function () {
      if(this.isLiked) {
        this.deleteLike();
      } else {
        this.addLike();
      }
    },
    toggleDislike: function () {
      if(this.isDisliked) {
        this.deleteDislike();
      } else {
        this.addDislike();
      }
    },
    addLike: function () {
      axios.post('/codes/likes', { code_id: this.codeId }).then((response) => {
        this.likesNum += 1;
        this.isLiked = true;
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    deleteLike: function () {
      axios.delete('/codes/likes/' + this.codeId).then((response) => {
        this.likesNum -= 1;
        this.isLiked = false;
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    addDislike: function () {
      axios.post('/codes/dislikes', { code_id: this.codeId }).then((response) => {
        this.dislikesNum += 1;
        this.isDisliked = true;
        console.log(response.status);
      }, (error) => {
        console.log(error);
      });
    },
    deleteDislike: function () {
      axios.delete('/codes/dislikes/' + this.codeId).then((response) => {
        this.dislikesNum -= 1;
        this.isDisliked = false;
        console.log(response.status);
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
