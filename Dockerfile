FROM node:18-alpine

RUN apk update
RUN apk upgrade
RUN apk add bash

WORKDIR /app
COPY . /app
RUN npm install -g npm@latest
RUN npm install cross-env

EXPOSE 3000

CMD ["npm", "start"]
