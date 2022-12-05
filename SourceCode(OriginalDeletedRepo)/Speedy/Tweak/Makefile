TWEAK_NAME = Speedy

SOURCES  = $(shell find . -name '*.m')
SOURCES += $(shell find . -name '*.x')
SOURCES += $(shell find . -name '*.xm')

dtoim = $(foreach d,$(1),-I$(d))
_IMPORTS =  $(shell /bin/ls -d ./*/)
_IMPORTS =  $(shell /bin/ls -d ./SPEEDY/)
_IMPORTS =  $(shell /bin/ls -d ./SPEEDY/*/)
_IMPORTS += $(shell /bin/ls -d ./SPEEDY/*/*/)
_IMPORTS += $(shell /bin/ls -d ./SPEEDY/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./SPEEDY/*/*/*/*/)
_IMPORTS += $(shell /bin/ls -d ./)
IMPORTS = -I$./SPEEDY $(call dtoim, $(_IMPORTS))

$(TWEAK_NAME)_FILES = $(SOURCES)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations $(IMPORTS)
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = OnBoardingKit SpringBoardServices
$(TWEAK_NAME)_LIBRARIES = TitanD3vUniversal

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
