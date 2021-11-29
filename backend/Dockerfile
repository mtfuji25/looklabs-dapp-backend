FROM node:latest

RUN mkdir /backend && chown 1000:1000 -R /backend

ADD . /backend

WORKDIR /backend

RUN npm install

CMD ["npm", "run", "start"]
