FROM python:3.8-alpine

COPY . /app/flutter-autograding

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]