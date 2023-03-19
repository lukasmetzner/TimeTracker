FROM node:16

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run lint

EXPOSE 8080
CMD [ "npm", "run", "serve" ]