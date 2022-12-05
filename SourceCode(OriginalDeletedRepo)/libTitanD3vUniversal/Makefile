ARCHS = arm64 arm64e

TARGET = iphone:clang:14.0:13.0

export PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export CFLAGS = -include $(realpath ./ExtraTools/Prefix.h)

FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libTitanD3vUniversal

dtoim = $(foreach d,$(1),-I$(d))
_IMPORTS += $(shell /bin/ls -d ./*)
_IMPORTS += $(shell /bin/ls -d ./*/*)
IMPORTS = -I$./ $(call dtoim, $(_IMPORTS))

SOURCES  = $(shell find . -name '*.m')

libTitanD3vUniversal_FILES = $(SOURCES) $(wildcard ImagePicker/*.mm)
libTitanD3vUniversal_PUBLIC_HEADERS = $(IMPORTS)
libTitanD3vUniversal_FRAMEWORKS = UIKit Photos MobileCoreServices
libTitanD3vUniversal_PRIVATE_FRAMEWORKS = Preferences AppSupport
libTitanD3vUniversal_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wunused-function $(IMPORTS)

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-all::
	echo "Copying library and headers..."
	cp -rf $(THEOS_OBJ_DIR)/libTitanD3vUniversal.dylib $(THEOS)/lib/libTitanD3vUniversal.dylib
	rm -rf $(THEOS)/include/TitanD3vUniversal/
	mkdir $(THEOS)/include/TitanD3vUniversal/
	cp -rf $(wildcard *.h PrimraryController/*.h SecondaryController/*.h ExternalController/*.h ListController/*.h PrefsManager/*.h Appearance/*.h Cells/*.h Alert/*.h Alert/Private/*.h Banner/*.h ImagePicker/*.h ColourPicker/*.h ColourPicker/*/*.h Weather/*.h Drawer/*.h Drawer/*/*.h MarqueeLabel/*.h Utilities/*.h TweakManager/*.h BlurView/*.h Constraints/*.h CustomViews/*.h AppList/*.h ReportBugs/*.h CollectionView/*.h Confetti/*.h ExtraTools/*.h RNCryptor/*.h Review/*.h PrivateFrameworks/*.h EmojiPicker/*.h ContactPicker/*.h AvatarPicker/*.h) $(THEOS)/include/TitanD3vUniversal/
	echo "Done."
