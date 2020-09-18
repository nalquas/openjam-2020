# Usage:
# make         - Build everything, except Android
# make linux   - Build for Linux/X11
# make windows - Build for Windows Desktop
# make mac     - Build for Mac OSX
# make html5   - Build for HTML5
# make android - Build for Android (Requires manual setup beforehand)

GAME_NAME = openjam-2020

.PHONY: all linux windows mac html5

all: linux windows mac html5

directory:
	mkdir -p build

linux: directory
	mkdir -p build/linux
	cd game && godot --export "Linux/X11" ../build/linux/$(GAME_NAME).x86_64

windows: directory
	mkdir -p build/windows
	cd game && godot --export "Windows Desktop" ../build/windows/$(GAME_NAME).exe

mac: directory
	mkdir -p build/mac
	cd game && godot --export "Mac OSX" ../build/mac/$(GAME_NAME).zip

html5: directory
	mkdir -p build/html5
	cd game && godot --export "HTML5" ../build/html5/$(GAME_NAME).html

android: directory
	mkdir -p build/android
	cd game && godot --export-debug "Android" ../build/android/$(GAME_NAME).apk
