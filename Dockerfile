FROM fischerscode/flutter:stable

USER root

RUN apt-get update && apt-get install python3 python3-pip wget -y

RUN python3 -m pip install requests

COPY . /app/flutter-autograding