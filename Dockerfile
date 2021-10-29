FROM node:10.19-alpine

COPY . .

RUN npm install

CMD node index.js
