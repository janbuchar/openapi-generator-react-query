#!/bin/sh
DIR=$(realpath $(dirname $0))
IMAGE=openapitools/openapi-generator-cli:v5.3.0

if [ $# -ge 1 ]; then
    curl $1 > ${DIR}/spec.json
fi

rm -rf ${DIR}/src/api/*

docker pull $IMAGE
docker run --rm -u $UID -v ${DIR}:/local $IMAGE generate \
    -i /local/spec.json \
    -c /local/config.yaml \
    -o /local/src/api/ \
    -g typescript-fetch \

