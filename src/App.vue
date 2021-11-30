<template>
  <div class="bot" v-if="state.botData">
    <Header :botData="state.botData" />
    <main>
      <button @click="playSound" v-if="false">Sound Notification</button>
      <ul id="chatContainer" class="chat-container">
        <li
          class="flex w-3/5 lg:w-1/5 mb-4"
          v-for="(message, i) in state.messages"
          :class="{ 'justify-end': message.sender, 'ml-auto': message.sender }"
          :key="i"
        >
          <ChatMessage :message="message" />
        </li>
      </ul>
    </main>
    <footer class="fixed bottom-0 w-full px-3 py-2 bg-white z-40">
      <div
        class="
          flex
          w-full
          border-2 border-solid
          py-1
          px-2
          border-black
          rounded-full
        "
      >
        <input
          type="text"
          class="w-full py-2 ml-2 outline-none"
          v-model="state.inputMessage"
          @keydown.enter="sendMessage"
        />
        <button class="outline-none">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="black"
            width="18px"
            height="18px"
            @click="sendMessage"
          >
            <path d="M0 0h24v24H0z" fill="none" />
            <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z" />
          </svg>
        </button>
      </div>
    </footer>
  </div>
  <div class="bot-loader" v-else-if="botData == null && errorMessage == ''">
    <div class="loader">
      <img src="./assets/loader-icon.svg" alt="loader" />
    </div>
  </div>
  <div v-else>
    <h1>{{ state.errorMessage }}</h1>
  </div>
</template>

<script>
import { reactive } from "vue";
import getEnv from "@/utils/env";
import Header from "@/components/Header.vue";
import ChatMessage from "@/components/chat/Message.vue";

export default {
  name: "App",
  components: {
    Header,
    ChatMessage,
  },
  methods: {},
  beforeMount() {
    // goal is to generate a random sender_id if it doesn't already exist in cookies
    if (this.$cookies.get("sender_id")) {
      this.state.sender_id = this.$cookies.get("sender_id");
    } else {
      const sender_id = Math.random().toString(36).substr(2, 9);
      this.$cookies.set("sender_id", sender_id);
      this.state.sender_id = sender_id;
    }
    // this can be used to changed the favicon of a page dynamically
    // goal is to fetch this from the server and set dynamically
    // document.querySelector("link[rel*='icon']").href = "favicon.ico";
  },
  mounted() {
    document.title = this.state.botData?.bot_name;
    // send welcome message
    const receivedMessage = {
      sender: false,
      message: this.state.botData.welcome_message,
      type: "text",
    };
    this.state.messages.push(receivedMessage);
  },
  setup() {
    const state = reactive({
      botData: {
        'bot_name': getEnv("VUE_APP_BOT_NAME"),
        'description': getEnv("VUE_APP_BOT_DESCRIPTION"),
        'image_url': getEnv("VUE_APP_BOT_IMAGE_URL"),
        'welcome_message': getEnv("VUE_APP_BOT_WELCOME_MESSAGE"),
        'theme_color': getEnv("VUE_APP_BOT_THEME_COLOR")
      },
      count: 0,
      inputMessage: "",
      messages: [],
      errorMessage: "",
      sender_id: null,
    });

    // methods
    const sendMessage = async () => {
      if (state.inputMessage.trim() === "") {
        return;
      }
      const request = {
        sender: state.sender_id,
        message: state.inputMessage,
        type: "text",
      };
      const newMessage = {
        sender: true,
        message: state.inputMessage,
        type: "text",
      };
      await state.messages.push(newMessage);
      await autoScrollBottom();
      state.inputMessage = "";
      const response = await fetch(
        `${getEnv("VUE_APP_BOT_BASE_URL")}api/webhooks/rest/webhook`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(request),
        }
      );
      const body = await response.json();
      for (const message of body) {
        const receivedMessage = {
          sender: false,
          message: message.text,
          type: "text",
        };
        await state.messages.push(receivedMessage);
        // await playSound();
        await autoScrollBottom();
      }
    };
    const playSound = async () => {
      const audio = new Audio(
        "https://res.cloudinary.com/ds7dprytb/video/upload/v1619867614/mixkit-sci-fi-confirmation-914.wav"
      );
      audio.play();
    };
    const autoScrollBottom = () => {
      const chatContainer = document.querySelector("#chatContainer");
      chatContainer.scrollTop = chatContainer.scrollHeight;
    };
    return { state, sendMessage, playSound }; // anything returned here will be available for the rest of the component
  },
};
</script>

<style>
.fixed {
  z-index: 999;
}
.chat-container {
  height: 80vh;
  scroll-behavior: smooth;
  overflow-y: scroll;
  padding: 15px 20px 0;
}
.bot {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
#chatContainer li:last-child {
  margin-bottom: 10px;

  @media screen and (max-width: 1255px) {
    margin-bottom: 30px;
  }

  @media screen and (max-width: 674px) {
    margin-bottom: 50px;
  }

  @media screen and (max-width: 400px) {
    margin-bottom: 70px;
  }
}
button svg {
  height: 26px;
  width: 26px;
}

button:focus {
  outline: none !important;
}
</style>
