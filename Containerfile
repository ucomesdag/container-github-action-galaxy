FROM python:3-alpine

ARG BUILD_DATE

LABEL summary="A container that is used for GitHub actions galaxy."
LABEL maintainer="Uco Mesdag <uco@mesd.ag>"
LABEL build-date=${BUILD_DATE}

WORKDIR /github/workspace

RUN apk add --update --no-cache python3 py-pip && \
    apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev rust cargo && \
    pip install ansible && \
    apk del build_dependencies

CMD cd ${INPUT_PATH:-./} ; ansible-galaxy role import --token ${INPUT_GALAXY_API_KEY} $(echo $GITHUB_REPOSITORY | cut -d/ -f1) $(echo $GITHUB_REPOSITORY | cut -d/ -f2)
