FROM python:3.8-alpine

WORKDIR /app/flutter-autograding
COPY . .

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]