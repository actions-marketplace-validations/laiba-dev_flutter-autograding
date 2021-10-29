FROM fischerscode/flutter:stable

USER root

ENV TZ=Asia/Jakarta

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install nodejs npm

COPY . .

RUN npm install
