#!/bin/sh

RUN_CMD="docker run --entrypoint spicedb quay.io/authzed/spicedb:$INPUT_VERSION version"
sh -c "$RUN_CMD"
