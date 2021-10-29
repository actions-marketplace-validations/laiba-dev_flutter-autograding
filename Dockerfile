FROM fischerscode/flutter:stable

USER root

RUN apt-get update && apt-get -y install nodejs npm

COPY . .

RUN npm install
