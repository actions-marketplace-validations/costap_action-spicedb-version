#!/bin/sh

output=$(docker run --entrypoint spicedb quay.io/authzed/spicedb:$INPUT_VERSION version)
version=$(echo $output | awk '{print $NF}')
echo "::set-output name=version::$version"