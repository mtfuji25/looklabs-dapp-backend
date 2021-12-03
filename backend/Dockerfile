FROM node:latest

RUN mkdir /app

ADD . /app

WORKDIR /app

RUN npm install

EXPOSE 8082

CMD ["npm", "run", "start"]

