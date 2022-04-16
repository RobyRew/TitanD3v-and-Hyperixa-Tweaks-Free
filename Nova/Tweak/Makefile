TWEAK_NAME = Nova

SOURCES  = $(shell find . -name '*.m')
SOURCES += $(shell find . -name '*.x')
SOURCES += $(shell find . -name '*.xm')

dtoim = $(foreach d,$(1),-I$(d))
_IMPORTS =  $(shell /bin/ls -d ./NOVA/*/)
_IMPORTS += $(shell /bin/ls -d ./NOVA/*/*/)
_IMPORTS += $(shell /bin/ls -d ./NOVA/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./NOVA/*/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./)
IMPORTS = -I$./NOVA $(call dtoim, $(_IMPORTS))

$(TWEAK_NAME)_FILES = $(SOURCES)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations $(IMPORTS)
$(TWEAK_NAME)_LIBRARIES = TitanD3vUniversal MobileGestalt rocketbootstrap
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = OnBoardingKit PersistentConnection AppSupport Preferences
$(TWEAK_NAME)_FRAMEWORKS = UIKit Photos PhotosUI

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
