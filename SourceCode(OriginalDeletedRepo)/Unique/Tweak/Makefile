TWEAK_NAME = Unique

SOURCES  = $(shell find . -name '*.m')
SOURCES += $(shell find . -name '*.x')
SOURCES += $(shell find . -name '*.xm')

$(TWEAK_NAME)_FILES = $(SOURCES)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = OnBoardingKit
$(TWEAK_NAME)_LIBRARIES = TitanD3vUniversal MobileGestalt

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
