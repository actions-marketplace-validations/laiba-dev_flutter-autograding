FROM fischerscode/flutter:stable

USER root

RUN apt-get update && apt-get install python3 -y

COPY . /app/flutter-autograding