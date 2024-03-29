FROM node:lts-bullseye-slim AS build
WORKDIR /app
COPY package.json ./
COPY . .
RUN yarn install
RUN yarn global add @angular/cli
#RUN ng extract-i18n
#RUN ng run mototrainer.ttm.web:extract-i18n
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/mototrainer.ttm.web /usr/share/nginx/html
