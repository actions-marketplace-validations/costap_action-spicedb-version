#!/bin/sh

version=$(docker run --entrypoint spicedb quay.io/authzed/spicedb:$INPUT_VERSION version)
echo "::set-output name=version::$version"