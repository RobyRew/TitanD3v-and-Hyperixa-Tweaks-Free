TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Palette
ARCHS = arm64 arm64e

FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

XCODEPROJ_NAME = Palette
Palette_XCODE_SCHEME = Palette
Palette_CODESIGN_FLAGS = -SPalette.entitlements
Palette_XCODE_PROJECT = Palette.xcodeproj

include $(THEOS_MAKE_PATH)/xcodeproj.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	find . -name ".DS_STORE" -delete
