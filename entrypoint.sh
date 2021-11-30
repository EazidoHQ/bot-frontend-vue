#!/bin/sh

JSON_STRING='window.configs = { \
  "VUE_APP_TITLE":"'"${VUE_APP_TITLE}"'", \
  "VUE_APP_BOT_SLUG":"'"${VUE_APP_BOT_SLUG}"'", \
  "VUE_APP_BOT_BASE_URL":"'"${VUE_APP_BOT_BASE_URL}"'", \
  "VUE_APP_BOT_NAME":"'"${VUE_APP_BOT_NAME}"'", \
  "VUE_APP_BOT_DESCRIPTION":"'"${VUE_APP_BOT_DESCRIPTION}"'", \
  "VUE_APP_BOT_IMAGE_URL":"'"${VUE_APP_BOT_IMAGE_URL}"'", \
  "VUE_APP_BOT_WELCOME_MESSAGE":"'"${VUE_APP_BOT_WELCOME_MESSAGE}"'", \
  "VUE_APP_BOT_THEME_COLOR":"'"${VUE_APP_BOT_THEME_COLOR}"'", \
}'

if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i "" "s@// CONFIGURATIONS_PLACEHOLDER@${JSON_STRING}@" /usr/share/nginx/html/index.html
else
  sed -i "s@// CONFIGURATIONS_PLACEHOLDER@${JSON_STRING}@" /usr/share/nginx/html/index.html
fi

echo "############# Done"

/usr/sbin/nginx -g "daemon off;"
