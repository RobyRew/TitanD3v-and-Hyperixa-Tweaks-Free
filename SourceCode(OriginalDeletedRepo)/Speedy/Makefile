export ARCHS = arm64 arm64e
export TARGET = iphone:clang:14.0:13.0
export PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/

FINALPACKAGE = 1
DEBUG = 0

INSTALL_TARGET_PROCESSES = SpringBoard
SUBPROJECTS += Tweak

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	find . -name ".DS_STORE" -delete