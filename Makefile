export THEOS_PACKAGE_SCHEME = rootless
TARGET = iphone:clang:latest:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard Butterfly

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Butterfly
Butterfly_FILES = main.m AppDelegate.m HomeViewController.m SpamViewController.m CreditsViewController.m SpamEngine.m
Butterfly_FRAMEWORKS = UIKit Foundation CoreBluetooth
Butterfly_PRIVATE_FRAMEWORKS = BluetoothManager
Butterfly_CFLAGS = -fobjc-arc
Butterfly_CODESIGN_FLAGS = -Sentitlements.plist
Butterfly_INSTALL_PATH = /Applications

TWEAK_NAME = WatchSpamDeb
WatchSpamDeb_FILES = WatchSpamDeb.xm
WatchSpamDeb_FRAMEWORKS = UIKit Foundation CoreBluetooth
WatchSpamDeb_PRIVATE_FRAMEWORKS = BluetoothManager
WatchSpamDeb_CFLAGS = -fobjc-arc
WatchSpamDeb_CODESIGN_FLAGS = -Sentitlements.plist

include $(THEOS_MAKE_PATH)/application.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-Butterfly-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Applications/Butterfly.app
	cp -r Resources/* $(THEOS_STAGING_DIR)/Applications/Butterfly.app/ 2>/dev/null || true
