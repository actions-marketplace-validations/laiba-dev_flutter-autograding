FROM node:16.13.0-alpine3.13

WORKDIR /app/mirfanrafif/autograde

COPY . .

RUN npm install