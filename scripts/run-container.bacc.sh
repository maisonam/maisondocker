#!/bin/bash
set -e

if [[ $# -eq 0 ]] ; then echo 'An version arg is required.' ; exit 0 ; fi

VERSION=$1

date +"%R--------- BUILDING DOCKER IMAGE ----------"

docker build -t docker.geus.aws/geus/qzd-web:$VERSION .

date +"%R--------- PUSHING DOCKER IMAGE ----------"

docker push docker.geus.aws/geus/qzd-web:$VERSION

date +"%R--------- DOCKER IMAGE BUILD COMPLETE ----------"


#!/bin/bash

if [[ $# -eq 0 ]] ; then echo 'An environment arg is required.' ; exit 0 ; fi
if [[ $# -eq 1 ]] ; then echo 'A version arg is required.' ; exit 0 ; fi

ENV=$1
VERSION=$2

echo ""
echo "Pulling fr-advisor-web version: [$VERSION]"
echo ""

docker pull docker.geus.aws/geus/fr-advisor-web-build:${VERSION}
docker pull docker.geus.aws/geus/fr-advisor-web:${VERSION}

/data/glitnir/apps/fr-advisor-web/restart.sh $ENV $VERSION





#!/bin/bash

if [[ $# -eq 0 ]] ; then echo 'An environment arg is required.' ; exit 0 ; fi
if [[ $# -eq 1 ]] ; then echo 'A version arg is required.' ; exit 0 ; fi

ENV=$1
VERSION=$2

echo ""
echo "Restarting fr-advisor-web [$ENV] version: [$VERSION]"
echo ""


docker run --name fr-advisor-web-build \
    --rm \
    -v ${WORKSPACE}/advisor-web:/src \
    docker.geus.aws/geus/fr-advisor-web-build:${VERSION} \
    bash -c "npm install && bower install --allow-root && gulp prod"

docker run --name fr-advisor-web --restart=on-failure:5 \
    -v /var/log/geus/fr-advisor-web:/var/log/nginx \
    --link jobmatch-api:jobmatch-api \
    --link calendar-api:calendar-api \
    -p 41282:80 \
    -d docker.geus.aws/geus/fr-advisor-web:${VERSION}



docker run --name paadvisorconsole --rm -it \
    -v /c/Users/Dev/geus-portailavenirs-apis/advisor-web/portailavenirs-advisor-console/:/src \
    -v /c/Users/Dev/geus-portailavenirs-apis/advisor-web/src/main/resources/static:/src/build  \
    docker.geus.aws/geus/pa-advisor-portal:1.0 npm install gulp dev



    #!/bin/bash

if [[ $# -eq 0 ]] ; then echo 'An environment arg is required.' ; exit 0 ; fi
if [[ $# -eq 1 ]] ; then echo 'A version arg is required.' ; exit 0 ; fi

ENV=$1
VERSION=$2

echo ""
echo "Restarting fr-advisor-web [$ENV] version: [$VERSION]"
echo ""

docker pull docker.geus.aws/geus/fr-advisor-web-build:1.1

docker run --name fr-advisor-web-build --rm -v /data/glitnir/apps/pa-advisor-build/geus-portailavenirs-apis/advisor-web:/src docker.geus.aws/geus/fr-advisor-web-build:1.0 bash -c "npm install && bower install --allow-root && gulp prod"

docker run --name uk-wp-web-build --rm -v /data/glitnir/apps/geus-uk-wp-web/client-web:/src geus/builder:pa-advisor-portal bash -c "npm install && bower install --allow-root && gulp prod"


docker run --name uk-wp-web --restart=on-failure:5 -v /var/log/geus/uk-wp-web:/var/log/nginx -p 51282:80 -d geus/uk-wp-web:1.0


docker run --name uk-wp-web --restart=on-failure:5 \
       --link fr-jobmatch-api:jobmatch-api \
       --link fr-calendar-api:calendar-api \
       -v /var/log/geus/uk-wp-web:/var/log/nginx \
       -p 51282:80 \
       -d docker.geus.azure/geus/uk-wp-web:${VERSION}
