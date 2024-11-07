# ESP32 Auto Programmer

Automatically program your ESP32 based boards when they are plugged in via USB
with udev, systemd and bash.

## Usage
1. Install esptool and ampy with `pip install esptool adafruit-ampy` or with
`pip install -r requirements.txt`.
2. If you're using MicroPython or CircuitPython and would like to upload your
`.py` files automatically, copy them to the project directory.
3. Create the `flash_args` file based on your programming command. You need to
put all the arguments and options for `write_flash` option inside this file
excluding `--chip` and `--port`. See
[flash_args.micropython](flash_args.micropython) and
[flash_args.platformio](flash_args.platformio) for examples.
4. Plug in an ESP32 board into your computer and find the device name. Also copy
vendor ID and product ID. You can use `dmesg` command to find these information.
5. Test out the script by running `esp32-program.sh <port>` where `<port>` is
the device name you copied in the previous step. If your firmware file(s) get
flashed successfully you can continue. You can unplug the device.
6. If the vendor ID and product ID is not in the
[99-esp32-auto-program.rules](99-esp32-auto-program.rules) file, edit it so that
all the VIDs and PIDs of your USB-to-UART ICs are present. You can add a new
line based on the existing entries or replace them.
7. Run `make` or `make build` to build the application. This fills the user and
path values in the service template file and bash scripts and copy them to the
`build` folder.
8. Run `sudo make install` to install the udev rule and the service template
files.
9. When you plug in a new ESP32 board into your computer, it'll automatically
get programmed and log files will be put into the `logs` folder. You can use
them to debug any issues.
10. If you need to uninstall, you can do so with `sudo make uninstall`. You can
cleanup the `build` directory with `make clean`.
