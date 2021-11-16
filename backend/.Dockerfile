# from base image node
FROM node:8.11-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# copy all files
COPY . .

# install all dependencies
RUN yarn install

# build
RUN yarn build

#expose the port
EXPOSE 3070

# command to run when intantiate an image
CMD ["yarn","serve"]