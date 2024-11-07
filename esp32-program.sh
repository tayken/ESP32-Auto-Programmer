#!/bin/bash
set -eu

CHIP="esp32"
PORT=${1}
SCRIPT_PATH=$(pwd)

echo "Erasing flash"
esptool.py --chip ${CHIP} --port ${PORT} erase_flash

echo "Uploading firmware"
esptool.py --chip ${CHIP} --port ${PORT} @${SCRIPT_PATH}/flash_args

for f in ${SCRIPT_PATH}/*.py; do
	[ -e ${f} ] && echo "Copying ${f}" && \
	ampy --port ${PORT} put ${f}
done

[ -e ${SCRIPT_PATH}/main.py ] && echo "Resetting" && \
esptool.py --chip ${CHIP} --port ${PORT} run
