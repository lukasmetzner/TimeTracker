FROM node:19

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run lint

EXPOSE 8080
CMD [ "npm", "run", "serve" ]