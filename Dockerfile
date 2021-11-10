FROM python:3.8-alpine

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "python3"]