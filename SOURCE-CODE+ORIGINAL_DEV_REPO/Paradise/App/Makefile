TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Paradise
ARCHS = arm64 arm64e

FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

XCODEPROJ_NAME = Paradise
Paradise_XCODE_SCHEME = Paradise
Paradise_CODESIGN_FLAGS = -SParadise.entitlements
Paradise_XCODE_PROJECT = Paradise.xcodeproj
Paradise_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/xcodeproj.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	find . -name ".DS_STORE" -delete
