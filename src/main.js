import { createWebHistory, createRouter } from "vue-router";

import { createApp } from "vue";
import App from "./App.vue";

// Importing plugin for handling browser cookies
import VueCookies from 'vue3-cookies'

const routes = [
  {
    path: "/",
    name: "Home",
    component: App,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

import "./assets/index.css";

createApp(App)
  .use(router)
  .use(VueCookies)
  .mount("#app");
