# from base image node
FROM node:12-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# copy all files
COPY . .

# install all dependencies
RUN yarn install

# Compile all typescript to javascript
RUN yarn tsc

#expose the port
EXPOSE 3070

# command to run when intantiate an image
CMD ["yarn","serve"]