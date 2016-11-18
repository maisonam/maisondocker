#!/bin/bash
set -e

echo " _   _ ____  __  __ "
echo "| \ | |  _ \|  \/  |"
echo "|  \| | |_) | |\/| |"
echo "| |\  |  __/| |  | |"
echo "|_| \_|_|   |_|  |_|"

echo " =========== NPM Install to add all NPM packages =========== "

npm install

echo " =========== NPM Install successful =========== "

echo " =========== =========== "
echo " =========== =========== "

echo " =========== Run Gulp build =========== "

gulp prod

echo " =========== Gulp build task successful =========== "

echo " =========== =========== "
echo " =========== =========== "

echo " ____   ___   ____ _  _______ ____  "
echo "|  _ \ / _ \ / ___| |/ / ____|  _ \ "
echo "| | | | | | | |   | ' /|  _| | |_) |"
echo "| |_| | |_| | |___| . \| |___|  _ < "
echo "|____/ \___/ \____|_|\_\_____|_| \_/"



