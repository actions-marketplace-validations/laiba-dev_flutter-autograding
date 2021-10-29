FROM fischerscode/flutter:stable

RUN sudo apt-get -y install nodejs npm

COPY . .

RUN npm install
