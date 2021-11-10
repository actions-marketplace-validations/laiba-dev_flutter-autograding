FROM python:3.8-alpine

COPY . .

CMD [ "python3", "main.py", "test-result.txt", "$GITHUB_ACTOR", "$GITHUB_REPOSITORY", "$GITHUB_RUN_ID" ]