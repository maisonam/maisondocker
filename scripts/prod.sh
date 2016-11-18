#!/bin/bash
set -e

echo "NPM Install to add all NPM packages"

npm install

echo "NPM Install successful"


echo "Run Gulp prod"

gulp prod

echo "Gulp production task successful"
