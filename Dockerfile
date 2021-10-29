FROM node:10.19-alpine

COPY . .

RUN npm install

EXPOSE 8080

CMD node index.js
