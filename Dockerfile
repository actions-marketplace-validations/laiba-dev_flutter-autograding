FROM fischerscode/flutter:stable

USER root

ENV TZ=Asia/Jakarta

RUN apt-get update && apt-get -y install nodejs npm

COPY . .

RUN npm install
