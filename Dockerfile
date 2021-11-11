FROM python:3.8-alpine

COPY . /app/flutter-autograding

WORKDIR /app/flutter-autograding

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "python3", "main.py", "./text-result.txt", "$GITHUB_ACTOR", "$GITHUB_REPOSITORY", "$GITHUB_ACTION"]