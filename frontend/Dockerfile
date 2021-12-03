FROM node:latest

RUN mkdir /app

ADD . /app

WORKDIR /app

RUN npm install
RUN npm run build

FROM nginx

COPY  --from=0 /app/public/. /usr/share/nginx/html/.

EXPOSE 80
