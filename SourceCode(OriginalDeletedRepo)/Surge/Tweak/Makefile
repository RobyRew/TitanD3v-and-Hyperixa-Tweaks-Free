TWEAK_NAME = Surge

SOURCES  = $(shell find . -name '*.m')
SOURCES += $(shell find . -name '*.x')
SOURCES += $(shell find . -name '*.xm')

dtoim = $(foreach d,$(1),-I$(d))
_IMPORTS =  $(shell /bin/ls -d ./SURGE/*/)
_IMPORTS += $(shell /bin/ls -d ./SURGE/*/*/)
_IMPORTS += $(shell /bin/ls -d ./SURGE/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./SURGE/*/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./)
_IMPORTS += $(shell /bin/ls -d ./*/)
IMPORTS = -I$./SURGE $(call dtoim, $(_IMPORTS))

$(TWEAK_NAME)_FILES = $(SOURCES)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations $(IMPORTS)
$(TWEAK_NAME)_LIBRARIES = TitanD3vUniversal MobileGestalt
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = OnBoardingKit

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
