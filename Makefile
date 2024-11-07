.PHONY: build

build:
	mkdir -p build
	sed "s:<path>:$(CURDIR)/build:" esp32-auto-program@.service | sed "s:<user>:$(USER):" > build/esp32-auto-program@.service
	sed "s:<path>:$(CURDIR):" esp32-program-shim.sh > build/esp32-program-shim.sh
	sed -r "s:^(SCRIPT_PATH=).*:\1$(CURDIR):" esp32-program.sh > build/esp32-program.sh
	chmod +x build/*.sh

install:
	cp 99-esp32-auto-program.rules /etc/udev/rules.d/
	udevadm control --reload
	cp build/esp32-auto-program@.service /etc/systemd/system/
	systemctl daemon-reload

clean:
	rm -rf build

uninstall:	
	rm /etc/udev/rules.d/99-esp32-auto-program.rules 
	udevadm control --reload
	rm /etc/systemd/system/esp32-auto-program@.service 
	systemctl daemon-reload
