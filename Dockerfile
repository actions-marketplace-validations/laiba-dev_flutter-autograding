FROM python:3.8-alpine

COPY . .

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "python3"]