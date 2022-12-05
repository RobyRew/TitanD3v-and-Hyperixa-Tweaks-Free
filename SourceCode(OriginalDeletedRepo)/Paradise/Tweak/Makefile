export ARCHS = arm64 arm64e
export PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/

TWEAK_NAME = Paradise

SOURCES  = $(shell find . -name '*.m')
SOURCES += $(shell find . -name '*.x')
SOURCES += $(shell find . -name '*.xm')

dtoim = $(foreach d,$(1),-I$(d))
_IMPORTS =  $(shell /bin/ls -d ./*/)
_IMPORTS =  $(shell /bin/ls -d ./PARADISE/)
_IMPORTS =  $(shell /bin/ls -d ./PARADISE/*/)
_IMPORTS += $(shell /bin/ls -d ./PARADISE/*/*/)
_IMPORTS += $(shell /bin/ls -d ./PARADISE/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./PARADISE/*/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./)
IMPORTS = -I$./PARADISE $(call dtoim, $(_IMPORTS))

$(TWEAK_NAME)_FILES = $(SOURCES)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error -Wno-unused-function -Wall $(IMPORTS)
$(TWEAK_NAME)_LIBRARIES = TitanD3vUniversal MobileGestalt
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = SpringBoardServices Preferences OnBoardingKit

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
