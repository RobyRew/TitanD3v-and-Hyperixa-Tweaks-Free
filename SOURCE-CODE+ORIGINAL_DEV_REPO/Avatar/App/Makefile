TARGET = iphone:clang:latest:14.4
INSTALL_TARGET_PROCESSES = Avatar
ARCHS = arm64 arm64e

FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

XCODEPROJ_NAME = Avatar
Avatar_XCODE_SCHEME = Avatar
Avatar_CODESIGN_FLAGS = -SAvatar.entitlements
Avatar_XCODE_PROJECT = Avatar.xcodeproj

include $(THEOS_MAKE_PATH)/xcodeproj.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	find . -name ".DS_STORE" -delete
