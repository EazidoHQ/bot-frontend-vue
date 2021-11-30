# build stage
FROM node:lts-alpine as build-stage

RUN mkdir -p app

RUN mkdir -p /app/frontend

RUN cd /app/frontend

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage

COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=build-stage dist /usr/share/nginx/html

COPY entrypoint.sh /usr/share/nginx/

RUN chmod +x /usr/share/nginx/entrypoint.sh

ENTRYPOINT ["/usr/share/nginx/entrypoint.sh"]
