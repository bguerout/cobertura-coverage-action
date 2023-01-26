FROM nikolaik/python-nodejs:python3.10-nodejs19-alpine

RUN apk update && apk add bash git jq

RUN pip install --root-user-action=ignore diff-cover

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
