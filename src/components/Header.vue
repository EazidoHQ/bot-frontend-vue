<template>
  <header
    class="w-full bg-gray-100 py-2 px-4 bot-header border-b-2 border-gray-200 fixed"
  >
    <div class="flex items-center">
      <div
        class="bot-profile-image w-16 h-16 rounded-full bg-gray-500 flex-shrink-0"
        v-bind:style="{ backgroundImage: 'url(' + botData.image_url + ')' }"></div>
      <div class="ml-2">
        <h4 class="font-bold">{{ botData.bot_name }}</h4>
        <small>{{ botData.description }} </small>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  props: [
    'botData'
  ]
};
</script>

<style scoped>
header {
  border-top: 5px solid #718096;
  z-index: 99;
  position: sticky;
  top: 0;
  left: 0;
}

header .bot-profile-image{
  background-position: center center;
  background-size: cover;
}
</style>
