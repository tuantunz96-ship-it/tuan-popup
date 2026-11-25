TARGET := iphone:clang:14.5:13.0
ARCHS = arm64
PACKAGE_FORMAT = gzip

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TuanPopup
TuanPopup_FILES = Tweak.xm
TuanPopup_FRAMEWORKS = UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
