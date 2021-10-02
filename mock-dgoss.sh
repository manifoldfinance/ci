#!/bin/bash
: '
dgoss testing for containers
sample script
coverage reports imply container is JVM based
'
export TEST_PATH=../tests
export GOSS_PATH=$TEST_PATH/goss-linux-amd64
export GOSS_OPTS="$GOSS_OPTS --format junit"
export GOSS_FILES_STRATEGY=cp
DOCKER_IMAGE=$1
DOCKER_FILE="${2:-$PWD/Dockerfile}"

i=0

## Checks on the Dockerfile
GOSS_FILES_PATH=$TEST_PATH/00 \
bash $TEST_PATH/dgoss dockerfile "$DOCKER_IMAGE" "$DOCKER_FILE" \
> ../reports/00.xml || i=$(expr $i + 1)
# fail fast if we dont pass static checks
if [[ $i != 0 ]]; then exit "$i"; fi

GOSS_FILES_PATH=$TEST_PATH/01 \
bash $TEST_PATH/dgoss run "$DOCKER_IMAGE" \
# pass flag options here \
> ../reports/01.xml || i=$(expr "$i" + 1)

exit "$i"
