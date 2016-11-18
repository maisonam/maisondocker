#!/bin/bash

if [[ $# -eq 0 ]] ; then echo 'An environment arg is required.' ; exit 0 ; fi
if [[ $# -eq 1 ]] ; then echo 'A version arg is required.' ; exit 0 ; fi

ENV=$1
VERSION=$2

echo ""
echo "RUN uk-wp-web-build [$ENV] version: [$VERSION]"
echo ""

docker run --name uk-wp-web-build \
    --rm \
    -v ${WORKSPACE}:/src \
    ingeus/builder:pa-advisor-portal \
    bash -c "npm install && bower install --allow-root && cd client-web && gulp prod"

 
