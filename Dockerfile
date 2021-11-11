FROM python:3.8-alpine

WORKDIR /github/workspaces

COPY . .

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "python3"]