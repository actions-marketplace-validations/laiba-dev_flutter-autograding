FROM python:3.8-alpine

COPY . /app/flutter-autograding

ENTRYPOINT [ "/app/flutter-autograding/entrypoint.sh" ]

CMD [ "python3"]