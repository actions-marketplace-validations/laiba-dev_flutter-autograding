FROM fischerscode/flutter:stable

RUN apt-get -y install nodejs npm

COPY . .

RUN npm install
