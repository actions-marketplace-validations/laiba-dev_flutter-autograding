FROM python:3.8-alpine

WORKDIR /github/workspaces

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "python3"]