FROM fischerscode/flutter:stable

USER root

RUN apt-get -y install nodejs npm

COPY . .

RUN npm install
