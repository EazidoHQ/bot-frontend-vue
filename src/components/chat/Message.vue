<template>
  <div>
    <div
      class="text-sm message-card p-5 rounded-b-md relative font-medium"
      :class="{ receiver: !message.sender, sender: message.sender }"
    >
      <span> {{ message.message }} </span>
    </div>
    <div class="actions mt-3" v-if="false">
      <div class="inline-block" v-for="i in 15" :key="i">
        <button
          class="text-xs shadow-lg px-4 py-2 rounded-full  mx-2 inline-block"
        >
          Menu
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    message: {
      type: Object,
      required: true,
    },
  },
  setup() {
    return {};
  },
};
</script>

<style scoped>
.receiver {
  background: hsla(222, 14%, 89%, 0.722);
  color: #4d4a4a;
}

.sender {
  background: #648384;
  color: #f9f6f2;
}

.receiver::before {
  content: "";
  position: absolute;
  visibility: visible;
  top: 0;
  left: -10px;
  border: 10px solid transparent;
  border-top: 10px solid hsla(222, 14%, 89%, 0.722);
}

.sender::after {
  content: "";
  position: absolute;
  visibility: visible;
  top: 0px;
  right: -8px;
  border: 10px solid transparent;
  border-top: 10px solid #648384;
  clear: both;
}

.actions {
  width: 200px;
  overflow-x: scroll;
  overflow-y: hidden;
  white-space: nowrap;
}

.actions button {
  display: inline-block;
  background: #fbfbfb;
}
</style>
