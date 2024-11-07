#!/bin/bash
set -eu

eval $(udevadm info --query=env --export /${1})
PORT=${DEVNAME}
LOG_FILE="$(date -u +'%FT%TZ').log"
BASE_PATH=<path>
LOG_PATH=${BASE_PATH}/logs
BUILD_PATH=${BASE_PATH}/build

mkdir -p ${LOG_PATH}
${BUILD_PATH}/esp32-program.sh ${PORT} >> ${LOG_PATH}/${LOG_FILE}
