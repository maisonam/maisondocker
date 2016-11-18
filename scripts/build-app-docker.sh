#!/bin/bash
set -e

if [[ $# -eq 0 ]] ; then echo 'An version arg is required.' ; exit 0 ; fi

VERSION=$1

date +"%R--------- BUILDING DOCKER IMAGE ----------"

docker build -t docker.ingeus.azure/ingeus/uk-wp-web:$VERSION ./client-web/

date +"%R--------- PUSHING DOCKER IMAGE ----------"

docker push docker.ingeus.azure/ingeus/uk-wp-web:$VERSION

date +"%R--------- DOCKER IMAGE BUILD COMPLETE ----------"
