#!/usr/bin/env bash

set -euo pipefail
test ! -z ${DEBUG+x} && set -x

PROJECT_DIR=$(realpath $(dirname $0))
PROJECT_NAME=wst2swst
BUILD_VERSION=${BUILD_VERSION:-dev}

export PYTHON_VERSION=3.10.0
export POETRY_VERSION=1.1.11
export NODEJS_MAJOR_VERSION=12

clean() {
    true # nothing to do
}

build() {
    cd ${PROJECT_DIR}
    docker build \
        --build-arg http_proxy \
        --build-arg https_proxy \
        --build-arg no_proxy \
        --build-arg PYTHON_VERSION \
        --build-arg POETRY_VERSION \
        --build-arg NODEJS_MAJOR_VERSION \
        -f Dockerfile \
        -t ${PROJECT_NAME}:${BUILD_VERSION} \
        .
}

help() {
    echo "Usage:
    $0 clean
    $0 build
"
}

test -z "$*" && help && exit 1

for TARGET in $*; do
    echo "${PROJECT_NAME} > ${TARGET} > Starting..."
    ${TARGET}
    echo "${PROJECT_NAME} > ${TARGET} > Great success!"
done
